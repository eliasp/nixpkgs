{ lib, buildGraalvmNativeImage, fetchurl  }:

buildGraalvmNativeImage rec {
  pname = "zprint";
  version = "1.2.1";

  src = fetchurl {
    url = "https://github.com/kkinnear/${pname}/releases/download/${version}/${pname}-filter-${version}";
    sha256 = "sha256-yC3ByAmR0btaWZQj8n9ITyOAw+wgsmSfNE0Q3QSdzqo=";
  };

  extraNativeImageBuildArgs = [
    "--no-server"
    "-H:EnableURLProtocols=https,http"
    "-H:+ReportExceptionStackTraces"
    "--report-unsupported-elements-at-runtime"
    "--initialize-at-build-time"
    "--no-fallback"
  ];

  meta = with lib; {
    description = "Clojure/EDN source code formatter and pretty printer";
    longDescription = ''
      Library and command line tool providing a variety of pretty printing capabilities
      for both Clojure code and Clojure/EDN structures. It can meet almost anyone's needs.
      As such, it supports a number of major source code formatting approaches
    '';
    homepage = "https://github.com/kkinnear/zprint";
    license = licenses.mit;
    maintainers = with maintainers; [ stelcodes ];
  };
}
