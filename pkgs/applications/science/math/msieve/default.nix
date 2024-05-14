{ lib, stdenv, fetchsvn, zlib, gmp, ecm }:

stdenv.mkDerivation rec {
  pname = "msieve";
  version = "r1051";

  src = fetchsvn {
    url = "svn://svn.code.sf.net/p/msieve/code/trunk";
    rev = "1051";
    hash = "sha256-PUCMlCh3RghJvaN598kKJBl1HlGgZzQ3GQ2KtsmXtis=";
  };

  buildInputs = [ zlib gmp ecm ];

  ECM = if ecm == null then "0" else "1";

  # Doesn't hurt Linux but lets clang-based platforms like Darwin work fine too
  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" "all" ];

  installPhase = ''
    mkdir -p $out/bin/
    cp msieve $out/bin/
  '';

  meta = {
    description = "A C library implementing a suite of algorithms to factor large integers";
    mainProgram = "msieve";
    license = lib.licenses.publicDomain;
    homepage = "http://msieve.sourceforge.net/";
    maintainers = [ lib.maintainers.roconnor ];
    platforms = [ "x86_64-linux" ] ++ lib.platforms.darwin;
  };
}
