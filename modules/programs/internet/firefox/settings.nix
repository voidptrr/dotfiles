{...}: {
  flake.homeManagerModules.firefox-settings = {...}: {
    programs.firefox.profiles.default.settings = {
      "browser.startup.homepage" = "about:blank";
      "browser.warnOnQuit" = false;
      "intl.accept_languages" = "en-US,en";
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

      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

      "browser.selfsupport.url" = "";
      "extensions.webservice.discoverURL" = "";
      "browser.urlbar.groupLabels.enabled" = false;
      "browser.urlbar.quicksuggest.enabled" = false;
      "browser.newtabpage.activity-stream.feeds.recommendationprovider" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
    };
  };
}
