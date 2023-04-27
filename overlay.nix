final: prev: let
  inherit (final.callPackage ./default.nix {}) spectaql;
in {
  inherit spectaql;
}
