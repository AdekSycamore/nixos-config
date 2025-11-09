{ config, pkgs, lib, ... }:

{
    programs.zsh = {
        enable = true;
        dotDir = "${config.home.homeDirectory}/.config/zsh";

        enableCompletion = true;
        autosuggestion.enable = true;

        shellAliases = {
           # File and directory listing
            l = "exa -l";
            ll = "exa -la";
            lt = "exa -laT";

            # Remove directory recursively
            rmd = "rm -rf";

            # Use bat for cat command
            cat = "bat";

            # Git shortcuts
            gs = "git status";
            ga = "git add";
            gc = "git commit";
            gp = "git push";

            # Nix commands
            nixdr = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin";
            hms = "home-manager switch --flake ~/.config/nix-darwin#adrian@macbook";
            hmp = "home-manager packages";
        };

        sessionVariables = {
            EDITOR = "lvim";
            VISUAL = "lvim";

            LANG="en_US.UTF-8";
            LC_ALL="en_US.UTF-8";
            LANGUAGE="en";

            NIXCONFIG="${config.home.homeDirectory}/.config/nix-darwin";

            XDG_CONFIG_HOME="${config.home.homeDirectory}/.config";
        };

        initContent = ''
            source "${config.home.homeDirectory}/.config/nix-darwin/hosts/aarch64-darwin/users/${config.home.username}/config/zsh/.zshrc"
        '';

        plugins = with pkgs; [
           {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
             tag = "0.8.0";
             hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
          };
        }
        {
          name = "zsh-completions";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            tag = "0.35.0";
            hash = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
          };
        }
        ];
    };
}