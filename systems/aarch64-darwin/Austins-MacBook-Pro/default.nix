{lib, ...}:
with lib.internal; {
  khanelinix = {
    suites = {
      common = enabled;
      development = enabled;
    };
  };

  environment.systemPath = [
    "/opt/homebrew/bin"
  ];

  system.stateVersion = 4;
}
