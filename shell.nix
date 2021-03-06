{ pkgs ? import ./nixpkgs {}, docTools ? true }:

with pkgs;

mkShell {
  # XXX: hack for macosX, this flags disable bazel usage of xcode
  # Note: this is set even for linux so any regression introduced by this flag
  # will be catched earlier
  # See: https://github.com/bazelbuild/bazel/issues/4231
  BAZEL_USE_CPP_ONLY_TOOLCHAIN=1;

  buildInputs = [
    go
    nix
    which
    perl
    python
    bazel
    # Needed for @com_github_golang_protobuf, itself needed by buildifier.
    git
    # Needed to get correct locale for tests with encoding
    glibcLocales
  ] ++ lib.optionals docTools [graphviz python36Packages.sphinx zip unzip];

  shellHook = ''
    # source bazel bash completion
    source ${pkgs.bazel}/share/bash-completion/completions/bazel
  '';
}
