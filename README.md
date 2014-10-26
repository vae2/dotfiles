dotfiles.git : Mac OS X Development Environment Setup
=====================================================
Purpose of this project
-----------------------
This repo is used to track the evolution of the numerous "dotfiles" that are
used to tweak and customize my dev environment on OS X (currently running
Mavericks). I'm assuming the use of iTerm2 and the bash shell. My project
config and repo was adapted from the coursera startup engineering class, and
the contents of those original files are contained in the
startup-engineering-class subdirectory.

Usage
-----
```sh
cd $HOME
[ ! -d "git/" ] && mkdir git
cd git && git clone https://github.com/vae2/dotfiles.git
cd $HOME
ln -sb git/dotfiles/dot-profile .profile
ln -sb git/dotfiles/dot-bashrc .bashrc
ln -sb git/dotfiles/dot-dir_colors .dir_colors
ln -sb git/dotfiles/dot-emacs .emacs
ln -sb git/dotfiles/dot-emacs-dot-d .emacs.d
```

Files/Content
-------------
* dot-profile
  * [Attempt to make this compatible across Ubuntu/OSX](http://dghubble.com/blog/posts/.bashprofile-.profile-and-.bashrc-conventions/)
* dot-bashrc
* dot-dircolors
* startup-engineering-class/
  * Contains files from Coursera's Startup Engineering course

Notes from startup engineering class
------------------------------------
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
