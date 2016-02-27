<h1>Switching from TPM</h1>

Make sure your using the `@plugin` notation, switch the initialization line in
your tmux.conf and your good to go!

```
# Remove this
set -g @plugin 'tmux-plugins/tpm'
run '~/.tmux/plugins/tpm/tpm'

# Add this
run 'ellipsis-tpm run'
```

