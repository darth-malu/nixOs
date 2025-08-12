{
  description = "Kenyan Tinkerer makes a flake -- 🫥";
  inputs = {

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # hyprsunset = { # TODO: test if needed
    #   url = "github:hyprwm/hyprsunset";
    #   inputs = {
    #     hyprgraphics.follows = "hyprland/hyprgraphics";
    #     hyprlang.follows = "hyprland/hyprlang";
    #     hyprutils.follows = "hyprland/hyprutils";
    #     nixpkgs.follows = "hyprland/nixpkgs";
    #     systems.follows = "hyprland/systems";
    #   };
    # };

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

  outputs = inputs@{nixpkgs, nixpkgs-unstable, ...}: # Note the use of `self` which allows reusing flake's outputs in itself.

  let
    system = "x86_64-linux"; # system = builtins.currentSystem;??

    # neovimConf = inputs.nvf.lib.neovimConfiguration {
    #     inherit (nixpkgs.legacyPackages.${system}) pkgs;
    #     modules = [ ./modules/nvf];
    # };

    config = {
      allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
        "discord"
        "google-chrome"
        "bluemail"
        "ventoy"
        "spotify"
        "steam"
        "steam-unwrapped"
        "wpsoffice"
        "xow_dongle-firmware"
        "warp-terminal"
        "windows10-icons"
        "aspell-dict-en-science"
        "davinci-resolve"
        "youtube-upnext"
        "evafast"
        "android-studio-stable"
      ];
      permittedInsecurePackages = [
        "ventoy-1.1.05"
        "libsoup-2.74.3"
      ];
    };
    # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};#FIXME better way to do this...+ inherit config
    pkgs-unstable = import nixpkgs-unstable {
      inherit  system;
      inherit config;
    };
    home = inputs.home-manager;
    home-unstable = inputs.home-manager-unstable;
    pkgs = import nixpkgs {
      inherit  system;
      inherit config;
    };
  in
  {
    # packages.${system}.my-neovim = neovimConf.neovim; # NVF

nixosConfigurations = {
  # carthage = nixpkgs-unstable.lib.nixosSystem {
  carthage = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit pkgs-unstable inputs system; };

modules = [
  ./hosts/carthage
  # {environment.systemPackages = [neovimConf.neovim];}

  home.nixosModules.home-manager {
  # home-unstable.nixosModules.home-manager {
    home-manager = {
      verbose = true;
      backupFileExtension = "home_bak";
      useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
      useUserPackages = false; # if false ... uses nix-profile for home apps
      extraSpecialArgs = { inherit pkgs pkgs-unstable inputs system; };
      users.malu = import ./modules/home/home.nix;
    };
  }

];  # modules
 };  # carthage

tangier = nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit pkgs-unstable inputs system; };
  modules = [
    ./hosts/tangier
    # inputs.quickshell.packages.${system}.default
    # {environment.systemPackages = [neovimConf.neovim];} # standalone nvf
    home.nixosModules.home-manager {
      home-manager = {
        verbose = true;
        backupFileExtension = "home_backup";
        users.malu = import ./modules/home/home.nix;
        useGlobalPkgs = true; # dont use private instance of pkgs which is the default
        useUserPackages = false; # if false:: ... uses nix-profile for home apps
        extraSpecialArgs = { inherit pkgs pkgs-unstable inputs system; };
      };
    }
  ];
};

}; #End of NixConfigurations

  devShells.${system}.default = pkgs.mkShell {
    buildInputs = with pkgs; [
      # numpy
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
          # pip
          # numpy
          adblock
        ]))
    ];

    shellHook = ''
      echo "$USER:: welcome to your dev env lul 🧊"
    '';

    # packages = [
        #inputs.python-nixpkgs.legacyPackages.${system}.python313
    #     (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
    #     pip
    #     ]))
    # ];
    # env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    #   pkgs.stdenv.cc.cc.lib
    #   pkgs.libz
    # ];
    # shellHook = ''
    #     if [ ! -d .venv ]; then
    #         python -m venv .venv
    #     fi
    #     source .venv/bin/activate
    # '';
  };

  };   # end of outputs
}    # EOF
