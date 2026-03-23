{

  # ===================================================================================== #
  # ,--.  ,--.,--.           ,-----.  ,---.       ,-----.                ,---.,--.        #
  # |  ,'.|  |`--',--.  ,--.'  .-.  ''   .-'     '  .--./ ,---. ,--,--, /  .-'`--' ,---.  #
  # |  |' '  |,--. \  `'  / |  | |  |`.  `-.     |  |    | .-. ||      \|  `-,,--.| .-. | #
  # |  | `   ||  | /  /.  \ '  '-'  '.-'    |    '  '--'\' '-' '|  ||  ||  .-'|  |' '-' ' #
  # `--'  `--'`--''--'  '--' `-----' `-----'      `-----' `---' `--''--'`--'  `--'.`-  /  #
  #                                                                               `---'   #
  # ===================================================================================== #

  description = "AdekSycamore NixOS configuration ❄️";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    caelestia = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nix-darwin,
      caelestia,
      zen-browser,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/x86_64-intel/configuration.nix
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          ];
        };
      };

      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/aarch64-darwin/configuration.nix ];
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        specialArgs = { inherit inputs outputs; };
      };

      homeConfigurations = {
        "adeksycamore@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };

          modules = [
            ./hosts/x86_64-intel/users/adeksycamore/home.nix
            caelestia.homeManagerModules.default
          ];
        };

        "adrian@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };

          modules = [ ./hosts/aarch64-darwin/users/adrian/home.nix ];
        };

      };
    };
}
