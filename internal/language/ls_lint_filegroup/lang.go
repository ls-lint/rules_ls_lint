package ls_lint_filegroup

import (
	"path"

	"github.com/bazelbuild/bazel-gazelle/config"
	"github.com/bazelbuild/bazel-gazelle/label"
	"github.com/bazelbuild/bazel-gazelle/language"
	"github.com/bazelbuild/bazel-gazelle/repo"
	"github.com/bazelbuild/bazel-gazelle/resolve"
	"github.com/bazelbuild/bazel-gazelle/rule"
)

const lsLintFilegroupName = "ls_lint_filegroup"

type lsLintFilegroupLang struct {
	language.BaseLang

	sawDone bool
}

func NewLanguage() language.Language {
	return &lsLintFilegroupLang{}
}

func (*lsLintFilegroupLang) Name() string { return lsLintFilegroupName }

func (*lsLintFilegroupLang) Kinds() map[string]rule.KindInfo {
	return kinds
}

var kinds = map[string]rule.KindInfo{
	"filegroup": {
		NonEmptyAttrs:  map[string]bool{"srcs": true, "deps": true},
		MergeableAttrs: map[string]bool{"srcs": true},
	},
}

func (l *lsLintFilegroupLang) GenerateRules(args language.GenerateArgs) language.GenerateResult {
	if l.sawDone {
		panic("GenerateRules must not be called after DoneGeneratingRules")
	}

	r := rule.NewRule("filegroup", "ls_lint_files")
	srcs := make([]string, 0, len(args.Subdirs)+len(args.RegularFiles))
	srcs = append(srcs, args.RegularFiles...)
	for _, f := range args.Subdirs {
		pkg := path.Join(args.Rel, f)
		srcs = append(srcs, "//"+pkg+":ls_lint_files")
	}
	r.SetAttr("srcs", srcs)
	r.SetAttr("testonly", true)
	if args.File == nil || !args.File.HasDefaultVisibility() {
		r.SetAttr("visibility", []string{"//visibility:public"})
	}
	return language.GenerateResult{
		Gen:     []*rule.Rule{r},
		Imports: []interface{}{nil},
	}
}

func (l *lsLintFilegroupLang) DoneGeneratingRules() {
	l.sawDone = true
}

func (l *lsLintFilegroupLang) Resolve(c *config.Config, ix *resolve.RuleIndex, rc *repo.RemoteCache, r *rule.Rule, imports interface{}, from label.Label) {
	if !l.sawDone {
		panic("Expected a call to DoneGeneratingRules before Resolve")
	}
}
