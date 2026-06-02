{
  programs.nixvim.plugins = {
    nvim-ufo = {
      enable = false;
      enableGetFoldVirtText = false; #null , bool or raw_lua
    };
  };
}

#https://nix-community.github.io/nixvim/stable/plugins/alpha/layout.html
