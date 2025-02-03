{
  description = "abstracT nixConfig";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    yazi.url = "github:sxyazi/yazi";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # nixvim = {
      # url = "github:nix-community/nixvim/nixos-24.11";
      # url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      #url = "github:elythh/nixvim"; #elythh maximal nixvim lul
    # };

    # obsidian-nvim.url = "github:epwalsh/obsidian.nvim";
    # Required, nvf works best and only directly supports flakes
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs"; # This is safe to do as nvf does not depend on a binary cache
      # Optionally, you can also override individual plugins
      # inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    };

    # nix-index-database.url = "github:nix-community/nix-index-database";
    # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland.url = "github:hyprwm/Hyprland";

    # python-nixpkgs.url = "github:nixos/nixpkgs/4ae2e647537bcdbb82265469442713d066675275";

    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";#TODO: find out what follows does exactly
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

  };

  outputs = {nixpkgs,nixpkgs-unstable, ...}@inputs:
    let
      system = "x86_64-linux";
      # system = builtins.currentSystem;
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}; #confirm syntax
      pkgs = import nixpkgs {#TODO: see if legacyPackages can be used instead 
        inherit  system;
        config = {
          allowUnfree = true;
          # permittedInsecurePackages = [
            #"qbittorrent-qt5-4.6.4"
          # ];
        };
      };
      # nvf
      neovimConf = inputs.nvf.lib.neovimConfiguration {
        inherit (nixpkgs.legacyPackages.${system}) pkgs;
        modules = [ ./modules/nvf];
      };
    in
    {
      packages.${system}.my-neovim = neovimConf.neovim; # NVF

      nixosConfigurations = {
        carthage = 
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs pkgs pkgs-unstable system; };
            modules = [
              ./hosts/carthage/default.nix
              {environment.systemPackages = [neovimConf.neovim];}
              inputs.home-manager.nixosModules.home-manager { # is this analogous to <home-manager/nixos> from docs # remove need for shell instantiation...get from flake TODO: split hyrland on laptop vs pc
                home-manager = {
                  verbose = true;
                  backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
                  users.malu = import ./modules/home.nix;
                  useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
                  useUserPackages = false; # if false ... uses nix-profile for home apps
                  extraSpecialArgs = { inherit pkgs pkgs-unstable inputs system; };
                };
              }
            ];
        };
        tangier =
          nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs pkgs pkgs-unstable system;
          };
          modules = [
            # ./hosts/carthage/default.nix
            ./hosts/tangier/default.nix
            # nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options. # using nvf/ import instead...cleaner
            inputs.home-manager.nixosModules.home-manager { 
              home-manager = {
                # verbose = true;
                backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
                users.malu = import ./modules/home.nix;
                useGlobalPkgs = true; # dont use private instance of pkgs which is the default
                useUserPackages = false; # if false ... uses nix-profile for home apps
                extraSpecialArgs = {
                inherit pkgs pkgs-unstable inputs system; 
                };
              };
            }
          ];
        };
      # homeConfigurations = {
      #   malu = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     extraSpecialArgs = {
      #       inherit pkgs pkgs-unstable inputs system  pc userPc; };
      #     modules = [
      #       ./modules/home.nix
      #       # inputs.nix-index-database.hmModules.nix-index
      #       # inputs.plasma-manager.homeManagerModules.plasma-manager
      #     ];
      #   };
      # };

      devShells.${system}.default = pkgs.mkShell
        {
          nativeBuildInputs = with pkgs; [
            #inputs.python-nixpkgs.legacyPackages.${system}.python313
            (python312.withPackages (python-pkgs: with python-pkgs; [
              pandas
              numpy
              seaborn
              matplotlib
              tkinter
              pip
              requests
            ])) # teal env
          ];
          shellHook = ''
            echo "welcome to your dev env lul"
            #pip install ttkbootstrap
          '';
          MYVAR = "custom var here lol";
        };
      };
    };
}
