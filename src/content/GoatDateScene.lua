local Scene = require( "src/Scene" );

local GoatDateScene = {};


local PlayNarration = function( self )
	self:playMusic( gAssets.MUSIC.narration );
	self:setBackground( gAssets.BG.black );
	self:setDialogSpeed( 6 );
	self:showNarration( "DEMONS", { wobbly = true } );
	self:setDialogSpeed( 28 );
	self:showNarration( "NO LONGER MERE MYTH, THEY NOW WALK AMONG US" );
	self:showNarration( "THEY SERVE COFFEE, THEY DRIVE BUSES, THEY WRITE CODE" );
	self:wait( 1 );
	self:showNarration( "THEY ARE MISERABLE", { wobbly = true } );
	self:showNarration( "DEMONS HATE OUR WORLD" );
	self:showNarration( "ALL THEY WANT IS TO RETURN HOME, BUT THEY HAVE LOST THE ABILITY TO CONTROL THEIR FORM" );
	self:showNarration( "THEY ARE TRAPPED AS THE LAST LIVING THING THEY POSSESSED" );
	self:showNarration( "ONLY A MOMENT OF TRUE HAPPINESS CAN EXORCISE A DEMON FROM THEIR UNWANTED HOST" );
	self:wait( 1 );
	self:showNarration( "YOU MUST FIND A DEMON" );
	self:showNarration( "TAKE THEM OUT ON A DATE" );
	self:showNarration( "AND SHOW THEM TRUE HAPPINESS" );
	self:showNarration( "THAT IS THE JOB OF AN EXORCIST" );
	self:setDialogSpeed( 6 );
	self:showNarration( "GOOD LUCK", { wobbly = true } );
	self:wait( 2 );
end


local PresentGoatDatingProfile = function( self )
	self:setDialogSpeed( 28 );
	self:showDialog( "All demons are lonely creatures.\n\nIn our modern day world, the best way for a demon to find a companion is with FivePointedLove.com" );
	self:showDialog( "Here is the profile of the first demon you must woo.\n\nPay close attention to everything they include on their profile, any one piece of information could save your life." );
	--self:showProfile( gAssets.PROFILES.goat );
	self:wait( 3 );
	self:waitForMainInput();
	self:wait( 2 );
end


local PraiseHisTitles = function( self )
	self:showDialog( "Finally! A human who knows how to treat a superior with respect. \nYou may be a worthy partner." );
	self:addPoints( 2 );
end


local AskAboutHim = function( self )
	self:showDialog( "You dare ask me for more? Mortal words do not suffice to capture my splendor." );
	self:addPoints( -2 );
end


local TheaterDate = function( self )
	self:setBackground( gAssets.BG.theater );
	self:fadeIn( 3 );
	--self:playMusic( gAssets.MUSIC.theaterLobby );
	--self:setCharacter( "goat" );
	--self:setCharacterPose( "entrance" );
	--self:wait( 2 );
	--self:setCharacterPose( "idle" );
	self:showDialog( "Mortal! I am the one you are waiting for! My name is Dae'mwe S'haur." );
	self:showDialog( "I am the Undertaker." );
	self:showDialog( "Chief Agony Administrator." );
	self:setDialogSpeed( 32 );
	self:showDialog( "Son of Ez the Wicked and Miriam the Bold.", { ignoreInput = true } );
	self:setDialogSpeed( 37 );
	self:showDialog( "Forger of the Obsidian Seal.", { ignoreInput = true } );
	self:setDialogSpeed( 43 );
	self:showDialog( "Founder of the New Order of Seven.", { ignoreInput = true } );
	self:setDialogSpeed( 49 );
	self:showDialog( "Bridger of Dimensions.", { ignoreInput = true } );
	self:setDialogSpeed( 52 );
	self:showDialog( "Fist of Wrath.", { ignoreInput = true } );
	self:setDialogSpeed( 58 );
	self:showDialog( "Capable Photographer.", { ignoreInput = true } );
	self:setDialogSpeed( 28 );
	self:showDialog( "Bringer of Despair.", { wobbly = true } );
	self:showChoice( "It looks like he's waiting for a response", 
		{ { "Praise be to Dae'mwe! The Undertaker, Chief of...", PraiseHisTitles }, 
		{ "Please, tell me more about yourself.", AskAboutHim } } );
	self:showDialog( "I have spoken enough! Tell me about yourself " );

end


local run = function( self )

	self:setIntroText("something something text");
	self:introTextFadeIn( 5 );
	self:introTextFadeOut( 5 );
	
	PlayNarration( self );
	self:stopMusic(gAssets.MUSIC.narration);
	PresentGoatDatingProfile( self );
	TheaterDate( self );
	

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