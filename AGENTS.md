# AGENTS: Module Authoring Guide

The repository follows the dendritic pattern: every file under `modules/` is a self-contained flake-parts module that registers itself under a `flake.*` registry. This page explains how to author those modules so future changes stay consistent.

## Current module layout
- `modules/darwin/`: nix-darwin modules registered as `flake.darwinModules.*`.
- `modules/hosts/<host>/`: host composition files (for example `base.nix` and `config.nix`) that register host-specific `flake.darwinModules.*` and `flake.darwinConfigurations.*`.
- `modules/terminal/`, `modules/internet/`: Home-Manager modules registered as `flake.homeManagerModules.*`.
- `modules/development/`: shared dev modules registered as `flake.devModules.*`.
- `modules/nix/`: shared Nix modules registered as `flake.nixModules.*`.
- `modules/packages/`: package definitions (for example `perSystem.packages.nvim`) and their internal config trees.

## Creating a nix-darwin module
1. Pick a descriptive file under `modules/darwin/` (e.g., `modules/darwin/homebrew.nix`).
2. Export a function that registers a named module inside `flake.darwinModules`.
3. Return pure option/config definitions—no side effects at the top level.

**Template**
```nix
# modules/darwin/<name>.nix
{ ... }: {
  flake.darwinModules.<name> = {
    pkgs,
    ...
  }: {
    # Declare options/config here.
    environment.systemPackages = [ pkgs.git ];
  };
}
```
- Arguments come from nix-darwin (`pkgs`, `lib`) plus anything passed through `specialArgs` (e.g., `username`).
- Keep each module focused. Multiple related modules are fine—just give each a unique registry key.

## Creating a Home-Manager module
Home-Manager programs in this repo typically live under `modules/terminal/` or `modules/internet/`. They register under `flake.homeManagerModules` and are threaded into hosts via `homeManagerModules` special args.

**Template**
```nix
# modules/terminal/<tool>.nix
{ ... }: {
  flake.homeManagerModules.<tool> = {
    pkgs,
    lib,
    config,
    ...
  }: {
    programs.<tool> = {
      enable = true;
      # Program-specific settings…
    };
  };
}
```
- Use `config` for HM helpers (e.g., `config.lib.file.mkOutOfStoreSymlink`).
- Avoid side effects or `pkgs.callPackage` at the top level; keep everything inside the returned attrset.

## Creating a dev module
Dev modules live under `modules/development/` and register under `flake.devModules`.

**Template**
```nix
# modules/development/<name>.nix
{ ... }: {
  flake.devModules.<name> = {
    pkgs,
    ...
  }: {
    # Shared Home-Manager config for development tooling
    home.packages = [ pkgs.git ];
  };
}
```

## Creating a shared Nix module
Shared Nix modules live under `modules/nix/` and register under `flake.nixModules`.

**Template**
```nix
# modules/nix/<name>.nix
{ ... }: {
  flake.nixModules.<name> = {
    lib,
    pkgs,
    ...
  }: {
    nix.settings = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      auto-optimise-store = true;
    };
  };
}
```

## Defining a host
Hosts live under `modules/hosts/<host>/` and usually split responsibilities across files (for example `base.nix` for `flake.darwinConfigurations.*` and `config.nix` for host-specific `flake.darwinModules.*`).

**Template**
```nix
# modules/hosts/<host>/base.nix
{
  self,
  inputs,
  ...
}: let
  system = "aarch64-darwin";
  username = "voidptr";
  darwinStack = [
    self.darwinModules.system
    self.darwinModules.home-manager-entry
    self.nixModules.base
    self.darwinModules.<host>
  ];

  homeModules =
    builtins.attrValues self.homeManagerModules
    ++ builtins.attrValues self.devModules;
in {
  flake.darwinConfigurations.<name> = inputs.nix-darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit username;
      homeManagerModules = homeModules;
    };
    modules =
      darwinStack
      ++ [
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.home-manager.darwinModules.home-manager
      ];
  };
}
```
- Compose host stacks from registries instead of importing modules directly.
- Include both `self.homeManagerModules` and `self.devModules` in `homeManagerModules` when you want shared dev tooling applied to the user profile.

## Checklist
- Place darwin-related files under `modules/darwin/` and register them via `flake.darwinModules.<name>`.
- Place HM files under `modules/terminal/` or `modules/internet/` and register them via `flake.homeManagerModules.<name>`.
- Place shared development modules under `modules/development/` and register them via `flake.devModules.<name>`.
- Place shared nix modules under `modules/nix/` and register them via `flake.nixModules.<name>`.
- Define hosts under `modules/hosts/<host>/` and expose `flake.darwinConfigurations.<host>` from the host base file.
- After adding/renaming modules, run `nix build .#darwinConfigurations.<host>.system` (or your `rebuild` alias) to ensure everything evaluates.
