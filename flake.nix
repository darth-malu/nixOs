{
  description = "Kenyan Tinkerer makes a flake -- 🫥";
  inputs = {

  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

yazi.url = "github:sxyazi/yazi";

home-manager = {
  url = "github:nix-community/home-manager/release-25.05";
  inputs.nixpkgs.follows = "nixpkgs";
};
home-manager-unstable = {
  url = "github:nix-community/home-manager";
  inputs.nixpkgs.follows = "nixpkgs-unstable";
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
  inputs.nixpkgs.follows = "nixpkgs-unstable";
};

};

outputs = inputs@{nixpkgs , nixpkgs-unstable, ...}:

let

system = "x86_64-linux"; # system = builtins.currentSystem;??

lib = nixpkgs.lib;
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
};                              # End of pkgs

pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

in
{

nixosConfigurations = {
  carthage =
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs pkgs-unstable system; };

modules = [

inputs.home-manager.nixosModules.home-manager {
  home-manager = {
    verbose = true;
    backupFileExtension = "home_backup"; # useful for clearance script
    users.malu = import ./modules/home/home.nix;
    useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
    useUserPackages = false; # if false ... uses nix-profile for home apps
    extraSpecialArgs = { inherit inputs pkgs pkgs-unstable system; };
  };
}

./hosts/carthage

];
}; # end of carthage config

tangier =
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs pkgs-unstable  system; };
    modules = [

      ./hosts/tangier

      # {environment.systemPackages = [neovimConf.neovim];} # standalone nvf

      inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          verbose = true;
          backupFileExtension = "bakup"; # conflict management,append .backup to existing conf. files
          users.malu = import ./modules/home/home.nix;
          useGlobalPkgs = true; # dont use private instance of pkgs which is the default
          useUserPackages = false; # if false:: ... uses nix-profile for home apps
          extraSpecialArgs = { inherit pkgs-unstable pkgs inputs system; };
        };
      }
    ];
  };

devShells.${system}.default = pkgs.mkShell {
    packages = [
        #inputs.python-nixpkgs.legacyPackages.${system}.python313
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
        pip
        ]))
    ];

    env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.libz
    ];
    # shellHook = ''
    #     if [ ! -d .venv ]; then
    #         python -m venv .venv
    #     fi
    #     source .venv/bin/activate
    # '';
    shellHook = ''
      echo "welcome to your dev env lul"
    '';
};

   }; # end of nixosConfigurations
  }; # end of let
}
