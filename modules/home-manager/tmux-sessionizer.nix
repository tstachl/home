{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.tmux.sessionizer;

  # Generate the configuration file content
  configContent = ''
    # tmux-sessionizer configuration
    ${optionalString (cfg.searchPaths != []) ''
    TS_SEARCH_PATHS=(${concatStringsSep " " cfg.searchPaths})
    ''}

    ${optionalString (cfg.extraSearchPaths != []) ''
    TS_EXTRA_SEARCH_PATHS=(${concatStringsSep " " (map (entry: 
      if entry.depth != null 
      then ''"${entry.path}:${toString entry.depth}"''
      else ''"${entry.path}"''
    ) cfg.extraSearchPaths)})
    ''}

    ${optionalString (cfg.maxDepth != null) ''
    TS_MAX_DEPTH=${toString cfg.maxDepth}
    ''}

    ${optionalString (cfg.sessionCommands != []) ''
    TS_SESSION_COMMANDS=(${concatStringsSep " " (map (cmd: ''"${cmd}"'') cfg.sessionCommands)})
    ''}

    ${optionalString cfg.logging.enable ''
    TS_LOG="${cfg.logging.type}"
    ${optionalString (cfg.logging.file != null) ''
    TS_LOG_FILE="${cfg.logging.file}"
    ''}
    ''}

    ${cfg.extraConfig}
  '';

in
{
  options.programs.tmux.sessionizer = {
    enable = mkEnableOption "tmux-sessionizer integration";

    package = mkOption {
      type = types.package;
      default = pkgs.tmux-sessionizer;
      description = "The tmux-sessionizer package to use.";
    };

    searchPaths = mkOption {
      type = types.listOf types.str;
      default = [ "~/" "~/personal" "~/personal/dev/env/.config" ];
      description = ''
        List of paths to search for directories. These override the default search paths.
      '';
      example = [ "~/" "~/projects" "~/work" ];
    };

    extraSearchPaths = mkOption {
      type = types.listOf (types.submodule {
        options = {
          path = mkOption {
            type = types.str;
            description = "Path to search in addition to the main search paths.";
          };
          depth = mkOption {
            type = types.nullOr types.ints.positive;
            default = null;
            description = "Maximum depth to search in this path.";
          };
        };
      });
      default = [ ];
      description = ''
        Additional search paths with optional depth specification.
      '';
      example = [
        { path = "~/ghq"; depth = 3; }
        { path = "~/Git"; depth = 3; }
        { path = "~/.config"; depth = 2; }
      ];
    };

    maxDepth = mkOption {
      type = types.nullOr types.ints.positive;
      default = null;
      description = ''
        Maximum depth for directory searches. Overrides the default depth of 1.
      '';
      example = 2;
    };

    sessionCommands = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of commands that can be executed in tmux sessions using the -s flag.
        These commands run in windows with indices starting from 69.
      '';
      example = [ "nvim" "git status" "npm run dev" ];
    };

    logging = {
      enable = mkEnableOption "logging for tmux-sessionizer";

      type = mkOption {
        type = types.enum [ "echo" "file" "true" ];
        default = "file";
        description = ''
          Type of logging to use:
          - "echo": Print logs to stdout
          - "file": Write logs to a file
          - "true": Enable logging (same as "file")
        '';
      };

      file = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Custom log file path. If not specified, defaults to 
          ~/.local/share/tmux-sessionizer/tmux-sessionizer.logs
        '';
        example = "~/.cache/tmux-sessionizer.log";
      };
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Extra configuration to add to the tmux-sessionizer config file.
      '';
      example = ''
        # Custom configuration
        export CUSTOM_VAR="value"
      '';
    };

    keyBinding = mkOption {
      type = types.nullOr types.str;
      default = "f";
      description = ''
        Key binding to launch tmux-sessionizer. Set to null to disable.
      '';
      example = "f";
    };
  };

  config = mkIf (config.programs.tmux.enable && cfg.enable) {
    # Add the package to home packages
    home.packages = [ cfg.package ];

    # Create the configuration file
    xdg.configFile."tmux-sessionizer/tmux-sessionizer.conf" = mkIf (configContent != "") {
      text = configContent;
    };

    # Add key binding to tmux configuration
    programs.tmux.extraConfig = mkIf (cfg.keyBinding != null) ''
      # tmux-sessionizer key binding
      bind-key -r ${cfg.keyBinding} run-shell "tmux neww ${lib.getExe cfg.package}"
    '';
  };
}
