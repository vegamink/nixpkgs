{ lib
, buildPythonPackage
, fastapi
, fetchFromGitHub
, limits
, mock
, hiro
, poetry-core
, pytestCheckHook
, pythonOlder
, redis
, starlette
}:

buildPythonPackage rec {
  pname = "slowapi";
  version = "0.1.5";
  format = "pyproject";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "laurentS";
    repo = pname;
    rev = "v${version}";
    sha256 = "1wjnlhjfgil86h6i5yij723ncg18rqdprs1q6i68w4msaspwpxg9";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    limits
    redis
  ];

  checkInputs = [
    fastapi
    hiro
    mock
    pytestCheckHook
    starlette
  ];

  disabledTests = [
    # E       AssertionError: Regex pattern 'parameter `request` must be an instance of starlette.requests.Request' does not match 'This portal is not running'.
    "test_endpoint_request_param_invalid"
    "test_endpoint_response_param_invalid"
  ];

  pythonImportsCheck = [ "slowapi" ];

  meta = with lib; {
    description = "Python library for API rate limiting";
    homepage = "https://github.com/laurentS/slowapi";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
