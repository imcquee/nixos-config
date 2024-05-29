{ pkgs, config, ... }:

{
  # home.file."${config.home.homeDirectory}/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink
   # ./dotfiles/.config/nvim;
}
