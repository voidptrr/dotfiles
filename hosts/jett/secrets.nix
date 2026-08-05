{
  config,
  self,
  ...
}: let
  userSecret = file: {
    inherit file;
    owner = "voidptr";
    group = config.users.users.voidptr.group;
    mode = "0600";
  };
in {
  age = {
    identityPaths = [
      "${config.users.users.voidptr.home}/.config/ragenix/age/keys.txt"
    ];

    secrets = {
      githubSshKey = userSecret (self.secretsDir + /github-ssh-key.age);
      gitSigningKey = userSecret (self.secretsDir + /git-signing-key.age);
    };
  };
}
