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
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
  };

  home.packages = with pkgs; [
    micromamba
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";


  home.stateVersion = "24.05";
}
