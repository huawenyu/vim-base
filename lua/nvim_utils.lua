--- NVIM SPECIFIC SHORTCUTS
local vim = vim
local api = vim.api

VISUAL_MODE = {
	line = "line"; -- linewise
	block = "block"; -- characterwise
	char = "char"; -- blockwise-visual
}

function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

