{ stdenv, fetchurl, python, root, makeWrapper, zlib, withRootSupport ? false }:

stdenv.mkDerivation rec {
  pname = "yoda";
  version = "1.8.2";

  src = fetchurl {
    url = "https://www.hepforge.org/archive/yoda/YODA-${version}.tar.bz2";
    sha256 = "1nqbv334iwdvbsc5bw8g936cxzc1hyzv9r8kjy4v124vrw8qqmc9";
  };

  nativeBuildInputs = with python.pkgs; [ cython makeWrapper ];
  buildInputs = [ python ]
    ++ (with python.pkgs; [ numpy matplotlib ])
    ++ stdenv.lib.optional withRootSupport root;
  propagatedBuildInputs = [ zlib ];

  enableParallelBuilding = true;

  postPatch = ''
    touch pyext/yoda/*.{pyx,pxd}
    patchShebangs .
  '';

  postInstall = ''
    for prog in "$out"/bin/*; do
      wrapProgram "$prog" --set PYTHONPATH $PYTHONPATH:$(toPythonPath "$out")
    done
  '';

  hardeningDisable = [ "format" ];

  doInstallCheck = true;
  installCheckTarget = "check";

  meta = {
    description = "Provides small set of data analysis (specifically histogramming) classes";
    license     = stdenv.lib.licenses.gpl3;
    homepage    = "https://yoda.hepforge.org";
    platforms   = stdenv.lib.platforms.unix;
    maintainers = with stdenv.lib.maintainers; [ veprbl ];
  };
}
