# dotfiles
Manage my dotfiles using GNU Stow

## Requirements
- Clone this repository as a subdirectory of $HOME
- Install GNU Stow:

### Mac Installation

`brew install stow`

### Ubunto Installation

`sudo apt install stow`


## Usage

Run `stow` to symlink everything or just select what you want:

`stow */ # Everything (the '/' ignores the README)`

OR

`stow zsh # Just my zsh config`
