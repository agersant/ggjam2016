local Scene = require( "src/Scene" );

local GoatDateScene = {};


local PlayNarration = function( self )
	self:playMusic( gAssets.MUSIC.narration );
	self:setBackground( gAssets.BG.black );
	self:setDialogSpeed( 6 );
	self:showNarration( "DEMONS", { wobbly = true } );
	self:setDialogSpeed();
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
	self:setDialogSpeed();
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
	self:setDialogSpeed();
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
	--self:setCharacterPose( "sad" );
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

	self:setDialogSpeed();
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
	self:showDialog( "My nanny used to take me to see horror films.\nWe would laugh and laugh until they kicked us out." );
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
	self:fadeOut( 3 );
end


local LavaPit = function( self )
	self:showDialog( "Good idea. If the children are slowly lowered into lava there is time to hear them scream." );
	self:addPoints( 2 );
end


local BowlBlood = function( self )
	--self:playCharacterAnimation( "shock" );
	self:showDialog( "That...", { wobbly = true } );
	self:showDialog( "is...", { wobbly = true } );
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "Sheer brilliance! Blood draining and bathing? That idea has a little something for everyone." );
end


local IronMaiden = function( self )
	--self:playCharacterAnimation( "idle" );
	self:showDialog( "It is good the children would be suffering, but I like to consume pain with both my eyes and my ears." );
end


local AllTheMeat = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "I was wrong to doubt you. I hope many animals are slaughtered to bring me this meal." );
end


local NewYorksFinest = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 1 );
	self:showDialog( "A fine choice." );
end


local NotMakingFriends = function( self )
	--self:playCharacterAnimation( "angry" );
	self:addPoints( -4 );
	self:showDialog( "YOU WOULD ORDER THE KING OF THE SEVENTH CIRCLE OF HELL TREE LEAVES?", { wobbly = true } );
	self:wait( 2 );
	self:showDialog( "I am S'haur!" );
	SayTheSpiel( self );
	self:showDialog( "I'm not a friggin' vegetarian." )
end


local StealOrder = function( self )
	--self:playCharacterAnimation( "shock" );
	self:showDialog( "You dare?", { wobbly = true } );
	self:addPoints( -1 );
	self:showChoice( "< He does not look happy >", { { "He'll take the turf and turf and turf and turf.", AllTheMeat },
		{ "He's in the mood for some pastrami.", NewYorksFinest },
		{ "This man is a salad man. Give him something as green as possible.", NotMakingFriends } } );
end


local TakeTime = function ( self )
	--self:playCharacterAnimation( "idle" );
	self:showDialog( "< THEN ARRIVES WAITER >" );
	self:showDialog( "I'll have the \"All you Can Meat special.\" with a side of meat." );
end


local SteakingAClaim = function( self )
	--self:playCharacterAnimation( "happy" )
	self:showDialog( "I was worried for a second that you would make the incorrect choice." );
	self:addPoints( 2 );
end


local SalAdd = function( self )
	--self:playCharacterAnimation( "angry" )
	self:showDialog( "I did not realize I was out with a-" );
	--self:playCharacterAnimation( "shakeydoo" );
	--self:waitForCharacterAnimation();
	self:showDialog( "-vegetarian." );
	self:addPoints( -2 );
end


local GottaGoFilm = function( self )
	self:addPoints( 2 );
	self:showDialog( "Yes, film is the only way to go." );
	--self:playCharacterAnimation( "angry" );
	self:wait( 1 );
	self:showDialog( "The only way.", { wobbly = true } );
end


local TheDigitalFuture = function( self )
	--self:playCharacterAnimation( "idle" );
	self:showDialog( "Do you not think photos lose their authenticity on digital?" );
	--self:playCharacterAnimation( "sad" );
	self:showDialog( "The future is grim for photography." );
	self:addPoints( -2 );
end


local FilmTime = function( self )
	self:showDialog( "I like to enfuse my shots with an aesthetically pleasing grain. The grain adds a tasteful extra dimension to a photo. It evokes a certain charm and personality which is otherwise lacking." );
	self:showDialog( "It's also very important to shoot in natural light. All the fake Hollywood trickery you see nowadays ruins the purity of a shot." );
	self:showChoice( "Do you have a favorite medium for picture taking?", { { "I prefer film.", GottaGoFilm },
		{ "Digitize me, baby.", TheDigitalFuture } } );
end


local ProfilePicDistraction = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "Thank you! I took that picture myself!" );
	FilmTime( self );
end


local HobbyMaybe = function( self )
	--self:playCharacterAnimation( "happy" );
	self:showDialog( "I have a passion for photography." );
	FilmTime( self );
end


local DevilSpiel = function( self )
	--self:playCharacterAnimation( "happy" );
	self:showDialog( "You've heard of him, yes?" );
	self:setDialogSpeed( 16 );
	self:showDialog( "He is Lucifer.", { ignoreInput = true }  );
	self:setDialogSpeed( 19 );
	self:showDialog( "Prince of Darkness.", { ignoreInput = true }  );
	self:setDialogSpeed( 23 );
	self:showDialog( "Gatekeeper of the Great Below.", { ignoreInput = true } );
	self:setDialogSpeed( 29 );
	self:showDialog( "Father of Lies.", { ignoreInput = true } );
	self:setDialogSpeed( 33 );
	self:showDialog( "Lord of the Underworld.", { ignoreInput = true } );
	self:setDialogSpeed( 37 );
	self:showDialog( "Inspiration of \"The Number of the Beast\".", { ignoreInput = true } );
	self:setDialogSpeed( 40 );
	self:showDialog( "Master Herbalist.", { ignoreInput = true } );
	self:setDialogSpeed( 42 );
	self:showDialog( "Source of all evil. That includes demons! He made my father's father, who made my father, who made me!", { ignoreInput = true } );
	self:setDialogSpeed( 16 );
	self:showDialog( "The Devil.", { wobbly = true } );
	self:setDialogSpeed( 28 );
end


local CloseFather = function( self )
	--self:playCharacterAnimation( "shock" );
	self:addPoints( 4 );
	self:showDialog( "You must tell me how I can achieve something similar with the allfather!" );
	DevilSpiel( self );
end


local LikeDad = function( self )
	--self:playCharacterAnimation( "idle" );
	self:addPoints( 1 );
	self:showDialog( "I wish I could get along well with the allfather." );
	DevilSpiel( self );
end


local NoDadPlease = function( self )
	--self:playCharacterAnimation( "angry" );
	self:addPoints( -2 );
	self:showDialog( "You squander your potential!" );
	self:showDialog( "Mortals are easy to get along with. I must attempt to create a relationship with the allfather!" );
	DevilSpiel( self );
end


local GoodEnough = function( self )
	--self:playCharacterAnimation( "idle" );
	self:addPoints( 1 );
	self:showDialog( "I thank you for your kind words, but I do not need to be patronized. I am the King of the Seventh Circle of Hell." );
end


local HappyAndSafe = function( self )
	self:wait( 2 );
	--self:playCharacterAnimation( "idle" );
	self:wait( 0.5 );
	--self:playCharacterAnimation( "sad" );
	self:wait( 0.5 );
	--self:playCharacterAnimation( "idle" );
	self:wait( 0.5 );
	--self:playCharacterAnimation( "sad" );
	self:wait( 0.5 );
	
	self:showDialog( "\n\nHappy and safe?", { wobbly = true } );
	self:wait( 0.5 );
	self:showDialog( "So you're saying I'm no demon at all. Lucifer will never notice me." );
	self:addPoints( -3 );
end


local Compromise = function( self )
	--self:playCharacterAnimation( "idle" );
	self:showDialog( "You might be right. Thank you for listening to an old goat rant." );
end


local EvilLaugh = function( self, pointsToAdd )
	self:wait( 2 );
	--self:playCharacterAnimation( "idle" );
	self:wait( 0.5 );
	self:addPoints( pointsToAdd );
	--self:playCharacterAnimation( "happy" );
	self:wait( 0.5 );
	--self:playCharacterAnimation( "idle" );
	self:wait( 0.5 );
	--self:playCharacterAnimation( "happy" );
	self:wait( 0.5 );

	self:setDialogSpeed( 8 );
	self:showDialog( "GWA HA HA HA HA HA", { wobbly = true, ignoreInput = true } );
	self:setDialogSpeed();
end


local BestLaidPlans = function( self )
	EvilLaugh( self, 8 );
	self:showDialog( "You're no mere mortal. I sense a demonic presence in you." );
	self:showDialog( "AND I LOVE IT!" );
	self:showDialog( "This plan of yours will surely work. I shall make preparations immediately after our date!" );
end


local YouTortureMe = function( self )
	EvilLaugh( self, 4 );
	self:showDialog( "Then I am the truest demon! To ellicit such a reaction from you is a great honor." );
	self:showDialog( "If I can make you feel that way, then I can surely make Lucifer notice me instead of cousin Cha'zir!" );
	--self:playCharacterAnimation( "angry" );
	self:showDialog( "He has always liked Cha'zir better." );
	self:showChoice( "< He's seething >", { { "Surely there's room in the heart of a god for more than one demon.", Compromise },
		{ "Okay, here's the plan. Let's murder your cousin, dump the body and you can slip into his position at Lucifer's side.", BestLaidPlans } } );
end


local BookIt = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 1 );
	self:showDialog( "That is just what I was thinking. Let's explode this stand of popsicles." );
end


local IWillPay = function( self )
	--self:playCharacterAnimation( "happy" );
	self:addPoints( 6 );
	self:showDialog( "I see money is not a problem for you. Very interesting." );
end


local LetHimPay = function( self )
	--self:playCharacterAnimation( "angry" );
	self:addPoints( -2 );
	self:showDialog( "Your weakness disappoints me. I will pay your bill if I must." );
	self:showDialog( "< Dae will remember that >" );
end


local DinnerDate = function( self )
	self:fadeIn( 3 );
	self:setBackground( gAssets.BG.dinner );

	if self.movieAnswer == 0 then
		--self:playCharacterAnimation( "angry" );
		self:showDialog( "Angels! Why did it have to be angels! I can not stand angels." );
		self:showDialog( "Their gross little wings." );
		self:showDialog( "Their sickening holly jolly attitude." );
		self:showDialog( "Those horrible smiles.", { wobbly = true } );
		self:wait( 1.5 );
		--self:playCharacterAnimation( "sad" );
		self:showDialog( "\n\nThey haunt my dreams..." );
		self:addPoints( -4 );
	elseif self.movieAnswer == 1 then
		--self:playCharacterAnimation( "happy" );
		self:addPoints( 4 );
		self:showDialog( "I LOVE DOGS!", { wobbly = true } );
		self:showDialog( "It may not be fashionable for a demon to say that." );
		self:wait( 1 );
		self:showDialog( "\nBUT THEY'RE SO FLUFFY!", { wobbly = true } );
	else
		--self:playCharacterAnimation( "shock" );
		self:showDialog( "I thought the title was in jest!" );
		self:showDialog( "An entire movie about laughing children, and not one was in pain!" );
		self:addPoints( -2 );
		--self:playCharacterAnimation( "idle" );
		self:showDialog( "How would you correct the mistakes of those filmmaking fools?" );
		self:showChoice( "< He's deep in thought >", { { "Slowly lower the children into a pit of lava.", LavaPit },
			{ "Drain the blood of the children into a bowl, then bathe in it.", BowlBlood },
			{ "Place the children into iron maidens.", IronMaiden } } );
	end

	self:showDialog( "What kind of base nourishment do they have at this establishment?" );
	self:showChoice( "< He's sifting through the menu >", { { "Order his food for him.", StealOrder }, 
		{ "Let him take his time.", TakeTime } } );

	self:showChoice( "< The waiter is looking at you >", { { "A steak please.", SteakingAClaim },
		{ "I'm in a health mood. Give me salad.", SalAdd } } );

	self:showDialog( "Meals are one of the only times of the day when I do not think of torture and suffering." );
	self:showChoice( "< He's lost in thought >", { { "Do you have any non-torture hobbies?", HobbyMaybe },
		{ "You know, your look fantastic in your profile picture.", ProfilePicDistraction } } );

	--self:playCharacterAnimation( "idle" );
	self:showDialog( "We speak too much of Dae. I must hear more of you." );
	self:showDialog( "Do you have a good relationship with your father?" );
	self:showChoice( "< He's looking at you, but also not?", { { "My father and I are extremely close. He's actually waiting in my car right now.", CloseFather }, 
		{ "I like my dad. He's a pretty cool guy.", LikeDad },
		{ "I could take him or leave him.", NoDadPlease } } );

	--self:playCharacterAnimation( "sad" );
	self:showDialog( "How can I possibly be a good enough demon for Beelzebub himself?" );
	self:setDialogSpeed( 12 );
	self:showDialog( "\nDo you think I'm good enough?", { wobbly = true, ignoreInput = true } );
	self:setDialogSpeed();
	self:showChoice( "Uh oh", { { "You are good enough.", GoodEnough }, 
		{ "You make me feel happy and safe.", HappyAndSafe },
		{ "Being with you is torturous.", YouTortureMe } } );

	self:showDialog( "< The waiter gingerly places the check on the table >" );
	self:showDialog( "Our dinner is over already? Time moves quickly when a demon fraternizes with a mortal." );

	if self.noMoMoney then
		self:showChoice( "You could pay for the bill, if you didn't spend all your money on concessions.", 
			{ { "I have no money, let's run!", BookIt },
			{ "I have no money, can you cover me?", LetHimPay } } );
	else
		self:showChoice( "It's do or die.", 
			{ { "Offer to pay for dinner.", IWillPay },
			{ "Wouldn't it be more fun if we just ran?", BookIt },
			{ "I have no money, can you cover me?", LetHimPay } } );
	end

	self:fadeOut( 3 );
end


local run = function( self )
	--PlayNarration( self );
	--self:stopMusic( gAssets.MUSIC.narration );
	--PresentGoatDatingProfile( self );
	--TheaterDate( self );
	self.movieAnswer = 0;
	DinnerDate( self );
end


GoatDateScene.new = function()
	return Scene.new( run );
end


return GoatDateScene;