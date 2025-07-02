return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local home = os.getenv("HOME")
    local jdtls = require("jdtls")
    local jdtls_base_path = home .. "/.local/share/astronvim/mason/packages/jdtls"
    local jdtls_bin = jdtls_base_path .. "/bin/jdtls"
    local jdtls_launcher = jdtls_base_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
    local jdtls_lombok = jdtls_base_path .. "/lombok.jar"
    local jdtls_config = jdtls_base_path .. "/config_linux"
    local root_markers = {"gradlew", "mvnw", ".git"}
    local root_dir = vim.fs.root(0, root_markers)
    local workspace_folder = jdtls_base_path .. "/workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    local config = {
      cmd = {
        jdtls_bin,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. jdtls_lombok,
        "-jar",
        vim.fn.glob(jdtls_launcher),
        "-configuration",
        jdtls_config,
        "-data", workspace_folder,
      },
      root_dir = root_dir,
      settings = {
        java = {
          project = {
            sourcePaths = { "." },
          },
          signatureHelp = { enabled = true },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-24",
                path = home .. "/.asdf/installs/java/openjdk-24",
              },
              {
                name = "JavaSE-21",
                path = home .. "/.asdf/installs/java/openjdk-21",
              },
              {
                name = "JavaSE-17",
                path = home .. "/.asdf/installs/java/openjdk-17"
              },
            }
          }
        },
      },
    }

    jdtls.start_or_attach(config)
  end,
}
