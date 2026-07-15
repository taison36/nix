{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = user; 
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      #_HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  
    finder.CreateDesktop = false;         
    trackpad.Clicking = true;            
  };

  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    #onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    casks = [
      "wezterm"
      "claude-code"
      "betterdisplay"
      "hiddenbar"
      "jordanbaird-ice"
      "mos"
      "lunar"
      "skim"
      "lookaway"
      "tomatobar"
      "lidanglesensor"
      "font-iosevka-ss04"
      "font-meslo-lg-nerd-font"
    ];
  };
}

