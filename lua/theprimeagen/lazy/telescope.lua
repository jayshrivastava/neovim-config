return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                    -- Make Telescope bigger by default (relative to the editor size).
                    width = 0.95,
                    height = 0.95,
                    horizontal = {
                        preview_width = 0.60,
                    },
                },
                dynamic_preview_title = true,
                results_title = "Results",
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', function() 
            builtin.find_files({ cwd = vim.fn.getcwd() }) -- Search from current working directory
        end)
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            local q = vim.fn.input("Grep > ")
            if q == nil or q == "" then
                return
            end
            builtin.grep_string({ search = q })
        end)
        vim.keymap.set('n', '<leader>pd', function()
            local current_file_dir = vim.fn.expand("%:p:h")
            local dir = vim.fn.input("Directory: ", current_file_dir .. "/", "dir")
            if dir == nil or dir == "" then
                return
            end
            builtin.live_grep({
                search_dirs = { dir }
            })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>pr', builtin.resume, {}) -- Resume last telescope search

        vim.keymap.set('n', 'gr', builtin.lsp_references, {})
    end
}

