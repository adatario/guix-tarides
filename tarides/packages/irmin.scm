; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides packages irmin)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module (guix build-system ocaml)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pkg-config)
  #:use-module (tarides packages ocaml)
  #:export (package-with-explicit-irmin-origin))

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
   (name "ocaml-ppx-repr")
   (arguments `(#:package "ppx_repr"))
   (propagated-inputs
    (list ocaml-repr ocaml-ppxlib))
   (native-inputs (list ocaml-alcotest ocaml-hex))))

(define* (package-with-explicit-irmin-origin p #:key origin version)
  "Return a procedure that takes a package and returns a package that
uses the specified origin for all Irmin packages."

  ;; packages that are built from the Irmin Git repository
  (define irmin-package-names
    (list "ocaml-irmin"
	  "ocaml-ppx-irmin"
	  "ocaml-irmin-pack"
	  "ocaml-irmin-test"
	  "ocaml-irmin-tezos"
	  "ocaml-irmin-tezos-utils"
	  "ocaml-irmin-fs"))

  (define (transform p)
    (if (member (package-name p)
		irmin-package-names)

	(package
	  (inherit p)
	  (location (package-location p))
	  (version (if version version (package-version p)))
	  (source origin))

	p))

  ;; stop package transformations when it's not an OCaml package
  (define (cut? p)
    (not (or (eq? (package-build-system p) ocaml-build-system)
             (eq? (package-build-system p) dune-build-system))))

  ((package-mapping transform cut?) p))

(define irmin-3.4
  (package
   (name "ocaml-irmin")
   (version "3.4.3")
   (home-page "https://github.com/mirage/irmin")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (sha256
      (base32
       "0s914y34skcmz81jzgspi6frjcrplpzs7y42mviic854b5ixja9i"))))
   (build-system dune-build-system)
   (synopsis "Irmin, a distributed database that follows the same design
principles as Git")
   (description "Irmin is a library for persistent stores with built-in
snapshot, branching and reverting mechanisms. It is designed to use a large
variety of backends. Irmin is written in pure OCaml and does not depend on
external C stubs; it aims to run everywhere, from Linux, to browsers and Xen
unikernels.")
   (license license:isc)))

(define-public (package-with-irmin-3.5 p)
  (let ((version "3.5.1")
	(home-page "https://github.com/mirage/irmin"))

    (package-with-explicit-irmin-origin
     p
     #:origin (origin
		(method git-fetch)
		(uri (git-reference
		      (url home-page)
		      (commit version)))
		(sha256
		 (base32
		  "1bjbi1m3n8pw6yb87i5l52cbi4n53xzv0179fb2p2hr5158hdiyy")))
     #:version version)))

(define-public ocaml-ppx-irmin-3.4
  (package
   (inherit irmin-3.4)
   (name "ocaml-ppx-irmin")
   (arguments `(#:package "ppx_irmin"))
   (propagated-inputs (list ocaml-ppx-repr ocaml-logs))
   (synopsis "PPX deriver for Irmin type representations")))

(define-public ocaml-irmin-3.4
  (package
   (inherit irmin-3.4)
   (name "ocaml-irmin")
   (arguments `(#:package "irmin"))
   (propagated-inputs
    (list ocaml-repr
	  ocaml-fmt
	  ocaml-uri
	  ocaml-uutf
	  ocaml-jsonm
	  ocaml-ppx-irmin-3.4
	  ocaml-digestif
	  ocaml-graph
	  ocaml-logs
	  ocaml-bheap
	  ocaml-astring))
   (native-inputs (list ocaml-alcotest ocaml-vector ocaml-fmt))))

(define-public ocaml-irmin-3.5
  (package-with-irmin-3.5 ocaml-irmin-3.4))

(define-public ocaml-index
  (package
   (name "ocaml-index")
   (version "1.6.1")
   (home-page "https://github.com/mirage/index")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "0bw2yvjp5ccibfzhil58ks8w7pws8ln2a8kf1m2dxj7ywwfncpas"))))
   (build-system dune-build-system)
   (propagated-inputs (list ocaml-optint
			    ocaml-repr
			    ocaml-ppx-repr
			    ocaml-fmt
			    ocaml-logs
			    ocaml-mtime
			    ocaml-cmdliner
			    ocaml-progress
			    ocaml-semaphore-compat
			    ocaml-jsonm
			    ocaml-stdlib-shims
			    ocaml-lru))
   (native-inputs (list ocaml-alcotest ocaml-crowbar ocaml-re))
   (synopsis "A platform-agnostic multi-level index for OCaml")
   (description
    "Index is a scalable implementation of persistent indices in OCaml.  It takes an
arbitrary IO implementation and user-supplied content types and supplies a
standard key-value interface for persistent storage.  Index provides instance
sharing: each OCaml run-time can share a common singleton instance.  Index
supports multiple-reader/single-writer access.  Concurrent access is safely
managed using lock files.")
   (license license:expat)))

(define-public ocaml-irmin-pack-3.4
  (package
   (inherit ocaml-irmin-3.4)
   (name "ocaml-irmin-pack")
   (arguments `(#:package "irmin-pack"))
   (propagated-inputs
    (list ocaml-irmin-3.4
	  ocaml-ppx-irmin-3.4
	  ocaml-index
	  ocaml-fmt
	  ocaml-logs
	  ocaml-lwt
	  ocaml-mtime
	  ocaml-cmdliner
	  ocaml-optint
	  ocaml-checkseum
	  ocaml-rusage))))

(define-public ocaml-irmin-test-3.4
  (package
   (inherit ocaml-irmin-3.4)
   (name "ocaml-irmin-test")
   (arguments `(#:package "irmin-test"))
   (propagated-inputs
    (list ocaml-alcotest
	  ocaml-astring
	  ocaml-fmt
	  ocaml-irmin-3.4
	  ocaml-jsonm
	  ocaml-fmt
	  ocaml-lwt
	  ocaml-mtime
	  ocaml-alcotest-lwt
	  ocaml-metrics-unix))
   (native-inputs
    (list ocaml-qcheck ocaml-hex ocaml-vector))))

(define-public ocaml-tezos-base58
  (package
   (name "ocaml-tezos-base58")
   (version "1.0.0")
   (home-page "https://github.com/tarides/tezos-base58")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url home-page)
	   (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32
       "08s3klpj0zq2ax19n35swgl3m279a59c29xx0sr29k0898kpz96j"))))
   (build-system dune-build-system)
   (arguments `(#:test-target "."))
   (propagated-inputs (list ocaml-zarith ocaml-digestif ocaml-fmt))
   (synopsis "Base58 encoding for Tezos")
   (description "Self-contained package for base58 encoding used by Tezos.")
   (license license:expat)))

(define-public ocaml-irmin-tezos-3.4
  (package
   (inherit ocaml-irmin-3.4)
   (name "ocaml-irmin-tezos")
   (arguments `(#:package "irmin-tezos"))
   (propagated-inputs
    (list ocaml-irmin-3.4
	  ocaml-irmin-pack-3.4
	  ocaml-ppx-irmin-3.4
	  ocaml-tezos-base58
	  ocaml-digestif
	  ocaml-cmdliner
	  ocaml-fmt
	  ocaml-yojson
	  gmp))
   (native-inputs
    (list ocaml-alcotest
	  ocaml-hex
	  ocaml-fpath
	  ocaml-irmin-test-3.4))))

(define-public ocaml-irmin-tezos-utils-3.4
  (package
   (inherit ocaml-irmin-3.4)
   (name "ocaml-irmin-tezos-utils")
   (arguments `(#:package "irmin-tezos-utils"))
   (propagated-inputs
    (list ocaml-irmin-pack-3.4
	  ocaml-irmin-tezos-3.4
	  ocaml-notty
	  ocaml-hex
	  ocaml-index
	  ocaml-cmdliner
	  ocaml-ppx-repr))))

(define-public ocaml-irmin-fs-3.4
  (package
   (inherit ocaml-irmin-3.4)
   (name "ocaml-irmin-fs")
   (arguments `(#:package "irmin-fs"
		#:tests? #f ; requires irmin-watcher
		))
   (propagated-inputs
    (list ocaml-irmin-3.4
	  ocaml-astring
	  ocaml-logs
	  ocaml-lwt))
   (native-inputs
    (list ocaml-irmin-test-3.4
	  ;; ocaml-irmin-watcher
	  ))))
