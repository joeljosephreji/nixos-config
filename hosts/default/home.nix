{ config, pkgs, ... }:

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
    pkgs.waybar # TODO fix the issue with the white colour on hovering on hyprland workspace buttons
    pkgs.rofi-wayland
    pkgs.dunst
    pkgs.lxqt.lxqt-policykit

    # compilers, interpreters, and programming stuff
    pkgs.gcc
    pkgs.gnumake
    pkgs.python3Minimal
    pkgs.pipenv
    pkgs.conda
    pkgs.nodejs
    pkgs.lua51Packages.lua # for neovim
    pkgs.lua51Packages.luarocks_bootstrap # for neovim
    pkgs.tree-sitter

    # command line utils
    pkgs.oh-my-posh
    pkgs.eza
    pkgs.bat
    pkgs.tlrc # tldr but rust
    pkgs.hyprpicker

    # command line applications
    pkgs.yazi
    pkgs.btop
    pkgs.wl-clipboard
    pkgs.newsraft
    # pkgs.psmisc # TODO killall not working

    # programming software
    pkgs.minizinc
    pkgs.minizincide # TODO check if a desktop file is also provided

    # application software and utils
    pkgs.vimiv-qt
    pkgs.keepassxc
    pkgs.flowtime
    pkgs.zotero
    pkgs.lxqt.pcmanfm-qt
    pkgs.protonvpn-gui
    pkgs.copyq
    pkgs.lxqt.lxqt-archiver
    pkgs.grim
    pkgs.slurp
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.libreoffice-qt-fresh
    pkgs.kdiskmark
    pkgs.zathura
    pkgs.mousam
    pkgs.mpv
    pkgs.vlc
    pkgs.localsend
    pkgs.obs-studio # TODO check if flatpak is a better option
    pkgs.qbittorrent
    pkgs.qutebrowser
    pkgs.shortwave
    pkgs.tenacity
    pkgs.wezterm
    pkgs.calibre
    pkgs.pwvucontrol
    pkgs.libnotify
    pkgs.kdePackages.kasts
    # pkgs.gsmartcontrol # facing some issues with polkit agent, need to fix
    # pkgs.gparted # facing some issues with polkit agent, need to fix
    # TODO might need to add xorg-xhost for the above stuff or look for options

    # messengers
    pkgs.signal-desktop
    pkgs.element-desktop
    pkgs.discord
    pkgs.slack

    # music
    pkgs.spotube
    # pkgs.kdePackages.audiotube # TODO still not working

    # games
    pkgs.prismlauncher # por minecraft

    # icon theme
    (pkgs.catppuccin-papirus-folders.override {
      accent = "mauve";
    })

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

  # gammastep
  services.gammastep = {
    enable = true;
    provider = "manual";
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    tray = true;
  };

  # flameshot
  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override {
      enableWlrSupport = true; # TODO remove once it becomes the default
    };
    settings = {
      General = {
        showStartupLaunchMessage = false;
        disabledGrimWarning = true;
      };
    };
  };

  # neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor = {
      enable = true;
      size = 24;
    };
  };
  services.hyprpaper.enable = true;

  # TODO best kitty configuration
  # programs.kitty.enable = true;

  # command line utils
  programs = {
    # zsh
    # TODO figure out how to theme zsh (like in the dotfiles repo)
    zsh = {
      enable = true;
      autocd = true;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      enableCompletion = true;
      history = {
        path = "$HOME/.zsh_history";
        expireDuplicatesFirst = true;
        append = true;
        share = true;
        ignoreSpace = true;
        ignoreAllDups = true;
        saveNoDups = true;
        ignoreDups = true;
        findNoDups = true;
      };
      autosuggestion = {
        enable = true;
        strategy = [
          "history"
          "completion"
        ];
      };
      syntaxHighlighting.enable = true;
      initExtra = ''
        # ls to have colour by default and grouped by directories first
        if command -v eza &> /dev/null; then    # if eza is available, use it instead
          alias ls="eza --group-directories-first"
        else
          alias ls="ls --color --group-directories-first" # otherwise use ls color
        fi

        eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)"
      '';
      # TODO see if completion styling can be added above
      # zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

    };

    fzf = {
      enable = true;
    };
    zoxide.enable = true;
    jq.enable = true;
    fd.enable = true;
    ripgrep.enable = true;
  };

  # ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # syncthing
  services.syncthing = {
    enable = true;
  };

  # lazygit
  programs.lazygit.enable = true;

  # catppuccin
  catppuccin = {
    enable = true;
    nvim.enable = false;
    gtk.enable = true;
    kvantum = {
      apply = true;
      enable = true;
    };
    cursors = {
      enable = true;
    };
  };

  # qt theme
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # tldr updates
  services.tldr-update.enable = true;

  # life without xdg is difficult
  xdg = {
    enable = true;
    userDirs.enable = true;

    # default filetype handlers
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "text/plain" = ["nvim.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "text/plain" = ["nvim.desktop"];
      };
    };
  };

# TODO figure out firefox options
# TODO use catppuccin nix sddm, check gtk later; adapt icon theme for it
# TODO global dark theme
# TODO lookup nixos wiki on bluetooth (blueman)
# TODO flatpak support and flatseal - see if flatpak packages can be automated
# TODO scanning, printing, firewall - install firewalld, zones, etc
# TODO mpd - music player daemon
# TODO kernel panic when opening pdf -> opening librewolf -> crash
# TODO maybe save logs from previous boot as well?
# TODO pytorch - also if cuda is working alongside
# TODO is xvideo wayland bridge required?
# TODO hwinfo/lstopo
# TODO meld
# TODO networkmanager ?
# TODO ungoogled-chromium ?
# TODO pandoc
# TODO shellcheck
# TODO bottles
# TODO default applications xdg.mime
# TODO restore deleted sleep service to make it nix-y refer commit ebe4defdfa71f5e0176019f0ff9aa98b61dd5e49 in dotfiles repo
# TODO issue with mic not working after plugin headset
# TODO try to fix the cursor not switching issue when using bindkey -v in zsh
# TODO podman, distrobox
# TODO nvtop install

}
