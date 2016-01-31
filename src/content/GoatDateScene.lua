local Scene = require( "src/Scene" );

local GoatDateScene = {};


local playNarration = function( self )
	self:playMusic( gAssets.MUSIC.narration );
	self:setBackground( gAssets.BG.black );
	self:setDialogSpeed( 6 );
	self:showDialog( "DEMONS", { wobbly = true } );
	self:setDialogSpeed( 28 );
	self:showDialog( "NO LONGER MERE MYTH, THEY NOW WALK AMONG US" );
	self:showDialog( "THEY SERVE COFFEE, THEY DRIVE BUSES, THEY WRITE CODE" );
	self:wait( 1 );
	self:showDialog( "THEY ARE MISERABLE", { wobbly = true } );
	self:showDialog( "DEMONS HATE OUR WORLD" );
	self:showDialog( "ALL THEY WANT IS TO RETURN HOME, BUT THEY HAVE LOST THE ABILITY TO CONTROL THEIR FORM" );
	self:showDialog( "THEY ARE STUCK AS THE LAST LIVING THING THEY POSSESSED" );
	self:showDialog( "ONLY A MOMENT OF TRUE HAPPINESS CAN EXORCISE A DEMON FROM THEIR UNWANTED HOST" );
	self:wait( 1 );
	self:showDialog( "YOU MUST FIND A DEMON" );
	self:showDialog( "TAKE THEM OUT ON A DATE" );
	self:showDialog( "AND SHOW THEM TRUE HAPPINESS" );
	self:showDialog( "THAT IS THE JOB OF AN EXORCIST" );
	self:setDialogSpeed( 6 );
	self:showDialog( "GOOD LUCK", { wobbly = true } );
end


local run = function( self )
	playNarration( self );
	
	
	-- TODO
	--[[scene:setBackground( gAssets.BG.mockup );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );

	scene:setCharacter( "characterName" );
	scene:setCharacterPose( "characterName" );
	scene:waitForCharacterAnimation();
	
	scene:playSound( gAssets.SOUND.mySound );
	scene:playMusic( gAssets.MUSIC.mySound );
	
	-- DONE
	scene:wait( seconds );
	scene:startThread( someFunc ); -- returns a thread
	scene:stopThread( thread );
	scene:setDialogSpeed( charactersPerSecond ); -- pass nil for default
	scene:showDialog( "Hello, welcome to this date", { wobbly = true } );
	scene:showChoice( { "a", outcomeA, }, { "b", outcomeB, } );--]]
	
end


GoatDateScene.new = function()
	return Scene.new( run );
end


return GoatDateScene;