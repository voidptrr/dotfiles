{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  userChrome = ''
    @-moz-document url(chrome://browser/content/browser.xhtml) {
      /* tabs on bottom of window */
      /* requires toolkit.legacyUserProfileCustomizations.stylesheets = true */
      #main-window body { flex-direction: column-reverse !important; }
      #navigator-toolbox { flex-direction: column-reverse !important; }
      .searchmode-switcher { position: static !important; }
      #urlbar {
        top: unset !important;
        bottom: calc(var(--urlbar-container-height) + 2 * var(--urlbar-padding-block)) !important;
        box-shadow: none !important;
        display: flex !important;
        flex-direction: column !important;
      }
      #urlbar > * {
        flex: none;
      }
      #urlbar .urlbar-input-container {
        order: 2;
      }
      #urlbar > .urlbarView {
        order: 1;
        border-bottom: 1px solid #666;
      }
      #urlbar-results {
        display: flex;
        flex-direction: column-reverse;
      }
      .search-one-offs { display: none !important; }
      .tab-background { border-top: none !important; }
      #navigator-toolbox::after { border: none; }
      #TabsToolbar .tabbrowser-arrowscrollbox,
      #tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
      .tabbrowser-tab { font-size: 80%; }
      .tab-content { padding: 0 5px; }
      .tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
      toolbox[inFullscreen=true] { display: none; }

      #mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
      #mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
      #mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }
      #navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
      panelview.cui-widget-panelview { flex: 1; }
      panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
    }
  '';
in {
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
                  url = "https://github.com";
                }
                {
                  name = "LC Problems";
                  url = "https://zerotrac.github.io/leetcode_problem_rating";
                }
                {
                  name = "PSN Profile";
                  url = "https://psnprofiles.com/voidptr__";
                }
              ];
            }
          ];
        };

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          proton-pass
        ];

        inherit userChrome;

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
        settings = import ./settings.nix;
      };
    };
  };
}
