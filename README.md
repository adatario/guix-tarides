# Tarides Guix channel

[Guix](https://guix.gnu.org/) channel containing packages used for development at [Tarides](https://tarides.com/).

## Overview

This repository contains [Guix](https://guix.gnu.org/) package defintions. A package definition defines the inputs required to build some package as well as the exact steps to build the package. Inputs include libraries used by the package (e.g. OCaml libraries) but also the OCaml compiler itself as well as any C libraries. Inputs themselves are also packages that are defined using package definitions. Transitively this allows us to pin the entire graph of transitive dependencies required to build some package (e.g. this includes the C compiler used to compile the OCaml compiler). Most packages are defined by the Guix project in a [git repository](https://git.savannah.gnu.org/cgit/guix.git). The root is formed by a [binary bootstrap seed](https://guix.gnu.org/manual/en/html_node/Bootstrapping.html).

These exact definitions of packages allow dependable and reproducible builds and build environments. Guix has been used to keep old code (and the build environment for it) running [[1](https://www.nature.com/articles/d41586-020-02462-7)] and is used by projects to provide bootstrappable builds [[2](https://github.com/bitcoin/bitcoin/tree/master/contrib/guix)].

Package definitions in this repository are specific to development for Tarides. Things that are useful more generally should be upstreamed to Guix (see [Contributing](https://guix.gnu.org/manual/en/html_node/Contributing.html#Contributing) in the Guix manual).

For more information see also the [Guix Reference Manual](https://guix.gnu.org/manual/en/html_node/index.html#SEC_Contents) (also available in [French](https://guix.gnu.org/manual/fr/html_node/)).

## Using the channel

### Setup

1. Instal Guix. On Debian stable a package is available (`apt install guix`). For other systems use the [binary installation](https://guix.gnu.org/manual/en/html_node/Binary-Installation.html). Currently only Linux systems are supported.

2. Add the channel to your `~/.config/guix/channels.scm`:

```
(cons
 (channel
  (name 'tarides)
  (url "https://github.com/adatario/guix-tarides.git")
  (branch "main"))
 %default-channels)
```

3. Run `guix pull`. This will fetch the channel.

### Updating the channel

When package definitions are updated in this repository, you need to update your local copy by running `git pull`.

It is possible to pull a specific commit of the package definitions for reproducible builds.

### Creating an environment with some packages

Run `guix shell ocaml-irmin ocaml-alcotest` to get a shell that has the OCaml packages Irmin and Alcotest installed.

Note: make sure that OPAM does not overwrite the shell environment (this can happen if you run `eval $(opam env)` in your `.bashrc`). Run `guix shell --check` to check that this does not happen.
