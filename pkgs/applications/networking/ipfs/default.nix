{ stdenv, buildGoModule, fetchurl, nixosTests }:

buildGoModule rec {
  pname = "ipfs";
  version = "0.5.1";
  rev = "v${version}";

  # go-ipfs makes changes to it's source tarball that don't match the git source.
  src = fetchurl {
    url = "https://github.com/ipfs/go-ipfs/releases/download/${rev}/go-ipfs-source.tar.gz";
    sha256 = "0lpilycjbc1g9adp4d5kryfprixj18hg3235fnivakmv7fy2akkm";
  };

  # tarball contains multiple files/directories
  postUnpack = ''
    mkdir ipfs-src
    mv * ipfs-src || true
    cd ipfs-src
  '';

  sourceRoot = ".";

  subPackages = [ "cmd/ipfs" ];

  passthru.tests.ipfs = nixosTests.ipfs;

  vendorSha256 = null;

  meta = with stdenv.lib; {
    description = "A global, versioned, peer-to-peer filesystem";
    homepage = "https://ipfs.io/";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ fpletz ];
  };
}
