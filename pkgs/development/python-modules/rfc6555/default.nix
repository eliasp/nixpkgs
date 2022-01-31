{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, selectors2
}:

buildPythonPackage rec {
  pname = "rfc6555";
  version = "0.1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "sethmlarson";
    repo = pname;
    rev = "v${version}";
    sha256 = "Lmwgusc4EQlF0GHmMTUxWzUCjBk19cvurNwbOnT+1jM=";
  };

  propagatedBuildInputs = [
    selectors2
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # Disabling tests that require a functional DNS IPv{4,6} stack to pass
    "test_create_connection_has_proper_timeout"
  ];

  pythonImportsCheck = [
    "rfc6555"
  ];

  meta = with lib; {
    description = "Python implementation of the Happy Eyeballs Algorithm";
    homepage = "https://github.com/sethmlarson/rfc6555";
    license = licenses.asl20;
    maintainers = with maintainers; [ endocrimes ];
  };
}
