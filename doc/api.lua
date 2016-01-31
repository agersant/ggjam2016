function DateVampire( scene )

	-- TODO
	scene:setCharacter( "characterName" );
	scene:setCharacterPose( "characterName" );
	scene:waitForCharacterAnimation();

	scene:stopMusic();
	
	-- DONE
	scene:setBackground( gAssets.BG.mockup );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );

	scene:wait( seconds );
	scene:startThread( someFunc ); -- returns a thread
	scene:stopThread( thread );
	scene:setDialogSpeed( charactersPerSecond ); -- pass nil for default
	scene:showDialog( "Hello, welcome to this date", { wobbly = true } );
	scene:showChoice( { "a", outcomeA, }, { "b", outcomeB, } );

	scene:playSound( gAssets.SOUND.mySound );
	scene:playMusic( gAssets.MUSIC.mySound );	
end