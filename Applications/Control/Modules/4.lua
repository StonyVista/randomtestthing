
local args = {...}
local application, window, localization = args[1], args[2], args[3]

require("advancedLua")
local component = require("component")
local computer = require("computer")
local GUI = require("GUI")
local buffer = require("doubleBuffering")
local image = require("image")
local MineOSPaths = require("MineOSPaths")
local MineOSInterface = require("MineOSInterface")

----------------------------------------------------------------------------------------------------------------

local module = {}
module.name = localization.moduleEvent

----------------------------------------------------------------------------------------------------------------

module.onTouch = function()
	window.contentContainer:removeChildren()

	local container = window.contentContainer:addChild(GUI.container(1, 1, window.contentContainer.width, window.contentContainer.height))

	local layout = container:addChild(GUI.layout(1, 1, container.width, window.contentContainer.height, 1, 1))
	layout:setAlignment(1, 1, GUI.ALIGNMENT_HORIZONTAL_CENTER, GUI.ALIGNMENT_VERTICAL_TOP)
	layout:setMargin(1, 1, 0, 1)

	local textBox = layout:addChild(GUI.textBox(1, 1, container.width - 4, container.height - 4, nil, 0x888888, {localization.waitingEvents .. "..."}, 1, 0, 0))
	local switch = layout:addChild(GUI.switchAndLabel(1, 1, 27, 6, 0x66DB80, 0x1E1E1E, 0xFFFFFF, 0x2D2D2D, localization.processingEnabled .. ": ", true)).switch
	
	textBox.eventHandler = function(application, object, ...)
		local eventData = {...}
		if switch.state and eventData[1] then
			local lines = table.concat(eventData, " ")
			lines = string.wrap(lines, textBox.width)
			for i = 1, #lines do
				table.insert(textBox.lines, lines[i])
			end
			textBox:scrollToEnd()

			application:draw()
		end
	end
end

----------------------------------------------------------------------------------------------------------------

return module