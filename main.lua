local TestScene = require( "src/content/TestScene" );


-- Globals

gCurrentScene = nil;



-- Core functions

SetClass = function( obj, class )
	local meta = {
		__index = class,
	};
	setmetatable( obj, meta );
end

ChangeScene = function( scene )
	assert( scene.update );
	assert( scene.draw );
	gCurrentScene = scene;
end

IsMainInputDown = function()
	return love.keyboard.isDown( "space" );
end



-- Love functions

love.update = function()
	if not gCurrentScene then
		local defaultScene = TestScene.new();
		ChangeScene( defaultScene );
	end
	gCurrentScene:update();
end

love.draw = function()
	if not gCurrentScene then
		return;
	end	
	gCurrentScene:draw();
end
