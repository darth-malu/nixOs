{
  vim.telescope = {
    enable = true;
    #setupOpts.defaults.initial_mode = "insert"; #insert  , normal
    setupOpts = {
      case_mode = "ignore_case";
    };
    mappings = {
      buffers = "<leader><leader>";
      diagnostics = "<leader>fld";
      findFiles = "<leader>ff";
      helpTags = "<leader>hh";
      lspDefinitions = "<leader>gd";
      lspImplementations = "<leader>gi";
      lspReferences = "<leader>gr";
      lspTypeDefinitions = "<leader>flt";
      lspWorkspaceSymbols = "<leader>ws";
      lspDocumentSymbols = "<leader>ds";

      #"<leader>cm" = "todo-comments";
      #"<leader>Z" = "grep_string";
      #"<leader>z" = "current_buffer_fuzzy_find";
    };
  };
}
