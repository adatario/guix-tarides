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

(define irmin
  (let ((commit "117873112abd5929f4a8b928eacdaa2dac17c210")
	(revision "0"))
    (package
     (name "irmin")
     (version (git-version "3.4.3" revision commit))
     (home-page "https://github.com/mirage/irmin")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url home-page)
	     (commit commit)))
       (sha256
	(base32
	 "0gbgscypp1xc84vh0b4f35m000hhvl2dxxc5ffinqalcwrl72hdp"))))
     (build-system dune-build-system)
     (synopsis "Irmin, a distributed database that follows the same design
principles as Git")
    (description "Irmin is a library for persistent stores with built-in
snapshot, branching and reverting mechanisms. It is designed to use a large
variety of backends. Irmin is written in pure OCaml and does not depend on
external C stubs; it aims to run everywhere, from Linux, to browsers and Xen
unikernels.")
    (license license:isc))))

(define-public ocaml-ppx-irmin
  (package
   (inherit irmin-dev-local)
   (name "ocaml-ppx-irmin")
   (arguments `(#:package "ppx_irmin"))
   (propagated-inputs (list ocaml-ppx-repr ocaml-logs))
   (synopsis "PPX deriver for Irmin type representations")))

(define-public ocaml-irmin
  (package
   (inherit irmin-dev-local)
   (name "ocaml-irmin")
   (arguments `(#:package "irmin"))
   (propagated-inputs
    (list ocaml-repr
	  ocaml-fmt
	  ocaml-uri
	  ocaml-uutf
	  ocaml-jsonm
	  ocaml-ppx-irmin
	  ocaml-digestif
	  ocaml-graph
	  ocaml-logs
	  ocaml-bheap
	  ocaml-astring))
   (native-inputs (list ocaml-alcotest ocaml-vector ocaml-fmt))))

