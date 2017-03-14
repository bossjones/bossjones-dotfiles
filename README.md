# bossjones-dotfiles
My dotfiles and other cool shit


# Fonts

### Enabling the Powerline look

Powerline originated as a status-line plugin for Vim. Its popular eye-catching
look is based on the use of special symbols: <img width="80" alt="Powerline Symbols" style="vertical-align: middle;" src="https://cloud.githubusercontent.com/assets/553208/10687156/1b76dda6-796b-11e5-83a1-1634337c4571.png" />

To make use of these symbols, there are several options:

- use a font that already bundles those: this is e.g. the case of the
  [2.030R-ro/1.050R-it version][source code pro] of the Source Code Pro] font
- use a [pre-patched font][powerline patched fonts]
- use your preferred font along with the [Powerline font][powerline font] (that
  only contains the Powerline symbols): [this highly depends on your operating
  system and your terminal emulator][terminal support]
- [patch your preferred font][powerline font patcher] by adding the missing
  Powerline symbols: this is the most difficult way and is no more documented in
  the [Powerline manual]

[source code pro]: https://github.com/adobe-fonts/source-code-pro/releases/tag/2.030R-ro/1.050R-it
[powerline patched fonts]: https://github.com/powerline/fonts
[powerline font]: https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
[powerline font patcher]: https://github.com/powerline/fontpatcher
[terminal support]: http://powerline.readthedocs.io/en/master/usage.html#usage-terminal-emulators
[Powerline manual]: http://powerline.readthedocs.org/en/latest/installation.html#fonts-installation

Please see the [Powerline manual] for further details.

Then edit the `~/.tmux.conf.local` file (`<prefix> e`) and adjust the following
variables:

```
tmux_conf_theme_left_separator_main=''
tmux_conf_theme_left_separator_sub=''
tmux_conf_theme_right_separator_main=''
tmux_conf_theme_right_separator_sub=''


# Dotfiles to checkout
- https://github.com/giftofjehovah/dotfiles/blob/8b61dfa30df615667eae7d236076a17729de5604/settings/macos.sh
- https://github.com/rafeca/dotfiles/blob/816ffb81dc9ef37a16ce1037dbe121038ac86222/osx/apps/iterm2.sh
- https://github.com/vbdjames/dotfiles/blob/853731feaad7c8486f74ee089f32a3674e0b349c/iterm/install.sh
- https://github.com/khoad/dotfiles/blob/c80db09659a590070c16d5942fcbfe8ccabd8e5c/setupNewRig.sh
- https://github.com/davejacobs/dotfiles/blob/a028a6e9b1f116035dd81ab6acdeee75751eb3f4/bin/setup-envs/osx
