{...}: {
  flake.devModules.opencode = {...}: {
    programs.opencode = {
      enable = true;
      settings = {
        plugin = ["opencode-openai-codex-auth"];
        theme = "opencode";
        provider = {
          openai = {
            options = {
              reasoningEffort = "medium";
              reasoningSummary = "auto";
              textVerbosity = "medium";
              include = ["reasoning.encrypted_content"];
              store = false;
            };
            models = {
              "gpt-5.2-codex" = {
                name = "GPT 5.2 Codex (OAuth)";
                limit = {
                  context = 272000;
                  output = 128000;
                };
                modalities = {
                  input = ["text" "image"];
                  output = ["text"];
                };
                variants = {
                  low = {
                    reasoningEffort = "low";
                    reasoningSummary = "auto";
                    textVerbosity = "medium";
                  };
                  medium = {
                    reasoningEffort = "medium";
                    reasoningSummary = "auto";
                    textVerbosity = "medium";
                  };
                  high = {
                    reasoningEffort = "high";
                    reasoningSummary = "detailed";
                    textVerbosity = "medium";
                  };
                  xhigh = {
                    reasoningEffort = "xhigh";
                    reasoningSummary = "detailed";
                    textVerbosity = "medium";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
