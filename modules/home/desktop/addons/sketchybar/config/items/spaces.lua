#!/usr/bin/env lua

local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local spaces = {}
for i = 1, 10, 1 do
  local space = sbar.add("space", "space." .. i, {
    associated_space = i,
    icon = {
      string = icons.spaces["_" .. i],
      padding_left = 7,
      padding_right = 7,
      color = colors.text,
      highlight_color = colors.getRandomCatColor(),
    },
    padding_left = 2,
    padding_right = 2,
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.text,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
      drawing = false,
      background = {
        height = 26,
        drawing = true,
        color = colors.surface1,
        corner_radius = 8
      }
    },
  })

  spaces[i] = space.name
  space:subscribe("space_change", function(env)
    local color = env.SELECTED == "true" and colors.text or colors.overlay0

    sbar.set(env.NAME, {
      icon = { highlight = env.SELECTED, },
      label = { highlight = env.SELECTED, },
      background = { border_color = color }
    })
  end)
  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      sbar.exec("yabai -m space --destroy " .. env.SID .. " && sketchybar --trigger space_change")
    else
      sbar.exec("yabai -m space --focus " .. env.SID)
    end
  end)
end

sbar.add("bracket", spaces, {
  background = {
    color = colors.surface0,
    border_color = colors.surface1,
    border_width = 2,
  }
})

spaces.creator = sbar.add("item", "spaces.creator", {
  padding_left = 10,
  padding_right = 8,
  icon = {
    string = "",
    font = {
      family = settings.nerd_font,
      style = "Regular",
      size = 16.0,
    },
  },
  label = { drawing = false },
  associated_display = "active",
})

spaces.creator:subscribe("mouse.clicked", function(_)
  sbar.exec("yabai -m space --create && sketchybar --trigger space_change")
end)
