{ sources ? import ./sources.nix }:

import sources.nixpkgs {
  overlays = [
    (import ./overlay.nix)
  ];
}
