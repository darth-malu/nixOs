{ fetchFromGitHub, tree-sitter }: tree-sitter.buildGrammar {
  language = "tree-sitter-qmljs";
  version = "master";
  src = fetchFromGitHub {
    owner = "yuja";
    repo = "tree-sitter-qmljs";
    rev = "6d4db242185721e1f5ef21fde613ca90c743ec47";
    sha256 = "S6rBQRecJvPgyWq1iydFZgDyXbm9CZBw8kxzNI0cqdw=";
  };
}
