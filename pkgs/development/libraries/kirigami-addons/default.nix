{ mkDerivation
, fetchFromGitLab
, extra-cmake-modules
, qtquickcontrols2
, ki18n
, kirigami2
}:

mkDerivation rec {
  pname = "kirigami-addons";
  version = "21.05";

  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "libraries";
    repo = pname;
    rev = "v${version}";
    sha256 = "0pwkpag15mvzhd3hvdwx0a8ajwq9j30r6069vsx85bagnag3zanh";
  };

  nativeBuildInputs = [ extra-cmake-modules ];
  buildInputs = [ qtquickcontrols2 kirigami2 ki18n ];
  outputs = [ "out" "dev" ];
}
