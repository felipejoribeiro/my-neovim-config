function CHECK_FLAKE8()
  local root_dir = vim.fs.dirname(
    vim.fs.find(
      { '.git', 'README.md', 'requirements.txt', '.python-version', 'Makefile', 'manage.py' },
      { upward = true }
    )[1]
  )
  if not root_dir then
    return false
  end

  local has_dot_flake8_file = vim.fn.filereadable(vim.fs.joinpath(root_dir, '.flake8')) == 1

  if has_dot_flake8_file then
    return true
  end
  return false
end

function CHECK_DJANGO()
  local root_dir = vim.fs.dirname(
    vim.fs.find(
      { '.git', 'README.md', 'requirements.txt', '.python-version', 'Makefile', 'manage.py' },
      { upward = true }
    )[1]
  )
  if not root_dir then
    return false
  end

  local has_manage_py = vim.fn.filereadable(vim.fs.joinpath(root_dir, 'manage.py')) == 1
  if has_manage_py then
    return true
  end
  return false
end

function CHECK_RUFF()
  local root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'README.md' }, { upward = true })[1])
  if not root_dir then
    return false
  end
  local has_pyproject_toml = vim.fn.filereadable(vim.fs.joinpath(root_dir, 'pyproject.toml')) == 1
  if has_pyproject_toml then
    local pyproject_toml = vim.fn.readfile(vim.fs.joinpath(root_dir, 'pyproject.toml'))
    for _, line in ipairs(pyproject_toml) do
      if line:match('^%s*%[tool%.ruff') then
        return true
      end
    end
  end
  return false
end
