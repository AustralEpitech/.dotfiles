-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify{
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify{
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err)
            }
            in_error = false
        end
    )
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

browser = "firefox"
files = "pcmanfm"

lock = "i3lock -ftni" .. gears.filesystem.get_configuration_dir() .. "wallpapers/debian11.png"

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    )
)

local tasklist_buttons = gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c.minimized = false
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    ),
    awful.button(
        {},
        3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    )
)

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
    function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Each screen has its own tag table.
        awful.tag(
            {"TTY", "WEB", "DEV", "SBX", "GAM", "MED", "SYS", "SRV", "ETC"},
            s,
            awful.layout.layouts[1]
        )

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist{
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist{
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

        -- Create the wibox
        s.mywibox = awful.wibar{position = "top", screen = s}

        -- Add widgets to the wibox
        s.mywibox:setup{
            layout = wibox.layout.align.horizontal,
            {
                -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist
            },
            s.mytasklist, -- Middle widget
            {
                -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                mytextclock
            },
        }
    end
)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key(
        {modkey},
        "s",
        hotkeys_popup.show_help,
        {description = "show help", group = "awesome"}
    ),
    awful.key(
        {modkey},
        "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {modkey},
        "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- Layout manipulation
    awful.key(
        {modkey, "Shift"},
        "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, "Control"},
        "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        {modkey},
        "u",
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
    ),
    -- Standard program
    awful.key(
        {modkey},
        "Return",
        function()
            awful.spawn(terminal, {tag = mouse.screen.selected_tag})
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "e",
        function()
            awful.spawn(files, {tag = mouse.screen.selected_tag})
        end,
        {description = "open file manager", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "b",
        function()
            awful.spawn(browser, {tag = mouse.screen.selected_tag})
        end,
        {description = "open browser", group = "launcher"}
    ),
    awful.key(
        {modkey},
        "l",
        function()
            awful.spawn(lock)
        end,
        {description = "lock screen", group = "awesome"}
    ),
    awful.key(
        {modkey, "Shift"},
        "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        {modkey, "Shift"},
        "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key(
        {modkey},
        "t",
        function()
            awful.layout.set(awful.layout.layouts[1])
        end,
        {description = "set tiling layout", group = "layout"}
    ),
    awful.key(
        {modkey},
        "m",
        function()
            awful.layout.set(awful.layout.layouts[2])
        end,
        {description = "set max layout", group = "layout"}
    ),
    -- Menubar
    awful.key(
        {modkey},
        "r",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    ),
    -- Shortcuts
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.spawn("set-vol +5")
        end,
        {description = "raise volume", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.spawn("set-vol -5")
        end,
        {description = "lower volume", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86AudioMute",
        function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end,
        {description = "mute volume", group = "shortcut"}
    ),
    awful.key(
        {"Control"},
        "XF86AudioMute",
        function()
            awful.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        end,
        {description = "mute volume", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86AudioPlay",
        function()
            awful.spawn("playerctl play-pause")
        end,
        {description = "play/pause media", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86AudioPrev",
        function()
            awful.spawn("playerctl previous")
        end,
        {description = "previous media", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86AudioNext",
        function()
            awful.spawn("playerctl next")
        end,
        {description = "next media", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function()
            awful.spawn("set-light +10")
        end,
        {description = "raise brightness", group = "shortcut"}
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function()
            awful.spawn("set-light -10")
        end,
        {description = "lower brightness", group = "shortcut"}
    ),
    awful.key(
        {},
        "Print",
        function()
            awful.spawn("flameshot full -c")
        end,
        {description = "take a screenshot", group = "shortcut"}
    ),
    awful.key(
        {"Shift"},
        "Print",
        function()
            awful.spawn("flameshot gui")
        end,
        {description = "take a rectangular screenshot", group = "shortcut"}
    )

)

clientkeys =
    gears.table.join(
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "c",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        {modkey},
        "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        {modkey},
        "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        )
    )
end

clientbuttons = gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            maximized = false,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation
            -- of the client and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = {"dialog"}
        },
        properties = {titlebars_enabled = true}
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and
            not c.size_hints.user_position and
            not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
    "request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    c:emit_signal("request::activate", "titlebar", {raise = true})
                    awful.mouse.client.resize(c)
                end
            )
        )

        awful.titlebar(c):setup {
            {
                -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Middle
                {
                    -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- }}}

apps = {
    "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1",
    "xset dpms 300 15", -- dim screen after 5 min and lock 15 sec after
    "xss-lock --  " .. lock,
    "picom",
    "nm-applet",
    "killall cbatticon",
    "cbatticon BAT0 -i symbolic",
    "flameshot",
}

for _, app in ipairs(apps) do
    awful.spawn.once(app)
end
