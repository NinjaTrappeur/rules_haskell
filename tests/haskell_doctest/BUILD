load(
    "@io_tweag_rules_haskell//haskell:haskell.bzl",
    "haskell_doctest",
    "haskell_library",
    "haskell_test",
)

package(default_testonly = 1)

haskell_library(
    name = "lib-a",
    srcs = ["Foo.hs"],
    deps = [
        "//tests/data:ourclibrary",
        "@hackage//:base",
        "@zlib.dev//:zlib",
    ],
)

haskell_library(
    name = "lib-b",
    srcs = [
        "Bar.hs",
        "Baz.hs",
        "Quux.hsc",
    ],
    deps = [
        ":lib-a",
        "@hackage//:base",
    ],
)

haskell_doctest(
    name = "doctest-lib-all-fail",
    tags = ["manual"],  # must FAIL
    visibility = ["//visibility:public"],
    deps = [":lib-b"],
)

haskell_doctest(
    name = "doctest-lib-all-success",
    doctest_flags = ["-DMAGIC_DOCTEST_THING"],
    visibility = ["//visibility:public"],
    deps = [":lib-b"],
)

haskell_doctest(
    name = "doctest-lib",
    modules = ["Bar"],  # exclude Baz and succeed
    visibility = ["//visibility:public"],
    deps = [":lib-b"],
)

haskell_test(
    name = "bin",
    srcs = ["Main.hs"],
    deps = [
        ":lib-a",
        "@hackage//:base",
    ],
)

haskell_doctest(
    name = "doctest-bin",
    visibility = ["//visibility:public"],
    deps = [":bin"],
)
