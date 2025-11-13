{
  description = ''
    My Nix templates to bootstrap a few types of projects.
  '';

  outputs = inputs: let
    makeWelcomeText = text: ''
      ${text}

      Optionally, setup direnv with:
        echo "use flake" > .envrc
    '';
  in {
    templates.default = {
      description = "A basic project bootstrap";
      path = ./default;
      welcomeText = makeWelcomeText ''
        Now you have a basic project..
        Do something cool!
      '';
    };

    templates.rust-simple = {
      description = "A basic Rust project setup (run `cargo init` to start!)";
      path = ./rust-simple;
      welcomeText = makeWelcomeText ''
        Now you have a basic Rust project..

        Run `cargo init` to start, and do something cool!
      '';
    };

    templates.rust-naersk = {
      description = "A basic Rust project setup using naersk (run `cargo init` to start!)";
      path = ./rust-naersk;
      welcomeText = makeWelcomeText ''
        Now you have a basic Rust project.. (using naersk)

        Run `cargo init` to start, and do something cool!
      '';
    };
  };
}
