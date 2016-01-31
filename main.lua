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
	FONT = {},
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
	gAssets.BG.mockup = love.graphics.newImage("assets/bgs/mockup.png");
	gAssets.SOUND.mySound = love.audio.newSource("assets/sounds/Jump.wav");
	gAssets.MUSIC.mySound = love.audio.newSource("assets/music/mySound.ogg");
	gAssets.FONT.dialogFont = love.graphics.newFont( "assets/font/PTS55F.ttf", 50 );
	gAssets.CHAR.minnie = {
		angry0 = love.graphics.newImage( "assets/portraits/minnie/angry0.png" );
		exit0 = love.graphics.newImage( "assets/portraits/minnie/exit0.png" );
		happy0 = love.graphics.newImage( "assets/portraits/minnie/happy0.png" );
		idle0 = love.graphics.newImage( "assets/portraits/minnie/idle0.png" );
		sad0 = love.graphics.newImage( "assets/portraits/minnie/sad0.png" );
		shocked0 = love.graphics.newImage( "assets/portraits/minnie/shocked0.png" );
	};
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
