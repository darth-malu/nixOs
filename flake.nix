{
  description = "Kenyan Tinkerer makes a flake -- 🫥";
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    yazi.url = "github:sxyazi/yazi";

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.url = "github:hyprwm/Hyprland"; # with cachix
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprpaper = { # TODO: test if needed
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
    };

    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{nixpkgs , home-manager, ...}: # Note the use of `self` which allows reusing flake's outputs in itself

  let
    system = "x86_64-linux"; # system = builtins.currentSystem;??

    # neovimConf = inputs.nvf.lib.neovimConfiguration {
    #     inherit (nixpkgs.legacyPackages.${system}) pkgs;
    #     modules = [ ./modules/nvf];
    # };

    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {
      inherit  system;
      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "discord"
          "google-chrome"
          "bluemail"
          "ventoy"
          "spotify"
          # "obsidian"
          "wpsoffice"
          "warp-terminal"
          "windows10-icons"
          # "whatsapp-emoji-linux"
          "aspell-dict-en-science"
          "davinci-resolve"
          # "steam"
          # "steam-original"
          # "steam-unwrapped"
          # "steam-run"
          "youtube-upnext"
          "evafast"
          "rider"
          "android-studio-stable"
          "broadcom-sta"
        ];
        permittedInsecurePackages = [
          "ventoy-1.1.05"
        ];
      };
    };
  in
  {
    # packages.${system}.my-neovim = neovimConf.neovim; # NVF

  nixosConfigurations = {
    carthage = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/carthage
          # inputs.quickshell.packages.${system}.default
          # {environment.systemPackages = [neovimConf.neovim];}
          inputs.home-manager.nixosModules.home-manager {
            home-manager = {
              verbose = true;
              backupFileExtension = "home_backup";
              users.malu = import ./modules/home/home.nix;
              useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
              useUserPackages = false; # if false ... uses nix-profile for home apps
              extraSpecialArgs = { inherit inputs pkgs system; };
            };
          }
        ];
  };

  tangier = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs system; };
      modules = [
        ./hosts/tangier
        # inputs.quickshell.packages.${system}.default
        # {environment.systemPackages = [neovimConf.neovim];} # standalone nvf
        home-manager.nixosModules.home-manager {
          home-manager = {
            verbose = true;
            backupFileExtension = "home_backup";
            users.malu = import ./modules/home/home.nix;
            useGlobalPkgs = true; # dont use private instance of pkgs which is the default
            useUserPackages = false; # if false:: ... uses nix-profile for home apps
            extraSpecialArgs = { inherit inputs pkgs system; };
          };
        }
      ];
    };

    }; # end of nixosConfigurations
  };   # end of outputs
}    # EOF
