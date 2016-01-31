function DateVampire( scene )
	-- TODO
	-- DONE
	scene:setBackground( gAssets.BG.mockup );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );
	scene:wait( seconds );
	scene:waitForMainInput();
	scene:startThread( someFunc ); -- returns a thread
	scene:stopThread( thread );
	scene:setDialogSpeed( charactersPerSecond ); -- pass nil for default
	scene:showNarration( "Hello, welcome to this date", { wobbly = true } );
	scene:showDialog( "Hello, welcome to this date", { ignoreInput = true, wobbly = true } );
	scene:showChoice( { "a", outcomeA, }, { "b", outcomeB, } );
	scene:setCharacter( characterClass ); -- dont forget to import the character in your scene
	scene:playCharacterAnimation( "happy" );
	scene:waitForCharacterAnimation();
	scene:playSound( gAssets.SOUND.mySound );
	scene:playMusic( gAssets.MUSIC.mySound );	
end