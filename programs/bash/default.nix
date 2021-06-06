{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellOptions = [
      "checkwinsize"
      "checkjobs"
      "-o vi"
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      hm = "home-manager";
      ls = "ls --color=auto";
      nvimf = "nvim $(fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888')";
    };
    initExtra = ''
      export PS1="\W  "
    '';
  };
}
