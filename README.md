dotfiles.git : Mac OS X Development Environment Setup
=====================================================
Purpose of this project
-----------------------
This repo is used to track the evolution of the numerous "dotfiles" that are
used to tweak and customize my dev environment on OS X (currently running
Mavericks). I'm assuming the use of iTerm2 (not required) and the bash shell
(required). My project config and repo was adapted from the coursera startup
engineering class, and the contents of those original files are contained in
the startup-engineering-class subdirectory.

Usage
-----
1) Install the solarized color theme, which makes life on the command-line
(and in your favorite editor) infinitely better.
```sh
cd $HOME
[ ! -d "git/" ] && mkdir git
cd git && git clone git://github.com/altercation/solarized.git
```
Go into the solarized project iTerm2 subdirectory, and follow the instructions
for importing the solarized color theme into iTerm2.

For the Emacs solarized theme, I've already included it in the
dotfiles project (below). Theoretically, it would be good to check
from time-to-time for updates from the solarized author.

2) Git/bash prompt integration setup. This grabs a helper bash script from the
git project that lets my setup my bash prompt to integrate with git. (note
below that I'm assuming Macports GNU port of the coreutils is installed).
```sh
cd git && git clone https://github.com/git/git.git
cd $HOME
/opt/local/bin/gln -sb ~/git/git/contrib/completion/git-prompt.sh ~/.git-prompt.sh
```
The necessary prompt/import commands are located in the dot-bashrc file (below)

3) Pull and setup Dotfile/config file customizations. I clone my own
dotfiles/config files from github:
```sh
cd $HOME
[ ! -d "git/" ] && mkdir git
cd git && git clone https://github.com/vae2/dotfiles.git
cd $HOME
/opt/local/bin/gln -sb git/dotfiles/dot-profile .profile
/opt/local/bin/gln -sb git/dotfiles/dot-bashrc .bashrc
/opt/local/bin/gln -sb git/dotfiles/dot-emacs .emacs
/opt/local/bin/gln -sb git/dotfiles/dot-emacs-dot-d .emacs.d
```

4) Upgrade bash shell version. Mac OSX uses a horribly outdated bash shell
(3.2 as of Yosemite). There is a bug in bash 3.x that breaks the command line
use of Rscript (and
[Rio](https://github.com/jeroenjanssens/data-science-at-the-command-line/blob/master/tools/Rio)).

 The best way around this is to upgrade bash using Macports and the following
 steps.
```sh
sudo port install bash
```
Then, I follow
 [these steps](http://stackoverflow.com/questions/791227/unable-to-update-my-bash-in-mac-by-macports),
 restart my terminal window, and Voila!

Files/Content
-------------
* dot-profile
  * [Attempt to make this compatible across Ubuntu/OSX](http://dghubble.com/blog/posts/.bashprofile-.profile-and-.bashrc-conventions/)
* dot-bashrc
  * The meat of the config settings for bash
* dot-dircolors
  * [here's why and how](http://hocuspokus.net/2008/01/a-better-ls-for-mac-os-x/)
  * Note, I no longer use this, replaced with solarized
* dot-emacs
  * Emacs config settings and customizations (there are good amount of these)
* dot-emacs-dot-d
  * Contains emacs customizations in file orgconfig.el (todo: split this into multiple configs per topic for better organization)
  * Directory to store 3rd party lisp extensions for emacs (e.g. python-mode.el)
* startup-engineering-class/
  * Contains files from Coursera's Startup Engineering course

Notes from startup engineering class (deprecated)
-------------------------------------------------
Clone and run this on a new EC2 instance running Ubuntu 12.04.2 LTS to
configure your `bash` and `emacs` development environment as follows:

```sh
cd $HOME
git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
mv .emacs.d .emacs.d~
ln -s dotfiles/.emacs.d .
```

See also http://github.com/startup-class/setup to install prerequisite
programs. If all goes well, in addition to a more useful prompt, now you can
do `emacs -nw hello.js` and hitting `C-c!` to launch an interactive SSJS
REPL, among many other features. See the
[Startup Engineering Video Lectures 4a/4b](https://class.coursera.org/startup-001/lecture/index)
for more details.
