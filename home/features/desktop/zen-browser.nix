{ inputs, pkgs, lib, config, ... }:

let
  locked = value: {
    Value = value;
    Status = "locked";
  };
in

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser.policies = {
    ExtensionSettings = {
      "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
        installation_mode = "force_installed";
      };

      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };
    };
  };

  programs.zen-browser = {
    enable = true;

    # NOTE: Zen Browser seems currently to ignore Enterprise Policies
    # See: https://github.com/zen-browser/desktop/discussions/2195
    # All actual configuration is done via Preferences instead
    policies = {
      Preferences = builtins.mapAttrs (_: locked) {
        # Original preferences
        "browser.tabs.warnOnClose" = false;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;

        # AutofillAddressEnabled = false
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.addresses.capture.enabled" = false;

        # AutofillCreditCardEnabled = false  
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.creditCards.available" = false;

        # DisableAppUpdate = true
        "app.update.enabled" = false;
        "app.update.auto" = false;
        "app.update.service.enabled" = false;

        # DisableFeedbackCommands = true
        "browser.chrome.toolbar_tips" = false;

        # DisableFirefoxStudies = true
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # DisablePocket = true
        "extensions.pocket.enabled" = false;
        "extensions.pocket.api" = "";
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.site" = "";

        # DisableTelemetry = true
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # DontCheckDefaultBrowser = true  
        "browser.shell.checkDefaultBrowser" = false;

        # NoDefaultBookmarks = true
        "browser.bookmarks.restore_default_bookmarks" = false;

        # OfferToSaveLogins = false
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.generation.enabled" = false;

        # EnableTrackingProtection (supplementary preferences)
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # Additional privacy hardening
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
      };
    };
  };

  home.activation.zenExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ZEN_PROFILES_DIR="$HOME/Library/Application Support/zen/Profiles"
    
    if [ -d "$ZEN_PROFILES_DIR" ]; then
      # Extract extension settings from the configuration
      EXTENSIONS_CONFIG='${builtins.toJSON config.programs.zen-browser.policies.ExtensionSettings}'

      # Find all profile directories that contain zen-themes.json
      find "$ZEN_PROFILES_DIR" -maxdepth 1 -type d -name "*.*" | while read -r PROFILE_DIR; do
        # Skip profiles that don't have zen-themes.json
        if [ ! -f "$PROFILE_DIR/zen-themes.json" ]; then
          continue
        fi
        EXTENSIONS_DIR="$PROFILE_DIR/extensions"
        mkdir -p "$EXTENSIONS_DIR"
        
        echo "Managing extensions for profile: $(basename "$PROFILE_DIR")"
        
        # Create a temporary file to track which extensions should exist
        EXPECTED_EXTENSIONS=$(mktemp)
        
        # Parse the JSON configuration and download/update extensions
        echo "$EXTENSIONS_CONFIG" | ${pkgs.jq}/bin/jq -r 'to_entries[] | select(.value.installation_mode == "force_installed") | "\(.key) \(.value.install_url)"' | while read -r EXTENSION_ID INSTALL_URL; do
          EXTENSION_FILE="$EXTENSIONS_DIR/$EXTENSION_ID.xpi"
          
          # Add to expected extensions list
          echo "$EXTENSION_ID.xpi" >> "$EXPECTED_EXTENSIONS"
          
          echo "Installing extension: $EXTENSION_ID"
          ${pkgs.curl}/bin/curl -L -o "$EXTENSION_FILE" "$INSTALL_URL"
          
          if [ $? -eq 0 ]; then
            echo "Successfully installed: $EXTENSION_ID"
          else
            echo "Failed to install: $EXTENSION_ID"
            rm -f "$EXTENSION_FILE"
          fi
        done
        
        # Remove extensions that are no longer in the configuration
        if [ -f "$EXPECTED_EXTENSIONS" ]; then
          for EXISTING_XPI in "$EXTENSIONS_DIR"/*.xpi; do
            if [ -f "$EXISTING_XPI" ]; then
              BASENAME=$(basename "$EXISTING_XPI")
              if ! grep -Fxq "$BASENAME" "$EXPECTED_EXTENSIONS"; then
                echo "Removing unmanaged extension: $BASENAME"
                rm -f "$EXISTING_XPI"
              fi
            fi
          done
        fi
        
        # Cleanup temporary file
        rm -f "$EXPECTED_EXTENSIONS"
      done
    else
      echo "Zen Browser profiles directory not found: $ZEN_PROFILES_DIR"
    fi
  '';
}
