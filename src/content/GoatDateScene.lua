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
	self:showDialog( "Here is the profile of the first demon you must court.\n\nPay close attention to everything they include on their profile, any one piece of information could save your life." );
	--self:showProfile( gAssets.PROFILES.goat );
	self:wait( 3 );
	self:waitForMainInput();
	self:wait( 2 );
end


local PraiseHisTitles = function( self )
	--self:setCharacterPose( "happy" );
	self:showDialog( "Finally! A human who knows how to treat a superior with respect.\nYou may be a worthy partner." );
	self:addPoints( 2 );
end


local AskAboutHim = function( self )
	--self:setCharacterPose( "angry" );
	self:showDialog( "You dare ask me for more? Mortal words do not suffice to capture my splendor." );
	self:addPoints( -2 );
end


local SayTheSpiel = function( self )
	self:setDialogSpeed( 16 );
	self:showDialog( "I am the Undertaker.", { ignoreInput = true }  );
	self:setDialogSpeed( 19 );
	self:showDialog( "Chief Agony Administrator.", { ignoreInput = true }  );
	self:setDialogSpeed( 23 );
	self:showDialog( "Son of Ez the Wicked and Miriam the Bold.", { ignoreInput = true } );
	self:setDialogSpeed( 29 );
	self:showDialog( "Forger of the Obsidian Seal.", { ignoreInput = true } );
	self:setDialogSpeed( 33 );
	self:showDialog( "Founder of the New Order of Seven.", { ignoreInput = true } );
	self:setDialogSpeed( 37 );
	self:showDialog( "Bridger of Dimensions.", { ignoreInput = true } );
	self:setDialogSpeed( 40 );
	self:showDialog( "Fist of Wrath.", { ignoreInput = true } );
	self:setDialogSpeed( 42 );
	self:showDialog( "Capable Photographer.", { ignoreInput = true } );
	self:setDialogSpeed( 16 );
	self:showDialog( "Bringer of Despair.", { wobbly = true } );
	self:setDialogSpeed( 28 );
end


local TellTheTruth = function( self )
	--self:setCharacterPose( "angry" );
	self:showDialog( "An exorcist? You believe you can exorcise me? You fool!" );
	self:showDialog( "You are speaking with Dae'mwe S'haur!" );
	SayTheSpiel( self );
	self:showDialog( "Foolish fool! You do not stand a chance." );
	self:addPoints( -4 );
end


local Complimentary = function( self )
	--self:setCharacterPose( "anger" );
	self:showDialog( "A human should not be excited to spend time with me!\nI am the Bringer of Despair!" );
	--self:setCharacterPose( "sad" );
	self:wait( 1 );
	self:showDialog( "\n\nHave I... lost my touch?" );
	self:addPoints( -2 );
end


local Dread = function( self )
	--self:setCharacterPose( "shock" );
	self:showDialog( "You have... dreaded this date?" );
	self:wait( 1 );
	--self:setCharacterPose( "happy" );
	self:showDialog( "Marvelous! I suppose my immense reputation precedes me." );
	self:addPoints( 2 );
end


local BuyTheManFood = function( self )
	--self:playCharacterAnimation( "shock" )
	self.noMoMoney = true;
	self:showDialog( "By the wing's of Abaddon. You must possess a fortune!", { wobbly = true } );
	self:addPoints( 2 );
	--self:playCharacterAnimation( "happy" )
end


local TheWiseChoice = function( self )
	--self:playCharacterAnimation( "idle" )
	self:showDialog( "You are very wise. Save your money for dinner." );
end


local FrontRow = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "The front row is perfect. Many mortals will not be able to see over my head.\nI may even obscure a portion of the screen." );
	self:showDialog( "< He's laughing heartily >" );
end


local MiddleRow = function( self )
	--self:playCharacterAnimation( "happy" );
	self:showDialog( "In the middle row we will have a good view of the film, and I can block the vision of half the theater.\n\nWonderful." );
	self:addPoints( 2 );
end


local BackRow = function( self )
	--self:playCharacterAnimation( "idle" );
	self:showDialog( "I suppose that is alright." );
end


local TheaterDate = function( self )
	self:setBackground( gAssets.BG.theater );
	self:fadeIn( 3 );
	--self:playMusic( gAssets.MUSIC.theaterLobby );
	--self:setCharacter( "goat" );
	--self:setCharacterPose( "entrance" );
	--self:wait( 2 );
	--self:setCharacterPose( "idle" );
	self:setIntroText( "King of the Seventh Circle of Hell: Dae’mwe S’haur" );
	self:introTextFadeIn( 5 );
	self:introTextFadeOut( 5 );

	self:setDialogSpeed( 28 );
	self:showDialog( "Mortal! I am the one you are waiting for! My name is Dae'mwe S'haur." );
	SayTheSpiel( self );
	self:showChoice( "< It looks like he's waiting for a response >", 
		{ { "Praise be to Dae'mwe! The Undertaker, Chief of...", PraiseHisTitles }, 
		{ "Please, tell me more about yourself.", AskAboutHim } } );
	self:showDialog( "I have spoken enough! Tell me about yourself." );

	self:showChoice( "< He's eyeing you sternly >", { { "I'm an exorcist. I'm here to perform an exorcism.", TellTheTruth },
		{ "I'm excited to be able to spend time with a man of your stature.", Complimentary },
		{ "I've been dreading this date for weeks.", Dread } } );

	self:showDialog( "So....." );
	self:showDialog( "The picture selection is quite varied. I haven't been to a multiplex since I was a kid." );
	self:showDialog( "My nanny used to take me to see horror films. I've never laughed so hard in my life." );
	self:showDialog( "What show should we see?" );

	local SetMovieAnswer = function( movieAnswer )
		return function( self )
			self.movieAnswer = movieAnswer;
		end
	end

	self.movieChoice = self:showChoice( "<He's staring at movie posters>", { 
		{ "Cherub my Back and I'll Rub Yours", SetMovieAnswer( 0 ) },
		{ "Puppy Love", SetMovieAnswer( 1 ) },
		{ "Happy Laughing Children not in Pain", SetMovieAnswer( 2 ) } } );
	self:showDialog( "Interesting choice." );
	self:showDialog( "These simpletons are charging a king's ransom for small confectionaries!\n\nI should punish them with hellfire!" );
	self:showChoice( "< He seems hungry >", { { "Spend all your money on popcorn.", BuyTheManFood }, 
		{ "Spend all your money on a drink.", BuyTheManFood },
		{ "Ignore the concession stand.", TheWiseChoice } } );

	self:showDialog( "Where should we sit?" );
	self:showChoice( "< He's getting anxious >", { { "The front row, I have bad eyesight.", FrontRow },
		{ "The middle row. Best seats in the house.", MiddleRow },
		{ "The back row. I can see my house from there.", BackRow } } );

	self:showDialog( "This is not the time to tarry! Let us make haste to our seats. \n\nCome with me human!" );
end


local run = function( self )
	--PlayNarration( self );
	--self:stopMusic( gAssets.MUSIC.narration );
	--PresentGoatDatingProfile( self );
	TheaterDate( self );
end


GoatDateScene.new = function()
	return Scene.new( run );
end


return GoatDateScene;