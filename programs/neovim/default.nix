{ pkgs, ... }:

let
  neovim = pkgs.neovim.override {
    configure = {
      customRC = "packadd! onedark-vim\n"
        + (builtins.readFile ./init.vim);
      
      packages.vimPackages = with pkgs.vimPlugins; {
        start = [
          fzf-vim
          vim-polyglot
          vim-airline
          vim-airline-themes
          vim-devicons
          auto-pairs
          easymotion
        ];
        opt = [ onedark-vim ];
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
