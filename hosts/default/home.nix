{ config, pkgs, ... }:

# TODO figure out firefox
# TODO figure out how to theme gtk (nwlook) and qt applications - use catpuccin (refer to repo if needed)
# TODO lookup nixos wiki on bluetooth (blueman)
# TODO flatpak support and flatseal
# TODO scanning, printing, firewall
# TODO mpd - music player daemon
# TODO minecraft
# TODO nvidia stuff
# TODO rog stuff - batteries, etc
# TODO install hypr stuff - cursor, graphics, idle, land, lang, lock, paper, polkitagent, utils, scanner, portal
# TODO is xvideo wayland bridge required?
# TODO pavucontrol
# TODO hwinfo/lstopo
# TODO meld
# TODO networkmanager ?
# TODO geo handler for gammastep
# TODO xwayland ?
# TODO librewolf ungoogled-chromium ?
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kierkegaard";
  home.homeDirectory = "/home/kierkegaard";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # tools for window manager
    pkgs.stow
    pkgs.waybar
    pkgs.rofi-wayland
    pkgs.dunst
    pkgs.hyprpolkitagent

    # compilers
    pkgs.gcc
    pkgs.gnumake

    # command line utils
    pkgs.oh-my-posh
    pkgs.eza
    pkgs.zoxide
    pkgs.fzf
    pkgs.jq
    pkgs.fd
    pkgs.ripgrep
    pkgs.newsraft
    pkgs.bat

    # command line applications
    pkgs.yazi
    pkgs.btop

    # programming software
    pkgs.neovim
    pkgs.minizinc
    pkgs.minizincide # check if a desktop file is also provided

    # application software and utils
    pkgs.vimiv-qt
    pkgs.keepassxc
    pkgs.flowtime
    pkgs.zotero
    pkgs.gammastep
    pkgs.lxqt.pcmanfm-qt
    pkgs.protonvpn-gui
    pkgs.copyq
    pkgs.lxqt.lxqt-archiver
    pkgs.grim
    pkgs.flameshot
    pkgs.gimp
    pkgs.kdePackages.kdenlive # TODO fix opengl thing
    pkgs.libreoffice-qt-fresh
    pkgs.kdiskmark
    pkgs.zathura
    pkgs.mousam
    pkgs.mpv
    pkgs.vlc
    pkgs.localsend # TODO fix opengly thing
    pkgs.obs-studio # TODO failed to initialise
    pkgs.qbittorrent
    pkgs.qutebrowser # TODO fix, EGL not available
    pkgs.shortwave
    pkgs.tenacity # TODO maybe some ffmpeg issue?
    pkgs.wezterm # TODO issue with wayland / EGL?
    # pkgs.kdePackages.kdeconnect-kde # TODO figure out how to set this
    # pkgs.kitty # TODO figure out how to set this and see if this needs to be set somewhere else
    # pkgs.gsmartcontrol # facing some issues with polkit agent, need to fix
    # pkgs.gparted # facing some issues with polkit agent, need to fix
    # TODO might need to add xorg-xhost for the above stuff or look for options

    # messengers
    pkgs.signal-desktop
    pkgs.element-desktop
    pkgs.discord
    pkgs.slack

    # music
    pkgs.spotube # TODO opengl stuff
    # pkgs.kdePackages.audiotube # not working
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kierkegaard/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # managing fonts
  fonts.fontconfig.enable = true;
}
