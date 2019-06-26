# Load the shell dotfiles, and then some:
for file in ~/.{bash_prompt,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

case $- in
   *i*) if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
esac

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

