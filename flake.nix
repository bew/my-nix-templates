{
  description = ''
    My Nix templates to bootstrap a few types of projects.
  '';

  inputs = {
    nixpkgs-lib-only.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = { self, ... }@inputs: let
    lib = inputs.nixpkgs-lib-only.lib;
    defaultPreSteps = [
      ''Setup git''
      ''Setup the devshell via direnv with e.g. `echo "use flake" > .envrc`''
    ];
    defaultPostSteps = [ ''.. and do something cool! 🚀'' ];
    whatsNext = {
      preSteps ? defaultPreSteps,
      mainSteps ? [],
      postSteps ? defaultPostSteps,
    }: (
      let allSteps = preSteps ++ mainSteps ++ postSteps;
      in lib.concatMapStringsSep "\n" (s: "- ${s}") (allSteps)
    );
  in {
    templates.default = self.templates.devshell-simple;

    templates.devshell-simple = {
      description = "A basic devshell setup";
      path = ./devshell-simple;
      welcomeText = ''
        Now you have a basic devshell for your project o/

        👉 Now you can...

        ${whatsNext {
          mainSteps = ["Run `hello` to test it out!"];
        }}
      '';
    };

    templates.devshell-project = {
      description = "A basic flake-parts + devshell setup";
      path = ./default;
      welcomeText = ''
        Now you have a basic project o/

        👉 Now you can...

        ${whatsNext {
          mainSteps = ["Run `hello` to test it out!"];
        }}
      '';
    };

    templates.rust-nixpkgs = {
      description = "A basic Rust project setup, using nixpkgs builder";
      path = ./rust-nixpkgs;
      welcomeText = ''
        Now you have a basic Rust project (using nixpkgs builder) o/

        👉 Now you can...

        ${whatsNext {
          mainSteps = [
            "Run `cargo init` to start a project"
          ];
        }}
      '';
    };

    templates.rust-naersk = {
      description = "A basic Rust project setup, using naersk builder";
      path = ./rust-naersk;
      welcomeText = ''
        Now you have a basic Rust project (using naersk builder) o/

        👉 Now you can...

        ${whatsNext {
          mainSteps = [
            "Run `cargo init` to start a project"
          ];
        }}
      '';
    };

    templates.rust-rust-overlay = {
      description = "A basic Rust project setup, using the rust-overlay builder";
      path = ./rust-rust-overlay;
      welcomeText = ''
        Now you have a basic Rust project (using rust-overlay builder) o/

        👉 Now you can...

        ${whatsNext {
          mainSteps = [
            "Run `cargo init` to bootstrap the sources (creates Cargo.toml, Cargo.lock, src/)"
          ];
        }}
      '';
    };
  };
}
