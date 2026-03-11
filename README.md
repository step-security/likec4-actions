[![StepSecurity Maintained Action](https://raw.githubusercontent.com/step-security/maintained-actions-assets/main/assets/maintained-action-banner.png)](https://docs.stepsecurity.io/actions/stepsecurity-maintained-actions)

# LikeC4 Github Action

![GitHub release](https://img.shields.io/github/release/step-security/likec4-actions.svg)

This action wraps [likec4](https://likec4.dev/docs/tools/cli/) CLI as a GitHub Action.
 
## Usage

Build website:

```yaml
...
    steps:
      - uses: actions/checkout@v4

      - name: build
        uses: step-security/likec4-actions@v1
        with:
          action: build
          path: src/likec4
          output: dist
          base: baseurl

      - name: upload artifacts
        uses: actions/upload-artifact@v7
        with:
          name: likec4
          path: dist
```

Export diagrams to PNG:

```yaml
...
    steps:
      - name: export diagrams
        uses: step-security/likec4-actions@v1
        with:
          export: png
          path: src/likec4
          output: images
          use-dot-bin: 'true'
```

Code generation:

```yaml
...
    steps:
      - name: code generation
        uses: step-security/likec4-actions@v1
        with:
          codegen: react
          output: __generated__/likec4.tsx
```

## Inputs

| Name          | Description                                                                                           |
| ------------- | ----------------------------------------------------------------------------------------------------- |
| `action`      | Action to perform (`build` / `export` / `codegen`)                                                    |
| `export`      | Can be used instead of `action: export`                                                               |
| `codegen`     | Can be used instead of `action: codegen`, same values as in [cli](https://likec4.dev/docs/tools/cli/) |
| `path`        | Path in repository to likec4 sources, root otherwise                                                  |
| `output`      | Output directory/file                                                                                 |
| `base`        | Custom baseUrl for website                                                                            |
| `use-dot-bin` | if `'true'` will use `dot` binary of graphviz                                                         |
| `use-hash-history` | use hash history for navigation, e.g. "/#/view" instead of "/view" |
| `webcomponent-prefix` | same as in [cli](https://likec4.dev/tooling/codegen/#webcomponent)      |

> All inputs are optional.  
> By default builds a website to `dist` directory.
