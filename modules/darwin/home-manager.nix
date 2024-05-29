{ config, pkgs, lib, home-manager, ... }:

let
  user = "%USER%";
  # Define the content of your file as a derivation
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    
    users = { 
      ${user} = { pkgs, config, lib, ... }:{
        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ./packages.nix {};
          file = lib.mkMerge [
            sharedFiles
          ];
          stateVersion = "24.05";
        };
        programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };
      };
      # defaultUserShell = pkgs.fish;
     };
  };

  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        { path = "/System/Applications/Messages.app/"; }
      ];
    };
  };
}
