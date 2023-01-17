; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

;; This module contains general OCaml package definitions that could
;; be/should be upstreamed to Guix.

(define-module (tarides packages ocaml)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module (guix build-system ocaml)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pkg-config))

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
     (list ocaml-stdlib-shims))
    (synopsis "OCaml library providing priority queues")
    (description
      "This OCaml library provides priority queues using a binary heap
encoded in a resizable array.")
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
   (description "An OCaml library that provides vectors - dynamic,
growable arrays.")
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
   (synopsis "User-definable progress bars for OCaml")
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
   (synopsis "OCaml compatibility Semaphore module")
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
   (synopsis "Functional Priority Search Queues for OCaml")
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
   (synopsis "Scalable LRU caches for OCaml")
   (description
    "This OCaml library provides weight-bounded finite maps that can
remove the least-recently-used (LRU) bindings in order to maintain a
weight constraint.")
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
   (name "ocaml-metrics-unix")
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
     (list ocaml-alcotest
	   ocaml-lwt
	   ocaml-logs))))

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
   (arguments `(#:package "ringo"
		;; TODO check why tests fail.
		#:tests? #f))
   (propagated-inputs
    (list ocaml-lwt))
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
    (version "0.6")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://gitlab.com/nomadic-labs/data-encoding.git")
	    (commit (string-append "v" version))))

      (sha256
       (base32
	"0kaw8rblvr247r8lpd5s4sm7h8z3rj9pmv63a6szmyy6akp1a0d1"))))
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

(define-public ocaml-notty
  (package
   (name "ocaml-notty")
   (version "0.2.3")
   (home-page "https://github.com/pqwy/notty")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "1j9788vdygw3n9nmr8f2c6v2hqm2b35366xwh8sb5cy5yhpbcr13"))))
   (build-system dune-build-system)
   (arguments `(#:package "notty"
		#:test-target "."))
   (propagated-inputs (list ocaml-uutf ocaml-ptime))
   (native-inputs (list ocaml-cppo))
   (synopsis "Declaring terminals for OCaml")
   (description
    "Notty is a declarative terminal library for OCaml structured around a notion of
composable images.  It tries to abstract away the basic terminal programming
model, providing something simpler and more expressive.")
   (license license:isc)))

(define-public ocaml-ptime
  (package
  (name "ocaml-ptime")
  (version "1.1.0")
  (source
    (origin
      (method url-fetch)
      (uri
       (string-append
	"https://erratique.ch/software/ptime/releases/ptime-"
	version ".tbz"))
      (sha256
        (base32
          "1c9y07vnvllfprf0z1vqf6fr73qxw7hj6h1k5ig109zvaiab3xfb"))))
  (build-system ocaml-build-system)
  (arguments
   `(#:build-flags (list "build" "--tests" "true")
     #:phases
     (modify-phases %standard-phases
       (delete 'configure))))
  (native-inputs
   (list ocaml-findlib
	 ocamlbuild
	 ocaml-topkg
	 opam))
  (home-page "https://erratique.ch/software/ptime")
  (synopsis "POSIX time for OCaml")
  (description
    "Ptime offers platform independent POSIX time support in pure OCaml. It
provides a type to represent a well-defined range of POSIX timestamps
with picosecond precision, conversion with date-time values,
conversion with [RFC 3339 timestamps][rfc3339] and pretty printing to a
human-readable, locale-independent representation.")
  (license license:isc)))

(define-public ocaml-domain-name
  (package
    (name "ocaml-domain-name")
    (version "0.4.0")
    (home-page "https://github.com/hannesm/domain-name")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url home-page)
	    (commit (string-append "v" version))))
      (sha256
       (base32
	"1a669zz1pc7sqbi1c13jsnp8algcph2b8gr5fjrjhyh3p232770k"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (native-inputs (list ocaml-alcotest))
    (synopsis "OCaml library for working with internet domain names")
    (description
     "This package provides a domain name is a sequence of labels separated by dots,
such as `foo.example`.  Each label may contain any bytes.  The length of each
label may not exceed 63 charactes.  The total length of a domain name is limited
to 253 (byte representation is 255), but other protocols (such as SMTP) may
apply even smaller limits.  A domain name label is case preserving, comparison
is done in a case insensitive manner.")
    (license license:isc)))

(define-public ocaml-macaddr
  (package
   (name "ocaml-macaddr")
   (version "5.3.1")
   (home-page "https://github.com/mirage/ocaml-ipaddr")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "1zgwx0ms3l4k4dzwnkrwq4zzqjrddjsvqn66mbd0rm6aq1ib019d"))))
   (build-system dune-build-system)
   (arguments `(#:package "macaddr"
		#:test-target "."))
   (native-inputs (list ocaml-ounit2 ocaml-ppx-sexp-conv))
   (synopsis "An OCaml library for manipulation of MAC address representations")
   (description
    "This package provides a library for manipulation of MAC address representations.
 Features: * ounit2-based tests * MAC-48 (Ethernet) address support * `Macaddr`
is a `Map.OrderedType` * All types have sexplib serializers/deserializers
optionally via the `Macaddr_sexp` library.")
   (license license:isc)))

(define-public ocaml-ipaddr
  (package
   (inherit ocaml-macaddr)
   (name "ocaml-ipaddr")
    (build-system dune-build-system)
    (arguments `(#:package "ipaddr"
		 #:test-target "."))
    (propagated-inputs (list ocaml-macaddr ocaml-domain-name))
    (native-inputs (list ocaml-ounit2 ocaml-ppx-sexp-conv))
    (home-page "https://github.com/mirage/ocaml-ipaddr")
    (synopsis
     "An OCaml library for manipulation of IP (and MAC) address representations")
    (description
     "Features: * Depends only on sexplib (conditionalization under consideration) *
ounit2-based tests * IPv4 and IPv6 support * IPv4 and IPv6 CIDR prefix support *
IPv4 and IPv6 [CIDR-scoped
address](http://tools.ietf.org/html/rfc4291#section-2.3) support * `Ipaddr.V4`
and `Ipaddr.V4.Prefix` modules are `Map.OrderedType` * `Ipaddr.V6` and
`Ipaddr.V6.Prefix` modules are `Map.OrderedType` * `Ipaddr` and `Ipaddr.Prefix`
modules are `Map.OrderedType` * `Ipaddr_unix` in findlib subpackage
`ipaddr.unix` provides compatibility with the standard library `Unix` module *
`Ipaddr_top` in findlib subpackage `ipaddr.top` provides top-level pretty
printers (requires compiler-libs default since OCaml 4.0) * IP address scope
classification * IPv4-mapped addresses in IPv6 (::ffff:0:0/96) are an embedding
of IPv4 * MAC-48 (Ethernet) address support * `Macaddr` is a `Map.OrderedType` *
All types have sexplib serializers/deserializers")
    (license license:isc)))

(define-public ocaml-ipaddr-cstruct
  (package
    (inherit ocaml-macaddr)
    (name "ocaml-ipaddr-cstruct")
    (arguments `(#:package "ipaddr-cstruct"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-ipaddr
	   ocaml-cstruct))
    (synopsis "OCaml library for manipulation of IP addresses as C-like structres")
    (description "This OCaml library provides functions for manipulating as
C-like structures using the @code{ocaml-cstruct} library.")))

(define-public ocaml-ipaddr-sexp
  (package
    (inherit ocaml-macaddr)
    (name "ocaml-ipaddr-sexp")
    (arguments `(#:package "ipaddr-sexp"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-ipaddr
	   ocaml-ppx-sexp-conv
	   ocaml-sexplib0))
    (native-inputs
     (list ocaml-ipaddr-cstruct
	   ocaml-ounit))
    (synopsis "OCaml library for manipulation of IP addresses as S-expressions")
    (description "This OCaml library provides functions for manipulating as
S-expressions using the @code{ocaml-sexp} library.")))

(define-public ocaml-conduit
  (package
    (name "ocaml-conduit")
    (version "6.0.1")
    (home-page "https://github.com/mirage/ocaml-conduit")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1p46f8k9q3fl4vf00ln4yj0lhf2xp6zl23jyi5bzdaf4mrc6wvch"))))
    (build-system dune-build-system)
    (arguments `(#:package "conduit"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-ppx-sexp-conv
	   ocaml-sexplib
	   ocaml-astring
	   ocaml-uri
	   ocaml-logs
	   ocaml-ipaddr
	   ocaml-ipaddr-sexp))
    (synopsis "OCaml library for establishing TCP and SSL/TLS connections")
    (description "This OCaml library provides an abstraction for establishing
TCP and SSL/TLS connections.  This allows using the same type signatures
regardless of the SSL library or platform being used.")
    (license license:isc)))

(define-public ocaml-conduit-lwt
  (package
    (inherit ocaml-conduit)
    (name "ocaml-conduit-lwt")
    (arguments `(#:package "conduit-lwt"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-ppx-sexp-conv
	   ocaml-sexplib
	   ocaml-conduit
	   ocaml-lwt))
    (synopsis "OCaml library for establishing TCP and SSL/TLS connections
using Lwt")
    (description "This OCaml library provides the abstractions for
establishing TCP and SSL/TLS connections from @code{ocaml-conduit} using
@code{ocaml-lwt}.")
    (license license:isc)))

(define-public ocaml-lwt-canceler
  (package
   (name "ocaml-lwt-canceler")
   (version "0.3")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://gitlab.com/nomadic-labs/lwt-canceler.git")
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "1xbb7012hp901b755kxmfgg293rz34rkhwzg2z9i6sakwd7i0h9p"))))
   (build-system dune-build-system)
   (propagated-inputs
    (list ocaml-lwt))
   (arguments `(#:package "lwt-canceler"))
   (home-page "https://gitlab.com/nomadic-labs/lwt-canceler")
   (synopsis "Cancellation synchronization object for OCaml Lwt")
   (description #f)
   (license license:expat)))

(define-public ocaml-mirage-crypto
  (package
    (name "ocaml-mirage-crypto")
    (version "0.10.7")
    (home-page "https://github.com/mirage/mirage-crypto")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1hn0y7cyvf2gqxgz5v7k4hfd829vcyqsa1d13vc4w258z55x0j4b"))))
    (build-system dune-build-system)
    (arguments `(#:package "mirage-crypto"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-eqaf
	   ocaml-bigarray-compat))
    (native-inputs
     (list pkg-config
	   ocaml-ounit))
    (synopsis "OCaml library provding cryptographic primitives")
    (description "This OCaml library provides symmetric ciphers (DES, AES,
RC4, ChaCha20/Poly1305), and hashes (MD5, SHA-1, SHA-2).  This library can be
used from MirageOS unikernels.")
    (license license:isc)))

(define-public ocaml-duration
  (package
    (name "ocaml-duration")
    (version "0.2.1")
    (home-page "https://github.com/hannesm/duration")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0vvxi0ipxmdz1k4h501brvccniwf3wpc32djbccyyrzraiz7qkff"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (native-inputs
     (list ocaml-alcotest))
    (synopsis "OCaml library providing conversions between various time units")
    (description "This OCaml library provides functions for representing a
time duration as an usigned 64 bit integer.  This can be used for conversions
between various time units.")
    (license license:isc)))

(define-public ocaml-randomconv
  (package
    (name "ocaml-randomconv")
    (version "0.1.3")
    (home-page "https://github.com/hannesm/randomconv")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0pzq2zqz5bpy2snsvmn82hg79wfd0lmbbbhmhdvc8k20km86jqy7"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct))
    (synopsis "OCaml library for converting random byte vectors to random numer")
    (description
     "This Ocaml library provides functions for converting random byte vectors
as (C-like structures using @code{ocaml-cstruct}) to OCaml native numbers.")
    (license license:isc)))

(define-public ocaml-mirage-crypto-rng
  (package
    (inherit ocaml-mirage-crypto)
    (name  "ocaml-mirage-crypto-rng")
    (arguments `(#:package "mirage-crypto-rng"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-duration
	   ocaml-cstruct
	   ocaml-logs
	   ocaml-mirage-crypto
	   ocaml-mtime
	   ocaml-lwt))
    (native-inputs
     (list ocaml-ounit
	   ocaml-randomconv))
    (synopsis "Cryptographically secure pseudo-random number generator in
OCaml")
    (description "@code{ocaml-mirage-crypto-rng} provides an OCaml random
number generator interface, and implementations.")))

(define-public ocaml-mirage-crypto-pk
  (package
    (inherit ocaml-mirage-crypto)
    (name  "ocaml-mirage-crypto-pk")
    (arguments `(#:package "mirage-crypto-pk"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-logs
	   ocaml-mirage-crypto
	   ocaml-mirage-crypto-rng
	   ocaml-mtime
	   ocaml-sexplib
	   ocaml-ppx-sexp-conv
	   ocaml-zarith
	   ocaml-eqaf
	   ocaml-rresult))

    (native-inputs
     (list ocaml-ounit
	   ocaml-randomconv))
    (inputs (list gmp))
    (synopsis "OCaml library providing public-key cryptography")
    (description "@code{ocaml-mirage-crypto-pk} provides public-key
cryptography (RSA, DSA, DH) for OCaml.")))

(define-public ocaml-asn1-combinators
  (package
    (name "ocaml-asn1-combinators")
    (version "0.2.6")
    (home-page "https://github.com/mirleft/ocaml-asn1-combinators")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1fkhlfglv0baiaxk4yxha9sv0l3acji74z9mkpdjkh9fn4c9yhv3"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-zarith
	   ocaml-bigarray-compat
	   ocaml-stdlib-shims
	   ocaml-ptime))
    (native-inputs
     (list ocaml-alcotest))
    (inputs (list gmp))
    (synopsis "OCaml library for embedding typed ASN.1 grammars")
    (description "@{ocaml-asn1-combinators} is an OCaml library for expressing
ASN.1 in OCaml.  This allows you to skip the notation part of ASN.1, and embed
the abstract syntax directly in the language.  These abstract syntax
representations can be used for parsing, serialization, or random testing.

The only ASN.1 encodings currently supported are BER and DER.")
    (license license:isc)))

(define-public ocaml-ppx-deriving-yojson
  (package
    (name "ocaml-ppx-deriving-yojson")
    (version "3.6.1") ;; 3.7.0 requires an updated ppxlib
    (home-page "https://github.com/ocaml-ppx/ppx_deriving_yojson")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1icz5h6p3pfj7my5gi7wxpflrb8c902dqa17f9w424njilnpyrbk"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-yojson
	   ocaml-result
	   ocaml-ppx-deriving
	   ocaml-ppxlib))
    (native-inputs (list ocaml-ounit))
    (properties `((upstream-name . "ppx_deriving_yojson")))
    (synopsis "JSON codec generator for OCaml")
    (description "@code{ocaml-ppx-deriving-yojson} is an OCaml ppx_deriving
plugin that provides a JSON codec generator.")
    (license license:expat)))

(define-public ocaml-mirage-crypto-ec
  ;; FIXME: This package contains generated code (see
  ;; https://github.com/mirage/mirage-crypto/blob/main/ec/native/README.md). These
  ;; should be re-generated during the build process.
  (package
    (inherit ocaml-mirage-crypto)
    (name "ocaml-mirage-crypto-ec")
    (arguments `(#:package "mirage-crypto-ec"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-eqaf
	   ocaml-mirage-crypto
	   ocaml-mirage-crypto-rng
	   gmp))
    (native-inputs
     (list pkg-config
	   ocaml-randomconv
	   ocaml-ounit
	   ocaml-mirage-crypto-pk
	   ocaml-asn1-combinators
	   ocaml-hex
	   ocaml-alcotest
	   ocaml-ppx-deriving-yojson
	   ocaml-ppx-deriving
	   ocaml-yojson))
    (synopsis "OCaml library providing Elliptic Curve Cryptography")
    (description "This OCaml library provides an implementation of key exchange
(ECDH) and digital signature (ECDSA/EdDSA) algorithms.  The curves P224
(SECP224R1), P256 (SECP256R1), P384 (SECP384R1),P521 (SECP521R1), and 25519
(X25519, Ed25519) are implemented by this package.")
    ;; See https://github.com/mirage/mirage-crypto/blob/main/ec/LICENSE.md
    (license license:expat)))

(define-public ocaml-pbkdf
  (package
    (name "ocaml-pbkdf")
    (version "1.2.0")
    (home-page "https://github.com/abeaumont/ocaml-pbkdf")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0cmalqa28b19bhprm85zl49vw2d2d4vynjfszi51lm5v1xbvhs3l"))))
    (build-system dune-build-system)
    (propagated-inputs (list ocaml-mirage-crypto))
    (native-inputs (list ocaml-alcotest))
    (synopsis "OCaml library for password based key derivation functions
(PBKDF) from PKCS#5")
    (description "This package provides an OCaml implementation of PBKDF 1 and
2 as defined by PKCS#5 using @code{ocaml-mirage-crypto}.")
    (license license:bsd-2)))

(define-public ocaml-cstruct-unix
  (package
    (inherit ocaml-cstruct)
    (name "ocaml-cstruct-unix")
    (build-system dune-build-system)
    (arguments
     `(#:package "cstruct-unix"
       #:test-target "."))
    (propagated-inputs (list ocaml-cstruct))
    (synopsis "Unix variation of the @code{ocaml-cstruct} library")
    (description "Cstruct is a library and syntax extension to make it easier
to access C-like structures directly from OCaml.  It supports both reading and
writing to these structures, and they are accessed via the `Bigarray`
module.")
    (license license:isc)))

(define-public ocaml-cstruct-sexp
  (package
    (inherit ocaml-cstruct)
    (name "ocaml-cstruct-sexp")
    (build-system dune-build-system)
    (arguments
     `(#:package "cstruct-sexp"
       #:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-sexplib))
    (native-inputs
     (list ocaml-alcotest))
    (synopsis
     "OCaml S-expression serialisers for C-like structures")
    (description
     "This library provides Sexplib serialisers for the C-like
structures as provided by the @code{ocaml-cstruct} package.")
    (license license:isc)))

(define-public ocaml-ppx-cstruct
  (package
    (inherit ocaml-cstruct)
    (name "ocaml-ppx-cstruct")
    (build-system dune-build-system)
    (arguments
     `(#:package "ppx_cstruct"
       #:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-sexplib
	   ocaml-ppxlib))
    (native-inputs
     (list ocaml-ounit
	   ocaml-ppx-sexp-conv
	   ocaml-cstruct-sexp
	   ocaml-cppo
	   ocaml-cstruct-unix
	   ocaml-migrate-parsetree
	   ocaml-lwt))
    (synopsis
     "OCaml syntax extension for writing serialisers for C-like structures")
    (description
     "This OCaml syntax extension generates helper functions for
accessing C-like structures")
    (license license:isc)))

(define-public ocaml-gmap
  (package
    (name "ocaml-gmap")
    (version "0.3.0")
    (home-page "https://github.com/hannesm/gmap")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0880mhcybr662k6wnahx5mwbialh878kkzxacn47qniadd21x411"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-fmt))
    (synopsis "OCaml library for heterogenous maps over a Generalized
Algebraic Data Type")
    (description "@code{ocaml-gmap} exposes an OCaml functor which can be used
to create a type-safe heterogenous maps.")
    (license license:isc)))

(define-public ocaml-x509
  (package
    (name "ocaml-x509")
    (version "0.16.2")
    (home-page "https://github.com/mirleft/ocaml-x509")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1a0gdz7jkgv25v2jmjrh4ynd3xqwvd7rjyfbda37c05pjk0fb0cg"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-cstruct
	   ocaml-asn1-combinators
	   ocaml-ptime
	   ocaml-base64
	   ocaml-mirage-crypto
	   ocaml-mirage-crypto-pk
	   ocaml-mirage-crypto-ec
	   ocaml-mirage-crypto-rng
	   ocaml-rresult
	   ocaml-fmt
	   ocaml-gmap
	   ocaml-domain-name
	   ocaml-ipaddr
	   ocaml-logs
	   ocaml-pbkdf))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-cstruct-unix))
    (synopsis "Public Key Infrastructure (RFC 5280, PKCS) purely in OCaml")
    (description "X.509 is a public key infrastructure used mostly on the
Internet.  It consists of certificates which include public keys and
identifiers, signed by an authority.  Authorities must be exchanged over a
second channel to establish the trust relationship.  This OCaml library
implements most parts of RFC5280 and RFC6125.  The Public Key Cryptography
Standards (PKCS) defines encoding and decoding (in ASN.1 DER and PEM format),
which is also implemented by this library --- namely PKCS 1, PKCS 5, PKCS 7,
PKCS 8, PKCS 9, PKCS 10, and PKCS 12.")
    (license license:bsd-2)))

(define-public ocaml-ca-certs
  (package
    (name "ocaml-ca-certs")
    (version "0.2.3")
    (home-page "https://github.com/mirage/ca-certs")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "198769wkmvvc89ygkq503611bhyspv40z0222ha4pqgjclcbl99i"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."
                 ;; Tests are failing as they require certificates to be in /etc/ssl/certs
                 #:tests? #f))
    (propagated-inputs
     (list ocaml-astring
	   ocaml-bos
	   ocaml-fpath
	   ocaml-rresult
	   ocaml-ptime
	   ocaml-logs
	   ocaml-mirage-crypto
	   ocaml-x509))
    (native-inputs (list ocaml-alcotest))
    (synopsis
     "Detect root CA certificates from the operating system")
    (description
     "TLS requires a set of root anchors (Certificate Authorities) to
authenticate servers.  This library exposes this list so that it can be
registered with ocaml-tls.")
    (license license:isc)))

(define-public ocaml-lwt-ssl
  (package
    (name "ocaml-lwt-ssl")
    (version "1.1.3")
    (home-page "https://github.com/ocsigen/lwt_ssl")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0v417ch5zn0yknj156awa5mrq3mal08pbrvsyribbn63ix6f9y3p"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-lwt
	   ocaml-ssl))
    (properties `((upstream-name . "lwt_ssl")))
    (synopsis "OpenSSL binding for OCaml with concurrent I/O")
    (description "This OCaml library provides an Lwt-enabled wrapper around
@code{ocaml-ssl}, that performs I/O concurrently.")
    (license license:lgpl2.1+))) ; with linking exception

(define-public ocaml-conduit-lwt-unix
  (package
    (inherit ocaml-conduit)
    (name "ocaml-conduit-lwt-unix")
    (arguments `(#:package "conduit-lwt-unix"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-logs
	   ocaml-ppx-sexp-conv
	   ocaml-conduit-lwt
	   ocaml-lwt
	   ocaml-uri
	   ocaml-ipaddr
	   ocaml-ipaddr-sexp
	   ocaml-ca-certs))
    (native-inputs
     (list ocaml-lwt-log
	   ocaml-ssl
	   ocaml-lwt-ssl))
    (synopsis "OCaml library for establishing TCP and SSL/TLC connections
using Lwt_unix")
    (description "This OCaml library provides an implementation
for establishing TCP and SSL/TLS connections for the @code{ocaml-conduit}
signatures using Lwt_unix.")
    (license license:isc)))

(define-public ocaml-magic-mime
  (package
    (name "ocaml-magic-mime")
    (version "1.3.0")
    (home-page "https://github.com/mirage/ocaml-magic-mime")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0l27c4bdn55jdzp6i7hlky7m5g40kgibv5j8xix6p2rkbs5qsy1y"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (synopsis "OCaml library for mapping filenames to common MIME types")
    (description "This library contains a database of MIME types that maps
filename extensions into MIME types suitable for use in many Internet
protocols such as HTTP or e-mail.  It is generated from the @file{mime.types}
file found in Unix systems, but has no dependency on a filesystem since it
includes the contents of the database as an ML datastructure.")
    (license license:isc)))

(define-public ocaml-cohttp-lwt
  (package
    (inherit ocaml-cohttp)
    (name "ocaml-cohttp-lwt")
    (arguments `(#:package "cohttp-lwt"
                 #:test-target "."))
    (propagated-inputs
     (list ocaml-cohttp
	   ocaml-lwt
	   ocaml-sexplib0
	   ocaml-ppx-sexp-conv
	   ocaml-logs
	   ocaml-uri))
    (synopsis "OCaml library for HTTP clients and servers using the Lwt
concurrency library")
    (description "This is a portable implementation of HTTP that uses the Lwt
concurrency library to multiplex IO.  It implements as much of the logic in an
OS-independent way as possible, so that more specialised modules can be
tailored for different targets.  For example, you can install
@code{ocaml-cohttp-lwt-unix} or @code{ocaml-cohttp-lwt-jsoo} for a Unix or
JavaScript backend, or @code{ocaml-cohttp-mirage} for the MirageOS unikernel
version of the library.  All of these implementations share the same IO logic
from this module.")))

(define-public ocaml-cohttp-lwt-unix
  (package
    (inherit ocaml-cohttp)
    (name "ocaml-cohttp-lwt-unix")
    (arguments `(#:package "cohttp-lwt-unix"
                 ;; tests require network
                 #:tests? #f))
    (propagated-inputs
     (list ocaml-conduit-lwt
	   ocaml-conduit-lwt-unix
	   ocaml-cmdliner
	   ocaml-magic-mime
	   ocaml-logs
	   ocaml-fmt
	   ocaml-cohttp-lwt
	   ocaml-ppx-sexp-conv
	   ocaml-lwt
	   ocaml-lwt-ssl))
    (native-inputs (list ocaml-ounit))
    (synopsis "OCaml HTTP implementation for Unix using Lwt")
    (description "This Ocaml package provides an implementation of an HTTP
client and server for Unix using the Lwt concurrency library.")))

(define-public ocaml-hacl-star-raw
  (package
   (name "ocaml-hacl-star-raw")
   (version "0.6.1")
   (source
    (origin
     (method url-fetch)
     ;; WARNING this archive contains compiled output!
     (uri "https://github.com/cryspen/hacl-packages/releases/download/ocaml-v0.6.1/hacl-star.0.6.1.tar.gz")
     (sha256
      (base32 "043l7njd03pkllhlrfrg4scbccwbfpfr4s2m5rb0924j48vs49zw"))))
   (build-system ocaml-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
       (delete 'configure)
       (replace 'build
	 (lambda _
	   (invoke "make" "-C" "." "build-c")
	   (invoke "make" "CC=gcc" "-C" "." "build-bindings")
	   #t))
       (delete 'check) ; no tests fr hacl-star-raw
       (replace 'install
	 (lambda _
	   (invoke "make" "-C" "." "install"))))))
   (propagated-inputs (list ocaml-ctypes))
   (native-inputs
    (list ocaml-findlib which cmake))
   (home-page "https://tech.cryspen.com/hacl-packages/")
   (synopsis "Auto-generated low-level OCaml bindings for EverCrypt/HACL*")
   (description
    "This package contains a snapshot of the EverCrypt crypto provider and the HACL*
library, along with automatically generated Ctypes bindings.  WARNING: This package is not built from HaCl sources, instead pre-built OCaml code is used.")
   (license license:asl2.0)))

(define-public ocaml-hacl-star-raw-045
  (package
    (inherit ocaml-hacl-star-raw)
    (version "0.4.5")
    (source
     (origin
       (method url-fetch)
       ;; WARNING this archive contains compiled output!
       (uri "https://github.com/hacl-star/hacl-star/releases/download/ocaml-v0.4.5/hacl-star.0.4.5.tar.gz")
       (sha256
	(base32 "0x710nd1fp7bsn8x4i3lgphzsxcjm0mqjv67zfr6khsfh0zjbgs7"))))
    (arguments
     `(#:tests? #f ; no tests
       #:phases
       (modify-phases %standard-phases
	 (add-after 'unpack 'enter-raw-subdirectory
	   (lambda _ (chdir "../raw")))
	 (replace 'configure
	   (lambda _
	     (setenv "CC" "gcc")
	     (invoke "./configure")))
	 (replace 'install
	   (lambda _
	     (invoke "make" "install-hacl-star-raw")))
	 ;; Validate RUNPATH phase fails. Tests (for ocaml-hacl-star)
	 ;; seem to pass nevertheless.
	 ;; TODO: figure out why
	 (delete 'validate-runpath))))))

(define-public ocaml-hacl-star
  (package
    (inherit ocaml-hacl-star-raw)
    (name "ocaml-hacl-star")
    (build-system dune-build-system)
    (arguments
     `(#:package "hacl-star"
       #:test-target "."
       #:phases
       (modify-phases %standard-phases
	 ;; The default unpack phase enters the first subdirectory.
	 (add-after 'unpack 'leave-hacl-star-raw-subdirectory
	   (lambda _ (chdir ".."))))))
    (propagated-inputs
     (list ocaml-hacl-star-raw ocaml-zarith gmp))
    (native-inputs (list cmake ocaml-cppo ocaml-alcotest))))

(define-public ocaml-hacl-star-045
  (package
    (inherit ocaml-hacl-star-raw-045)
    (name "ocaml-hacl-star")
    (build-system dune-build-system)
    (arguments
     `(#:package "hacl-star"
       #:test-target "."
       #:phases
       (modify-phases %standard-phases
	 ;; The default unpack phase enters the first subdirectory.
	 (add-after 'unpack 'leave-hacl-star-raw-subdirectory
	   (lambda _ (chdir ".."))))))
    (propagated-inputs
     (list ocaml-hacl-star-raw-045 ocaml-zarith gmp))
    (native-inputs (list cmake ocaml-cppo ocaml-alcotest))))

(define-public ocaml-integers-stubs-js
  (package
    (name "ocaml-integers-stubs-js")
    (version "1.0")
    (home-page "https://github.com/o1-labs/integers_stubs_js")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url home-page)
	     (commit version)))
       (sha256
	(base32
	 "0dlrzj07qmyn0gyn4fy5v5m9m8kggf6p15wd8xk5ahnbvxgmq3ln"))))
    (build-system dune-build-system)
    (propagated-inputs (list js-of-ocaml ocaml-zarith-stubs-js))
    (properties `((upstream-name . "integers_stubs_js")))
    (synopsis "Javascript stubs for the integers library in js_of_ocaml")
    (description "Javascript stubs for the integers library in js_of_ocaml.")
    (license license:expat)))

(define-public ocaml-ctypes-stubs-js
  (package
    (name "ocaml-ctypes-stubs-js")
    (version "0.1")
    (home-page "https://gitlab.com/nomadic-labs/ctypes_stubs_js")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://gitlab.com/nomadic-labs/ctypes_stubs_js.git")
	     (commit version)))
       (sha256
	(base32
	 "0jy9ja78ynqw2gbsynfdh5zqnmz7fha6sy3p83j4bhk7d21k74iq"))))
    (build-system dune-build-system)
    ;; TODO enable tests
    (arguments `(#:tests? #f)) ; currennly failing due to build issue
    (propagated-inputs (list ocaml-integers-stubs-js))
    (native-inputs
     (list ocaml-ctypes
	   ocaml-ppx-expect))
    (synopsis "Javascript stubs for the ctypes library in js_of_ocaml")
    (description "Javascript stubs for the ctypes library in js_of_ocaml.")
    (license license:expat)))

(define-public ocaml-resto
  (package
   (name "ocaml-resto")
   (version "1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url "https://gitlab.com/nomadic-labs/resto.git")
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "0ryssy17b583fj685927yyrszc4k2kdxqa9f1q8jic0jc9zbp28c"))))
   (build-system dune-build-system)
   (arguments
    ;; Tests require network.
    `(#:tests? #f))
   (propagated-inputs
    (list ocaml-uri
	  ocaml-json-data-encoding
	  ocaml-json-data-encoding-bson
	  ocaml-conduit-lwt-unix
	  ocaml-cohttp-lwt-unix))
   (native-inputs
    (list ocaml-ezjsonm
	  ocaml-lwt
	  ocaml-alcotest
	  ocaml-alcotest-lwt))
   (home-page "https://gitlab.com/nomadic-labs/resto")
   (synopsis "A small OCaml library for type-safe HTTP/JSON RPCs")
   (description "A small OCaml library for type-safe HTTP/JSON RPCs")
   (license license:expat)))

(define-public ocaml-secp256k1-internal
  (package
    (name "ocaml-secp256k1-internal")
    (version "0.4.0")
    (home-page
     "https://gitlab.com/nomadic-labs/ocaml-secp256k1-internal")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url (string-append home-page ".git"))
	     (commit "v0.4")))
       (sha256
	(base32
	 "0kczrwdnnm74k0w3xvs216fsas26dz1832am19qm64qwvsknsrba"))))
    (build-system dune-build-system)
    (propagated-inputs
     (list gmp
	   ocaml-cstruct
	   ocaml-bigstring))
    (native-inputs
     (list ocaml-hex
	   ocaml-alcotest
	   js-of-ocaml))
    (synopsis "Bindings to secp256k1 internal functions (generic
operations on the curve)")
    (description "Bindings to secp256k1 internal functions (generic
operations on the curve)")
   (license license:expat)))

(define-public ocaml-ff-sig
  (package
    (name "ocaml-ff-sig")
    (version "0.6.2")
    (home-page
     "https://gitlab.com/nomadic-labs/cryptography/ocaml-ff")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url (string-append home-page ".git"))
	     (commit version)))
       (sha256
	(base32
	 "1rn3zwwmxqd5b739ii00kd6p9d7km2c16z7vkdlssf8cmkhhg192"))))
    (build-system dune-build-system)
    (arguments `(#:package "ff-sig"))
    (propagated-inputs
     (list ocaml-zarith))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-bisect-ppx))
    (synopsis "Minimal finite field signatures")
    (description "Minimal finite field signatures")
    (license license:expat)))

(define-public ocaml-ff-pbt
  (package
    (inherit ocaml-ff-sig)
    (name "ocaml-ff-pbt")
    (arguments `(#:package "ff-pbt"))
    (propagated-inputs
     (list ocaml-zarith
	   ocaml-ff-sig))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-bisect-ppx))))

(define-public ocaml-bls12-381
  (package
    (name "ocaml-bls12-381")
    (version "5.0.0")
    (home-page
     "https://gitlab.com/nomadic-labs/cryptography/ocaml-bls12-381")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url (string-append home-page ".git"))
	     (commit version)))
       (sha256
	(base32
	 "0wxqqgnv40r7qf7lvc674spyf7kgh1c193q1cvl2879ppvxwhbqz"))))
    (build-system dune-build-system)
    (arguments `(#:package "bls12-381"))
    (propagated-inputs
     (list ocaml-ff-sig
	   ocaml-zarith
	   gmp
	   ocaml-hex
	   ocaml-integers))
    (native-inputs
     (list ocaml-zarith-stubs-js
	   ocaml-alcotest
	   ocaml-integers-stubs-js
	   ocaml-bisect-ppx
	   ocaml-ff-pbt))
    (synopsis "Implementation of BLS12-381 and some cryptographic
primitives built on top of it")
    (description "Implementation of BLS12-381 and some cryptographic
primitives built on top of it")
    (license license:expat)))

(define-public ocaml-bls12-381-signature
  (package
    (name "ocaml-bls12-381-signature")
    (version "1.0.0")
    (home-page
     "https://gitlab.com/nomadic-labs/cryptography/ocaml-bls12-381-signature")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url (string-append home-page ".git"))
	     (commit version)))
       (sha256
	(base32
	 "1gmqaj4hdhkdrivpmkr6wi8xbns7d24qn6ws7ya1jnw17w0jk999"))))
    (build-system dune-build-system)
    (arguments `(#:package "bls12-381-signature"))
    (propagated-inputs
     (list ocaml-bls12-381))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-bisect-ppx
	   ocaml-integers-stubs-js))
    (synopsis "Implementation of BLS signatures for the
pairing-friendly curve BLS12-381")
    (description "Implementation of BLS signatures for the
pairing-friendly curve BLS12-381")
    (license license:expat)))

(define-public ocaml-printbox
  (package
    (name "ocaml-printbox")
    (version "0.6.1")
    (home-page "https://github.com/c-cube/printbox/")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1scpkd5dlsllcmlf2h2w89dil1vj6apb01fp4awgbpjc322r7vgf"))))
    (build-system dune-build-system)
    (arguments `(#:test-target "."))
    (propagated-inputs
     (list ocaml-uutf
	   ocaml-uucp
	   ocaml-tyxml
	   ocaml-re))
    (native-inputs
     (list ocaml-mdx))
    (synopsis "Allows to print nested boxes, lists, arrays, tables in
several formats")
    (description "Allows to print nested boxes, lists, arrays, tables
in several formats")
    (license license:bsd-2)))

(define-public ocaml-bentov
  (package
    (name "ocaml-bentov")
    (version "1")
    (home-page "https://github.com/barko/bentov")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url home-page)
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "1h2wmmhvwgkxv7dpvjzbg12032q4fvvrlrcvd4n2a334lighh69g"))))
    (build-system dune-build-system)
    (propagated-inputs
     (list ocaml-cmdliner))
    (synopsis "1D histogram sketching for OCaml")
    (description "This OCaml library implements an algorithm which approximates a 1D histogram as data is streamed over it.")
    (license license:bsd-3)))
