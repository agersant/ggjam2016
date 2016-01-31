function DateVampire( scene )

	-- TODO
	scene:setBackground( "imageName" );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );

	scene:playSound();
	scene:playMusic();
	
	-- DONE
	scene:wait( seconds );
	scene:startThread( someFunc ); -- returns a thread
	scene:stopThread( thread );
	scene:setDialogSpeed( charactersPerSecond ); -- pass nil for default
	scene:showDialog( "Hello, welcome to this date", { wobbly = true } );
	scene:showChoice( { "a", outcomeA, }, { "b", outcomeB, } );
	scene:setCharacter( characterClass ); -- dont forget to import the character in your scene
	scene:playCharacterAnimation( "anim" );
	scene:waitForCharacterAnimation();
end