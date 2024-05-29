{ config, pkgs, lib, ... }:

let name = "Isaac McQueen";
    user = "imcquee";
    email = "imcqueen@truehomesusa.com"; in
{

  fish = {
    enable = true;  
  };

  neovim = {
    enable = true; 
  }; 

  direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
  };
  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
  
  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    extraConfig = ''
    set -g mouse on
    setw -g mode-keys vi
    set -sg escape-time 0
    set-option -g status-position top
    set-option -g focus-events on
    
    # Enable true color support
    set -g default-terminal "tmux-256color"
    set -as terminal-features ",*:RGB"
    # Pop up windows
    bind -n M-g display-popup -d "#{pane_current_path}" -w 90% -h 90% -E 'lazygit'
    bind -n M-d display-popup -d "#{pane_current_path}" -w 90% -h 90% -E 'lazydocker'
    '';
  };
}
