vim.api.nvim_create_autocmd("FileType", {
    pattern = "php",
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<F5>",
            ":w<CR>:split<CR>:te time /usr/local/bin/php %<CR>i",
            { silent = true, noremap = true }
        )
    end,
})
