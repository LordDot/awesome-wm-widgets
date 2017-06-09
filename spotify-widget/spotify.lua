local wibox = require("wibox")
local awful = require("awful")
local watch = require("awful.widget.watch")

spotify_widget = wibox.widget.textbox()
spotify_widget:set_font('Play 9')

-- optional icon, could be replaced by spotfiy logo (https://developer.spotify.com/design/)
spotify_icon = wibox.widget.imagebox()
spotify_icon:set_image("/usr/share/icons/Arc/devices/22/audio-headphones.png")

watch(
    "sp current-oneline", 1,
    function(widget, stdout, _, _, _)
        if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
            widget:set_text("")
        else
            widget:set_text(stdout)
        end
    end,
    spotify_widget
)

--[[
-- Adds mouse control to the widget:
--  - left click - play/pause
--  - scroll up - play next song
--  - scroll down - play previous song ]]
spotify_widget:connect_signal("button::press", function(_,_,_,button)
    if (button == 1) then awful.spawn("sp play", false)
    elseif (button == 4) then awful.spawn("sp next", false)
    elseif (button == 5) then awful.spawn("sp prev", false)
    end
end)