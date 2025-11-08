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
    username = "adrian";
    homeDirectory = "/Users/adrian/";
  };

  home.packages = with pkgs; [
    cowsay
    zsh
    rustc
    cargo
  ];


  programs.fish.shellAliases = {
    nixdr = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin";
    hms = "home-manager switch --flake ~/.config/nix-darwin#adrian@macbook";
    hmp = "home-manager packages";
  };

  programs.fish = {
    enable = true;
  };

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
