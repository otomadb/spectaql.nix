# Nix Flake for [SpectaQL](https://github.com/anvilco/spectaql)

Provide Nix Flake for [SpectaQL](https://github.com/anvilco/spectaql), GraphQL API Document Generator.

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

[![Status](https://github.com/otomadb/spectaql.nix/actions/workflows/flake.yml/badge.svg)](https://github.com/otomadb/spectaql.nix/actions/workflows/flake.yml)
[![License](https://img.shields.io/github/license/otomadb/spectaql.nix?style=flat)](https://github.com/otomadb/spectaql.nix/blob/main/LICENSE)

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    spectaql.url = "github:otomadb/spectaql.nix";
    devshell.url = "github:numtide/devshell";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            devshell.overlays.default
            spectaql.overlays.default
          ];
        };
      in {
        devShells.default = pkgs.devshell.mkShell {
          packages = with pkgs; [
            spectaql
          ];
        };
      }
    );
}
```

Refer to [otomadb/graphql-api-document](https://github.com/otomadb/graphql-api-document).

## License

[![License](https://img.shields.io/github/license/otomadb/spectaql.nix?style=flat-square)](https://github.com/otomadb/spectaql.nix/blob/main/LICENSE)
