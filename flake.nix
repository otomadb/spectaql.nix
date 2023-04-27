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
    {
      overlays.default = import ./overlay.nix;
    }
    // flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            self.overlays.default
          ];
        };
      in {
        packages = flake-utils.lib.flattenTree {spectaql = pkgs.spectaql;};
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            nodePackages.node2nix
          ];
        };
      }
    );
}
