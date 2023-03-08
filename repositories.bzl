load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

versions = {
    "1.11.2": {
        "darwin_arm64": "89e5a68d669fa16621f89198fff5bc167743404e640a4802f73c59644bd0d9ba",
        "linux_amd64": "2ea81d1d7f6a9c63f7a1195aec4fe71e913842dcd4b867f69a145f885158d610",
    },
}

def rules_ls_lint_dependencies(version = "1.11.2"):
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        ],
    )

    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "ecba0f04f96b4960a5b250c8e8eeec42281035970aa8852dda73098274d14a1d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.29.0/bazel-gazelle-v0.29.0.tar.gz",
        ],
    )

    maybe(
        http_file,
        name = "com_github_loeffel_io_ls_lint_darwin_arm64",
        downloaded_file_path = "ls-lint",
        executable = True,
        sha256 = versions[version]["darwin_arm64"],
        urls = [
            "https://github.com/loeffel-io/ls-lint/releases/download/v" + version + "/ls-lint-darwin-arm64",
        ],
    )

    maybe(
        http_file,
        name = "com_github_loeffel_io_ls_lint_linux_amd64",
        downloaded_file_path = "ls-lint",
        executable = True,
        sha256 = versions[version]["linux_amd64"],
        urls = [
            "https://github.com/loeffel-io/ls-lint/releases/download/v" + version + "/ls-lint-linux",
        ],
    )
