with import <nixpkgs> {};
let
  erlang = pkgs.beam_nox.interpreters.erlangR24;
  otpPackages = pkgs.beam.packagesWith erlang;
  elixir = otpPackages.elixir_1_12;
  pcre2 = pkgs.pcre2;
in
pkgs.mkShell {
  buildInputs = [
    elixir
    pcre2
  ];
}