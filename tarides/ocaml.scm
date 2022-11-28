; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides ocaml)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module (guix build-system ocaml)
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

(define-public ocaml-rusage
  (package
   (name "ocaml-rusage")
   (version "1.0.0")
   (home-page "https://github.com/CraigFe/ocaml-rusage")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "1359xzd8i0ilgb7jrcqxnbi8p2gx1na5jli5f1pf327j8kf2vk2s"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (synopsis "Bindings to the GETRUSAGE(2) syscall")
   (description "Bindings to the GETRUSAGE(2) syscall")
   (license license:expat)))

(define-public ocaml-metrics
  ;; Contains fix for more recent versions of mtime (see https://github.com/mirage/metrics/pull/58)
  (let ((commit "995eb18d2837df02c8ead719c00fb156cf475ab5")
	(revision "0"))
    (package
     (name "ocaml-metrics")
     (version (git-version "0.4.0" revision commit))
     (home-page "https://github.com/mirage/metrics")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url home-page)
	     (commit commit)))
       (sha256
	(base32
	 "14mlakahpkhckiv3vmpkdndgmm70g790a2ncjm4r73fcscpvrlbr"))))
     (build-system dune-build-system)
     (arguments `(#:package "metrics"))
     (propagated-inputs (list ocaml-fmt))
     (native-inputs (list ocaml-alcotest))
     (synopsis "Metrics infrastructure for OCaml")
     (description
      "Metrics provides a basic infrastructure to monitor and gather runtime metrics
for OCaml program.  Monitoring is performed on sources, indexed by tags,
allowing users to enable or disable at runtime the gathering of data-points.  As
disabled metric sources have a low runtime cost (only a closure allocation), the
library is designed to instrument production systems.  Metric reporting is
decoupled from monitoring and is handled by a custom reporter.  A few reporters
are (will be) provided by default.  Metrics is heavily inspired by
[Logs](http://erratique.ch/software/logs).")
     (license license:isc))))

(define-public ocaml-metrics-lwt
  (package
   (inherit ocaml-metrics)
   (name "ocaml-metrics-lwt")
   (arguments `(#:package "metrics-lwt"))
   (propagated-inputs
    (list ocaml-metrics ocaml-lwt ocaml-logs))))

(define-public ocaml-metrics-unix
  (package
   (inherit ocaml-metrics)
   (arguments `(#:package "metrics-unix"))
   (propagated-inputs
    (list ocaml-metrics ocaml-uuidm ocaml-mtime
	  ocaml-lwt
	  ocaml-fmt))
   (native-inputs
    (list ocaml-alcotest
	  ocaml-metrics-lwt
	  gnuplot))))

(define-public ocaml-alcotest-lwt
  (package
    (inherit ocaml-alcotest)
    (name "ocaml-alcotest-lwt")
    (arguments
     `(#:package "alcotest-lwt"
       #:tests? #f))
    (propagated-inputs
     `(("ocaml-alcotest" ,ocaml-alcotest)
       ("ocaml-lwt" ,ocaml-lwt)
       ("ocaml-logs" ,ocaml-logs)))))

(define-public ocaml-zarith-stubs-js
  (package
   (name "ocaml-zarith-stubs-js")
   (version "0.15.0")
   (source
    (origin
     (method url-fetch)
     (uri "https://ocaml.janestreet.com/ocaml-core/v0.15/files/zarith_stubs_js-v0.15.0.tar.gz")
     (sha256
      (base32 "03sk4awj6wgxq740k0132y1f53q7gz8lw4pd9slf4xynhgw34pps"))))
   (build-system dune-build-system)
   (arguments `(#:tests? #f))
   (properties `((upstream-name . "zarith_stubs_js")))
   (home-page "https://github.com/janestreet/zarith_stubs_js")
   (synopsis "Javascripts stubs for the Zarith library")
   (description
    " This library contains no ocaml code, but instead implements all of the Zarith C
stubs in Javascript for use in Js_of_ocaml")
   (license license:expat)))

(define-public ocaml-ringo-0.9
  (package
   (name "ocaml-ringo")
   (version "0.9")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://gitlab.com/nomadic-labs/ringo.git")
	   (commit (string-append "v" version))))

     (sha256
      (base32
       "1mb7sv2ks5xdjkawmf7fqjb0p0hyp1az8myhqfld76kcnidgxxll"))))
   (build-system dune-build-system)
   (arguments `(#:package "ringo"))
   (home-page "https://gitlab.com/nomadic-labs/ringo")
   (synopsis "Ring data-structure and ring-derived data-structures for OCaml")
   (description "Ring data-structure and ring-derived data-structures for OCaml")
   (license license:expat)))

(define-public ocaml-ringo
  (package
   (name "ocaml-ringo")
   (version "1.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://gitlab.com/nomadic-labs/ringo.git")
	   (commit (string-append "v" version))))

     (sha256
      (base32
       "1r9sifyyndh18187l8llvcjndh9z6dy3072zdh7v3in1dqrvfxgl"))))
   (build-system dune-build-system)
   (arguments `(#:package "ringo"))
   (home-page "https://gitlab.com/nomadic-labs/ringo")
   (synopsis "Ring data-structure and ring-derived data-structures for OCaml")
   (description "Ring data-structure and ring-derived data-structures for OCaml")
   (license license:expat)))

(define-public ocaml-omd
  (package
    (name "ocaml-omd")
    (version "2.0.0-alpha2")
    (home-page "https://github.com/ocaml/omd")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url home-page)
	    (commit "2.0.0.alpha2")))
      (sha256
       (base32
	"1wa14fqr048dyldv2ppdj6p8wnb75i3rjb4phk5kwp6g43p8bnka"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (synopsis "A Markdown frontend in pure OCaml")
    (description
     "This Markdown library is implemented using only pure OCaml (including I/O
operations provided by the standard OCaml compiler distribution).  OMD is meant
to be as faithful as possible to the original Markdown.  Additionally, OMD
implements a few Github markdown features, an extension mechanism, and some
other features.  Note that the opam package installs both the OMD library and
the command line tool `omd`.")
    (license license:isc)))

(define-public ocaml-json-data-encoding
  (package
    (name "ocaml-json-data-encoding")
    (version "0.12.1")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://gitlab.com/nomadic-labs/json-data-encoding.git")
	    (commit version)))

      (sha256
       (base32
	"03n24r4y472j5lq09jjzlk13zv20ai7l0knich4d8552waa2w9xn"))))
    (build-system dune-build-system)
    (arguments `(#:package "json-data-encoding"))
    (propagated-inputs (list ocaml-uri js-of-ocaml))
    (native-inputs (list ocaml-crowbar ocaml-alcotest))
    (home-page "https://gitlab.com/nomadic-labs/json-data-encoding")
    (synopsis "Type-safe encoding to and decoding from JSON")
    (description #f)
    (license license:expat)))

(define-public ocaml-json-data-encoding-bson
  (package
   (inherit ocaml-json-data-encoding)
   (name "ocaml-json-data-encoding-bson")
   (arguments `(#:package "json-data-encoding-bson"))
   (propagated-inputs
    (list ocaml-uri
	  ocaml-json-data-encoding
	  ocaml-ocplib-endian))))

(define-public ocaml-data-encoding
  (package
    (name "ocaml-data-encoding")
    (version "0.7.1")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://gitlab.com/nomadic-labs/data-encoding.git")
	    (commit (string-append "v" version))))

      (sha256
       (base32
	"0998b3vhbaa1swl6xqj9n0j95ml6dhi5b2lg70mynlv85c4f4xap"))))
    (build-system dune-build-system)
    (propagated-inputs (list ocaml-ezjsonm
                             ocaml-zarith
                             ocaml-zarith-stubs-js
			     gmp
                             ocaml-hex
                             ocaml-json-data-encoding
                             ocaml-json-data-encoding-bson
                             ocaml-either
                             ocaml-ppx-hash
                             ocamlformat
                             ocaml-odoc))
    (native-inputs (list ocaml-alcotest
			 ocaml-crowbar
			 ocaml-ppx-expect
			 js-of-ocaml))
    (home-page "https://gitlab.com/nomadic-labs/data-encoding")
    (synopsis "Library of JSON and binary encoding combinators")
    (description #f)
    (license license:expat)))

(define-public ocaml-pure-splitmix
  (package
   (name "ocaml-pure-splitmix")
   (version "0.3")
   (home-page "https://github.com/Lysxia/pure-splitmix")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (sha256
      (base32
       "1dd9ycciydnaj7ymphcfb1iwdcgd70bimcnh48xmyc913q0fqja5"))))
   (build-system dune-build-system)
   (synopsis "Purely functional splittable PRNG")
   (description #f)
   (license license:expat)))

(define-public ocaml-bigstring
  (package
   (name "ocaml-bigstring")
   (version "0.3")
   (home-page "https://github.com/c-cube/ocaml-bigstring")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (sha256
      (base32
       "0bkxwdcswy80f6rmx5wjza92xzq4rdqsb4a9fm8aav8bdqx021n8"))))
   (build-system dune-build-system)
   (native-inputs
    (list ocaml-alcotest))
   (synopsis "Overlay over bigarrays of chars (deprecated use ocaml-bigstringaf)")
   (description #f)
   (license license:bsd-2)))
(define-public ocaml-ptime
  (package
  (name "ocaml-ptime")
  (version "0.8.5")
  (source
    (origin
      (method url-fetch)
      (uri "https://erratique.ch/software/ptime/releases/ptime-0.8.5.tbz")
      (sha256
        (base32
          "1fxq57xy1ajzfdnvv5zfm7ap2nf49znw5f9gbi4kb9vds942ij27"))))
  (build-system ocaml-build-system)
  (arguments
   `(#:build-flags (list "build" "--with-js_of_ocaml" "true" "--tests" "true")
     #:phases
     (modify-phases %standard-phases
       (delete 'configure))))
  (propagated-inputs
   `(("ocaml-result" ,ocaml-result)
     ("js-of-ocaml" ,js-of-ocaml)))
  (native-inputs
    `(("ocaml-findlib" ,ocaml-findlib)
      ("ocamlbuild" ,ocamlbuild)
      ("ocaml-topkg" ,ocaml-topkg)
      ("opam" ,opam)))
  (home-page "https://erratique.ch/software/ptime")
  (synopsis "POSIX time for OCaml")
  (description
    "Ptime offers platform independent POSIX time support in pure OCaml. It
provides a type to represent a well-defined range of POSIX timestamps
with picosecond precision, conversion with date-time values,
conversion with [RFC 3339 timestamps][rfc3339] and pretty printing to a
human-readable, locale-independent representation.")
  (license license:isc)))
