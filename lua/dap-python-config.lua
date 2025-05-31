local uv = vim.loop

local function find_env_file_down(dir)
  local env_file = nil

  local function scan(path)
    local handle = uv.fs_scandir(path)
    if not handle then return end

    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then break end

      local full_path = path .. "/" .. name
      if name == ".env" then
        env_file = full_path
        return true -- stop after first match
      elseif type == "directory" then
        if scan(full_path) then
          return true
        end
      end
    end
  end

  scan(dir)
  return env_file
end

local function load_env_file_down(start_dir)
  local env = {}
  local env_path = find_env_file_down(start_dir)
  if not env_path then return env end

  for line in io.lines(env_path) do
    local key, val = string.match(line, "([^=]+)=['\"]?([^'\"]+)['\"]?")
    if key and val then
      env[key] = val
    end
  end

  return env
end

-- Example usage:
local env_vars = load_env_file_down(vim.fn.getcwd())

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
        name = 'Beetman API (dev)',
        program = '/home/griff/git/beetman/src/api/beetman.py',
        args = {
            "/home/griff/git/beetman/src/api/config.json"
        },
        cwd = '/home/griff/git/beetman/src/api',
        pythonPath = '/home/griff/git/beetman/venv/bin/python',
        env = vim.tbl_extend("force", env_vars, {
            PYTHONPATH = "/home/griff/git/beetman/src",
            FLASK_ENV = "development"
        }),
        justMyCode = false,
    },
    {
        type = 'python',
        request = 'launch',
        name = 'jawnt',
        cwd = '/home/griff/git/jawnt/',
        program = 'venv/bin/flask',
        args = { "--app", "backend.api.app", "run" }
    }
}

