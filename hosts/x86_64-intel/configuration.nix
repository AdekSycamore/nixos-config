{
  inputs,
  lib,
  config,
  pkgs,
  ...
<<<<<<< HEAD
}: {
=======
}:
{
>>>>>>> ead762d (save before merge)
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
<<<<<<< HEAD
      
    ];
   
=======

    ];

>>>>>>> ead762d (save before merge)
    config = {
      allowUnfree = true;
    };
  };

<<<<<<< HEAD
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
  
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
=======
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
>>>>>>> ead762d (save before merge)

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

<<<<<<< HEAD
  networking.hostName = "home-lab";

  users.users = {
    nixos = {
=======
  networking.hostName = "nixos";

  users.users = {
    adeksycamore = {
>>>>>>> ead762d (save before merge)
      initialPassword = "secretPassword";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
<<<<<<< HEAD
    
      extraGroups = ["wheel" "docker"];
=======

      extraGroups = [
        "wheel"
        "docker"
      ];
>>>>>>> ead762d (save before merge)
    };
  };

  environment.systemPackages = with pkgs; [
<<<<<<< HEAD
     vim 
     wget
     pciutils
     htop
     eza
     nvtopPackages.nvidia
     cudaPackages.cudatoolkit
  ];

  virtualisation.docker.enable = true;
=======
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
>>>>>>> ead762d (save before merge)

  services.openssh = {
    enable = true;
  };

<<<<<<< HEAD
  hardware.opengl.enable = true; 
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "24.05";
}
=======
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
>>>>>>> ead762d (save before merge)
