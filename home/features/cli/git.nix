{ pkgs, ... }: {

  home.packages = with pkgs; [ git-crypt ];

  programs.git = {
    enable = true;
    userName = "Thomas Stachl";
    userEmail = "i@t5.st";

    includes = [
      {
        condition = "gitdir/i:~/workspace/aesir/**";
        contents = {
          core.sshCommand = "ssh -i ~/.ssh/id_aesirdev";
          user = {
            email = "dev@aesirdev.com";
            name = "Æsir Dev";
            signingKey = "58145313C9636027";
          };
          commit.gpgSign = true;
        };
      }
    ];

    signing = {
      key = "ED5EAAA8E895B23A";
      signByDefault = true;
      signer = "${pkgs.gnupg}/bin/gpg";
    };

    extraConfig = {
      color = {
        grep = "always";
        pager = "true";
        showbranch = "auto";
        ui = "always";

        interactive = {
          error = "red bold";
        };

        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        diff = {
          meta = "yellow";
          frag = "magenta";
          old = "red";
          new = "green";
          whitespace = "white reverse";
        };

        status = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
          branch = "magenta";
        };
      };

      init.defaultBranch = "master";

      url = {
        "git@github.com:" = {
          insteadOf = "github:";
        };
        "git@codeberg.org:" = {
          insteadOf = "codeberg:";
        };
      };

      branch = {
        master = {
          remote = "origin";
          merge = "refs/head/master";
        };
      };
    };
  };
}
