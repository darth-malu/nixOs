{
  description = "maluware";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    yazi.url = "github:sxyazi/yazi";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # obsidian-nvim.url = "github:epwalsh/obsidian.nvim";
    # Required, nvf works best and only directly supports flakes
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs"; # This is safe to do as nvf does not depend on a binary cache
      # Optionally, you can also override individual plugins
      # inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.url = "github:hyprwm/Hyprland"; # with cachix
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # python-nixpkgs.url = "github:nixos/nixpkgs/4ae2e647537bcdbb82265469442713d066675275";
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";#TODO: find out what follows does exactly
    };
  };

  outputs = {nixpkgs , ...}@inputs: # Note the use of `self` which allows reusing flake's outputs in itself
    let
      system = "x86_64-linux"; # system = builtins.currentSystem;??
      neovimConf = inputs.nvf.lib.neovimConfiguration {
        inherit (nixpkgs.legacyPackages.${system}) pkgs;
        modules = [ ./modules/nvf];
      };
      pkgs = import nixpkgs {#TODO: see if legacyPackages can be used instead 
        inherit  system;
        config = {
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
              "discord" "microsoft-edge" "google-chrome" "bluemail" "spotify" "obsidian" "wpsoffice" "broadcom-sta"
            ];
        };
      };
    in
    {
      packages.${system}.my-neovim = neovimConf.neovim; # NVF

      #WARN: CARTHAGE-
      nixosConfigurations = {
        carthage = 
          nixpkgs.lib.nixosSystem {
            inherit system;
            # specialArgs = { inherit pkgs inputs system; };
            specialArgs = { inherit inputs system; };
            modules = [
              # {config = { nixpkgs.pkg = import nixpkgs {}; nixpkgs.config.allowUnfree = true;};}
              # nixpkgs.nixosModules.readOnlyPkgs # then set nnixpkgs.pkgs to use options like config.allowUnfreePredicate
              ./hosts/carthage/default.nix
              {environment.systemPackages = [neovimConf.neovim];} # standalone nvf
              inputs.home-manager.nixosModules.home-manager { 
                home-manager = {
                  verbose = true;
                  backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
                  users.malu = import ./modules/home.nix;
                  useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
                  useUserPackages = false; # if false ... uses nix-profile for home apps
                  extraSpecialArgs = { inherit inputs pkgs system; };
                };
              }
            ];
        };
        #WARN: TANGIER
        tangier =
          nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/tangier/default.nix
            # nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options. # using nvf/ import instead...cleaner
            # {nixpkgs.pkg = import nixpkgs {};}
            inputs.home-manager.nixosModules.home-manager { 
              home-manager = {
                # verbose = true;
                backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
                users.malu = import ./modules/home.nix;
                useGlobalPkgs = true; # dont use private instance of pkgs which is the default
                useUserPackages = false; # if false ... uses nix-profile for home apps
                extraSpecialArgs = { inherit  inputs system; };
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
