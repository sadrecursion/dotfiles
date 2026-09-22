local function switch_complete(arglead, cmdline, cursorpos)
    local current = vim.api.nvim_buf_get_name(0)
    if current == "" then return {} end

    local dir = vim.fn.fnamemodify(current, ":h")
    local base = vim.fn.fnamemodify(current, ":t:r")
    local ext = vim.fn.fnamemodify(current, ":e")

    local headers = { "h", "hpp", "hh" }
    local sources  = { "c", "cc", "cpp", "cxx" }

    local results = {}

    local function add(pattern)
        local matches = vim.fn.glob(dir .. "/" .. pattern, false, true)
        for _, f in ipairs(matches) do
            table.insert(results, vim.fn.fnamemodify(f, ":."))
        end
    end

    if vim.tbl_contains(headers, ext) then
        for _, e in ipairs(sources) do
            add(base .. "." .. e)
        end
    else
        for _, e in ipairs(headers) do
            add(base .. "." .. e)
        end
    end

    -- dedupe
    local seen, uniq = {}, {}
    for _, f in ipairs(results) do
        if not seen[f] then
            seen[f] = true
            table.insert(uniq, f)
        end
    end

    if arglead ~= "" then
        uniq = vim.tbl_filter(function(p)
            return p:find(arglead, 1, true)
        end, uniq)
    end

    return uniq
end

vim.api.nvim_create_user_command("Switch", function(opts)
    local current = vim.api.nvim_buf_get_name(0)
    if current == "" then return end

    local dir = vim.fn.fnamemodify(current, ":h")
    local base = vim.fn.fnamemodify(current, ":t:r")
    local ext = vim.fn.fnamemodify(current, ":e")

    local headers = { "h", "hpp", "hh" }
    local sources  = { "c", "cc", "cpp", "cxx" }

    local results = {}

    local function add(pattern)
        local matches = vim.fn.glob(dir .. "/" .. pattern, false, true)
        for _, f in ipairs(matches) do
            table.insert(results, vim.fn.fnamemodify(f, ":."))
        end
    end

    if vim.tbl_contains(headers, ext) then
        for _, e in ipairs(sources) do
            add(base .. "." .. e)
        end
    else
        for _, e in ipairs(headers) do
            add(base .. "." .. e)
        end
    end

    -- dedupe
    local seen, uniq = {}, {}
    for _, f in ipairs(results) do
        if not seen[f] then
            seen[f] = true
            table.insert(uniq, f)
        end
    end

    -- FILTRO por input manual del comando
    if opts.args ~= "" then
        uniq = vim.tbl_filter(function(p)
            return p:find(opts.args, 1, true)
        end, uniq)
    end

    -- AUTO-SWITCH SOLO AQUÍ
    if #uniq == 1 then
        vim.cmd("edit " .. vim.fn.fnameescape(uniq[1]))
        return
    end

    -- fallback: dejar que el completion muestre opciones
    -- (si quieres, podrías aquí imprimir lista o error)
end, {
    nargs = "?",
    complete = switch_complete,
})
