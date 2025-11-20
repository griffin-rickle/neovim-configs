-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/home/grickle/git/workspaces/' .. project_name
local home = os.getenv("HOME")
-- local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local jdtls_path = home .. "/bin/jdt/"

-- find the launcher jar (should be one matching that pattern)
local function find_launcher_jar()
  local scan = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  if scan == "" then
    error("Could not find launcher jar in " .. jdtls_path .. "/plugins")
  end
  return scan
end

local launcher_jar = find_launcher_jar()

local java_debug_bundle = vim.fn.glob(
  "/home/grickle/git/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
)

local bundles = {}

if java_debug_bundle ~= "" then
    table.insert(bundles, java_debug_bundle)
end

local config = {
    -- cmd = { "/home/grickle/bin/jdt/bin/jdtls",
    -- cmd = { home .. "/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
    cmd = {
        '/usr/lib/jvm/java-21-openjdk-21.0.8.0.9-1.el8.x86_64/bin/java',
    --     '/usr/lib/jvm/java-17-openjdk-17.0.14.0.7-3.el8.x86_64/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher_jar,
        "-configuration", home .. "/bin/jdt/config_linux",
        -- "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        -- '-jar', '/home/grickle/git/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/products/languageServer.product/linux/gtk/x86_64/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    --     '-configuration', '/home/grickle/git/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',
        '-data', workspace_dir
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        bundles = bundles
    },
    -- settings = {
    --     java = {
    --         configuration = {
    --             runtimes = {
    --                 {
    --                     name = "JavaSE-17",
    --                     path = "/usr/lib/jvm/java-17-openjdk-17.0.15.0.6-2.el8.x86_64/"
    --                 }
    --             }
    --         }
    --     }
    -- }
}
require('jdtls').start_or_attach(config)
