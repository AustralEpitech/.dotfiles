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
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            if in_error then
                return
            end
            in_error = true

            naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err)
            })
            in_error = false
        end
    )
end
-- }}}

-- {{{ Variable definitions
config_dir = gears.filesystem.get_configuration_dir()
wallpaper_dir = config_dir .. "wallpapers/"

beautiful.init(config_dir .. "theme.lua")

mytags = {
    {name = "TTY"                                   },
    {name = "WEB",  layout = awful.layout.suit.max  },
    {name = "DEV"                                   },
    {name = "SBX",   layout = awful.layout.suit.max  },
    {name = "GAM",  layout = awful.layout.suit.max  },
    {name = "MED",  layout = awful.layout.suit.max  },
    {name = "DOC",  layout = awful.layout.suit.max  },
    {name = "GFX",  layout = awful.layout.suit.max  },
    {name = "ETC"                                   }
}

terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "brave"
files = "thunar"
wallpaper = "landscape.png"
lock = "i3lock -fti" .. wallpaper_dir .. "lock.png && sleep 600 && systemctl suspend"
screenshot = "flameshot full -c"
screenshot_gui = "flameshot gui"

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button(
        {}, 1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey}, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),
    awful.button(
        {}, 3,
        awful.tag.viewtoggle
    ),
    awful.button(
        {modkey}, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),
    awful.button(
        {}, 4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {}, 5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

local tasklist_buttons = gears.table.join(
    awful.button(
        {}, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end
    ),
    awful.button(
        {}, 3,
        function()
            awful.menu.client_list({theme = {width = 250}})
        end
    ),
    awful.button(
        {}, 4,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {}, 5,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)

local function set_wallpaper(s)
    if beautiful.wallpaper then
        gears.wallpaper.maximized(wallpaper_dir .. wallpaper, s, true)
    end
end

local function set_clock(s)
    local dpi = require("beautiful.xresources").apply_dpi

    s.mytextclock = wibox.widget.textclock()
    s.month_calendar = awful.widget.calendar_popup.month({
        screen = s,
        style_year          = {border_width = dpi(1)},
        style_month         = {border_width = dpi(1)},
        style_yearheader    = {border_width = dpi(1)},
        style_header        = {border_width = dpi(1)},
        style_weekday       = {border_width = dpi(1)},
        style_weeknumber    = {border_width = dpi(1)},
        style_normal        = {border_width = dpi(1)},
        style_focus         = {border_width = dpi(1)}
    })
    s.month_calendar:attach(s.mytextclock)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
    function(s)
        -- Wallpaper and clock
        set_wallpaper(s)
        set_clock(s)

        -- Each screen has its own tag table.
        for i, tag in pairs(mytags) do
            awful.tag.add(
                tag.name,
                {
                    layout = tag.layout or awful.layout.layouts[1],
                    screen = s,
                    selected = i == 1
                }
            )
        end

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
            awful.button(
                {}, 1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {}, 3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {}, 4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {}, 5,
                function()
                    awful.layout.inc(-1)
                end
            )
        ))
        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

        -- Create the wibox
        s.mywibox = awful.wibar({position = "top", screen = s})

        -- Add widgets to the wibox
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                s.mytextclock,
                s.mylayoutbox,
            },
        }
    end
)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Awesome
    awful.key(
        {modkey}, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    awful.key(
        {modkey, "Control"}, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        {modkey, "Control"}, "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key(
        {"Control", "Shift"}, "Escape",
        function()
            awful.spawn("xkill")
        end,
        {description = "kill an app", group = "awesome"}
    ),

    awful.key(
        {modkey}, "Escape",
        awful.tag.history.restore,
        {description = "go back", group = "tag"}
    ),

    awful.key(
        {modkey}, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {modkey}, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key(
        {modkey, "Shift"}, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"}, "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        {modkey, "Control"}, "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, "Control"}, "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        {modkey}, "u",
        awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
    ),
    awful.key(
        {modkey}, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),
    awful.key(
        {modkey, "Control"}, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    -- Standard program
    awful.key(
        {modkey}, "Return",
        function()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        {modkey}, "r",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    ),
    awful.key(
        {modkey}, "b",
        function()
            awful.spawn(browser)
        end,
        {description = "open " .. browser, group = "launcher"}
    ),
    awful.key(
        {modkey}, "e",
        function()
            awful.spawn(files)
        end,
        {description = "open " .. files, group = "launcher"}
    ),
    awful.key(
        {modkey}, "l",
        function()
            awful.spawn.with_shell(lock)
        end,
        {description = "lock the screen", group = "launcher"}
    ),
    awful.key(
        {}, "Print",
        function()
            awful.spawn(screenshot)
        end,
        {description = "take a screenshot", group = "launcher"}
    ),
    awful.key(
        {"Shift"}, "Print",
        function()
            awful.spawn(screenshot_gui)
        end,
        {description = "take a rectangular screenshot", group = "launcher"}
    ),

    awful.key(
        {modkey, "Shift"}, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        {modkey, "Shift"}, "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        {modkey}, "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        {modkey, "Shift"}, "space",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),

    -- Hotkeys
    awful.key(
        {}, "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-mute 0 0 && pactl set-sink-volume 0 +5%")
        end,
        {description = "increase volume up by 5%", group = "hotkeys"}
    ),
    awful.key(
        {}, "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-mute 0 0 && pactl set-sink-volume 0 -5%")
        end,
        {description = "decrease volume up by 5%", group = "hotkeys"}
    ),
    awful.key(
        {}, "XF86AudioMute",
        function()
            awful.spawn("pactl set-sink-mute 0 toggle")
        end,
        {description = "toggle mute", group = "hotkeys"}
    ),
    awful.key(
        {"Control"}, "XF86AudioMute",
        function()
            awful.spawn("pactl set-source-mute 0 toggle")
        end,
        {description = "toggle mic mute", group = "hotkeys"}
    ),
    awful.key(
        {}, "XF86AudioPlay",
        function()
            awful.spawn("playerctl play-pause")
        end,
        {description = "play / pause media", group = "hotkeys"}
    ),
    awful.key(
        {}, "XF86AudioPrev",
        function()
            awful.spawn("playerctl previous")
        end,
        {description = "play previous media", group = "hotkeys"}
    ),
    awful.key(
        {}, "XF86AudioNext",
        function()
            awful.spawn("playerctl next")
        end,
        {description = "play next media", group = "hotkeys"}
    ),
    awful.key(
        {"Control"}, "F6",
        function()
            awful.spawn.with_shell("~/bin/toggle_touchpad")
        end,
        {description = "toggle touchpad", group = "hotkeys"}
    )
)

clientkeys = gears.table.join(
    awful.key(
        {modkey}, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"}, "c",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        {modkey, "Control"}, "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        {modkey, "Control"}, "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    ),
    awful.key(
        {modkey}, "o",
        function(c)
            c:move_to_screen()
        end,
        {description = "move to screen", group = "client"}
    ),
    awful.key(
        {modkey}, "t",
        function(c)
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        {modkey}, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        {modkey}, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
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
            {modkey}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {modkey, "Shift"}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        )
    )
end

clientbuttons = gears.table.join(
    awful.button(
        {}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        {modkey}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {modkey}, 3,
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
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },

    {rule_any = {class = {"Brave-browser"}},                properties = {tag = "WEB",  switch_to_tags = true}},
    {rule_any = {class = {"code-oss"}},                     properties = {tag = "DEV",  switch_to_tags = true}},
    {rule_any = {class = {"Steam", "Lutris", "Minecraft"}}, properties = {tag = "GAM",  switch_to_tags = true}},
    {rule_any = {class = {"Virt-manager"}},                 properties = {tag = "SBX",  switch_to_tags = true}},
    {rule_any = {class = {"libreoffice"}},                  properties = {tag = "DOC",  switch_to_tags = true}},
    {rule_any = {class = {"vlc"}},                          properties = {tag = "MED",  switch_to_tags = true}},
    {rule_any = {class = {"Gimp"}},                         properties = {tag = "GFX",  switch_to_tags = true}}
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
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "picom",
    "redshift",
    "nm-applet",
    "pasystray",
    "flameshot",
    terminal
}

for _, app in ipairs(apps) do
    awful.spawn.once(app)
end
