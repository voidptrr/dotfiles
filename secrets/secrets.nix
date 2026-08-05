let
  trim = key: builtins.replaceStrings ["\n"] [""] key;
  jett = trim (builtins.readFile ./publicKeys/jett_age.pub);
in {
  "age/git-signing-key.age".publicKeys = [jett];
  "age/github-ssh-key.age".publicKeys = [jett];
}
