{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devshell.url = "github:numtide/devshell";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, systems, nixpkgs, devshell, rust-overlay }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs (import systems) f;

      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ rust-overlay.overlays.default ];
      };

      commonsFor = pkgs: {
        rustToolchain = pkgs.rust-bin.stable.latest.default;
      };
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
          commons = commonsFor pkgs;
          rustPlatform = pkgs.makeRustPlatform {
            cargo = commons.rustToolchain;
            rustc = commons.rustToolchain;
          };
        in
        {
          default = rustPlatform.buildRustPackage {
            name = "myprog";
            src = pkgs.lib.fileset.toSource {
              root = ./.;
              fileset = pkgs.lib.fileset.unions [
                ./Cargo.toml
                ./Cargo.lock
                ./src
              ];
            };
            cargoHash = ""; # FIXME: TO FILL!
          };
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = pkgsFor system;
          commons = commonsFor pkgs;
        in
        {
          default = devshell.legacyPackages.${system}.mkShell {
            packages = [
              commons.rustToolchain  # includes rustc, cargo, clippy
            ];
          };
        }
      );
    };
}
