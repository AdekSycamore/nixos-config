{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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

  networking.hostName = "home-lab";

  users.users = {
    nixos = {
      initialPassword = "secretPassword";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
    
      extraGroups = ["wheel" "docker"];
    };
  };

  environment.systemPackages = with pkgs; [
     vim 
     wget
     pciutils
     htop
     eza
     nvtopPackages.nvidia
     cudaPackages.cudatoolkit
  ];

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
  };

  hardware.opengl.enable = true; 
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "24.05";
}