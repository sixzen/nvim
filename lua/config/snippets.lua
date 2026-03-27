local ls = require "luasnip"
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
  return { os.date "%Y-%m-%d" }
end

local timestamp = function()
  return { tostring(os.time()) }
end

local timestamp_with_filename = function()
  local ts = tostring(os.time())
  local filename = vim.fn.expand "%:t:r"
  return { ts .. "-" .. filename }
end

local datetime = function()
  return { os.date "%Y-%m-%d %H:%M:%S" }
end

-- Función para obtener el título del archivo sin timestamp ni extensión
local filename_title = function()
  local filename = vim.fn.expand "%:t:r" -- Obtiene nombre sin extensión
  -- Remueve timestamp si existe (asume formato: timestamp-titulo)
  local title = filename:gsub("^%d+%-", "")
  -- Reemplaza guiones y underscores con espacios
  title = title:gsub("[-_]", " ")
  -- Capitaliza primera letra de cada palabra
  title = title:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)
  return { title }
end

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "datetest",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
    snip({
      trig = "metatest",
      namr = "Metadata",
      dscr = "Yaml metadata format for markdown",
    }, {
      text { "---", "title: " },
      insert(1, "note_title"),
      text { "", "author: " },
      insert(2, "author"),
      text { "", "date: " },
      func(date, {}),
      text { "", "categories: [" },
      insert(3, ""),
      text { "]", "lastmod: " },
      func(date, {}),
      text { "", "tags: [" },
      insert(4),
      text { "]", "comments: true", "---", "" },
      insert(0),
    }),
  },
  markdown = {
    -- Zettelkasten frontmatter con timestamp ID y título del archivo
    snip({
      trig = "zet",
      name = "Zettelkasten Note",
      dscr = "Creates Zettelkasten-style frontmatter with timestamp ID, tags, and filename as title",
    }, {
      text { "---", "id: " },
      func(timestamp_with_filename, {}),
      text { "", "tags: [" },
      insert(1, ""),
      text { "]", "aliases:", "  - " },
      func(function() return { vim.fn.expand "%:t:r" } end, {}),
      text { "", "---", "", "# " },
      func(filename_title, {}),
      text { "", "", "" },
      insert(0),
    }),
    -- Frontmatter simple para notas rápidas
    snip({
      trig = "front",
      name = "Simple Frontmatter",
      dscr = "Simple frontmatter with tags",
    }, {
      text { "---", "tags: [" },
      insert(1, ""),
      text { "]", "---", "", "" },
      insert(0),
    }),
    -- Timestamp único (para IDs manuales)
    snip({
      trig = "ts",
      name = "Timestamp",
      dscr = "Insert current Unix timestamp",
    }, {
      func(timestamp, {}),
    }),
    -- Fecha actual
    snip({
      trig = "date",
      name = "Date",
      dscr = "Current date YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
    -- Fecha y hora completa
    snip({
      trig = "datetime",
      name = "DateTime",
      dscr = "Current date and time",
    }, {
      func(datetime, {}),
    }),
  },
})
