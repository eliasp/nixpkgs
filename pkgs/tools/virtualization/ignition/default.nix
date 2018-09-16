{ stdenv, lib, fetchFromGitHub, buildGoPackage, blkid }:

with lib;

buildGoPackage rec {
  name = "ignition-${version}";
  version = "0.26.0";

  goPackagePath = "github.com/coreos/ignition";
  #buildInputs = [ makeWrapper blkid ];

  src = fetchFromGitHub {
    owner = "coreos";
    repo = "ignition";
    rev = "v${version}";
    sha256="04b21c20f3xzsp800qaiw2q6xndp57i34k488244mgl2xaslr1cz";
  };

  NIX_LDFLAGS = "-lblkid";
  buildFlagsArray = ''
    -ldflags=-X ${goPackagePath}/internal/version.Raw=v${version}
  '';

  postInstall = ''
    mv $bin/bin/{internal,ignition}
  '';

  meta = {
    description = "First boot installer and configuration tool";
    license = licenses.asl20;
    homepage = https://coreos.com/ignition/;
    maintainers = with maintainers; [ eliasp ];
    platforms = with platforms; unix;
  };
}

