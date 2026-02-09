vim.filetype.add({
  extension = {
    -- Turtle
    ttl = 'turtle',

    -- TriG
    trig = 'trig',

    -- SPARQL (you already have this, but including for completeness)
    sq = 'sparql',
    rq = 'sparql',
    sparql = 'sparql',

    -- SMS (Stardog Mapping Syntax)
    sms = 'sms',

    -- SRS (Stardog Rules Syntax)
    srs = 'srs',

    -- SHACL (often uses .ttl or .shacl)
    shacl = 'shacl',
  },

  filename = {
    ['.shacl'] = 'shacl',
  }
})

-- Set comment strings for each filetype
local rdf_filetypes = { 'turtle', 'trig', 'sms', 'srs', 'shacl' }
for _, ft in ipairs(rdf_filetypes) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.bo.commentstring = "# %s"
    end,
  })
end
