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
    rev = "ffc43371fe326f51258d23d27fc64dd333532e71";
    sha256 = "0df0s2aff72am37zkffhv9wy9bymyjd0431fhyrb0s6626619jc5";
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
