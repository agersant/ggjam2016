local Scene = require( "src/Scene" );


SetClass = function( obj, class )
	local meta = {
		__index = class,
	};
	setmetatable( obj, meta );
end


gCurrentScene = nil;

love.update = function()
	if not gCurrentScene then
		gCurrentScene = Scene.new();
	end
end

love.draw = function()
	if not gCurrentScene then
		return;
	end	
	gCurrentScene:draw();
end