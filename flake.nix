{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.hello = nixpkgs.legacyPackages.${system}.hello;
        defaultPackage = self.packages.${system}.hello;
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.clojure pkgs.leiningen ];
        };
      });
}
