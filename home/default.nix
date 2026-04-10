{username, ...}: {
  imports = [
    ../features/zsh.nix
    ../features/ghostty.nix
    ../features/firefox
    ../features/git.nix
    ../features/linux/i3.nix
    ../features/nvim.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
