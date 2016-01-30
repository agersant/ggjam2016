local TestScene = require( "src/content/TestScene" );


-- Globals

refWidth = 1920;
refHeight = 1080;
gCurrentScene = nil;
gRenderOffset = { x = 0, y = 0 };
gRenderScale = 1;
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
	return 		love.keyboard.isDown( "space" )
			or	love.keyboard.isDown( "return" )
			or	love.keyboard.isDown( "kpenter" )
			or	love.keyboard.isDown( "z" );
end

Letterbox = function()
	love.graphics.translate( gRenderOffset.x, gRenderOffset.y );
	love.graphics.scale( gRenderScale, gRenderScale );
end


-- Love functions

love.load = function()
	love.resize( love.graphics.getWidth(), love.graphics.getHeight() );
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
	Letterbox();
	gCurrentScene:draw();
end

love.resize = function( winW, winH )
	local winAspectRatio = winW / winH;
	local refAspectRatio = refWidth / refHeight;
	local gameW, gameH;
	if winAspectRatio > refAspectRatio then
		gameH = winH;
		gameW = gameH * refAspectRatio;
		gRenderScale = gameH / refHeight;
	else
		gameW = winW;
		gameH = gameW / refAspectRatio;
		gRenderScale = gameW / refWidth;
	end
	assert( gameW <= winW );
	assert( gameH <= winH );
	gRenderOffset.x = ( winW - gameW ) / 2;
	gRenderOffset.y = ( winH - gameH ) / 2;
end
