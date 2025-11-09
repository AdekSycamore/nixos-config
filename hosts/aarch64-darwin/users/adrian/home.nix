{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    ./config/zsh
    ./config/starship
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
    username = "adrian";
    homeDirectory = "/Users/adrian/";
  };

  home.packages = with pkgs; [
    cowsay
    rustc
    cargo
    bat
  ];

  home.sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LANGUAGE = "en";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };

  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";


  home.stateVersion = "25.05";
}
