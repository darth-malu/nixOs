{
  imports = [
    ./sections.nix
    ./setupOpts.nix
  ];

  vim.statusline.lualine = {
    enable = true;
    alwaysDivideMiddle = false; #TODO: what this do exactly
    disabledFiletypes = [
      # "Starter"
    ];
    ignoreFocus = [
      "telescope"
      "[NO NAME]"
    ];
  };
}
