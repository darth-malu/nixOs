pkgs.mkShell = {
    packages = [
    (pkgs.python3.withPackages(p: with p[
        pandas
        requests
    ]))
    ];
}
