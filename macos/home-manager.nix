{ config, pkgs, lib, ... }:

let
  common-programs = import ../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; }; in
{
  imports = [
    <home-manager/nix-darwin>
   ./dock
  ];

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Slack.app/"; }
    { path = "/System/Applications/Messages.app/"; }
    { path = "/System/Applications/Facetime.app/"; }
    { path = "/Applications/Telegram.app/"; }
    { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    { path = "/Applications/Discord.app/"; }
    { path = "${pkgs.emacs}/Applications/Emacs.app/"; }
    { path = "/System/Applications/Music.app/"; }
    { path = "/System/Applications/News.app/"; }
    { path = "/System/Applications/Photos.app/"; }
    { path = "/System/Applications/Photo Booth.app/"; }
    { path = "/Applications/Drafts.app/"; }
    { path = "/System/Applications/Home.app/"; }
    {
      path = "/Users/dustin/State/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "/Users/dustin/State/Inbox/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];

  # It me
  users.users.dustin = {
    name = "dustin";
    home = "/Users/dustin";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # We use Homebrew to install impure software only (Mac Apps)
  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
    upgrade = true;
  };
  homebrew.brewPrefix = "/opt/homebrew/bin";

  # These app IDs are from using the mas CLI app
  # mas = mac app store
  # https://github.com/mas-cli/mas
  #
  # $ mas search <app name>
  #
  homebrew.casks = pkgs.callPackage ./casks.nix {};
  homebrew.masApps = {
    "1password" = 1333542190;
    "drafts" = 1435957248;
    "hidden-bar" = 1452453066;
    "tailscale" = 1475387142;
    "yoink" = 457622435;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.dustin = { pkgs, lib, ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.packages = pkgs.callPackage ./packages.nix {};
      programs = common-programs // {};

      # https://github.com/nix-community/home-manager/issues/3344
      # Marked broken Oct 20th, check later to remove this
      manual.manpages.enable = false;
    };
  };
}
