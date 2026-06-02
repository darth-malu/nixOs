{
  programs.nixvim.autoCmd = [
    {
    event = [ "TextYankPost" ];
    pattern = "*"; #every file
    callback.__raw = ''function ()
        --vim.highlight.on_yank { higroup = "IncSearch", timeout = 250}
        vim.highlight.on_yank { higroup = "Comment", timeout = 250}
      end'';
    }
    #----
    #{
      ##command = "echo 'Days without ricing: 0'";
      #event = [
        #"FileType"
      #];
      #callback = {
        #__raw = ''function ()
          #local data = {
            #buf = vim.fn.expand("<abuf>"),
            #file = vim.fn.expand("<afile>"),
            #match = vim.fn.expand("<amatch>"),
          #}
          #vim.schedule(function()
            #print('Filetype cmd called lul')
            #print(vim.inspect(data))
          #end)
        #end'';
      #};
      #pattern = "nix"; #lua table to list
    #}
    #----
  ];
}
