# :fzf-tab:complete:docker:*
query="$words$word"
# query=${${query%%--*}%% } # remove options and trailing space
eval "$word --help" | bat --color=always -plhelp
