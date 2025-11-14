# My Nix templates to bootstrap projects

Add this repo to your registry, for example:
```sh
nix registry add bewtpl github:bew/my-nix-templates
```

Checkout what's available with:
```sh
nix flake show bewtpl
# or (longer)
nix flake show github:bew/my-nix-templates
```

Use a template in the current dir, like:
```sh
nix flake init -t bewtpl
# or
nix flake init -t bewtpl#rust-naersk
# or (longer)
nix flake init -t github:bew/my-nix-templates#rust-naersk
```
