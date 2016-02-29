local Scene = require( "src/Scene" );
local Minnie = require( "src/content/portraits/Minnie" );
local FinalScene = require( "src/content/FinalScene" );


local MinnieDateScene = {};

local ReportCard = function( self, tragicEnd )
	local success;
	local rate = self:getPoints() / self.maxPoints;
	if tragicEnd then
		success = false;
	else
		success = rate > self.winRate;
	end
	self:playMusic( gAssets.MUSIC.narration );
	self:setBackground( gAssets.BG.black );
	self:showReport( success, rate );
	self:setCharacter();
	self:fadeIn( 1 );
	self:waitForMainInput();
	ChangeScene( FinalScene.new() );
end

local Hug = function( self )
	local rate = self:getPoints() / self.maxPoints;
	local success = rate > self.winRate;
	if success then
		self:showDialog( "< You feel the warmth and the smell of her fur as you get close to her. >", { ignoreInput = true, } );
		self:wait( 4 );
		self:showDialog( "< In a way, this is almost romantic. >", { ignoreInput = true, } );
		self:wait( 4 );
		self:showDialog( "< But business is business, and this date has come to an end. >", { ignoreInput = true, } );
		self:playCharacterAnimation( "hyped" );
		self:playSuccessFX();
		self:wait( 3 );
		self:playSuccessFX();
		self:setDialogSpeed( 8 );
		self:playCharacterAnimation( "exit" );
		self:showDialog( "Thank you so much!!!", { wobbly = true, ignoreInput = true, } );
		self:wait( 5 );
		self:fadeOut( 7 );
	else
		self:showDialog( "I don't think we're that close to each other. Could you like, keep your distances for the time being. Ok, please?" );
		self:wait( 1 );
		self:showDialog( "Thanks for the evening. I'll talk to you, like later." );
	end
	ReportCard( self );
end

local GetGoing = function( self )
	self:showDialog( "Thanks for the evening. I'll talk to you, like later." );
	ReportCard( self, false );
end

local ListenAllDay = function( self )
	self:addPoints( 4 );
	self:playCharacterAnimation( "hyped" );
	self:showDialog( "Awwwww! You're so nice.", { wobbly = true } );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "It reminds me of that time when Jenny and I went to the gym and she spilled a coke latte on her couch, like all over him. It was so gross but the coach was so sweet about it. I heard from Stephen that the coach is really into organic food and indie Pop music so he like, eats a lot of quinoa and I heard quinoa makes people real chill." );
	-- TODO more shit
	self:showChoice( "Time for your true final move!", {
		{ "Hug her.", Hug },
		{ "It's late I think we should get going.", GetGoing },
	} );
end

local SorryLonely = function( self )
	self:showDialog( "I always feel so alone, it's probably because I spend so much time in the maze. Also there's like no one ever at the VHS rental store. Fireflix stole all our customers long ago.", {} );
	self:showDialog( "So I spend most of my time there like, watching the cool music videos.", {} );
	self:wait( 1 );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "I really shouldn't say any of that on a date. I'm like so sorry.", { wobbly = true } );
	self:showDialog( "But I like that you're always listening to me. My friend Stephen never listens to anyone else, lol.", {} );
	self:playCharacterAnimation( "idle" );
	self:wait( 1 );
	self:showChoice( "Time for your final move", {
		{ "It's late I think we should get going.", GetGoing },
		{ "Hug her.", Hug },
		{ "I could listen to you all day", ListenAllDay },
	} );
end

local WhatFriends = function( self )
	self:addPoints( 2 );
	self:showDialog( "Well." );
	self:wait( 1 );
	self:showDialog( "To tell you the truth, I don't see them that often." );
	self:wait( 1 );
	self:showDialog( "I don't know if I should be telling you this but...", { wobbly = true } );
	self:showDialog( "I've like, never met Stephen, Jenny and Amanda.", { wobbly = true } );
	self:wait( 1 );
	self:showDialog( "I totally wish they were my friends for real.", {} );
	SorryLonely( self );
end

local ParkingLot = function( self )
	self:setBackground( gAssets.BG.parking );
	self:playMusic( gAssets.MUSIC.parkingLot );
	self:fadeIn( 3 );
	if self.gotMilk or self.quesadilla then
		self:showDialog( "< Minnie-T looks very pale, it seems she isn't feeling well. >" );
		self:wait( 1 );
		if self.gotMilk and self.quesadilla then
			self:showDialog( "< You wonder if it's related to these dairy products she's been eating throughout the date. >" );
			self:addPoints( -6 );
		else
			self:addPoints( -2 );
		end
	end
	self:showDialog( "I had a pretty good time with you tonight, it was like so much fun." );
	self:wait( 2 );
	self:showDialog( "It's good to hang out with someone else for a while. I'm like, so lonely being lockup by my father all the time." );
	self:showChoice( "Minnie-T seems a bit down.", {
		{ "What about Amanda and your other friends?", WhatFriends },
		{ "I'm sorry you feel lonely.", SorryLonely },
	} );
end

local AskHerSomething = function( self )
	self:showDialog( "< Minnie-T keeps talking on and an about her friends and her hobbies. >" );
	self:showDialog( "< You can barely say anything before the meal comes to an end. >" );
	self:fadeOut( 5 );
	ParkingLot( self );
end

local Penne = function( self )
	self:addPoints( 2 );
end

local Shroom = function( self )
end

local Quesadilla = function( self )
	self.quesadilla = true;
end

local Quinoa = function( self )
	self.quinoa = true;
	self:addPoints( 3 );
end

local OrderFood = function( self )
	self:wait( 1 );
	self:showDialog( "What do you think I should order?" );
	self:showChoice( "Make a suggestion", {
		{ "The tofu quesadilla!", Quesadilla },
		{ "The organic quinoa dumplings", Quinoa },
	} );
	self:showDialog( "Interesting choice, I think I'll go with that!" );
	self:showChoice( "Now your own food order:", {
		{ "Penne Marinara", Penne },
		{ "Portobello Mushroom Burger", Shroom  },
	} );
	self:showDialog( "That sounds totally tasty. I love eating like all sorts of food but there's a lot I can't at all." );
	self:showDialog( "Because I'm a vegetarian.", { wobbly = false } );
	self:showDialog( "And also lactose intolerant.", { wobbly = true } );
	AskHerSomething( self );
end

local FriendsSpiel = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I wish my friend Stephen was with us, he would totally have digged this movie! But then I guess it wouldn't really be a date, lol." );
	self:wait( 1 );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "Sometimes when my friends aren't here, I try to imagine that they are and what their reactions would be. Do you sometimes do that? I hope you don't think it's like creepy or anything. It's a habit I totally picked up when I was SO locked in my father's labyrinth." );
	self:showDialog( "It was like, so rough back then." );
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "Please ignore I said that!!", { wobbly = true } );
	self:playCharacterAnimation( "idle" );
	OrderFood( self );
end

local ConcludeTacos = function( self )
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Also I liked that scene at the end where all the various tacos totally join forces to defeat the big bad burrito. It made me heart beat like, so fast." );
	FriendsSpiel( self );
end

local LoveTacos = function( self )
	self:playCharacterAnimation( "hyped" );
	self:showDialog( "O M G! I'm also like totally a fan of tacos. My friend Patty makes the best tofu tacos in the world. Like really, I've never had better tacos." );
	self:addPoints( 4 );
	ConcludeTacos( self );
end

local PowerFriendship = function( self )
	self:showDialog( "Totally! It's like the most important thing in my life too. Like, I don't know what I would do without my friends Jenny and Stephen." );
	self:addPoints( 4 );
	ConcludeTacos( self );
end

local FightBear = function( self )
	self:showDialog( "I don't know about that, lol. I think the bear was like totally cute." );
	self:showDialog( "Not cute like in a romantic way, but still kinda cute like you'd want to hug it and protect it. I don't know, I think animals are cute, it's sad you have to fight them sometimes." );
	self:showDialog( "Like that one time when my friend Jenny threw a starfish at my other friend, and then the starfish got all mad at us." );
	self:addPoints( -2 );
	self:showDialog( "It was like, so totally weird. But we had a good time with my friends that day." );
	FriendsSpiel( self );
end

local Brutal = function( self )
	self:playCharacterAnimation( "angry" );
	self:showDialog( "You're such a monster, lol. We're like completely different you and I." );
	self:addPoints( -4 );
	self:playCharacterAnimation( "idle" );
	self:wait( 1 );
	self:showDialog( "But it's ok, it's like totally cool not to be into the sane things all the time. I have so many friends, we can't be all alike, lol! Like my friend Amanda is so weird, sometimes she wears a tutu to her job. And she's like a lawyer." );
	FriendsSpiel( self );
end

local Psychology = function( self )
	self:showDialog( "You think so? All they did was scream at each other and getting dismembered" );
	self:showDialog( "I was like, so spooked the whole time. My friend Stephen is into that kind of movie, but I think they're like, so weird. So he said to me \"You like broccoli right? Well I think THAT's gross.\" And I was like wow, it's like different people can totally be into different stuff." );
	self:addPoints( -2 );
	self:wait( 1 );
	self:showDialog( "Isn't it beautiful?", { ignoreInput = true, wobbly = true, } );
	self:wait( 1 );
	FriendsSpiel( self );
end

local PostMovie = function( self )
	self:fadeOut( 2 );
	self:setBackground( gAssets.BG.black );
	self:fadeIn( 2 );
	self:showDialog( "< There are funny sounds coming from Minnie-T's belly. >" );
	self:wait( .5 );
	if self.gotMilk then
		self:showDialog( "< You wonder if that's related to the milkshakes. >" );
	else
		self:showDialog( "< Maybe she's a bit hungry. You decide to go to the restaurant. >" );
	end
	self:fadeOut( 2 );
	self:setBackground( gAssets.BG.dinner );
	self:playMusic( gAssets.MUSIC.dinner );
	self:fadeIn( 2 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "So like, what did you think of the movie?" );
	if self.kicked then
		self:showDialog( "I wish we got to see the whole thing." );
	end
	self:playCharacterAnimation( "idle" );
	local choices = {};
	if self.movie == "cardinal" then
		table.insert( choices, { "I loved it, it shows the power of friendship is invincible.", PowerFriendship } );
		table.insert( choices, { "I loved it, I'm a big fan of martial arts and tacos.", LoveTacos } );
	end
	if self.movie == "alone" then
		table.insert( choices, { "I loved it, it really makes you think about friendship.", PowerFriendship } );
		table.insert( choices, { "I loved it, it's cool how he fought the bear at the end.", FightBear } );
	end
	if self.movie == "chop" then
		table.insert( choices, { "I loved it, it was brutal just like me.", Brutal } );
		table.insert( choices, { "I loved it, the psychology of the characters was so deep.", Psychology } );
	end
	self:showChoice( "Your thoughts on the movie", choices );
end

local IgnoreThem = function( self )
	self:addPoints( -2 );
	self:setDialogSpeed( 8 );
	self:showDialog( "< ... >", { ignoreInput = true, } );
	self:setDialogSpeed();
	self:showDialog( "< The babbling intensifies! >" );
	self:wait( 1 );
	self:playCharacterAnimation( "angry" );
	self:showDialog( "< Uhh, what is she doing? >" );
	self:showDialog( "You guys have like, no idea what you're talking about!" );
	self:showDialog( "If you think Joey Pellagio looks bad, you should see his second ex-wife Hunter Harrington." );
	self:showDialog( "Could you say that you would look as good as him after seven public and embarassing divorces?")
	self:showDialog( "Don't you trash talk Joey like that, he's a sweetheart and he's the best thing in this movie." );
	self:showDialog( "You know what? Maybe we should take this outside! I doubt your face will look half as good as Joey's after I'm through with you! Come on, let's-" );
	self:showDialog( "< Before she can continue, you are asked by a manager to leave the theater >" );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Oops." );
	self:showDialog( "Well, that movie sucked anyways." );
	self.kicked = true;
end

local PleaseLeave = function( self )
	self:wait( 1 );
	self:addPoints( -3 );
	self:showDialog( "Wow, I'm impressed at how far you managed to kick that bucket of popcorn." );
	self:showDialog( "Still, you didn't need to do that." );
	self:showDialog( "They were just trying to enjoy the movie with their friends." );
	self:playCharacterAnimation( "angry" );
	self:showDialog( "But maybe they deserved it for dissing Joey Pellagio! After the year he's had, how dare they?", { wobbly = true } );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "< You watch the rest of the movie peacefully >" );
end

local BeQuiet = function( self )
	self:addPoints( 2 );
	self:wait( .5 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Thanks, they were so annoying." );
	self:showDialog( "Joey Pellagio is way better looking now." );
	self:showDialog( "His new nose really brings out the grassy color of his eyes." );
	self:showDialog( "And the facelift he got last year makes you forget that he's actually seventy years old." );
	self:showDialog( "Those chumps have no idea what they're talking about. They're just like his first ex-wife Nancy Fleeceful." );
	self:showDialog( "You know, I really never thought she was good for him. She-" );
	self:showDialog( "< A man behind you politely asks you to be quiet >" );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "Sorry!" );
end

local WatchMovie = function( self )
	self:fadeOut( 2 );
	self:setBackground( gAssets.BG.theater2 );
	self:playCharacterAnimation( "idle" );
	self:fadeIn( 1 );
	self:showDialog( "< The people next to you start talking about how the lead actor was better looking in the 90s >" );
	self:showChoice( "< They won't shut up >", {
		{ "Politely ask them to be quiet.", BeQuiet },
		{ "Ignore them.", IgnoreThem },
		{ "Kick their popcorn over and scream at them.", PleaseLeave },
	} );
	PostMovie( self );
end

local KungFuCardinals = function( self )
	self.movie = "cardinal";
end

local AloneWilderness = function( self )
	self.movie = "alone";
end

local ChopChop = function( self )
	self.movie = "chop";
end

local PickMovie = function( self )
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Now that we've settled the food situation, we should totally get moving for the movie! Hurry up!" );
	self:playCharacterAnimation( "idle" );
	self:showChoice( "Which movie will you suggest?", {
		{ "Kung-fu Cardinals!", KungFuCardinals },
		{ "Alone in the Wilderness", AloneWilderness },
		{ "Industri4l Slaughterhouse 4: A Cut Above", ChopChop },
	} );
	self:wait( 1 );
	self:showDialog( "Oh! Nice choice! I haven't seen it before!" );
	WatchMovie( self );
end


local Milkshakes = function( self )
	self:addPoints( 2 );
	self.gotMilk = self.gotMilk + 1;
	self:playCharacterAnimation( "shocked" );
	self:setDialogSpeed( 10 );
	self:showDialog( "Milkshakes?" );
	self:setDialogSpeed();
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Kinky!", { wobbly = true } );
end


local ManUp = function( self )
	self:addPoints( 1 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Whatever you say Mr. Rich Boy." );
	self:showDialog( "I was going to let you pay for dinner, but I guess you can afford to pay for both!" );
	self:wait( 1 );
	self:showDialog( "<You can't afford to pay for both >", { wobbly = true } );
	self.noMuns = true;	
end


local NoJunkFood = function( self )
	self:addPoints( -1 );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "I guess you're right." );
	self:wait( 1 );
	self:showDialog( "My stomachs are growling." );
	self.hungryLady = true;
	self:setDialogSpeed();
end


local Concessions = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I'm so hungry right now.\n" );
	self:showDialog( "People say these places are super expensive, but I'm super rich, so I'm buying." );
	self:showChoice( "So what do you want to get?", {
		{ "We should save room for the restaurant.", NoJunkFood },
		{ "The chocolate milkshakes are to die for.", Milkshakes },
		{ "Please, I insist, let me pay.", ManUp }
	} );
	PickMovie( self );
end

local Brisket = function( self )
	self:playCharacterAnimation( "shocked" );
	self:addPoints( -4 );
	self:setDialogSpeed( 8 );
	self:showDialog( "So.", { ignoreInput = true } );
	self:wait( 1 );
	self:showDialog( "Gross.", { ignoreInput = true } );
	self:wait( 1 );
	self:showDialog( "Like... wow.", { ignoreInput = true } );
	self:wait( 1 );
	self:setDialogSpeed();
	self:playCharacterAnimation( "angry" );
	self:showDialog( "You are TOTALLY the worst." );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "Maybe my friend Amanda was right about you. You're so disappointing." );
end

local Beach = function( self )
	self:playCharacterAnimation( "hyped" );
	self:addPoints( 4 );
	self:showDialog( "We have like so much in common!" );
	self:showDialog( "I'm a huuuuuuuge beach lady, like really!" );
	self:showDialog( "My friend Jamie once told Jessica that he saw Jennifer at the beach." );
	self:playCharacterAnimation( "happy" );
	self:setDialogSpeed( 36 );
	self:showDialog( "Jennifer was like \"Where the duck is Minnie?\"" );
	self:showDialog( "She said the beach isn't really the beach if I'm not there." );
	self:showDialog( "She said I'm the main event!" );
	self:showDialog( "Tim said Jenny was nuts, and she should just suck it up and enjoy the beach without me." );
	self:showDialog( "But that made Jenny freak out!" );
	self:setDialogSpeed( 50 );
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "She threw a STARFISH at him!" );
	self:showDialog( "I don't know why she would even pick up a starfish in the first place, they're so gross! And they have like, a million legs. Just like the spiders in Sam's apartment.", { ignoreInput = true } );
	self:setDialogSpeed( 60 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Sam always has tons of bugs in her apartment because she never cleans up her food. Her favorite food is bacon, which I can't eat because it gives me stomach cramps.", { ignoreInput = true } );
	self:setDialogSpeed( 80 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "My doctor said that my stomach cramps will go away if I stick to vegetarian food. I'm fine with that because the concept of meat is waaaay gross. I mean, do you really want to eat something that used to live?", { ignoreInput = true } );
	self:playCharacterAnimation( "angry" );
	self:setDialogSpeed( 90 );
	self:showDialog( "Ugghhh, I know plants are also living, but you know what I mean. You're just like this online message board I go to. They always totally freak out if you make a tiny mistake in a post.", { ignoreInput = true } );
	self:setDialogSpeed( 100 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "My friend Patrick says it's because...", { ignoreInput = true } );
	self:setDialogSpeed();
	self:playCharacterAnimation( "happy" );
	self:showDialog( "< She's still talking >" );
	self:wait( 2 );
end

local Puzzles = function( self )
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "A nerd?" );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Tres chic!" );
	self:addPoints( 4 );
	self:showDialog( "Puzzles are cool, but I mostly like mazes." );
	self:showDialog( "I am awesome at solving mazes!" );
	self:showDialog( "My friends all call me \"The GPS\"!" );
	self:showDialog( "And if someone is mean to me..." );
	self:wait( 0.5 );
	self:playCharacterAnimation( "angry" );
	self:showDialog( "I will always find them.", { wobbly = true } );
	self:playCharacterAnimation( "happy" );
end

local AboutYourself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "What kind of stuff are you into?" );
	self:wait( .5 );
	self:showChoice( "< It looks like it's your turn to say something >", {
		{ "I spend all my time eating meat. Brisket is my life.", Brisket },
		{ "I'm a beach person. This tan doesn't come for free.", Beach },
		{ "I'm a huge nerd. I'm always solving puzzles.", Puzzles },
	} );
	Concessions( self );
end

local RentMusicVideos = function( self )
	self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "O M G!", { wobbly = true } ); 
	self:showDialog( "I do the exact same thing! I watch music videos all day even when I'm at the store." );
	self:showDialog( "The customers get upset sometimes, but whatever I just ignore them." );
	self:showDialog( "I mainly listen to pop, hip-hop, RnB, rock, jazz, blues, EDM, death metal, rap, punk, opera, honky tonk, ragtime, techno, folk, holiday, new age, reggae, j-pop, k-pop, c-pop, p-pop, stop pop rock nop, and classical." );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "You know, the normal stuff." );
end

local WhatIsVHS = function( self )
	self:playCharacterAnimation( "shocked" );
	self.donnoVHS = true;
	self:addPoints( -4 );
	self:showDialog( "Wow." );
	self:wait( 1 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "VHS is so hot right now!" );
	self:showDialog( "They are way retro, and retro is IN." );
	self:showDialog( "They're like, just as cool as vinyl, but less old and gross." );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "How do you not know what VHS is? What do you even DO all day?" );
end

local WishDadRich = function( self )
	self:addPoints( 2 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "I know, right? My friends are way jealous." );
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "The other day I caught my friend Stephen trying to take some money from the register at Burning Wings." );
	self:wait( 1 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "He's such a prankster." );
	self:showDialog( "Soooo funny." );
end

local IntroducesHerself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "So yeah." );
	self:showDialog( "My name is Minnie Crete, but my friends call me Minnie-T." );
	self:showDialog( "I work in my dad's FAB-ulous VHS store: Burning Wings." );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "My dad doesn't JUST own the VHS store. He's super rich so he owns like half the town." );
	self:showDialog( "I know what you're thinking." );
	self:showDialog( "Yes, that totally includes this theater." );
	self:showDialog( "I'm a pretty big deal." );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "Don't freak out." );
	if self.badHeart then
		self:wait( 0.5 );
		self:showDialog( "You know, for the sake of your heart." );
	end
	self:playCharacterAnimation( "happy" );
	self:showChoice( "< She looks very proud >", {
		{ "I love that store, I rent music videos from there all the time.", RentMusicVideos },
		{ "What's a Vee Aych Ess?", WhatIsVHS  },
		{ "I wish my dad was that loaded.", WishDadRich },
	} );
	AboutYourself( self );
end

local NeverKnow = function( self )
	self:playCharacterAnimation( "shocked" );
	self:addPoints( 1 );
	self:showDialog( "\nYOU ARE SO RIGHT!", { wobbly = true } );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "I was freaking out on my way here! Online dates are SCARY." );
	self:showDialog( "My BFF Amanda told me not to come because you could be some predatory wacko!" ); 
end

local NiceToMeetYou = function( self )
	self:playCharacterAnimation( "happy" );
	self:addPoints( 2 );
	self:showDialog( "You're right, it's totally nice to meet me." );
	self:wait( 0.5 );
	self:showDialog( "I'm..." );
	self:wait( 0.5 );
	self:showDialog( "The..." );
	self:wait( 0.5 );
	self:showDialog( "BEST!", { wobbly = true } );
end

local BadHeart = function( self )
	self.badHeart = true;
	self:addPoints( -2 );
	self:playCharacterAnimation( "shocked" );
	self:wait( 0.5 );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "Sorry..." ); 
	self:showDialog( "This is just..." );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "What I'm like..." );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Your heart is just going to have to deal with it!", { wobbly = true } );
end

local TheaterDate = function( self )
	self.gotMilk = 0;
	self:setBackground( gAssets.BG.theater );
	self:playMusic( gAssets.MUSIC.theater );
	self:setCharacter( Minnie );
	self:playCharacterAnimation( "idle" );
	self:fadeIn( 3 );
	self:setIntroText( "Posh Greek Princess:\nMinnie-T" );
	self:introTextFadeIn( 1 );
	self:wait( 2 );
	self:introTextFadeOut( 2 );
	self:setDialogSpeed();
	self:showDialog( "Hey!" );
	self:showDialog( "Sorry, I was, like, totally not sure you were the right person!\nYou look way different from your pic!" );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Nice to meet you!", { wobbly = true } );
	self:showChoice( "< She's bursting with energy >", {
		{ "Yeah, you never know with online dates.", NeverKnow },
		{ "Nice to meet you too!", NiceToMeetYou },
		{ "Please tone it down, I have a bad heart.", BadHeart },
	} );
	IntroducesHerself( self );
end


local ConfirmProfile;
ConfirmProfile = function( self )
	self:waitForMainInput();
	self:showChoice( "Did you memorize the key information about your date?", {
		{ "I'll take another look.", ConfirmProfile },
		{ "I'm ready to go!", TheaterDate },
	} );
end

local PresentDatingProfile = function( self )
	self:fadeOut( 1 );
	self:setBackground( gAssets.BG.profileMinnie );
	self:fadeIn( 2 );
	self:wait( .5 );
	ConfirmProfile( self );
end

local PlayNarration = function( self )
	self:playMusic( gAssets.MUSIC.narration );
	self:setBackground( gAssets.BG.black );
	self:fadeIn( 3 );
	self:setDialogSpeed( 16 );
	self:showNarration( "I SEE YOU'RE DONE WITH YOUR FIRST DATE" );
	self:wait( 1 );
	self:showNarration( "THEY SAY EXORCISTS ONLY MASTER THE ART OF DATING AFTER A FEW HUNDRED DATES" );
	self:showNarration( "DON'T STRESS OUT", { wobbly = true } );
	self:wait( 1 );
	self:showDialog( "Here is the profile of the next demon to romance." );
	self:stopMusic( gAssets.MUSIC.narration );
	PresentDatingProfile( self );
end

local FailMinnie = function( self )
	self:playCharacterAnimation( "angry" );
	self:wait( 2 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I don't think I'm feeling too well. I'm going to head home." );
	self:wait( 2 );
	self:showDialog( "I'll talk to you later, maybe." );
	ReportCard( self, true );
end


MinnieDateScene.new = function()
	local scene = Scene.new( PlayNarration );
	scene.maxPoints = 30;
	scene.winRate = .7;
	scene.kill = FailMinnie;
	return scene;
end


return MinnieDateScene;