{...}: {
  registry.homeManagerModules.tmux = {pkgs, ...}: {
    home.packages = [pkgs.tmux];
  };
}
