# :fzf-tab:complete:sde:*
# Preview for the `sde` CLI. The `sde` binary isn't on $PATH (the `sde` shell function
# finds it relative to itself), so resolve it for this preview subshell.
bin=${SDE_BIN:-/opt/homebrew/opt/cli-utils/share/cli-utils/sde}
[[ -x $bin ]] || return 0

# Render rich help/status at the preview pane's width so the boxes aren't cut off.
cols=${FZF_PREVIEW_COLUMNS:-${COLUMNS:-80}}
# `--help` via a var so main.zsh's global `--help` alias doesn't pipe it through bat
# (sde already renders its own colored help; bat would double-format it).
hflag=--help

if [[ $word == -* ]]; then
  return 0                                                   # option flag: no preview
elif "$bin" list 2>/dev/null | grep -qxF -- "$word"; then
  COLUMNS=$cols "$bin" -s "$word" status 2>/dev/null         # an SDE name -> its status
else
  COLUMNS=$cols "$bin" "$word" $hflag 2>/dev/null            # a (sub)command -> its help
fi
