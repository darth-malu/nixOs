{
  programs.less = {
    enable = true;
    envVariables = {
      LESS = "-R --use-color -Dd+r -Du+b";
    };
  };
}
