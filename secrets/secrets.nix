let
  trim = key: builtins.replaceStrings ["\n"] [""] key;
  jett = trim (builtins.readFile ./publicKeys/jett_age.pub);
in {
  "git-signing-key.age".publicKeys = [jett];
  "github-ssh-key.age".publicKeys = [jett];
}
