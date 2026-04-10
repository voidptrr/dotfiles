{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Source Code Pro";
      font-size = 13;
      theme = "Kanagawa Dragon";
      window-decoration = "server";
      working-directory = "home";
      window-inherit-working-directory = false;
    };
  };
}
