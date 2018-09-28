{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  version = "2018-09-28";
  name = "phabricator-${version}";
  srcLibphutil = pkgs.fetchgit {
      url = git://github.com/facebook/libphutil.git;
      rev = "3215e4e291ed4468faeed4542d47a571b5bc559a";
      sha256 = "0bbinaxny0j4iniz2grf0s9cysbl3x24yc32f3jra9mwsgh2v2zj";
  };
  srcArcanist = pkgs.fetchgit {
      url = git://github.com/facebook/arcanist.git;
      rev = "2650e8627a20e1bfe334a4a2b787f44ef5d6ebc5";
      sha256 = "0x0xxiar202ypbgxh19swzjil546bbp8li4k5yrpvab55y8ymkd4";
  };
  srcPhabricator = pkgs.fetchgit {
      url = git://github.com/phacility/phabricator.git;
      rev = "8065433ee8dcfd31ca544c52b3bcc620db9df13f";
      sha256 = "0kk3m6j1v4hyr9wk0s4029xxrdr46rgjbscgvkw92n7wq7h22xqv";
  };

  buildCommand = ''
    mkdir -p $out
    cp -R ${srcLibphutil} $out/libphutil
    cp -R ${srcArcanist} $out/arcanist
    cp -R ${srcPhabricator} $out/phabricator
  '';

  meta = {
    platforms = stdenv.lib.platforms.unix;
    license = stdenv.lib.licenses.asl20;
  };
}
