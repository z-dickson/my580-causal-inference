--[[
slides.lua: small layout helpers so main.qmd stays free of hand-written HTML.
(Adapted from the design_A_reveal_minimal deck.)

1. Section tracker. Every `# Part n: Title {.section-slide}` heading starts a new
   part. Each later slide gets the "01 Foundations  02 Experiments ..." tracker
   at the top, with the current part highlighted. Slides with class `.pause`
   or `.closing` get no tracker; `tracker=off` on a heading switches it off
   from that slide onwards.

2. Part dividers. "Part 1: Foundations" is split into a small kicker
   ("Part 1") and a large title ("Foundations").

3. Greyed title prefix. In a heading like "Summary: Foundations" the short
   prefix up to the colon ("Summary:") is wrapped in [..]{.pre} and greyed.
]]

local PARTS = {}      -- filled from the section-slide headings
local function has_class(el, c)
  for _, x in ipairs(el.classes) do if x == c then return true end end
  return false
end

local function tracker(active)
  local parts = {}
  for i, label in ipairs(PARTS) do
    local cls = (i == active) and ' class="on"' or ''
    parts[#parts + 1] = string.format('<span%s><span class="n">%02d</span>%s</span>', cls, i, label)
  end
  return pandoc.RawBlock('html', '<div class="tracker">' .. table.concat(parts) .. '</div>')
end

-- wrap the inlines up to (and including) a colon in the first three words
local function grey_prefix(h)
  local words = 0
  for i, el in ipairs(h.content) do
    if el.t == 'Str' then
      words = words + 1
      if el.text:sub(-1) == ':' and i < #h.content then
        local pre = pandoc.List()
        for j = 1, i do pre:insert(h.content[j]) end
        local rest = pandoc.List()
        for j = i + 1, #h.content do rest:insert(h.content[j]) end
        h.content = pandoc.Inlines { pandoc.Span(pre, { class = 'pre' }) }
        h.content:extend(rest)
        return h
      end
      if words >= 3 then return h end
    elseif el.t ~= 'Space' then
      return h
    end
  end
  return h
end

function Pandoc(doc)
  -- first pass: part labels
  for _, b in ipairs(doc.blocks) do
    if b.t == 'Header' and b.level == 1 and has_class(b, 'section-slide') then
      local txt = pandoc.utils.stringify(b.content)
      local _, title = txt:match('^Part%s+(%d+):%s*(.+)$')
      local short = b.attributes['short'] or title or txt
      PARTS[#PARTS + 1] = short
    end
  end

  local out = pandoc.List()
  local part, on = 0, true
  for _, b in ipairs(doc.blocks) do
    if b.t == 'Header' and b.level == 1 then
      if b.attributes['tracker'] == 'off' then on = false end
      b.attributes['short'] = nil
      b.attributes['tracker'] = nil
      if has_class(b, 'section-slide') then
        part = part + 1
        local txt = pandoc.utils.stringify(b.content)
        local n, title = txt:match('^Part%s+(%d+):%s*(.+)$')
        if n then
          b.content = pandoc.Inlines {
            pandoc.Span(pandoc.Inlines { pandoc.Str('Part ' .. n) }, { class = 'kicker' }),
            pandoc.Space(),
            pandoc.Span(pandoc.Inlines { pandoc.Str(title) }, { class = 'divider-title' }),
          }
        end
        out:insert(b)
        out:insert(tracker(part))
      else
        out:insert(grey_prefix(b))
        if part > 0 and on and not has_class(b, 'pause') and not has_class(b, 'closing') then
          out:insert(tracker(part))
        end
      end
    else
      out:insert(b)
    end
  end
  doc.blocks = out
  return doc
end
