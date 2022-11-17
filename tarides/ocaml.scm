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

(define-public ocaml-bheap
  (package
    (name "ocaml-bheap")
    (version "2.0.0")
    (home-page "https://github.com/backtracking/bheap")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url home-page)
              (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0b8md5zl4yz7j62jz0bf7lwyl0pyqkxqx36ghkgkbkxb4zzggfj1"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (native-inputs
      `(("ocaml-stdlib-shims" ,ocaml-stdlib-shims)))
    (synopsis "Priority queues")
    (description
      "Traditional implementation using a binary heap encoded in a resizable array.")
    (license license:lgpl2.1)))

(define-public ocaml-vector
  (package
   (name "ocaml-vector")
   (version "1.0.0")
   (home-page "https://github.com/backtracking/vector")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "00ga0sjljhg9f8vfj297m2bip5hw4cmx8i3fdalzdk1fkvj7qmj6"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (synopsis "Resizable Arrays for OCaml")
   (description "An OCaml library that provides vectors - dynamic, growable arrays.")
   (license license:lgpl2.1)))

(define-public ocaml-progress
  (package
   (name "ocaml-progress")
   (version "0.2.1")
   (home-page "https://github.com/CraigFe/progress")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "07yi7qbhf5lm4ykff78wxbp1nzyxl9f4a3ndlrgwrcri7w41miid"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (propagated-inputs (list ocaml-fmt
			    ocaml-logs
			    ocaml-mtime
			    ocaml-uucp
			    ocaml-uutf
			    ocaml-vector
			    ocaml-optint))
   (native-inputs (list ocaml-alcotest ocaml-astring))
   (synopsis "User-definable progress bars")
   (description
    "This package provides a progress bar library for OCaml, featuring a DSL for
declaratively specifying progress bar formats.  Supports rendering multiple
progress bars simultaneously.")
   (license license:expat)))
