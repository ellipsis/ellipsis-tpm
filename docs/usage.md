<h1>Usage</h1>

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


[tpm]:          https://github.com/tmux-plugins/tpm
