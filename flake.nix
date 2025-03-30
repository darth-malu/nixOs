{
  description = "maluware";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    yazi.url = "github:sxyazi/yazi";

emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";

nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

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

nyaa = {
  url = "github:Beastwick18/nyaa";
  inputs.nixpkgs.follows = "nixpkgs";#TODO: find out what follows does exactly
};
};

outputs = inputs@{nixpkgs , nix-doom-emacs, self, ...}: # Note the use of `self` which allows reusing flake's outputs in itself
  let
    system = "x86_64-linux"; # system = builtins.currentSystem;??

neovimConf = inputs.nvf.lib.neovimConfiguration {
  inherit (nixpkgs.legacyPackages.${system}) pkgs;
  modules = [ ./modules/nvf];
};

pkgs = import nixpkgs {
  inherit  system;
  config = {
    allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "discord" "microsoft-edge" "google-chrome" "bluemail" "spotify" "obsidian" "wpsoffice" "broadcom-sta" "windows10-icons" "whatsapp-emoji-linux" "aspell-dict-en-science" "davinci-resolve"
      "youtube-upnext"
    ];
  };
  # overlays = [
  #   (import self.inputs.emacs-overlay) # with flakes
  # ];
};
in
{
  packages.${system}.my-neovim = neovimConf.neovim; # NVF

# NOTE CARTHAGE-
nixosConfigurations = {
  carthage =
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs self system; };
      modules = [
        { nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ]; } # emacs overlay

        ./hosts/carthage

        {environment.systemPackages = [neovimConf.neovim];} # standalone nvf

        inputs.home-manager.nixosModules.home-manager {
          home-manager = {
            verbose = true;
            backupFileExtension = "home_backup"; # useful for clearance script
            users.malu = import ./modules/home.nix;
            useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
            useUserPackages = false; # if false ... uses nix-profile for home apps
            extraSpecialArgs = { inherit inputs pkgs self system; };
          };
        }
      ];
    };

# NOTE TANGIER
tangier =
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs system; };
    modules = [
      ./hosts/tangier
      {environment.systemPackages = [neovimConf.neovim];} # standalone nvf
      inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          verbose = true;
          backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
          users.malu = import ./modules/home.nix;
          useGlobalPkgs = true; # dont use private instance of pkgs which is the default
          useUserPackages = false; # if false:: ... uses nix-profile for home apps
          extraSpecialArgs = { inherit  pkgs inputs system; };
        };
      }
    ];
  };

devShells.${system}.default = pkgs.mkShell
  {
    # nativeBuildInputs = with pkgs; [ # TODO: see between
    BuildInputs = with pkgs; [
      doom-emacs
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
