; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides irmin)
  #:use-module (guix package)
  #:use-module (guix git)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pkg-config))

(define-public ocaml-repr
  (let (;; Tests are fixed in an unreleased commit (https://github.com/mirage/repr/pull/100)
	(commit "9dfc5a3d234759aaac6636bc5a2925449c781e8a")
	(revision "0"))
    (package
     (name "ocaml-repr")
     (version (git-version "0.6.0" revision commit))
     (home-page "https://github.com/mirage/repr")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url home-page)
	     (commit commit)))
       (sha256
	(base32
	 "1zwcxh8pkv35ldl6svqylwp4203824zlnfc51afcvyaq9ka1z517"))))
     (build-system dune-build-system)
     (arguments `(#:package "repr"))
     (propagated-inputs (list ocaml-fmt
                              ocaml-uutf
                              ocaml-either
                              ocaml-jsonm
                              ocaml-base64
                              ocaml-optint))
     (synopsis "Dynamic type representations. Provides no stability guarantee")
     (description
      "This package defines a library of combinators for building dynamic type
representations and a set of generic operations over representable types, used
in the implementation of Irmin and related packages.  It is not yet intended for
public consumption and provides no stability guarantee.")
     (license license:isc))))

(define-public ocaml-ppx-repr
  (package
   (inherit ocaml-repr)
   (arguments `(#:package "ppx_repr"))
   (propagated-inputs
    (list ocaml-repr ocaml-ppxlib))
   (native-inputs (list ocaml-alcotest ocaml-hex))))
