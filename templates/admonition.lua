function Div(el)
  local box_types = { "warning", "tip", "note" }

  for _, box in ipairs(box_types) do
    if el.classes:includes(box) then
      local latex = string.format(
        "\\%sbox{%s}",
        box,
        pandoc.write(pandoc.Pandoc(el.content), "latex")
      )
      return pandoc.RawBlock("latex", latex)
    end
  end
end
