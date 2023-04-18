# nvim-stable

Configuration directory for stable branch of neovim

# Lazygit Configuration (location: $HOME/.config/lazygit/config.yml)

```
os:
editCommand: "nvim"

keybinding:
universal:
return: '<c-\>'

gui:
theme:
selectedLineBgColor: - underline
selectedRangeBgColor: - underline

git:
paging:
colorArg: never
pager: delta --dark --paging=never

```
# Related system-wide configurations
# To enable mapping of capslock to escape ~/.xprofile has following
# Read comments on ~/.config/nvim/lua/user/keymaps.lua
# If all this does not work source ~/.xprofile!
```
setxkbmap -option caps:escape_shifted_capslock

```
