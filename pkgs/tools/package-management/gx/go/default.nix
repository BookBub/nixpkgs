# This file was generated by go2nix.
{ stdenv, buildGoPackage, fetchgit
, gx
}:

buildGoPackage rec {
  pname = "gx-go";
  version = "1.9.0";
  rev = "refs/tags/v${version}";

  goPackagePath = "github.com/whyrusleeping/gx-go";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/whyrusleeping/gx-go";
    sha256 = "0fdy4b3ymqw6hzvvjwq37mfrdmizc8lxm53axw93n3x6118na9jc";
  };

  goDeps = ./deps.nix;

  extraSrcs = [
    {
      goPackagePath = gx.goPackagePath;
      src = gx.src;
    }
  ];

  meta = with stdenv.lib; {
    description = "A tool for importing go packages into gx";
    homepage = https://github.com/whyrusleeping/gx-go;
    license = licenses.mit;
    maintainers = with maintainers; [ zimbatm ];
  };
}
