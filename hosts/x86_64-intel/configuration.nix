{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [

    ];

    config = {
      allowUnfree = true;
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };

      channel.enable = false;

      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  boot = {
    kernelPackages = pkgs.linuxPackages;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };
  };

  networking.hostName = "kompostownik67";

  users.users = {
    adeksycamore = {
      initialPassword = "secretPassword";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];

      extraGroups = [
        "wheel"
        "docker"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    pciutils
    htop
    eza
    home-manager
    # xwayland-satellite
    alacritty
    kitty
    # nvtopPackages.nvidia
    # cudaPackages.cudatoolkit
  ];

  #virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
  };

  hardware.nvidia.open = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];


  programs.hyprlock.enable = true;
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # hardware.opengl.enable = true;
  # services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  # };

  services.greetd = {
  enable = true;
  settings = rec {
    initial_session = {
      command = "hyprland > /dev/null 2>&1";
      user = "adeksycamore";
    };
    default_session = initial_session;
  };
};

  programs.nix-ld.enable = true;

  system.stateVersion = "25.05";
}
