function DateVampire( scene )

	-- TODO
	scene:setBackground( "imageName" );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );

	scene:setCharacter( "characterName" );
	scene:setCharacterPose( "characterName" );
	scene:waitForCharacterAnimation();
	
	scene:dialogChoice( { "a", "b" } ); -- returns a or b
	
	scene:wait( seconds );
	
	scene:playSound();
	scene:playMusic();
	
	-- DONE
	self:startThread( someFunc );
	scene:setDialogSpeed( charactersPerSecond ); -- pass nil for default
	scene:showDialog( "Hello, welcome to this date", { wobbly = true } );
	
end