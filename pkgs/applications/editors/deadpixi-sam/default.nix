{ lib, stdenv, fetchFromGitHub, freetype, libX11, libXi, libXt, libXft }:

stdenv.mkDerivation rec {
  pname = "deadpixi-sam-unstable";
  version = "2020-07-14";

  src = fetchFromGitHub {
    owner = "deadpixi";
    repo = "sam";
    rev = "5d8acb35d78c327d76f00a54857cbd566ed9bc11";
    sha256 = "sha256-+vRh6nDPc3UnmEdqROHRel5Te0h5m4eiaERs492xciQ=";
  };

  postPatch = ''
    substituteInPlace config.mk.def \
      --replace "/usr/include/freetype2" "${freetype.dev}/include/freetype2" \
      --replace "CC=gcc" "CC=${stdenv.cc.targetPrefix}cc"
  '';

  CFLAGS = "-D_DARWIN_C_SOURCE";
  makeFlags = [ "DESTDIR=$(out)" ];
  buildInputs = [ libX11 libXi libXt libXft ];

  postInstall = ''
    mkdir -p $out/share/applications
    mv deadpixi-sam.desktop $out/share/applications
  '';

  meta = with lib; {
    homepage = "https://github.com/deadpixi/sam";
    description = "Updated version of the sam text editor";
    license = licenses.lpl-102;
    maintainers = with maintainers; [ ramkromberg ];
    platforms = platforms.unix;
  };
}
