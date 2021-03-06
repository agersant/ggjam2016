local TestScene = require( "src/content/TestScene" );
local TitleScene = require( "src/content/TitleScene" );
local GoatDateScene = require( "src/content/GoatDateScene" );
local MinnieDateScene = require( "src/content/MinnieDateScene" );


-- Globals

refWidth = 1920;
refHeight = 1080;
startScene = TitleScene;
gCurrentMusic = nil;
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
	gAssets.BG.black = love.graphics.newImage( "assets/bgs/Black.png");
	gAssets.BG.theater = love.graphics.newImage( "assets/bgs/Theater.jpg" );
	gAssets.BG.theater2 = love.graphics.newImage( "assets/bgs/theater2.png" );
	gAssets.BG.parking = love.graphics.newImage( "assets/bgs/ParkingLot.jpg" );
	gAssets.BG.dinner = love.graphics.newImage( "assets/bgs/Dinner.jpg" );
	gAssets.BG.profileGoat = love.graphics.newImage( "assets/bgs/ProfileGoat.jpg" );
	gAssets.BG.profileMinnie = love.graphics.newImage( "assets/bgs/ProfileMinnie.jpg" );
	gAssets.BG.logo = love.graphics.newImage( "assets/bgs/logo.jpg" );
	gAssets.BG.titleScreen = love.graphics.newImage( "assets/bgs/TitleScreen.jpg" );
	gAssets.BG.reportCard = love.graphics.newImage( "assets/bgs/report.png" );

	gAssets.FONT.dialogFont = love.graphics.newFont( "assets/font/PTS55F.ttf", 50 );
	gAssets.FONT.introTextFont = love.graphics.newFont( "assets/font/PTS55F.ttf", 100 );
	gAssets.CHAR.hearts = love.graphics.newImage( "assets/portraits/heart.png" );
	gAssets.CHAR.minnie = {
		angry0 = love.graphics.newImage( "assets/portraits/minnie/angry0.png" );
		exit0 = love.graphics.newImage( "assets/portraits/minnie/exit0.png" );
		happy0 = love.graphics.newImage( "assets/portraits/minnie/happy0.png" );
		happy1 = love.graphics.newImage( "assets/portraits/minnie/happy1.png" );
		hyped0 = love.graphics.newImage( "assets/portraits/minnie/hyped0.png" );
		idle0 = love.graphics.newImage( "assets/portraits/minnie/idle0.png" );
		sad0 = love.graphics.newImage( "assets/portraits/minnie/sad0.png" );
		shocked0 = love.graphics.newImage( "assets/portraits/minnie/shocked0.png" );
	};
	gAssets.CHAR.goat = {
		exit0 = love.graphics.newImage( "assets/portraits/goat/exit0.png" );
		sad0 = love.graphics.newImage( "assets/portraits/goat/sad.png" );
		shocked0 = love.graphics.newImage( "assets/portraits/goat/shocked.png" );
		mad0 = love.graphics.newImage( "assets/portraits/goat/mad.png" );
		happy0 = love.graphics.newImage( "assets/portraits/goat/happy.png" );
		idle0 = love.graphics.newImage( "assets/portraits/goat/idle.png" );
	};

	gAssets.SOUND.mySound = love.audio.newSource("assets/sounds/Jump.wav");
	gAssets.MUSIC.mySound = love.audio.newSource("assets/music/mySound.ogg");
	gAssets.MUSIC.narration = love.audio.newSource( "assets/music/Narration.mp3" );
	gAssets.MUSIC.parkingLot = love.audio.newSource( "assets/music/ParkingLot.mp3" );
	gAssets.MUSIC.dinner = love.audio.newSource( "assets/music/Dinner.mp3" );
	gAssets.MUSIC.theater = love.audio.newSource( "assets/music/Theater.mp3" );
end

love.update = function( dt )
	if not gCurrentScene then
		local scene = startScene.new();
		ChangeScene( scene );
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
