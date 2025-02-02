{pkgs,...}:

{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = true; # install missing parsers when entering buffer
      ensure_installed = ["lua" "nix" "python" "bash" "css" "jsonc" "regex" "markdown" "toml" "json"];#"all";
      #ensure_installed = "all";
      folding = false;#TODO: ?
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        markdown
        nix
        regex
        toml
        yaml
      ];
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = true;
        custom_captures = { };
        disable = [
          # "rust"
        ];
      };
      #ignore_install = [
        #"rust"
      #];
      #incremental_selection = {
        #enable = true;
        #keymaps = {
          #init_selection = false;
          #node_decremental = "grm";
          #node_incremental = "grn";
          #scope_incremental = "grc";
        #};
      #};
      indent = {
        enable = true;
      };
      #parser_install_dir = {
        #__raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
      #};
      #sync_install = false;
      };
  };
}
