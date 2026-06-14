{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # DEVELOPER 🛠️
    typescript-language-server
    typescript
    tailwindcss_4
    rustywind
    tailwindcss-language-server # for use with lsp-tailwind (emacs)
    ed
    # eas-cli
    # cling
    # firebase-tools
    manim # FIXME failed
    # nasm
    qtcreator
    # beekeeper-studio
    patchelf
    socat
    zlib
    libxml2

    # LUA
    lua54Packages.lua
    lua54Packages.luarepl

    # JavaScript
    nodejs
    # nodejs_25 # consider npm for auto install of servers in lsp-mode
    # nodejs-slim_latest # consider npm for auto install of servers in lsp-mode
    # deno
  ];
}
