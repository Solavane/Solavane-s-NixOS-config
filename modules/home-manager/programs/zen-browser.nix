{ inputs, config, osConfig, pkgs, lib, ... }:

let
  cfg = config.nixconf.programs.zen-browser;

  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    "zen.welcome-screen.seen" = true;
    "browser.shell.checkDefaultBrowser" = false;
    
    #################################
    # Hardening (Security settings) #
    #################################
    # referenced from https://gist.github.com/jolovicdev/82ed0f1667505345dccd69c7678a71ca
    
    # Captive Portal
    "network.captive-portal-service.enabled" = false;
    "captivedetect.canonicalURL" = "";

    # Additional Geolocation Hardening
    "geo.enabled" = false;
    "geo.provider.ms-windows-location" = false;
    "geo.provider.use_corelocation" = false;
    "geo.provider.use_gpsd" = false;
    "geo.provider.use_geoclue" = false;

    # Additional Push Notifications Hardening
    "dom.push.enabled" = false;
    "dom.push.connection.enabled" = false;
    "dom.push.serverURL" = "";

    # Firefox Monitor
    "signon.management.page.breach-alerts.enabled" = false;
    "extensions.fxmonitor.enabled" = false;

    # Safe Browsing
    "browser.safebrowsing.malware.enabled" = false;
    "browser.safebrowsing.phishing.enabled" = false;
    "browser.safebrowsing.blockedURIs.enabled" = false;
    "browser.safebrowsing.provider.google4.gethashURL" = "";
    "browser.safebrowsing.provider.google4.updateURL" = "";
    "browser.safebrowsing.provider.google.gethashURL" = "";
    "browser.safebrowsing.provider.google.updateURL" = "";

    # Prefetching and Predictive Connections
    "network.predictor.enable-prefetch" = false;
    "network.http.referer.disallowCrossSiteRelaxingDefault" = true;

    # Mozilla Sync
    "identity.fxaccounts.enabled" = false;

    # Extension Blocklist Updates
    "extensions.blocklist.enabled" = false;

    # Automatic Updates
    "app.update.auto" = false;
    "app.update.enabled" = false;

    # WebRTC (Prevents IP leaks)
    "media.peerconnection.enabled" = false;
    "media.navigator.enabled" = false;

    # Search Suggestions
    "browser.search.suggest.enabled.private" = false;
    "browser.urlbar.suggest.searches" = false;

    # Location Bar Suggestions
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

    # UI Elements & Quality of Life (Ads, Firefox View, Shopping)
    "browser.vpn_promo.enabled" = false;
    "browser.tabs.firefox-view" = false;
    "browser.shopping.experience2023.enabled" = false;

    ###############################
    # End of referenced hardening #
    # Own General hardening       #
    ###############################

    # Content blocking
    "browser.contentblocking.category" = "strict";

    # Force HTTPS
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_ever_enabled" = true;

    # Clear cookies on shutdown
    "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;

    # Disable WebGL, can enable with exeptions in settings
    "webgl.disabled" = true;

    # Battery info can be used for tracking
    "dom.battery.enabled" = false;

    # Enable Multi-Account Containers
    "privacy.userContext.enabled" = true;
    "privacy.userContext.ui.enabled" = true;

    # Enable Total Cookie Protection (Dynamic First-Party Isolation)
    "network.cookie.cookieBehavior" = 5;

    # Enables newer Fingerprinting Protection
    "privacy.fingerprintingProtection" = true;
    "privacy.fingerprintingProtection.pbmode" = true;

    # Disable link prefetching and speculative connections (Without this, just hovering over links can be harmful)
    "network.dns.disablePrefetch" = true;
    "network.dns.disablePrefetchFromHTTPS" = true;
    "network.prefetch-next" = false;
    "network.http.speculative-parallel-limit" = 0;

    # Disable disk cache (forces RAM-only cache)
    "browser.cache.disk.enable" = false;
    "browser.cache.disk_cache_ssl" = false;
    "browser.cache.offline.enable" = false;


  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    # Adding many extensions makes it easier for websites to fingerprint you
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "sponsorblock"  "sponsorBlocker@ajay.app")
  ]

  # Enables keepassxc-browser extension if keepass option is enabled
  ++ lib.optional config.nixconf.programs.keepass.enable
    (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org");
  
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {
    
    home.packages = [
      (pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            ) prefs
          );

          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs extensions;

            Cookies = {
              Allow = cfg.allowedCookieSites;
              Default = true;
            };

            "3rdparty".Extensions = {
              "uBlock0@raymondhill.net" = {
                adminSettings = {
                  userFilters = lib.concatStringsSep "\n" cfg.uBlockBlocklist;
                };
              };
            };

            SearchEngines = {
              Default = "ddg";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
            };
          };
        }
      )
    ];
  };
}
