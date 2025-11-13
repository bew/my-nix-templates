{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs@{ systems, flake-parts, ... }: (
    flake-parts.lib.mkFlake { inherit inputs; } ({
      systems = import systems;
      imports = [ inputs.devshell.flakeModule ];

      perSystem = { pkgs, ... }: {
        packages.default = rustPlatform.buildRustPackage {
          name = "myprog";
          src = ./.;
          cargoHash = ""; # FIXME: TO FILL!
        };

        devshells.default =  {
          packages = with pkgs; [
            cargo
            rustc
            rustPackages.clippy
          ];
        };
      };
    })
  );
}
