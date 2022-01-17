{ pkgs, ... }:

let
  neovim = pkgs.neovim.override {
    configure = {
      customRC = builtins.readFile ./init.vim;
      
      packages.vimPackages = with pkgs.vimPlugins; {
        start = [
          fzf-vim
          vim-polyglot
          vim-airline
          vim-airline-themes
          vim-devicons
          auto-pairs
          easymotion
          vim-orgmode
          onedark-vim
        ];
      };
    };
  };
in
{
  home.packages = with pkgs; [
    fzf
  ] ++ [
    neovim
  ];
}
