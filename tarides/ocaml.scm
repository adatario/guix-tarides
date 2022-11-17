; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides ocaml)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml))

(define-public ocaml-monolith
  (package
   (name "ocaml-monolith")
   (version "20210525")
   (home-page "https://gitlab.inria.fr/fpottier/monolith")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url (string-append home-page ".git"))
	   (commit version)))
     (sha256
      (base32
       "1b6jj4ivl9ni8kba7wls4xsqdy8nm7q9mnx9347jvb99dmmlj5mc"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (native-inputs (list ocaml-afl-persistent ocaml-pprint ocaml-seq))
   (synopsis "An OCaml framework for testing a library using
afl-fuzz")
   (description #f)
   (license license:lgpl3+)))

(define-public ocaml-optint
  (package
   (name "ocaml-optint")
   (version "0.2.0")
   (home-page "https://github.com/mirage/optint")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "0d82nf9w46zbyfq3h3n2b9jajvv8gndjyc168xzzk328vj63i12p"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (native-inputs (list ocaml-crowbar ocaml-monolith ocaml-fmt))
   (synopsis "Efficient integer types on 64-bit architectures")
   (description
    "This library provides two new integer types, `Optint.t` and `Int63.t`, which
guarantee efficient representation on 64-bit architectures and provide a
best-effort boxed representation on 32-bit architectures.  Implementation
depends on target architecture.")
   (license license:isc)))
