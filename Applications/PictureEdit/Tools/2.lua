
local image = require("image")
local tool = {}

------------------------------------------------------

tool.shortcut = "Mv"
tool.keyCode = 47
tool.about = "Move tool allows you to move image as you wish. But be careful: large images will take a time to shift and redraw. Hello, shitty GPUs!"

local xOld, yOld
tool.eventHandler = function(application, object, e1, e2, e3, e4)
	if e1 == "touch" then
		xOld, yOld = e3, e4
	elseif e1 == "drag" and xOld and yOld then
		application.image.localX = application.image.localX + (e3 - xOld)
		application.image.localY = application.image.localY + (e4 - yOld)
		xOld, yOld = e3, e4
		
		application:draw()
	elseif e1 == "drop" then
		xOld, yOld = nil, nil
	end
end

------------------------------------------------------

return tool