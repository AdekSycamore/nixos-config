{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
in
{

  imports = [
    inputs.zen-browser.homeModules.beta
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
    username = "adeksycamore";
    homeDirectory = "/home/adeksycamore";
  };

  home.packages = with pkgs; [
    cowsay
    vscode
    nixfmt
    fish
    btop
    telegram-desktop
    discord

  ];

  programs.home-manager.enable = true;
  programs.fuzzel.enable = true;
  programs.vscode.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
  };

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "default.target";
      environment = [ ];
    };
    settings = {
      bar.status = {
        showBattery = false;
      };
      paths.wallpaperDir = "~/Images";
    };
    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };

  services.hyprpaper = {
  enable = true;
  settings = {
    preload = [
      "~/Images/wallhaven-rqyd8j.png"
    ];
    wallpaper = [
      "~/Images/wallhaven-rqyd8j.png"
    ];
  };
};


  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 12;
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
