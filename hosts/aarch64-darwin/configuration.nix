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


  nix.settings = {
  experimental-features = "nix-command flakes";
  max-jobs = 4;
};
  
  nix.optimise.automatic = true;
  nix.channel.enable = false;


  networking.hostName = "macbook";

  users.users.adrian = {
    shell = pkgs.fish;
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  environment.systemPackages = with pkgs; [ 
     lunarvim
     vim 
     wget
     htop
     eza
  ];

   programs.fish.enable = true;

  system.stateVersion = 6;
}
