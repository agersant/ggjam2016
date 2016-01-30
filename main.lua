local TestScene = require( "src/content/TestScene" );


-- Globals

gCurrentScene = nil;

gAssets = {
	BG = {},
	CHAR = {},
	SOUND = {},
	MUSIC = {},
}

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


love.load = function()
	gAssets.BG.monster = love.graphics.newImage("assets/bgs/monster.jpg");
	gAssets.SOUND.mySound = love.audio.newSource("assets/sounds/mySound.ogg");
	gAssets.MUSIC.mySound = love.audio.newSource("assets/music/Jump.wav");

	A = 255;
end



love.update = function( dt )
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

