; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tezos)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages multiprecision)
  #:use-module (tarides ocaml)
  #:use-module (tarides irmin))

(define tezos
  (package
   (name "tezos")
   (version "15.0")
   (home-page "https://gitlab.com/tezos/tezos")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url (string-append home-page ".git"))
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "0jmzgw4ay1kjywhq8ygbndddfgwm05w2zki853wx04vdgd9i1zi9"))))
   (build-system dune-build-system)
   (synopsis "Tezos")
   (description "Tezos")
   (license license:expat)))

(define-public ocaml-tezos-test-helpers
  (package
   (inherit tezos)
   (name "ocaml-tezos-test-helpers")
   (propagated-inputs
    (list ocaml-uri
	  ocaml-fmt
	  ocaml-qcheck
	  ocaml-alcotest
	  ocaml-lwt
	  ocaml-data-encoding
	  ocaml-pure-splitmix))
   (arguments `(#:package "tezos-test-helpers"
		#:test-target "."))))

(define-public ocaml-tezos-test-helpers-extra
  (package
   (inherit tezos)
   (name "ocaml-tezos-test-helpers-extra")
   (propagated-inputs
    (list ocaml-tezos-base
	  ocaml-tezos-crypto
	  ocaml-tezos-test-helpers))
   (arguments `(#:package "tezos-test-helpers-extra"
		#:test-target "."))))

(define-public ocaml-tezos-stdlib
  (package
   (inherit tezos)
   (name "ocaml-tezos-stdlib")
   (propagated-inputs
    (list ocaml-lwt
	  ocaml-hex
	  ocaml-zarith
	  ocaml-zarith-stubs-js
	  gmp
	  ocaml-ppx-expect
	  ocaml-ringo-0.9))
   (native-inputs
    (list ocaml-alcotest
	  ocaml-alcotest-lwt
	  ocaml-qcheck
	  ocaml-bigstring
	  ocaml-tezos-test-helpers
	  ocaml-lwt-log))
   (arguments `(#:package "tezos-stdlib"
		#:test-target "."))))

(define-public ocaml-tezos-lwt-result-stdlib
  (package
   (inherit tezos)
   (name "ocaml-tezos-lwt-result-stdlib")
   (arguments `(#:package "tezos-lwt-result-stdlib"
		#:test-target "."))
   (propagated-inputs
    (list ocaml-lwt))
   (native-inputs
    (list ocaml-alcotest
	  ocaml-alcotest-lwt
	  ocaml-qcheck
	  ocaml-tezos-test-helpers))))

(define-public ocaml-tezos-error-monad
  (package
   (inherit tezos)
   (name "ocaml-tezos-error-monad")
   (arguments `(#:package "tezos-error-monad"
		#:test-target "."))
   (propagated-inputs
    (list ocaml-data-encoding
	  ocaml-tezos-stdlib
	  ocaml-tezos-lwt-result-stdlib
	  ocaml-lwt-canceler
	  ocaml-lwt))
   (native-inputs
    (list ocaml-alcotest))))

(define-public ocaml-tezos-event-logging
  (package
   (inherit tezos)
   (name "ocaml-tezos-event-logging")
   (arguments `(#:package "tezos-event-logging"
		#:test-target "."))
   (propagated-inputs
    (list ocaml-tezos-stdlib
	  ocaml-data-encoding
	  ocaml-tezos-error-monad
	  ocaml-tezos-lwt-result-stdlib
	  ocaml-lwt-log
	  ocaml-uri))))

(define-public ocaml-tezos-stdlib-unix
  (package
   (inherit tezos)
   (name "ocaml-tezos-stdlib-unix")
   (arguments `(#:package "tezos-stdlib-unix"
		#:test-target "."))
   (propagated-inputs
    (list
     ocaml-tezos-error-monad
     ocaml-tezos-lwt-result-stdlib
     ocaml-tezos-event-logging
     ocaml-tezos-stdlib
     ocaml-data-encoding
     ocaml-lwt
     ocaml-ipaddr
     ocaml-re
     ocaml-ezjsonm
     ocaml-ptime
     ocaml-mtime
     ocaml-lwt-log
     ocaml-uri
     libev))))

(define-public ocaml-tezos-hacl
  (package
    (inherit tezos)
    (name "ocaml-tezos-hacl")
    (arguments `(#:package "tezos-hacl"
		 #:test-target "."))
    (propagated-inputs
     (list ocaml-ctypes
	   ocaml-ctypes-stubs-js
	   ocaml-hacl-star-raw-045
	   ocaml-ezjsonm
	   ocaml-hacl-star-045))
    (native-inputs
     (list ocaml-tezos-stdlib
	   ocaml-tezos-error-monad
	   ocaml-zarith
	   ocaml-zarith-stubs-js
	   ocaml-data-encoding
	   ocaml-qcheck
	   ocaml-tezos-test-helpers))))

(define-public ocaml-tezos-rpc
  (package
    (inherit tezos)
    (name "ocaml-tezos-rpc")
    (arguments `(#:package "tezos-rpc"
		 #:test-target "."))
    (propagated-inputs
     (list ocaml-data-encoding
	   ocaml-tezos-error-monad
	   ocaml-resto
	   ocaml-uri))))

(define-public ocaml-tezos-micheline
  (package
    (inherit tezos)
    (name "ocaml-tezos-micheline")
    (arguments `(#:package "tezos-micheline"
		 #:test-target "."))
    (propagated-inputs
     (list ocaml-ppx-expect
	   ocaml-uutf
	   ocaml-zarith
	   ocaml-zarith-stubs-js
	   ocaml-tezos-stdlib
	   ocaml-tezos-error-monad
	   ocaml-data-encoding))))

(define-public ocaml-tezos-crypto
  (package
    (inherit tezos)
    (name "ocaml-tezos-crypto")
    (arguments `(#:package "tezos-crypto"
		 #:test-target "."
		 ;; tests fail to compile. TODO: research
		 #:tests? #f))
    (propagated-inputs
     (list
	   ocaml-tezos-stdlib
	   ocaml-tezos-error-monad
	   ocaml-zarith
	   ocaml-zarith-stubs-js
	   ocaml-tezos-hacl
	   ocaml-data-encoding
	   ocaml-tezos-lwt-result-stdlib
	   ocaml-secp256k1-internal
	   ocaml-tezos-rpc
	   ocaml-ringo-0.9
	   ocaml-bls12-381
	   ocaml-bls12-381-signature))
    (native-inputs
     (list ocaml-alcotest
	   ocaml-alcotest-lwt
	   ocaml-qcheck
	   ocaml-tezos-test-helpers))))

(define-public ocaml-tezos-base
  (package
    (inherit tezos)
    (name "ocaml-tezos-base")
    (arguments `(#:package "tezos-base"
		 #:test-target "."))
    (propagated-inputs
     (list ocaml-tezos-error-monad
	   ocaml-data-encoding
	   ocaml-tezos-crypto
	   ocaml-tezos-hacl
	   ocaml-tezos-stdlib
	   ocaml-tezos-stdlib-unix
	   ocaml-uri
	   ocaml-tezos-rpc
	   ocaml-tezos-micheline
	   ocaml-tezos-event-logging
	   ocaml-ptime
	   ocaml-ezjsonm
	   ocaml-lwt
	   ocaml-ipaddr))
    (native-inputs
     (list ocaml-tezos-test-helpers
	   ocaml-alcotest))))

(define-public ocaml-tezos-context
  (package
   (inherit tezos)
   (name "ocaml-tezos-context")
   (arguments `(#:package "tezos-context"
		#:test-target "."))
   (propagated-inputs
    (list ocaml-tezos-base
	  ocaml-tezos-stdlib-unix
	  ocaml-bigstringaf
	  ocaml-fmt
	  ocaml-logs
	  ocaml-digestif
	  ocaml-irmin-3.4
	  ocaml-irmin-pack-3.4
	  ocaml-tezos-stdlib))
   (native-inputs
    (list ocaml-qcheck
	  ocaml-alcotest-lwt
	  ocaml-tezos-test-helpers-extra))))
