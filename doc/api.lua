function DateVampire( scene )

	scene:setBackground( "imageName" );
	scene:fadeOut( seconds );
	scene:fadeIn( seconds );
	
	scene:setCharacter( "characterName" );
	scene:setCharacterPose( "characterName" );
	scene:waitForCharacterAnimation();
	
	scene:showDialog( "Hello, welcome to this date" );
	scene:dialogChoice( { "a", "b" } ); -- returns a or b
	
	scene:wait( seconds );
	
	scene:playSound();
	scene:playMusic();
	
	thread( someFunction );
	
end