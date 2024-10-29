local constants = require("config.constants")
local settings = require("config.settings")

local whitelist = {
	['Spotify'] = true,
	['Music'] = true,
	['Podcasts'] = true,
	['VLC'] = true,
	['IINA'] = true,
	['Arc'] = true
};

local media = sbar.add('item', 'media', {
	icon = {
		color = settings.colors.LIGHT2,
        background = {
            color = settings.colors.DARK4,
            height = 24,
            corner_radius = 16,
        },
		font = settings.fonts.icons(),
	},
	label = {
		color = settings.colors.LIGHT2,
        width = 25,
		background = {
			color = settings.colors.DARK2,
		},
	},
	position = 'center',
	updates = true,
	background = {
		color = settings.colors.DARK2,
	},
	width = 50,
})

local function animate_media_width(width)
	sbar.animate('tanh', 50.0, function()
		media:set({ label = { width = width } })
	end)
end

media:subscribe('mouse.entered', function()
	local text = media:query().label.value
	animate_media_width(#text * 10) -- adjust depending on font width
end)
media:subscribe('mouse.exited', function()
	animate_media_width(25)
end)
media:subscribe('mouse.clicked', function(env)
	sbar.exec('shortcuts run "playpause"')
end)

media:subscribe('media_change', function(env)
    if whitelist[env.INFO.app] then
        local lookup = settings.icons.apps[env.INFO.app]
        local icon = ((lookup == nil) and settings.icons.apps['default'] or lookup)

        local playback_icon = ((env.INFO.state == 'playing') and '' or '')
        local artist = (env.INFO.artist ~= "" and env.INFO.artist) or "Unknown Artist"
        local title = (env.INFO.title ~= "" and env.INFO.title) or "Unknown Title"
        local label = playback_icon .. ' ' .. artist .. ': ' .. title

        sbar.animate('tanh', 10, function()
            media:set({
                icon = { string = icon },
                label = label
            })
        end)
    end
end)