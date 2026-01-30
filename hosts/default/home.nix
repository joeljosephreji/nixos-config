{ config, pkgs, ... }:
# { config, pkgs, inputs, ... }:
# let
#   stable = import inputs.nixpkgs-stable {
#     system = "x86_64-linux";
#     config.allowUnfree = true;
#   };
# in
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
    pkgs.waybar # TODO: fix the issue after sleep where workspaces get locked like the previous situations and have to restart for it to get fixed again
    pkgs.rofi
    pkgs.dunst

    # compilers, interpreters, and programming stuff
    pkgs.tree-sitter
    pkgs.gcc
    pkgs.gnumake
    pkgs.python3Minimal
    pkgs.pipenv
    pkgs.conda
    # (pkgs.conda.overrideAttrs (oldAttrs: {
    # runScript = "zsh -l";
    # }))
    pkgs.nodejs
    # nix language
    pkgs.nixd
    pkgs.nixfmt
    # lua
    pkgs.lua51Packages.lua # for neovim
    pkgs.lua51Packages.luarocks_bootstrap # for neovim
    pkgs.lua-language-server # lsp
    pkgs.stylua # formatter
    # shell
    pkgs.shellcheck
    pkgs.shfmt

    # command line utils
    pkgs.oh-my-posh
    pkgs.tlrc # tldr but rust
    pkgs.hyprpicker
    pkgs.ncdu # disk analyser
    pkgs.distrobox
    pkgs.poppler-utils
    pkgs.ghostscript
    pkgs.pdftk
    pkgs.inxi
    pkgs.wl-clipboard
    pkgs.nixpkgs-track
    pkgs.ast-grep
    pkgs.caligula
    # pkgs.psmisc # TODO: killall not working

    # command line applications
    pkgs.newsraft
    pkgs.exercism

    # programming software
    pkgs.minizinc
    pkgs.minizincide

    # application software and utils
    pkgs.vimiv-qt
    pkgs.keepassxc
    pkgs.flowtime
    pkgs.zotero
    pkgs.lxqt.pcmanfm-qt
    # pkgs.protonvpn-gui # TODO: add back after this is fixed
    pkgs.lxqt.lxqt-archiver
    pkgs.grim
    pkgs.slurp
    pkgs.gimp3
    # pkgs.kdePackages.kdenlive
    pkgs.libreoffice-qt-fresh
    pkgs.kdiskmark
    pkgs.zathura
    pkgs.mpv
    pkgs.vlc
    pkgs.localsend
    # pkgs.obs-studio # TODO: check if flatpak is a better option
    pkgs.qbittorrent
    pkgs.shortwave
    pkgs.tenacity
    pkgs.wezterm
    pkgs.calibre
    pkgs.pwvucontrol
    pkgs.libnotify
    pkgs.kdePackages.kasts
    pkgs.bibletime
    # pkgs.gsmartcontrol # facing some issues with polkit agent, need to fix
    # pkgs.gparted # facing some issues with polkit agent, need to fix
    # TODO: might need to add xorg-xhost for the above stuff or look for options

    # messengers
    pkgs.signal-desktop-bin
    pkgs.element-desktop
    pkgs.discord
    pkgs.slack

    # music
    pkgs.pear-desktop
    # pkgs.spotube # TODO: wait for rewrite
    # pkgs.kdePackages.audiotube # TODO: still not working

    # games
    pkgs.prismlauncher # por minecraft
    pkgs.mgba

    # icon theme
    (pkgs.catppuccin-papirus-folders.override {
      accent = "lavender";
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

  # kitty configuration
  programs.kitty = {
    enable = true;
    settings = {
      background_blur = 5;
      background_opacity = "0.9";
      enable_audio_bell = false;
      symbol_map =
        let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
    };
    shellIntegration = {
      enableZshIntegration = true;
      mode = "enabled";
    };
  };

  # command line utils
  programs = {
    # zsh
    # TODO: figure out how to theme zsh (like in the dotfiles repo)
    zsh = {
      enable = true;
      autocd = true;
      defaultKeymap = "viins";
      dotDir = "${config.xdg.configHome}/zsh";
      enableCompletion = true;
      history = {
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
      initContent = ''
        # ls to have colour by default and grouped by directories first
        if ! command -v eza &> /dev/null; then    # if eza is available, use it instead
          alias ls="ls --color --group-directories-first" # otherwise use ls color
        fi

        eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)"
      '';
      # TODO: see if completion styling can be added above
      # zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    };

    # eza
    eza = {
      enable = true;
      colors = "always";
      git = true;
      icons = "always";
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
      ];
    };

    btop = {
      enable = true;
      package = pkgs.btop-cuda;
      settings = {
        vim_keys = true;
      };
    };

    fzf = {
      enable = true;
    };
    yazi.enable = true;
    bat.enable = true;
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
    accent = "lavender";
    nvim.enable = false;
    # not enabling gtk since it is deprecated
    kvantum = {
      apply = true;
      enable = true;
    };
    cursors = {
      enable = true;
      accent = "lavender";
    };
  };

  # gtk settings
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-hint-font-metrics = 1;
    };
  };

  # qt theme
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # dconf
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
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
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
        "inode/directory" = [
          "pcmanfm-qt.desktop"
          "lxqt-archiver.desktop"
        ];
        "image/jpeg" = [ "vimiv.desktop" ];
        "image/png" = [ "vimiv.desktop" ];
      };
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "writer.desktop" ];
        "inode/directory" = [ "pcmanfm-qt.desktop" ];
        "image/jpeg" = [ "vimiv.desktop" ];
        "image/png" = [ "vimiv.desktop" ];
        "x-scheme-handler/sgnl" = [ "signal.desktop" ];
        "x-scheme-handler/signalcaptcha" = [ "signal.desktop" ];
      };
    };
  };

  programs.qutebrowser = {
    enable = true;
    # package = stable.qutebrowser;
    searchEngines = {
      DEFAULT = "https://search.brave.com/search?q={}";
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      nixpkg = "https://search.nixos.org/packages?channel=unstable&query={}";
      nixopt = "https://search.nixos.org/options?channel=unstable&query={}";
      nixhm = "https://home-manager-options.extranix.com/?query={}&release=master";
    };
    settings = {
      colors.webpage.preferred_color_scheme = "dark";
      url.start_pages = "https://search.brave.com/";
      url.default_page = "https://search.brave.com/";
    };
  };

  services.copyq = {
    enable = true;
    forceXWayland = false;
  };

  # automating gc for the user-side as well
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # thunderbird email and calendar client
  programs.thunderbird = {
    enable = true;
    profiles.kierkegaard = {
      isDefault = true;
    };
  };

  # hyprpolkitagent
  services.hyprpolkitagent.enable = true;

}

# TODO: figure out firefox options
# TODO: flatpak support and flatseal - see if flatpak packages can be automated
# TODO: scanning, printing, firewall - install firewalld, zones, etc
# TODO: mpd - music player daemon
# TODO: kernel panic when opening pdf -> opening librewolf -> crash
# TODO: maybe save logs from previous boot as well?
# TODO: is xvideo wayland bridge required?
# TODO: hwinfo/lstopo
# TODO: meld
# TODO: pandoc
# TODO: bottles
# TODO: restore deleted sleep service to make it nix-y refer commit ebe4defdfa71f5e0176019f0ff9aa98b61dd5e49 in dotfiles repo
# TODO: issue with mic not working after plugin headset
# TODO: try to fix the cursor not switching issue when using bindkey -v in zsh
# TODO: nvtop install
# TODO: conda-shell figure out zsh
# TODO: kdenlive, calibre to have nonCudaPkgs with nixpkgs.config.cudaSupport = false; requires let/overlay etc something like: nonCudaPkgs = import pkgs.path { config.cudaSupport = false; };
# TODO: kdenlive not being able to use GPU rendering. check for price.
# TODO: install kdenlive and obs-studio automatically with flatpak - nix-flatpak or declarative-flatpak
# TODO: fix logout - figure out the issue when logging out where cursor blinks in a blank screen
# TODO: see if there are workarounds for autotype by keepassxc
# TODO: solve issue with lsp not working in neovim on nixos
