function DateVampire( scene )

	scene:setBackground( "imageName" );
	scene:fadeOut();
	scene:fadeIn();
	
	scene:setCharacter( "characterName" );
	scene:setCharacterPose( "characterName" );
	scene:waitForCharacterAnimation();
	
	scene:showDialog( "Hello, welcome to this date" );
	scene:dialogChoice( { "a", "b" } ); -- returns a or b
	
	scene:wait( milliseconds );
	
	scene:playSound();
	scene:playMusic();
	
	thread( someFunction );
	
end