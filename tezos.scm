; SPDX-FileCopyrightText: 2022 Tarides <contact@tarides.com>
;
; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (tezos)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system dune)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages pkg-config))

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
