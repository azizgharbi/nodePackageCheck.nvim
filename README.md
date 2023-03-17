# nodePackageCheck for Neovim

- A plugin for Neovim that allows you to check updates and versions of your node packages from within Neovim.

### Example

- Show the latest verion of any package from `registry.npmjs`.
- Check if packages are outdated inside `package.json`.

# Installation

- Work in progress : You still can manually install the plugin.
- git clone this repository:

#### Packer

- `use("azizgharbi/nodePackageCheck.nvim")`

# Usage

- Currently, the plugin is in a work in progress state.
- Get the package latest version: `:NodePackageCheckVersion [package name]`.
- While this feature may not be particularly useful at this stage, it is being developed further.
- `:NodepackagecheckUpdateLineVersion` : Command to update the current line package version and save
- `:NodepackagecheckLoadVersions`: Load package version inside `package.json`.

#### Available commands

- `:NodePackageCheckVersion` : Require a `string` parameter which is the `package name`.
- `:NodepackagecheckUpdateLineVersion`.
- `:NodepackagecheckLoadVersions`

# Unit Test

- Using busted: [busted](https://lunarmodules.github.io/busted/).
- Inside `lua folder` run `busted .`

# Contributing

We welcome contributions from the community. If you have an idea for a feature or would like to report a bug, please create an issue on the project's GitHub repository.

If you would like to contribute code, please create a pull request with your changes. We ask that all contributions adhere to our code of conduct.

# License

This project is licensed under the MIT License.
