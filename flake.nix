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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {

    nixosConfigurations = {
      home-lab = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/x86_64-intel/configuration.nix
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
        ];
      };
    };


    homeConfigurations = {
      "nixos@home-lab" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; 
        extraSpecialArgs = {inherit inputs outputs;};

        modules = [./hosts/x86_64-intel/users/nixos/home.nix];
      };
    };
  };
}
