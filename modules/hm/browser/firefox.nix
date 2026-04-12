{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.hm.browser.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf config.hm.browser.firefox.enable {
    programs.firefox = {
      enable = true;
      policies = import ./policies.nix;

      profiles.default = {
        name = "voidptr";

        bookmarks = {
          force = true;
          settings = [
            {
              toolbar = true;
              bookmarks = [
                {
                  name = "GitHub";
                  url = "https://github.com/";
                }
              ];
            }
          ];
        };

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          proton-pass
        ];

        search = {
          force = true;
          default = "ddg";
          order = ["ddg"];
          engines = {
            "nix-packages" = {
              definedAliases = ["@n" "@nix"];
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "home-manager-options" = {
              definedAliases = ["@homemanager" "@hm"];
              urls = [
                {
                  template = "https://home-manager-options.extranix.com";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "youtube" = {
              definedAliases = ["@yt"];
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };

        settings = {
          "browser.startup.homepage" = "about:blank";
          "browser.warnOnQuit" = false;
          "layout.css.devPixelsPerPx" = 1.25;
          "intl.accept_languages" = "en-US,en";
          "signon.rememberSignons" = false;
          "services.sync.prefs.sync.signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "services.sync.prefs.sync.layout.spellcheckDefault" = false;
          "layout.spellcheckDefault" = 0;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.disableResetPrompt" = true;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.useDownloadDir" = false;
          "browser.toolbars.bookmarks.showInPrivateBrowsing" = true;
          "browser.toolbars.bookmarks.visibility" = "always";
          "extensions.autoDisableScopes" = 0;

          "privacy.globalprivacycontrol.functionality.enabled" = true;
          "dom.security.https_only_mode" = true;
          "privacy.donottrackheader.enabled" = true;

          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.introShown" = false;
          "browser.newtabpage.pinned" = [];
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

          "browser.selfsupport.url" = "";
          "extensions.webservice.discoverURL" = "";
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.recommendationprovider" = false;

          "font.name.monospace.x-western" = "Source Code Pro";
          "font.name-list.monospace.x-western" = "Source Code Pro";
        };
      };
    };
  };
}
