{
  lib,
  buildGoModule,
  fetchFromGitHub
}:

buildGoModule rec {
  name = "oauth2l";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "google";
    repo = name;
    rev = "v${version}";
    sha256 = "1n8qdn3jf3nyvm5bjwbn23q71i62sfx5v5afh6mr0wb6lwlpmhzq";
  };

  vendorSha256 = null;
  runVend = true;
}
