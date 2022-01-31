{ lib
, buildPythonPackage
, aiohttp
, bitarray
, cryptography
, deepdiff
, fetchFromGitHub
, mediafile
, miniaudio
, netifaces
, protobuf
, pytest-aiohttp
, pytest-asyncio
, pytest-timeout
, pytestCheckHook
, pythonOlder
, srptools
, zeroconf
}:

buildPythonPackage rec {
  pname = "pyatv";
  version = "0.9.8";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "postlund";
    repo = pname;
    rev = "v${version}";
    sha256 = "1ns1ys3mwi1s1b8zxcr7xgr1rfnlxwdn2fp680yi09x4d9nmnvqp";
  };

  propagatedBuildInputs = [
    aiohttp
    bitarray
    cryptography
    mediafile
    miniaudio
    netifaces
    protobuf
    srptools
    zeroconf
  ];

  checkInputs = [
    deepdiff
    pytest-aiohttp
    pytest-asyncio
    pytest-timeout
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "pytest-runner" ""
    # Remove all version pinning
    sed -i -e "s/==[0-9.]*//" requirements/requirements.txt
  '';

  disabledTestPaths = [
    # Test doesn't work in the sandbox
    "tests/protocols/companion/test_companion_auth.py"
  ];

  __darwinAllowLocalNetworking = true;

  pythonImportsCheck = [
    "pyatv"
  ];

  meta = with lib; {
    description = "Python client library for the Apple TV";
    homepage = "https://github.com/postlund/pyatv";
    license = licenses.mit;
    maintainers = with maintainers; [ elseym ];
  };
}
