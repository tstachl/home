{ writeShellScriptBin, lib, tmux, aerospace }:

let
  aerospaceBin = "${lib.getExe aerospace}";
  tmuxBin = "${lib.getExe tmux}";
in

writeShellScriptBin "tmux-aerospace-focus" ''
  direction="$1"

  if [[ -n "$(${aerospaceBin} list-windows --focused | grep tmux)" ]]; then
    tmux_dir=""

    case "$direction" in
      left) tmux_dir="L" ;;
      down) tmux_dir="D" ;;
      up) tmux_dir="U" ;;
      right) tmux_dir="R" ;;
    esac

    if [[ -n "$tmux_dir" ]]; then
      ret=$(${tmuxBin} run "#{at_edge} $tmux_dir")

      if [[ $ret -eq 1 ]]; then
        ${aerospaceBin} focus "$direction"
      else
        ${tmuxBin} select-pane "-$tmux_dir"
      fi
    fi
  fi

  ${aerospaceBin} focus "$direction"
''
