# scrypta/scrypta-install

Home of the script that lives at get.scryptachain.org!

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
