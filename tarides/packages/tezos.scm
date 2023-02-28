; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tarides packages tezos)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix deprecation)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module (guix build-system ocaml)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages multiprecision)
  #:use-module (tarides packages ocaml)
  #:use-module (tarides packages irmin)
  #:export (package-with-explicit-tezos-origin
	    package-with-tezos-15
	    package-with-tezos-16))

(define* (package-with-explicit-tezos-origin p #:key origin version
					     variant-property)
  "Return a procedure that takes a package and returns a package that
uses the specified origin for all Tezos packages."

  (define package-variant
    (if variant-property
        (lambda (package)
          (assq-ref (package-properties package)
                    variant-property))
        (const #f)))

  ;; packages that are built from the Tezos Git repository
  (define tezos-package-names
    (list "ocaml-tezos-test-helpers"
	  "ocaml-tezos-test-helpers-extra"
	  "ocaml-tezos-stdlib"
	  "ocaml-tezos-lwt-result-stdlib"
	  "ocaml-tezos-error-monad"
	  "ocaml-tezos-event-logging"
	  "ocaml-tezos-stdlib-unix"
	  "ocaml-tezos-hacl"
	  "ocaml-tezos-rpc"
	  "ocaml-tezos-micheline"
	  "ocaml-tezos-crypto"
	  "ocaml-tezos-base"
	  "ocaml-tezos-context"
	  "ocaml-tezos-p2p-services"
	  "ocaml-tezos-version"
	  "ocaml-tezos-shell-services"))

  (define (transform p)
    (cond
     ;; Use explicitly defined package-variant if available. This is
     ;; useful for switching between major versions of tezos that might
     ;; require different dependencies.
     ((package-variant p) =>
      (lambda (variant)
	(transform
	 ;; Inherit package variant but set source to explicit origin
	 (package
	  (inherit (force variant))
	  (location (package-location p))
	  (version (if version version (package-version p)))
	  (source origin)))))

     ;; Check if package is built from Tezos repository by checking
     ;; the known list of packages.
     ((member (package-name p) tezos-package-names)
      (package
	(inherit p)
	(location (package-location p))
	(version (if version version (package-version p)))
	(source origin)))

     ;; else return the package as is
     (else p)))

  ;; stop package transformations when it's not an OCaml package
  (define (cut? p)
    (not (or (eq? (package-build-system p) ocaml-build-system)
             (eq? (package-build-system p) dune-build-system))))

  ((package-mapping transform cut?) p))

(define tezos-15.1
  (package
   (name "tezos")
   (version "15.1")
   (home-page "https://gitlab.com/tezos/tezos")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url (string-append home-page ".git"))
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "0lvf226hahlflfvyx9jh65axvain7lhzi6m62ih3pbwi72d600wr"))))
   (build-system dune-build-system)
   (synopsis "Tezos")
   (description "Tezos")
   (license license:expat)))

(define* (package-with-tezos-15 p
				#:key
				(origin (package-source tezos-15.1))
				(version "15.1"))
  (package-with-explicit-tezos-origin p
				      #:origin origin
				      #:version version
				      #:variant-property 'tezos-15-variant))

(define tezos-16
  (package
   (name "tezos")
   (version "16.0-rc2")
   (home-page "https://gitlab.com/tezos/tezos")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
	   (url (string-append home-page ".git"))
	   (commit (string-append "v" version))))
     (sha256
      (base32
       "0f1p6gp28ihimx6hpj4q4gvxvqb4zwmcblmc1svnh2v5y9m8fgzd"))))
   (build-system dune-build-system)
   (synopsis "Tezos")
   (description "Tezos")
   (license license:expat)))

(define* (package-with-tezos-16 p
				#:key
				(patches '())
				(origin (origin
					 (inherit (package-source tezos-16))
					 (patches patches)))
				(version (package-version tezos-16)))
  (package-with-explicit-tezos-origin p
				      #:origin origin
				      #:version version
				      #:variant-property 'tezos-16-variant))

(define-public ocaml-tezos-test-helpers
  (package
   (inherit tezos-15.1)
   (name "ocaml-tezos-test-helpers")
   (propagated-inputs
    (list ocaml-uri
	  ocaml-fmt
	  ocaml-qcheck
	  ocaml-alcotest
	  ocaml-lwt
	  ocaml-data-encoding
	  ocaml-pure-splitmix))
   (arguments `(#:package "tezos-test-helpers"))))

(define-public ocaml-tezos-test-helpers-extra
  (package
   (inherit tezos-15.1)
   (name "ocaml-tezos-test-helpers-extra")
   (propagated-inputs
    (list ocaml-tezos-base
	  ocaml-tezos-crypto
	  ocaml-tezos-test-helpers))
   (arguments `(#:package "tezos-test-helpers-extra"))))

(define-public ocaml-tezos-stdlib
  (package
   (inherit tezos-15.1)
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
   (arguments `(#:package "tezos-stdlib"))
   (properties `((tezos-16-variant . ,(delay ocaml-tezos-16-stdlib))))))

(define ocaml-tezos-16-stdlib
  (package
    (inherit ocaml-tezos-stdlib)
    (propagated-inputs
     (modify-inputs
	 (package-propagated-inputs ocaml-tezos-stdlib)
       (delete "ocaml-ringo")
       (append ocaml-ringo)
       (append ocaml-aches)
       (append ocaml-aches-lwt)))
    (properties '())))

(define-public ocaml-tezos-lwt-result-stdlib
  (package
   (inherit tezos-15.1)
   (name "ocaml-tezos-lwt-result-stdlib")
   (arguments `(#:package "tezos-lwt-result-stdlib"))
   (propagated-inputs
    (list ocaml-lwt))
   (native-inputs
    (list ocaml-alcotest
	  ocaml-alcotest-lwt
	  ocaml-qcheck
	  ocaml-tezos-test-helpers))))

(define-public ocaml-tezos-error-monad
  (package
   (inherit tezos-15.1)
   (name "ocaml-tezos-error-monad")
   (arguments `(#:package "tezos-error-monad"))
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
   (inherit tezos-15.1)
   (name "ocaml-tezos-event-logging")
   (arguments `(#:package "tezos-event-logging"))
   (propagated-inputs
    (list ocaml-tezos-stdlib
	  ocaml-data-encoding
	  ocaml-tezos-error-monad
	  ocaml-tezos-lwt-result-stdlib
	  ocaml-lwt-log
	  ocaml-uri))))

(define-public ocaml-tezos-stdlib-unix
  (package
   (inherit tezos-15.1)
   (name "ocaml-tezos-stdlib-unix")
   (arguments `(#:package "tezos-stdlib-unix"))
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
    (inherit tezos-15.1)
    (name "ocaml-tezos-hacl")
    (arguments `(#:package "tezos-hacl"))
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
	   ocaml-tezos-test-helpers))
    (properties `((tezos-16-variant . ,(delay ocaml-tezos-16-hacl))))))

(define-public ocaml-tezos-16-hacl
  (package
    (inherit ocaml-tezos-hacl)
    (propagated-inputs
     (modify-inputs
	 (package-propagated-inputs ocaml-tezos-stdlib)
       (delete "ocaml-hacl-star-raw")
       (append ocaml-hacl-star-raw)
       (delete "ocaml-hacl-star")
       (append ocaml-hacl-star)
       (append ocaml-ctypes-stubs-js)))
    (properties '())))

(define-public ocaml-tezos-rpc
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-rpc")
    (arguments `(#:package "tezos-rpc"))
    (propagated-inputs
     (list ocaml-data-encoding
	   ocaml-tezos-error-monad
	   ocaml-resto
	   ocaml-uri))))

(define-public ocaml-tezos-micheline
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-micheline")
    (arguments `(#:package "tezos-micheline"))
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
    (inherit tezos-15.1)
    (name "ocaml-tezos-crypto")
    (arguments `(#:package "tezos-crypto"
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
	   ocaml-tezos-test-helpers))
   (properties `((tezos-16-variant . ,(delay ocaml-tezos-16-crypto))))))

(define ocaml-tezos-16-crypto
  (package
    (inherit ocaml-tezos-crypto)
    (propagated-inputs
     (modify-inputs
	 (package-propagated-inputs ocaml-tezos-crypto)
       (delete "ocaml-ringo")
       (append ocaml-ringo)
       (append ocaml-aches)))
    (properties '())))

(define-public ocaml-tezos-base
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-base")
    (arguments `(#:package "tezos-base"))
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
   (inherit tezos-15.1)
   (name "ocaml-tezos-context")
   (arguments `(#:package "tezos-context"))
   (propagated-inputs
    (list ocaml-tezos-base
	  ocaml-tezos-stdlib-unix
	  ocaml-bigstringaf
	  ocaml-fmt
	  ocaml-logs
	  ocaml-digestif
	  ocaml-irmin
	  ocaml-irmin-pack
	  ocaml-tezos-stdlib))
   (native-inputs
    (list ocaml-qcheck
	  ocaml-alcotest-lwt
	  ocaml-tezos-test-helpers-extra))
   (properties `((tezos-16-variant . ,(delay ocaml-tezos-16-context))))))

(define-public ocaml-tezos-16-context
  (package-with-irmin-3.5
   (package
     (inherit ocaml-tezos-context)
     (properties '()))))

(define-public ocaml-tezos-p2p-services
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-p2p-services")
    (arguments `(#:package "tezos-p2p-services"))
    (propagated-inputs
     (list ocaml-tezos-base))))

(define-public ocaml-tezos-version
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-version")
    (arguments `(#:package "tezos-version"))
    (propagated-inputs
     (list ocaml-tezos-base
	   ocaml-ppx-deriving))
    (native-inputs
     (list ocaml-alcotest))))

(define-public ocaml-tezos-shell-services
  (package
    (inherit tezos-15.1)
    (name "ocaml-tezos-shell-services")
    (arguments `(#:package "tezos-shell-services"))
    (propagated-inputs
     (list ocaml-tezos-base
	   ocaml-tezos-p2p-services
	   ocaml-tezos-version
	   ocaml-tezos-context))
    (native-inputs
     (list ocaml-alcotest))))

(define-public ocaml-tezos-context-trace
  (let ((commit "e8729a10f271ff370752e559cd122f7db56e9d0b")
	(revision "0"))
   (package-with-tezos-16
    (package
     (name "ocaml-tezos-context-trace")
     (version (git-version "git" revision commit))
     (home-page "https://github.com/adatario/tezos-context-trace")
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
	     (url home-page)
	     (commit commit)))
       (sha256
	(base32
	 "1gpjd2vf0b7z05xkjpjvlkr78vhlskxlksin1dm52jc30znr0mpl"))))
     (build-system dune-build-system)
     (propagated-inputs
      (list

       ;; tezos-contest (aka lib_context)
       ocaml-tezos-context

       ;; Extra dependencies required by the replay patches
       ocaml-ppx-deriving
       ocaml-ppx-deriving-yojson
       ocaml-printbox
       ocaml-bentov))
     (synopsis "Tezos Context Trace tools.")
     (description "Tools that allow replaying of Tezos Context action
traces.  This is used to benchmark performance of changes to Irmin.")
     (license license:isc))
    #:patches (list
	       (local-file
		"./patches/tezos-context-add-irmin-stats.patch")))))


;; alias for backwards-compatibility
(define-deprecated/public ocaml-tezos-context-replay ocaml-tezos-context-trace
  (package
   (inherit ocaml-tezos-context-trace)
   (name "ocaml-tezos-context-replay")))

