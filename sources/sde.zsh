# :fzf-tab:complete:sde:*
# Preview for the `sde` CLI. `sde` is a shell function (not on $PATH), and this preview runs
# in a fresh subshell, so resolve the binary via $SDE_BIN (exported by sde.zsh) or the brew
# install. Renders sde's own rich help/status, sized to the preview pane.
bin=${SDE_BIN:-$commands[sde]}
[[ -x $bin ]] || bin=/opt/homebrew/opt/cli-utils/share/cli-utils/sde
[[ -x $bin ]] || bin=/opt/homebrew/opt/cli-utils/share/cli-utils/sde-core   # pre-rename fallback
[[ -x $bin ]] || return 0

cols=${FZF_PREVIEW_COLUMNS:-${COLUMNS:-80}}
(( cols > 0 )) || cols=80           # COLUMNS can be 0 with no tty; rich renders nothing at width 0
hflag=--help                       # bypass main.zsh's --help→bat alias (sde colors its own help)
context=(${words[2,-1]})           # subcommand path after `sde` (handles `sde qcs <tab>`, `-s X …`)

if [[ $word == -* || $group == options ]]; then
  return 0                                                       # flag candidate: no preview
elif [[ $group == SDEs ]] || "$bin" list 2>/dev/null | grep -qxF -- "$word"; then
  COLUMNS=$cols "$bin" -s "$word" status 2>/dev/null             # an SDE name -> its status
else
  COLUMNS=$cols "$bin" $context "$word" $hflag 2>/dev/null       # a (sub)command -> its help
fi
