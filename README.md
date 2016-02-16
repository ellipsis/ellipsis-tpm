# Ellipsis-TPM [![Build Status][travis-image]][travis-url] [![Latest tag][tag-image]][tag-url] [![Gitter chat][gitter-image]][gitter-url]
Tmux plugin manager

**This project is in an alpha stage! Use at own risk!**

Ellipsis-TPM is an [Ellipsis][ellipsis] extension to manage Tmux plugins. It
can be used as replacement for [TPM][tpm].

### Features
- Easy plugin management.
- Easy plugin loading.
- Compatible with existing plugins written for [TPM][tpm]!
- No Tmux version restrictions!
- Can be used without Tmux running.
- Supports custom config file locations.
- Supports branch based installs

### Install
**Requirements:** [Ellipsis][ellipsis]

```bash
# With ellipsis installed
$ ellipsis install ellipsis-tpm

# Without ellipsis installed
$ curl -Ls ellipsis.sh | PACKAGES='ellipsis-tpm' sh
```

### Usage
**TODO**

### Development
Pull requests welcome! New code should follow the [existing style][style-guide]
(and ideally include [tests][bats]).

Suggest a feature or report a bug? Create an [issue][issues]!

## Author
By [G. Roggemans][groggemans]

## License
Ellipsis-TPM is open-source software licensed under the [MIT license][mit-license].

[travis-image]: https://img.shields.io/travis/ellipsis/ellipsis-tpm.svg
[travis-url]:   https://travis-ci.org/ellipsis/ellipsis-tpm
[tag-image]:    https://img.shields.io/github/tag/ellipsis/ellipsis-tpm.svg
[tag-url]:      https://github.com/ellipsis/ellipsis-tpm/tags
[gitter-image]: https://badges.gitter.im/ellipsis/ellipsis.svg
[gitter-url]:   https://gitter.im/ellipsis/ellipsis

[ellipsis]:     https://github.com/ellipsis/ellipsis
[tpm]:          https://github.com/tmux-plugins/tpm

[style-guide]:  https://google-styleguide.googlecode.com/svn/trunk/shell.xml
[bats]:         https://github.com/sstephenson/bats
[issues]:       http://github.com/ellipsis/ellipsis-tpm/issues

[groggemans]:   https://github.com/groggemans
[mit-license]:  http://opensource.org/licenses/MIT
