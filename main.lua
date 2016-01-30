local Scene = require( "src/Scene" );


SetClass = function( obj, class )
	local meta = {
		__index = class,
	};
	setmetatable( obj, meta );
end


gCurrentScene = nil;
gAssets = {
	BG = {},
	CHAR = {},
	SOUND = {},
	MUSIC = {},
}




love.load = function()
	gAssets.BG.monster = love.graphics.newImage("assets/bgs/monster.jpg");
	gAssets.SOUND.mySound = love.audio.newSource("assets/sounds/mySound.ogg");
	gAssets.MUSIC.mySound = love.audio.newSource("assets/music/Jump.wav");
	
	A = 255;
end



love.update = function( dt )
	if not gCurrentScene then
		gCurrentScene = Scene.new();
	end
	
	
--	gCurrentScene.fadeOut( 5 );
	
	A = A - ( 255 / 5 * dt );
	love.graphics.setColor(255, 255, 255, A)
	
	
	gCurrentScene:setBackground( gAssets.BG.monster );
--	gCurrentScene:playSound( gAssets.SOUND.mySound );
--	gCurrentScene:playMusic( gAssets.MUSIC.mySound );
	
	
end

love.draw = function()
	if not gCurrentScene then
		return;
	end	
	gCurrentScene:draw();
end

