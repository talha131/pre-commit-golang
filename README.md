# pre-commit-golang

Golang hooks for [pre-commit](https://pre-commit.com/)

## Why a new golang-hook?

A lot many [golang-hooks](https://pre-commit.com/hooks.html) were not working in my project, because my go code is inside a subdirectory, instead of the root of the repository.

Here is an [example](https://github.com/dnephin/pre-commit-golang/issues/30) of the issue.

## What it does?

1. This hook runs [`golangci-lint`](https://github.com/golangci/golangci-lint) in the folder which contains `go.mod` file.
2. It runs on all the go files present in the folder, not just on the staged files.
3. It ignores the `vendor` folder.

## How to customize?

You can use `args` option in your pre-commit configuration, or use [`golangci-lint` configuration file](https://github.com/golangci/golangci-lint#config-file).

## Example

Add to your pre-commit configuration:

```yaml
- repo: https://github.com/talha131/pre-commit-golang
  rev: master
  hooks:
  - id: golangci-lint
    args: [--verbose]  
```

## Credits

I have taken a significant portion of the code from the @TekWizely hook [TekWizely/pre-commit-golang](https://github.com/TekWizely/pre-commit-golang).

## Future

My motivation for this hook is to scratch my back only. I will add new hooks to this repository, if and when I felt the need for my projects.
