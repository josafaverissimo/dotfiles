# env.nu
#
# Installed by:
# version = "0.104.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.edit_mode = 'vi'
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

zoxide init nushell | save -f ~/.zoxide.nu

let shims_dir = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)

$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

$env.ASDF_DATA_DIR = (
  if ( $env | get --optional ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  }
)

$env.ASDF_DATA_DIR_COMPLETIONS = ( $env.ASDF_DATA_DIR | path join "completions/nushell.nu" )

$env.VIRTUAL_ENV_DISABLE_PROMPT = true

$env.PAGER = 'less'
