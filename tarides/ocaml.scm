; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides ocaml)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pkg-config))

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

(define-public ocaml-semaphore-compat
  (package
   (name "ocaml-semaphore-compat")
   (version "1.0.1")
   (home-page "https://github.com/mirage/semaphore-compat")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1k6pbc0170166wif6a92lc77ifhmb1hydx9r1h3wlpsz2r3j59ds"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (synopsis "Compatibility Semaphore module")
   (description
    "Projects that want to use the Semaphore module defined in OCaml 4.12.0 while
staying compatible with older versions of OCaml should use this library instead.")
   (license license:lgpl2.0)))

(define-public ocaml-psq
  (package
   (name "ocaml-psq")
   (version "0.2.1")
   (home-page "https://github.com/pqwy/psq")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0ahxbzkbq5sw8sqv31c2lil2zny4076q8b0dc7h5slq7i2r23d79"))))
   (build-system dune-build-system)
   (propagated-inputs (list ocaml-seq))
   (native-inputs (list ocaml-qcheck ocaml-alcotest))
   (synopsis "Functional Priority Search Queues")
   (description
    "Typical applications are searches, schedulers and caches.  If you ever scratched
your head because that A* didn't look quite right, a PSQ is what you needed.")
   (license license:isc)))

(define-public ocaml-lru
  (package
   (name "ocaml-lru")
   (version "0.3.1")
   (home-page "https://github.com/pqwy/lru")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0xjy0h484j5skrxax26vnj9kn6pf40dkj6rjghw02c467s3lcfv8"))))
   (build-system dune-build-system)
   (propagated-inputs (list ocaml-psq))
   (native-inputs (list ocaml-qcheck ocaml-alcotest))
   (synopsis "Scalable LRU caches")
   (description
    "Lru provides weight-bounded finite maps that can remove the least-recently-used
(LRU) bindings in order to maintain a weight constraint.")
   (license license:isc)))

(define-public ocaml-checkseum
  (package
   (name "ocaml-checkseum")
   (version "0.4.0")
   (home-page "https://github.com/mirage/checkseum")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "10xi3g1jini3nlijhvdawsxpzpbaahx5wq7n7fzxcj29dm29bzns"))))
   (build-system dune-build-system)
   (propagated-inputs (list ocaml-optint))
   (native-inputs
    (list pkg-config
	  ocaml-alcotest
	  ocaml-bos
	  ocaml-astring
	  ocaml-fmt
	  ocaml-fpath
	  ocaml-rresult
	  ocaml-findlib))
   (synopsis "Adler-32, CRC32 and CRC32-C implementation in C and OCaml")
   (description
    "Checkseum is a library to provide implementation of Adler-32, CRC32 and CRC32-C
in C and OCaml.  This library use the linking trick to choose between the C
implementation (checkseum.c) or the OCaml implementation (checkseum.ocaml).
This library is on top of optint to get the best representation of an int32.")
   (license license:expat)))
