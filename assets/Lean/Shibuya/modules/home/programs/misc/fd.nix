{
  enable = true;
  hidden = true;
  ignores = [
    ".git"
    "*.bak"
  ];
  extraOptions = [
    # extra options to pass to fd
    "--no-ignore"
    "--absolute-path"
  ];
}
