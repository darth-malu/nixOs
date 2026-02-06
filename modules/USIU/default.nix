{pkgs, lib, config, ...}:
{

services.jupyter = {
  enable = true;
  # command = "jupyter lab"; # "jupyter notebook"::
  extraPackages = with pkgs.python3.pkgs; [
    # nbconvert
    # nbformat
  ];
  group = "users";
  user = "malu";                # jupyter::
  # ip = "localhost";             # localhost::
  kernels = {
    python3 = let
      env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
              ipykernel
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
    notebookDir = "/home/malu/USIU/2026/[ APT3025B ]  Machine Learning - LeahMutanu-1320-T-T/Jupyter";
  password = "testtest";
  # port = 8888;
};

  environment.systemPackages = with pkgs; [
    # zulip
    # zulip-term
  ];

}
