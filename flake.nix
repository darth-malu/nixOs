{
  description = "Kenyan Tinkerer makes a flake -- 🫥";
  inputs = {

    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    yazi.url = "github:sxyazi/yazi";

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-qml = {
      url = "git+https://git.outfoxxed.me/outfoxxed/nix-qml-support";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager/release-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref={version}";

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

    hyprpaper = {
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

    # hyprland-easymotion = {
    #   url = "github:zakk4223/hyprland-easymotion";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Hyprspace = {
    #   url = "github:KZDKM/Hyprspace";

    #   # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
    #   inputs.hyprland.follows = "hyprland";
    # };

    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{nixpkgs, ...}: # Note the use of `self` which allows reusing flake's outputs in itself.

let
  system = "x86_64-linux"; # system = builtins.currentSystem;??

  config = {

    allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "aspell-dict-en-science"
      "discord"
      "evafast"
      "google-chrome"
      "rar"
      "spotify"
      "steam"
      "steam-unwrapped"
      "unrar"
      "ventoy"
      "xow_dongle-firmware"
      "youtube-upnext"
      # "android-studio-stable"
      # "bluemail"
      # "stremio-server"
      # "stremio-shell"
      # "unigine-heaven"
      # "warp-terminal"
      # "windows10-icons"
      # "wpsoffice"
    ];

    permittedInsecurePackages = [
      "ventoy-1.1.07"
      "libsoup-2.74.3"
      "libxml2-2.13.8" # for cisco?
      "qtwebengine-5.15.19"     # TODO check dependency
    ];

};
 home = inputs.home-manager;

 # pkgs = nixpkgs-unstable.legacyPackages.${system};#FIXME better way to do this...+ inherit config
 pkgs = import nixpkgs {
   inherit  system;
   inherit config;
 };

in
{
  # This will make the package available as a flake output under 'packages'
  # packages.${system}.my-neovim = customNeovim.neovim;

nixosConfigurations = {
  carthage = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs system; };

modules = [
  ./hosts/carthage
  # {environment.systemPackages = [neovimConf.neovim];}

  home.nixosModules.home-manager {
    home-manager = {
      verbose = true;
      backupFileExtension = "home_bak";
      useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
      useUserPackages = false; # if false ... uses nix-profile for home apps
      extraSpecialArgs = { inherit inputs pkgs system; };
      users.malu = import ./modules/home/home.nix;
    };
  }

];  # modules
 };  # carthage

tangier = nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs system; };
  modules = [
    ./hosts/tangier
    # inputs.quickshell.packages.${system}.default
    # {environment.systemPackages = [neovimConf.neovim];} # standalone nvf
    # inputs.nvf.nixosModules.default 
    home.nixosModules.home-manager {
      home-manager = {
        verbose = true;
        backupFileExtension = "home_backup";
        users.malu = import ./modules/home/home.nix;
        useGlobalPkgs = true; # dont use private instance of pkgs which is the default
        useUserPackages = false; # if false:: ... uses nix-profile for home apps
        extraSpecialArgs = { inherit pkgs inputs system; };
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
