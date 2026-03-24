{...}: {
  flake.hostModules.macbook-pro-m2-secrets = {username, ...}: {
    darwin.sops.defaultSopsFile = ../../../secrets/macbook-pro-m2.yaml;

    sops.secrets.git-signing-key = {
      path = "/Users/${username}/.ssh/git_signing_ed25519";
      owner = username;
      mode = "0400";
    };
  };
}
