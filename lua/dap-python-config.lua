local dap = require('dap')

root_dir = require('lspconfig.util').root_pattern(".git")(0)
if root_dir then
    python_env = root_dir .. "/venv/bin/python" 
    if vim.fn.executable(python_env) == 0 then
        vim.notify("venv not found. Falling back to global python. Run: python -m venv venv to use local python", vim.log.levels.WARN)
        python_env = "python"
    end
end

require("dap-python").setup(python_env)
dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = 'Debug Unit Tests';
        cwd = '${workspaceFolder}';
        program = '-m';
        args = function()
            local test_path = vim.fn.input('Test module/path: ', '', 'file')
            if test_path == '' then
                return {'unittest'}
            else
                return {'unittest', test_path}
            end
        end;
        console = 'integratedTerminal';
        justMyCode = false;
    },
    {
        type = 'python';
        request = 'launch';
        cwd = '/';
        program = '${file}';
        name = 'Launch current file';
    },
    {
        type = 'python';
        request = 'launch',
        cwd = '/',
        name = 'Launch with args',
        program = '${file}',
        args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
        end;
    },
    {
        type = 'python';
        request = 'launch';
        name = '[MAS CUT] Debug MAS CUT';
        cwd = '/home/grickle/git/mas-cut';
        program = 'venv/bin/mascut';
        -- console = 'integratedTerminal';
        args = {
            '/home/grickle/mas-cut-debug.xlsx', '--force', '--click-login', '--verbose'
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = '[MAS CUT] Debug MAS CUT - TRAINING';
        cwd = '/home/grickle/git/mas-cut';
        program = 'venv/bin/mascut';
        -- console = 'integratedTerminal';
        args = {
            '/home/grickle/mas-cut-debug.xlsx', '-p', 'training', '--force', '--click-login', '--verbose'
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = '[CONCOURSE] Debug Concourse Importer';
        cwd = '/home/grickle/git/excel_importer/';
        program = '/home/grickle/git/excel_importer/main.py';
    },
}

