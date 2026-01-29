{pkgs, lib, config, ...}:
{

services.jupyter = {
  enable = true;
  extraPackages = with pkgs.python3.pkgs; [
    nbconvert
    nbformat
  ];
  group = "users";
  ip = "localhost";
  kernels = {
    python3 = let
      env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
              ipykernel
              pandas
              scikit-learn
            ]));
    in {
      displayName = "Python 3 for machine learning";
      argv = [
        "${env.interpreter}"
        "-m"
        "ipykernel_launcher"
        "-f"
        "{connection_file}"
      ];
      language = "python";
      # logo32 = "${env.sitePackages}/ipykernel/resources/logo-32x32.png";
      # logo64 = "${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      extraPaths = {
        "cool.txt" = pkgs.writeText "cool" "cool content";
      };
    };
  };
  notebookDir = "~/Development/school/2026/Machine Learning/Jupyter";
  password = "testtest";
  # port = 8888;
};

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  environment.systemPackages = with pkgs; [
    # zulip
    # zulip-term
  ];

}
