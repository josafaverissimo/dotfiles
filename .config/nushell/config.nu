# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ~/.zoxide.nu

source "~/.asdf/completions/nushell.nu"

def hyprlog [] {
  ls ($env.XDG_RUNTIME_DIR | path join "hypr")
  | sort-by modified
  | reverse
  | first
  | get name
  | path join "hyprland.log"
  | open
}

def glg [path: string = "."] {
  git log --pretty=%h»¦«%aN»¦«%s»¦«%aD $path
    | lines
    | split column "»¦«" sha1 committer desc merged_at
}

def glgc [path: string = "."] {
  git log --pretty=%h»¦«%aN»¦«%s»¦«%aD $path
    | lines 
    | split column "»¦«" sha1 committer desc merged_at 
    | histogram committer merger 
    | sort-by merger 
    | reverse
}

alias vrun = overlay use .venv/bin/activate.nu

def jrun [file: string] {
  let  filename = ($file | path basename)
  let classname = ($filename | str replace ".java" "")

  javac $file

  if $env.LAST_EXIT_CODE != 0 {
    null
  }

  java $classname
}
