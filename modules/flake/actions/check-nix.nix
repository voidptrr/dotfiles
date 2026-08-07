_: {
  ".github/workflows/checks.yml" = {
    name = "checks";

    on = {
      pull_request = {};
      push = {
        branches = ["main"];
        paths = [
          "**/*.nix"
          "flake.lock"
          ".github/workflows/checks.yml"
        ];
      };
      workflow_dispatch = {};
    };

    jobs.flake = {
      runs-on = "ubuntu-latest";
      steps = [
        {uses = "actions/checkout@v7";}
        {uses = "DeterminateSystems/nix-installer-action@main";}
        {
          name = "Run nix flake check";
          run = "nix flake check";
        }
      ];
    };
  };
}
