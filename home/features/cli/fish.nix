{ lib, pkgs, ... }:
{
  programs.fish.enable = true;
  programs.fish.shellAliases = {
    cd = "z";
    grep = "rg";
  };

  xdg.configFile."fish/conf.d/kanagawa.fish".text =
    lib.strings.fileContents (pkgs.fetchFromGitHub
      {
        owner = "rebelot";
        repo = "kanagawa.nvim";
        rev = "83e377c";
        sha256 = "sha256-IBZFfQRNvIEIFiQF5Gm4LGTmRc2VCWy4Gx51RhtDNDM=";
      } + "/extras/fish/kanagawa.fish");
}
