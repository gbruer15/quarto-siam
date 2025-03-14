local bibname = ''

function has_class(el, class)
  if el.attr == nil then
    return nil
  end
  for i,v in ipairs(el.attr.classes) do
    if v == class then
      return true
    end
  end
  return false
end

function Meta(meta)
  for i, v in ipairs(meta.bibliography) do
    if bibname ~= '' then
      bibname = bibname .. ','
    end
    bibname = bibname .. pandoc.utils.stringify(v)
  end
end

function Pandoc(doc)
  if not quarto.doc.is_format("latex") then
    return doc
  end

  local first_appendix = -1
  for i, el in ipairs(doc.blocks) do
    if el.t == "Header" and pandoc.utils.stringify(el.content) == "References" then
      -- add bibliography to the right place
      local bibliography = pandoc.RawBlock(
        "latex", 
        "\\bibliographystyle{siamplain}\n\\bibliography{" .. bibname .. "}"
      )
      doc.blocks[i] = bibliography
    elseif el.t == "Div" and el.attr and el.attr.identifier == "refs" then
      doc.blocks[i] = pandoc.RawBlock("latex", "")
    elseif el.t == "Header" and has_class(el, "appendix") then
      -- fix appendix compilation
      if first_appendix == -1 then
        first_appendix = i
      end
      -- doc.blocks[i] = appendix
    end
  end
  if first_appendix ~= -1 then
    local appendix = pandoc.RawBlock("latex", "\\appendix")
    table.insert(doc.blocks, first_appendix, appendix)
  end

  return doc
end