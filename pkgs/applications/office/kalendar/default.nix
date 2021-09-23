{ mkDerivation
, lib
, fetchFromGitLab
, extra-cmake-modules
, qtbase
, qtquickcontrols2
, qtlocation
, kirigami2
, kirigami-addons
, ki18n
, kcalendarcore
, kconfigwidgets
, kwindowsystem
, kcoreaddons
, kpeople
, kcontacts
, kitemmodels
, kpackage
, kxmlgui
, akonadi
, akonadi-contacts
, calendarsupport
, eventviews
}:

mkDerivation rec {
  pname = "kalendar";
  version = "0.0.20210921";

  src = fetchFromGitLab {
    domain = "invent.kde.org";
    owner = "pim";
    repo = pname;
    rev = "f0bdb6917da155efdc8260e88ab21cac838a3443";
    sha256 = "0wj9h5bfq5lbgg8pi8ys64d8n8icjmlxbhns4v7m3z35z73iza7y";
  };

  nativeBuildInputs = [
    extra-cmake-modules
  ];

  buildInputs = [
    qtbase
    qtquickcontrols2
    qtlocation
    # depends on kirigami >=5.85.0 as kalendar makes use of OverlaySheet's "title" property, which was added
    # in https://github.com/KDE/kirigami/commit/d8aabb0c05234af35993303ac803d51a2eb153f8
    kirigami2
    kirigami-addons
    ki18n
    kcalendarcore
    kconfigwidgets
    kwindowsystem
    kcoreaddons
    kpeople
    kcontacts
    kitemmodels
    kpackage
    kxmlgui
    akonadi
    akonadi-contacts
    calendarsupport
    eventviews
  ];

  meta = with lib; {
    description = "A calendar application using Akonadi to sync with external services (NextCloud, GMail, ...)";
    homepage = "https://invent.kde.org/pim/kalendar";
    maintainers = with maintainers; [ eliasp ];
    platforms = platforms.linux;
    license = licenses.gpl3Plus;
  };
}
