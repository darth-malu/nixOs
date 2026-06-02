{ fetchFromGitHub, trivialBuild }: trivialBuild {
  pname = "qml-ts-mode";
  version = "master";
  src = fetchFromGitHub {
    owner = "xhcoding";
    repo = "qml-ts-mode";
    rev = "22e5b4ee2036d01878e463b5e4cce80957c96619";
    sha256 = "Mx3kwDx7sVwF9uQ5vOIXnfPkuOkuq3VN2KhkC/dod+4=";
  };
}
