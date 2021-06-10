{ pkgs, ... }:

let
  fzf-file-open = pkgs.writeShellScriptBin "fzf-file-open" "
    file=\"$(${pkgs.fzf}/bin/fzf --color='gutter:-1,prompt:#a0a0a0,pointer:#a0a0a0,hl:#888888,hl+:#888888')\"
    ${pkgs.utillinux}/bin/setsid xdg-open \"$file\" > /dev/null 2>&1 &
    ${pkgs.coreutils}/bin/sleep 0.001
    exit
  ";
in
{
  home.packages = with pkgs; [
    fzf
    ripgrep
    fzf-file-open
  ];
  programs.bash.sessionVariables = {
    FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs";
  };
}
