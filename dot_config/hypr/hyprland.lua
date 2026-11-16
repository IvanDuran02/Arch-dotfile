-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- HYPRLAND LUA CONFIGURATION                             --
-- Optimized for Wayland, Alt Modifiers & 4K Primary      --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

------------------
---- MONITORS ----
------------------
-- Primary 4K MSI Gaming Monitor (MAG 321CUPDF) at 120Hz
hl.monitor({
    output   = "DP-1",
    mode     = "3840x2160@120.00Hz",
    position = "1920x0",
    scale    = 1.25, -- Adjust to 1.0 if you prefer unscaled 4K
})

-- Secondary 1080p Samsung Monitor (LF24T35) on the left
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@74.97Hz",
    position = "0x0",
    scale    = 1.0,
})

-- Fallback for any other monitor
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.0,
})

-- Workspace monitor bindings (Workspaces 1-5 on Primary 4K, 6-10 on Secondary)
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "wezterm"
local menu        = "wofi --show drun"
local browser     = "brave"
local discordApp  = "discord"
local audioMixer  = "pavucontrol"


-------------------
---- AUTOSTART ----
-------------------
-- Ensures Wayland bar, clipboard & notification services are ready
hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- NVIDIA RTX 4080 optimizations
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(cba6f7ee)", "rgba(89b4faee)"}, angle = 45 },
            inactive_border = "rgba(313244aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = 0x66000000,
        },

        blur = {
            enabled   = true,
            size      = 6,
            passes    = 2,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 238.12, damping = 24.21 })

hl.animation({ leaf = "global",        enabled = true, speed = 8,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5,   bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4,   spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4,   spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 2,   bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 2,   bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 2,   bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3,   bezier = "almostLinear", style = "fade" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1, -- Restores default anime mascot / Hyprland wallpaper
        disable_hyprland_logo   = false,
    },
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    cursor = {
        no_hardware_cursors = true, -- Fixes cursor blinking/flickering on NVIDIA
    },
})


---------------------
---- KEYBINDINGS ----
---------------------
-- Mod key set to ALT to match Sway muscle memory
local mainMod = "ALT"

-- Core Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd(discordApp))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(audioMixer))

-- Window Layout & State
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar || waybar"))

-- Vim-style Navigation (Focus)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Arrow key Navigation (Focus)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))

-- Vim-style Window Movement
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Arrow key Window Movement
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ==============================================================================
-- LIGHTWEIGHT SCREENSHOT TOOLS (Sway hotkeys, instant Wayland capture)
-- ==============================================================================
-- 1. Area Selection -> Direct to Clipboard (Sway: Shift+$mod+s)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("bash -c 'grim -g \"$(slurp)\" - | wl-copy && notify-send -a \"Screenshot\" \"Selection copied to clipboard\" -i camera-photo'"))

-- 2. Area Selection -> Save to file + Copy to Clipboard (Sway: Ctrl+$mod+s)
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("bash -c 'mkdir -p ~/Pictures/Screenshots && file=\"$HOME/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png\" && grim -g \"$(slurp)\" \"$file\" && wl-copy < \"$file\" && notify-send -a \"Screenshot\" \"Saved and copied to clipboard\" -i camera-photo'"))

-- 3. Full Screen -> Save to file + Copy to Clipboard (Print key)
hl.bind("Print", hl.dsp.exec_cmd("bash -c 'mkdir -p ~/Pictures/Screenshots && file=\"$HOME/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png\" && grim \"$file\" && wl-copy < \"$file\" && notify-send -a \"Screenshot\" \"Full screenshot saved and copied\" -i camera-photo'"))


-- Mouse bindings (Drag & Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia / Volume controls (WirePlumber / wpctl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})
