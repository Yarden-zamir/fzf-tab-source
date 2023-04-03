# :fzf-tab:complete:gh:
query="$words$word"
query=${${query%%--*}%% } # remove options and trailing space
eval "$query --help" | bat --color=always -plhelp