# Ellipsis-TPM [![Build Status][travis-image]][travis-url] [![Latest tag][tag-image]][tag-url] [![Gitter chat][gitter-image]][gitter-url] [![Documentation status][docs-image]][docs-url]
Tmux plugin manager

Ellipsis-TPM is an [Ellipsis][ellipsis] extension to manage Tmux plugins. It
can be used as replacement for [TPM][tpm].

### Features
- Easy plugin management.
- Easy plugin loading.
- Compatible with [existing plugins][tmux-plugins] written for [TPM][tpm]!
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

The `.ellipsis/bin` folder should be added to your path. If it isn't you will
need to symlink `.ellipsis/bin/ellipsis-tpm` to a folder that is in your path.

### Switching from [TPM][tpm]

Make sure your using the `@plugin` notation, switch the initialization line in
your tmux.conf and your good to go!

```
# Remove this
set -g @plugin 'tmux-plugins/tpm'
run '~/.tmux/plugins/tpm/tpm'

# Add this
run 'ellipsis-tpm run'
```

### Usage

Add your plugins in your `.tmux.conf` file.
```
# List of plugins
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-yank'

# Other examples
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name@branch_name'
# set -g @plugin 'http://github.com/user/plugin'
# set -g @plugin 'https://github.com/user/plugin'
# set -g @plugin 'git://github.com/user/plugin'
# set -g @plugin 'ssh://git@github.com/user/plugin'
# set -g @plugin 'https://gitlab.com/user/plugin'

# Initialize the manager (loads all plugins)
run 'ellipsis-tpm run'

```

After you modified your config file you can either source it again or run
`ellipsis-tpm run` manually.

#### Installing plugins
- Add the plugins to your config file with `set -g @plugin '...'`
- Press `prefix + I` to install newly added plugins or run `ellipsis-tpm
  install` in your terminal

Only testing a plugin? Run `ellipsis-tpm install <plugin_url>` to quickly install
it!

#### Uninstalling plugins
- Remove from your config file or comment out.
- Press `prefix + alt + u` or run `ellipsis-tpm clean` in your terminal

Remove a specific plugin? Run `ellipsis-tpm uninstall <plugin_name>`.

#### Updating plugins
- Press `prefix + U` or run `ellipsis-tpm update` in your terminal.

Update a specific plugin? Just run `ellipsis-tpm update <plugin_name>`

#### Customization

There are several options wich can either be set in the tmux config file or
with an environment variable. When both are set the environment variable will
be used.

env var          | tmux var           | Default                       | Description
-----------------|--------------------|-------------------------------|------------
`TPM_CONF`       |  /                 | `/etc/tmux.conf:~/.tmux.conf` | Tmux configuration files ( `:` separated)
`TPM_PLUGIN_PATH`| `@tpm_plugin_path` | `~/.tmux/plugins`             | Location where plugins are installed
`TPM_INSTALL_KEY`| `@tpm_install_key` | `I`                           | Key to install plugins
`TPM_UPDATE_KEY` | `@tpm_update_key`  | `U`                           | Key to update plugins
`TPM_CLEAN_KEY`  | `@tpm_clean_key`   | `M-u`                         | Key to clean plugins

The original [TPM][tpm] variables are also supported:

tmux var                   | Description
---------------------------|------------
`TMUX_PLUGIN_MANAGER_PATH` | Location where plugins are installed
`@tpm-install`             | Install key
`@tpm-update`              | Update key
`@tpm-clean`               | Cleanup key


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
[docs-image]:   https://readthedocs.org/projects/ellipsis-tpm/badge/?version=master
[docs-url]:     http://ellipsis-tpm.readthedocs.org/en/master

[ellipsis]:     https://github.com/ellipsis/ellipsis
[tpm]:          https://github.com/tmux-plugins/tpm
[tmux-plugins]: https://github.com/tmux-plugins

[style-guide]:  https://google-styleguide.googlecode.com/svn/trunk/shell.xml
[bats]:         https://github.com/sstephenson/bats
[issues]:       http://github.com/ellipsis/ellipsis-tpm/issues

[groggemans]:   https://github.com/groggemans
[mit-license]:  http://opensource.org/licenses/MIT
