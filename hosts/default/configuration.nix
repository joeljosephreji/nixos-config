# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
    ];

  # Flakes and nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # cache for cuda libraries
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # because building is a pain and it is causing memory issues
  nix.settings.build-dir = "/nix/build-sandbox";

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  # TODO check later to see if Indian locale has utf8
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kierkegaard = {
    isNormalUser = true;
    description = "kierkegaard";
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  git
  kitty
  networkmanagerapplet
  brightnessctl
  playerctl
  coreutils-full
  unzip
  wget
  pciutils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # For firefox
  programs.firefox.enable = true;

  # For electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true; # for screen lock
  services.hypridle.enable = true; # automatically turning off the screen

  # List services that you want to enable:

  # Display Manager.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    users = {
      "kierkegaard" = {
          imports = [
            ./home.nix
            inputs.catppuccin.homeManagerModules.catppuccin
          ];
      };
    };
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      fira-code
      fira-sans
      font-awesome
      fira-go
      fira-math
      merriweather
      merriweather-sans
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Merriweather" "Noto Serif Malayalam" ];
        sansSerif = [ "FiraGO" "Noto Sans Malayalam" ];
        monospace = [ "FiraCode Nerd Font" "FiraMono Nerd Font" ];
      };
    };
  };

  services = {
    # asus laptop stuff
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
    udev.extraHwdb = ''
      evdev:name:*:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
       KEYBOARD_KEY_ff31007c=f20    # fixes mic mute button
       KEYBOARD_KEY_ff3100b2=home   # Set fn+LeftArrow as Home
       KEYBOARD_KEY_ff3100b3=end    # Set fn+RightArrow as End
    '';

    flatpak.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # pipewire stuff
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # for mounting external devices
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # kdeconnect - TODO clipboard sync not working
  programs.kdeconnect.enable = true;

  # polkit
  security.polkit.enable = true;

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # enabling power profiles daemon
  services.power-profiles-daemon.enable = true;

  # nvidia - TODO powermgmt seems to be not working well with my gpu
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true; # opengl enabled
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;

    dynamicBoost.enable = false; # error coming up in powerd service

    prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    nvidiaSettings = true;
  };

  # Allow cuda support
  nixpkgs.config.cudaSupport = true;

  # catppuccin
  catppuccin = {
    enable = true;
    sddm.enable = false;
  };

  # virtualisation
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  programs.virt-manager.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
}
