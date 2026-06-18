-- Cache project root per-buffer; recompute only when the buffer's *directory* changes.

local root_markers = {
    ".git", "pyproject.toml", "package.json", "go.mod",
    "Makefile", "composer.lock",
}

local function apply_root(root)
  vim.cmd.lcd(root)   -- window-local (swap to :tcd / :cd if you prefer)
end

local function dirname(path)
  -- :h vim.fs.dirname (Neovim 0.10). For 0.9 use :h fnamemodify below.
  if vim.fs and vim.fs.dirname then
    return vim.fs.dirname(path)
  end
  return vim.fn.fnamemodify(path, ":p:h")
end

local function compute_root_for_buf(buf)
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then return nil end
  return vim.fs.root(file, root_markers)
end

local function set_root_cached(buf, opts)
  opts = opts or {}
  local force = opts.force or false

  local cached = vim.b[buf].project_root
  if not force and cached ~= nil then
    if cached ~= false then
      apply_root(cached)
    end
    return
  end

  local root = compute_root_for_buf(buf)
  vim.b[buf].project_root = root or false
  vim.b[buf].project_dir  = dirname(vim.api.nvim_buf_get_name(buf)) or false

  if root then
    apply_root(root)
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    set_root_cached(args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufFilePost", {
  callback = function(args)
    local buf = args.buf
    local file = vim.api.nvim_buf_get_name(buf)
    if file == "" then return end

    local new_dir = dirname(file)
    local old_dir = vim.b[buf].project_dir

    -- Only reset/recompute if the buffer's directory actually changed
    if old_dir ~= nil and old_dir == new_dir then
      return
    end

    vim.b[buf].project_root = nil
    vim.b[buf].project_dir  = new_dir
    set_root_cached(buf, { force = true })
  end,
})

