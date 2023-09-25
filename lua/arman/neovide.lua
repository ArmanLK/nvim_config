local g = vim.g
local opt = vim.opt
if g.neovide then
    opt.guifont = 'Jetbrains Mono:h9'
    g.neovide_transparency = 0.75
    g.neovide_scroll_animation_length = 0.3 -- in seconds
    -- g.neovide_no_idle=v:true
    -- g.neovide_no_idle=v:true
    g.neovide_remember_window_size = 'v:true'
    g.neovide_cursor_animation_length = 0.13
    g.neovide_cursor_trail_length = 0.8
    g.neovide_cursor_antialiasing = 'v:true'
    -- particle animations from = railgun, torpedo, pixiedust, sonicboom,
    -- ripple and wireframe
    g.neovide_cursor_vfx_mode = 'railgun'
    -- g.neovide_cursor_vfx_opacity=200.0
    g.neovide_cursor_vfx_particle_lifetime = 1.0 -- in seconds
    g.neovide_cursor_vfx_particle_density = 8.0
    g.neovide_cursor_vfx_particle_speed = 10.0
    -- railgun ony.
    g.neovide_cursor_vfx_particle_phase = 1.5
    g.neovide_cursor_vfx_particle_curl = 1.0
end
