require("telescope").setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules/.*",
            "venv/.*",
            ".venv/.*",
            "env/.*",
            ".env/.*",
            ".git/.*",
            "%.o",
            "%.a",
            "%.out",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip",
            "__pycache__/.*",
            "%.pyc",
            "%.pyi",
        },
        preview = {
            filesize_limit = 1
        }
    }
}
