{  }:

let
  userName = "user";
in
{
  hostName = "user-computer";
  userName = userName;
  userHome = "/home/${userName}";
  luksUuid = "00000000-aaaa-bbbb-cccc-dddddddddddd";
  timeZone = "Europe/Amsterdam";
  gpg-agent = {
    sshKeys = [
      "1234"
      "5678"
    ];
  };
  password-store = {
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/private/password-store";
      PASSWORD_STORE_KEY = "1234";
    };
  };
  neomutt = {
    accounts = {
      ".config/neomutt/accounts/1-foo@bar.net.neomuttrc".source = ./neomutt/accounts/1-foo + "@bar.net.neomuttrc";
    };
  };
}
