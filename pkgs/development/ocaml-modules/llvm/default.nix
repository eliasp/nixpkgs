{ stdenv, lib, python2, cmake, libllvm, ocaml, findlib, ctypes }:

let version = lib.getVersion libllvm; in

stdenv.mkDerivation {
  pname = "ocaml-llvm";
  inherit version;

  inherit (libllvm) src;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ python2 ocaml findlib ctypes ];
  propagatedBuildInputs = [ libllvm ];

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=YES" # fixes bytecode builds
    "-DLLVM_OCAML_OUT_OF_TREE=TRUE"
    "-DLLVM_OCAML_INSTALL_PATH=${placeholder "out"}/ocaml"
    "-DLLVM_OCAML_EXTERNAL_LLVM_LIBDIR=${lib.getLib libllvm}/lib"
  ];

  buildFlags = [ "ocaml_all" ];

  installFlags = [ "-C" "bindings/ocaml" ];

  postInstall = ''
    mkdir -p $OCAMLFIND_DESTDIR/
    mv $out/ocaml $OCAMLFIND_DESTDIR/llvm
    mv $OCAMLFIND_DESTDIR/llvm/META{.llvm,}
    mv $OCAMLFIND_DESTDIR/llvm/stublibs $OCAMLFIND_DESTDIR/stublibs
  '';

  passthru = {
    inherit libllvm;
  };

  meta = {
    inherit (libllvm.meta) license homepage;
    platforms = ocaml.meta.platforms or [];
    description = "OCaml bindings distributed with LLVM";
    maintainers = with lib.maintainers; [ vbgl ];
  };

}
