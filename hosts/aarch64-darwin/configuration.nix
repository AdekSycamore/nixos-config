{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
      
    ];
   
    config = {
      allowUnfree = true;
    };
  };


  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 4;
    };
    
    optimise.automatic = true;
    channel.enable = false;
  };

  networking.hostName = "macbook";

  users.users.adrian = {
    shell = pkgs.zsh;
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  environment.systemPackages = with pkgs; [ 
     lunarvim
     vim 
     wget
     htop
     eza
  ];

  environment.shells = with pkgs; [ zsh ];

  system.stateVersion = 6;
}
