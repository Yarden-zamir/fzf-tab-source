# :fzf-tab:complete:(-command-:|command:option-(v|V)-rest)
# some logic taken from https://github.com/fluxninja/dotfiles/blob/master/dot_zshrc

export COLUMNS=$(($FZF_PREVIEW_COLUMNS - 2))
case $group in
'[shell function]'|'[alias]')
  (which $word &> /dev/null) || source $HOME/.zshrc
  which $word | bat --color=always -pl zsh
  ;;
'[external command]'|'[executable file]'|'[builtin command]'|['builtin command'])
  (out=$(man $word) 2>/dev/null && echo $out) ||\
  (out=$(tldr "$word") 2>/dev/null && echo $out) ||\
  (out=$($word --help) 2>/dev/null && echo $out) ||\
  (out=$(which "$word") && echo $out) ||\
  echo "$word"
  ;;
'builtin command')
  run-help $word | bat -lman
  ;;
'[parameter]')
  echo ${(P)word} | bat --color=always -pl zsh
  ;;
esac
