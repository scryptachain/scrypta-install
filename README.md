# Scrypta installation script
<p><a href="https://camo.githubusercontent.com/4e892209b4b1e2d1a773ec97e544a92f068a6f0b/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f333136382f312a31674778414b57714b5135577a635170755f766932412e6a706567" target="_blank" rel="noopener noreferrer"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://camo.githubusercontent.com/4e892209b4b1e2d1a773ec97e544a92f068a6f0b/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f333136382f312a31674778414b57714b5135577a635170755f766932412e6a706567" alt="" data-canonical-src="https://miro.medium.com/max/3168/1*1gGxAKWqKQ5WzcQpu_vi2A.jpeg" /></a></p>

### Home of the script that lives at https://get.scryptachain.org

The purpose of the install script is for a convenience for quickly installing the latest [Scrypta wallet](https://github.com/scryptachain/scrypta) releases on the supported linux distros. It is not recommended to depend on this script for deployment to production systems. For more thorough instructions for installing on the supported distros, see the install instructions.

This repository is solely maintained by Scrypta Foundation

## Usage:
From https://get.scryptachain.org:

```shell
curl -fsSL https://get.scryptachain.org -o get-scrypta.sh
sh get-scrypta.sh
```

From the source repo:

```shell
sh install.sh
```

## Testing:
To verify that the install script works amongst the supported operating systems run:

```shell
make check
```

## Licensing

scrypta/scrypta-install is licensed under the MIT License. See [LICENSE](LICENSE) for the full license text.
