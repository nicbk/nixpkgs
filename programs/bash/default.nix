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
    };
    initExtra = ''
      export PS1="\W  "
    '';
  };
}
