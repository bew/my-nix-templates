{
  description = ''
    My Nix templates to bootstrap a few types of projects.
  '';

  inputs = {
    nixpkgs-lib-only.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = inputs: let
    lib = inputs.nixpkgs-lib-only.lib;
    defaultPreSteps = [
      ''Setup git''
      ''(Setup direnv with e.g. `echo "use flake" > .envrc`)''
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
    templates.default = {
      description = "A basic project bootstrap";
      path = ./default;
      welcomeText = ''
        Now you have a basic project o/

        👉 Now you can...

        ${whatsNext {}}
      '';
    };

    templates.rust-simple = {
      description = "A basic Rust project setup, using nixpkgs builder";
      path = ./rust-simple;
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
  };
}
