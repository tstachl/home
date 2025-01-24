{
  programs.ssh = {
    enable = true;
    compression = true;
    forwardAgent = true;

    matchBlocks = {
      modgud = {
        hostname = "modgud.t5.st";
        user = "thomas";
      };

      "github.com".user = "git";
      github.hostname = "github.com";
    };
  };
}
