local dap = require('dap')
require("dap-python").setup("python")
dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        cwd = '/';
        program = '${file}';
        name = 'Launch current file';
    },
    {
        type = 'python';
        request = 'launch';
        name = 'beet web';
        cwd = '/home/griff/git/beets/';
        program = 'venv/bin/beet';
        -- console = 'integratedTerminal';
        args = {
            'web'
        };
    },
    {
        type = 'python',
        request = 'launch',
        name = 'disbeet bot',
        cwd = '/home/griff/git/disbeet/',
        program = 'venv/bin/disbeet',
        args = {
            '-c', 'discord.json'
        }
    },
    {
        type = 'python',
        request = 'launch',
        name = 'beetman API',
        cwd = '/home/griff/git/beetman/src/api',
        program = '/home/griff/git/beetman/venv/bin/flask',
        args = {
            "--app", "routes", "run"
        }
    }
}

