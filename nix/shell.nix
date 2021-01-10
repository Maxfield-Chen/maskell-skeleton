let
  nixpkgs = import <nixpkgs> {overlays = [(import ./haskell/overlay.nix)];};

  inherit (nixpkgs) pkgs;

  haskell = import ./haskell { inherit pkgs; };

in
pkgs.mkShell {
  buildInputs = with pkgs; [
    haskell.ormolu
    haskell.cabal-install
    haskell.ghc
    haskell.ghcid
    haskell.ghcide
    haskell.hlint
    haskell.hpack
    haskell.stylish-haskell
    pkgs.zlib
  ];

  # Use the libraries from the derivation created by ghcWithHoogle.
  NIX_GHC_LIBDIR = "${haskell.ghc}/lib/ghc-${haskell.ghc.version}";
  LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:/usr/lib/";
}
