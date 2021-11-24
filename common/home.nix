{ pkgs, ... }:

{
  zsh = {
    enable = true;
    autocd = true;
    cdpath = [ "~/State/Projects/Code/" ];
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "docker" "emacs" ];
    };
    initExtraFirst = ''
      export PATH=$HOME/.npm-packages/bin:$PATH
      export PATH=$NIX_USER_PROFILE_DIR/profile/bin:$PATH
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
   '';
  };

  git = {
    enable = true;
    ignores = [ "*~" "*.swp" ];
    userName = "Dustin Lyons";
    userEmail = "hello@dustinlyons.co";
    attributes = [ "* filter=trimWhitespace" ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vim";
      filter.trimWhitespace.clean = "git-stripspace";
    };
  };

  alacritty = {
    enable = true;
    settings = {
      background_opacity =  1.0;
      cursor = {
        style = "Block";
      };

       window = {
         padding = {
           x = 8;
           y = 8;
         };
       };

       dynamic_padding = true;
       decorations = "full";
       title = "Terminal";
       class = {
         instance = "Alacritty";
         general = "Alacritty";
       };

       font = {
         normal = {
           family = "Hack";
           size = 10;
         };
       };

       colors = {
         primary = {
           background = "0x1f2528";
           foreground = "0xc0c5ce";
         };

         normal = {
           black = "0x1f2528";
           red = "0xec5f67";
           green = "0x99c794";
           yellow = "0xfac863";
           blue = "0x6699cc";
           magenta = "0xc594c5";
           cyan = "0x5fb3b3";
           white = "0xc0c5ce";
         };

         bright = {
           black = "0x65737e";
           red = "0xec5f67";
           green = "0x99c794";
           yellow = "0xfac863";
           blue = "0x6699cc";
           magenta = "0xc594c5";
           cyan = "0x5fb3b3";
           white = "0xd8dee9";
         };
       };
     };
  };
}
