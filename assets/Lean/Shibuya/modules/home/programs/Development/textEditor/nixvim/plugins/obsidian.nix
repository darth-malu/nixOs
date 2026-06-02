{
  programs.nixvim.plugins = {
    obsidian = {
      enable = false;
      settings = {
        completion = {
          min_chars = 2;
          nvim_cmp = true;
        };
        new_notes_location = "current_dir";
        workspaces = [
          {
            name = "work";
            path = "~/obsidian/work";
          }
          {
            name = "startup";
            path = "~/obsidian/startup";
          }
        ];
      };
    }; # end of obsidian
    }; # programs.plugins
}
