{ buildGoModule, lib, fetchFromGitHub, undmg, fetchurl, stdenv }:
let
  name = "aws-vault";
  ver = "6.2.0";
  source = if stdenv.isDarwin then fetchurl {
    url = "https://github.com/BookBub/aws-vault/releases/download/v${ver}/aws-vault-darwin.tar.gz";
    sha256 = "0lmv5skszq5whpb4l17fhym85n5f9mam385wzpyqfjd6m2vdv5gi";
  } else fetchFromGitHub {
    owner = "99designs";
    repo = name;
    rev = "v${ver}";
    sha256 = "0892fhjmxnms09bfbjnngnnnli2d4nkwq44fw98yb3d5lbpa1j1j";
  };
in
buildGoModule rec {
  pname = name;
  version = ver;

  src = source;

  vendorSha256 = "18lmxx784377x1v0gr6fkdx5flhcajsqlzyjx508z0kih6ammc0z";

  doCheck = false;

  subPackages = [ "." ];

  # set the version. see: aws-vault's Makefile
  buildFlagsArray = ''
    -ldflags=
    -X main.Version=v${version}
  '';

  meta = with lib; {
    description =
      "A vault for securely storing and accessing AWS credentials in development environments";
    homepage = "https://github.com/99designs/aws-vault";
    license = licenses.mit;
    maintainers = with maintainers; [ zimbatm ];
  };
}
