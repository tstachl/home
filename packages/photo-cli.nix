{ buildDotnetGlobalTool, lib, ... }:

buildDotnetGlobalTool {
  pname = "photo-cli";
  version = "0.3.3";

  nugetHash = "sha512-bSD5i6e6YoNafiQdOHpem+iTNYD6e41VxedpCCzPd+la+Wc1n0/cc6iI+u/puujhUitG48lcz8BJ0ESnCXSG8g==";

  meta = {
    homepage = "https://photocli.com/";
    changelog = "https://github.com/photo-cli/photo-cli/blob/main/CHANGELOG.md";
    license = lib.licenses.asl20;
  };
}
