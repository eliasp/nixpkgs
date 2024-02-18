{ lib
, fetchFromGitHub
, buildGoModule
, testers
, files-cli
}:

buildGoModule rec {
  pname = "files-cli";
  version = "2.12.36";

  src = fetchFromGitHub {
    repo = "files-cli";
    owner = "files-com";
    rev = "v${version}";
    hash = "sha256-tWOC2QDu72dETTFXG9JmOlm/xBWehTH2FUStegyYu2g=";
  };

  vendorHash = "sha256-rNftWnIbUruUOPrfCso8uu2Z4CAL43RxjoTVMpNkD3U=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  doInstallCheck = true;

  installCheckPhase = ''
    runHook preInstallCheck

    $out/bin/files-cli --help

    runHook postInstallCheck
  '';

  passthru.tests = {
    version = testers.testVersion {
      package = files-cli;
      command = "files-cli -v";
      version = "files-cli version ${version}";
    };
  };

  meta = with lib; {
    description = "Files.com Command Line App for Windows, Linux, and macOS.";
    homepage = "https://developers.files.com";
    license = licenses.mit;
    maintainers = with maintainers; [ kashw2 ];
    mainProgram = "files-cli";
  };

}
