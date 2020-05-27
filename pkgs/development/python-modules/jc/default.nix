{ stdenv
, buildPythonPackage
, fetchFromGitHub
, ruamel_yaml
, xmltodict
, pygments
, isPy27
}:

buildPythonPackage rec {
  pname = "jc";
  version = "1.10.12";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "kellyjonbrazil";
    repo = "jc";
    rev = "v${version}";
    sha256 = "04gggx47acckyd96cginrw7ldw7fqgkiggk9fxdij2hwi03mk4n4";
  };

  propagatedBuildInputs = [ ruamel_yaml xmltodict pygments ];

  meta = with stdenv.lib; {
    description = "This tool serializes the output of popular command line tools and filetypes to structured JSON output.";
    homepage = "https://github.com/kellyjonbrazil/jc";
    license = licenses.mit;
    maintainers = with maintainers; [ atemu ];
  };
}
