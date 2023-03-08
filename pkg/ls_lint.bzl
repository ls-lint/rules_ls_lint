def ls_lint_test(data = []):
    native.sh_test(
        name = "ls_lint",
        srcs = ["@com_github_ls_lint_rules_ls_lint//:ls_lint"],
        data = [".ls-lint.yml"] + data,
    )
