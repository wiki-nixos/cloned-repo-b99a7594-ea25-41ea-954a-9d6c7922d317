{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.internal; let
  cfg = config.khanelinix.system.input;
in {
  options.khanelinix.system.input = with types; {
    enable = mkEnableOption "macOS input";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      system = {
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        defaults = {
          # trackpad settings
          trackpad = {
            # silent clicking = 0, default = 1
            ActuationStrength = 0;
            # enable tap to click
            Clicking = true;
            # firmness level, 0 = lightest, 2 = heaviest
            FirstClickThreshold = 1;
            # firmness level for force touch
            SecondClickThreshold = 1;
            # don't allow positional right click
            TrackpadRightClick = false;
            # three finger drag for space switching
            # TrackpadThreeFingerDrag = true;
          };

          ".GlobalPreferences" = {
            "com.apple.mouse.scaling" = "-1";
          };

          NSGlobalDomain = {
            AppleKeyboardUIMode = 3;
            ApplePressAndHoldEnabled = false;

            KeyRepeat = 1;
            InitialKeyRepeat = 10;

            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
          };
        };
      };
    }
  ]);
}
