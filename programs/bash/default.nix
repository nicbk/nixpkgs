{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellOptions = [
      "checkwinsize"
      "checkjobs"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      QT_QPA_PLATFORMTHEME="qt5ct";
    };
    shellAliases = {
      hm = "home-manager";
      ls = "ls --color=auto";
      cdf = "cd \"$(fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888' | xargs -I {} dirname {})\"";
      nvimf = "nvim \"$(fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888')\"";
      ef = "./\"$(fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888')\"";
      sef = "sudo ./\"$(fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888')\"";
      th = "trash";
      thl = "trash-list";
      thr = "trash-restore";
      thrm = "trash-rm";
    };
    initExtra = ''
      set -o vi
      export PS1="\W  "
    '';
    bashrcExtra = builtins.readFile ./bashrc;
  };
}
