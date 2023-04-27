{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        inherit (import ./. {inherit pkgs system;}) spectaql;
      in {
        packages = flake-utils.lib.flattenTree {inherit spectaql;};
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            nodePackages.node2nix
          ];
        };
      }
    );
}
