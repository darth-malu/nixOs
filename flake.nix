{
  description = "Kenyan Tinkerer makes a flake -- 🫥";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    nix-qml.url = "git+https://git.outfoxxed.me/outfoxxed/nix-qml-support";
    nix-qml.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim"; # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`

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

    # hyprland-plugins = {
    #     url = "github:hyprwm/hyprland-plugins";
    #     inputs.hyprland.follows = "hyprland";
    # };

    # hyprland-easymotion = {
    #   url = "github:zakk4223/hyprland-easymotion";
    #   inputs.hyprland.follows = "hyprland";
    # };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vermilion = {
      url = "github:vaxerski/Vermilion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{
      # nixpkgs-stable,
      nixpkgs,
      disko,
      ...
    }: # Note the use of `self` which allows reusing flake's outputs in itself.

    let
      system = "x86_64-linux"; # TODO system = builtins.currentSystem;?? find reason it doesn't work

      config = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (nixpkgs.lib.getName pkg) [
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
            "youtube-upnext"
            "davinci-resolve"
            "wpsoffice"
            "bluemail"
            "discord"
            "stremio-linux-shell"
            "antigravity-cli"
            "windows10-icons"
          ];
        permittedInsecurePackages = [
          "ventoy-1.1.12"
          "libsoup-2.74.3"
          "libxml2-2.13.8" # for cisco?
          "qtwebengine-5.15.19"
          "beekeeper-studio-5.5.3"
        ];
      };

      home = inputs.home-manager;

      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        inherit config;
      };
      # pkgs-stable = import nixpkgs-stable {
      #   inherit system;
      #   inherit config;
      # };
      unifiedModules = [
        disko.nixosModules.disko
        ./hosts/common/disko-BTRFS-LUKS.nix
        home.nixosModules.home-manager
        {
          home-manager = {
            verbose = true;
            backupFileExtension = "home_bak";
            useGlobalPkgs = true; # if true dont use private instance of pkgs which is the default
            useUserPackages = true; # if false ... uses nix-profile for home apps
            extraSpecialArgs = { inherit inputs pkgs system; };
            users.malu = import ./modules/home/home.nix;
          };
        }
      ];

    in
    {
      nixosConfigurations.carthage = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/carthage
        ]
        ++ unifiedModules;
      };
      nixosConfigurations.tangier = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs system; };
        modules = [
          ./hosts/tangier
          # nixvim.homeModules.nixvim
        ]
        ++ unifiedModules;
      };
    };
}
