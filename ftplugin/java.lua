-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/home/griff/git/' .. project_name

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', '/home/griff/git/eclipse.jdt.ls-1.40.0/org.eclipse.jdt.ls.product/target/products/languageServer.product/linux/gtk/x86_64/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
        '-configuration', '/home/griff/git/eclipse.jdt.ls-1.40.0/org.eclipse.jdt.ls.product/target/repository/config_linux',
        '-data', workspace_dir
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        bundles = {
            vim.fn.glob("/home/griff/git/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
        }
    }
    -- runtimes = {
    --     {
    --         name = "Java17 OpenJDK",
    --         path= = "/usr/lib/jvm/java-17-openjdk-17.0.12.0.7-2.el8.x86_64/"
    --     }
    -- }
}
require('jdtls').start_or_attach(config)
