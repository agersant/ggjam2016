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
	if self.movie == "tacos" then
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
	self:addPoints( 3 );
	self:setDialogSpeed( 8 );
	self:showDialog( "< ... >", { ignoreInput = true, } );
	self:setDialogSpeed();
	self:showDialog( "< The babbling intensifies! >" );
	self:wait( 1 );
	self:showDialog( "< Minnie has decided to intervene >" );
	self:playCharacterAnimation( "angry" );
	self:wait( 2 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "O M G! You guys have like, no idea what you're talking about." );
	self:showDialog( "If you think Joey Pellagio has a nose like a potato, well you should look at Samantha Flutter more closely. Her nose is like, twice that size." );
	self:wait( .5 );
	self:playCharacterAnimation( "angry" );
	self:wait( .5 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "And it's shaped more like an artichoke too. Seriously, it totally is. Don't you trash talk Joey like that, he's such a sweetheart and he's the best thing on screen in this movie." );
	self:setDialogSpeed( 50 );
	self:showDialog( "I know because my dad organized a party for his company two years ago and he invited Joey and also other stars and they all were like d", { ignoreInput = true} );
	self:showDialog( "< Before she can continue, you are asked by a manager to leave the theater >", {} );
	self.kicked = true;
end

local PleaseLeave = function( self )
	self:wait( 1 );
	self:showDialog( "I don't think you really had to do that." );
	self:wait( .5 );
	self:showDialog( "They were just enjoying the movie with their friends." );
	self:addPoints( -2 );
	self:showDialog( "< You watch the rest of the movie peacefully >" );
end

local BeQuiet = function( self )
	self:addPoints( 2 );
	self:showDialog( "<You ask the other spectators to be quiet.>" );
	self:wait( .5 );
	self:showDialog( "Thanks, these guys were like, so annoying." );
	self:showDialog( "Joey Pellagio doesn't even have a big nose, lol! They have no idea what they're talking about." );
	self:showDialog( "< You watch the rest of the movie in peace >" );
end

local WatchMovie = function( self )
	self:fadeOut( 2 );
	self:setBackground( gAssets.BG.theater2 );
	self:fadeIn( 1 );
	self:showDialog( "< While the movie is playing, the people next to you start talking about how the lead actor's nose looks like a potato >" );
	self:showChoice( "How will you react?", {
		{ "Politely ask them to be quiet.", BeQuiet },
		{ "Ignore them.", IgnoreThem },
		{ "Kick their popcorn over and scream at them to leave the theater.", PleaseLeave },
	} );
	PostMovie( self );
end

local KungFuTacos = function( self )
	self.movie = "tacos";
end

local AloneWilderness = function( self )
	self.movie = "alone";
end

local ChopChop = function( self )
	self.movie = "chop";
end

local PickMovie = function( self )
	local score = self:getPoints();
	if score > 15 then
		self:showDialog( "< You feel a bond forming between the two of you >" );
	end
	self:playCharacterAnimation( "happy" );
	self:showDialog( "We should like, totally get moving for the movie! Hurry up!" );
	self:playCharacterAnimation( "idle" );
	self:showChoice( "Which movie will you suggest?", {
		{ "Kung-fu Tacos!", KungFuTacos },
		{ "Alone in the Wilderness", AloneWilderness },
		{ "Industri4l Slaughterhouse 4: Return to chop-chop town", ChopChop },
	} );
	self:wait( 1 );
	self:showDialog( "Oh! I didn't think you would choose that! And I haven't seen it before!" );
	WatchMovie( self );
end

local BeefJerky = function( self )
	self:addPoints( -2 );
	self:playCharacterAnimation( "angry" );
	self:wait( 2 );
	self:playCharacterAnimation( "idle" );
	self:setDialogSpeed( 8 );
	self:showDialog( "Eeeeew.", { ignoreInput = true, } );
	self:wait( 2 );
	self:setDialogSpeed();
	self:showDialog( "Beef jerky is like so gross.", { wobbly = true } );
	self:showDialog( "People who eat it are like, totally the worst. Why would you do that? It's like if a cabbage was eating sun-dried tomatoes? Wouldn't that be weird? I don't know, it just grosses me out." );
	self:showDialog( "I used to eat meat, but I was always like, totally disgusted by it." );
	self:showDialog( "My friend Matt says that when he becomes like King President of the country he'll make meat illegal. But I don't think he'll remember it, because he's like so forgetful. He even forgot where he parked his car at the mall once, lol!" );
end

local Milkshakes = function( self )
	self:addPoints( 1 );
	self.gotMilk = true;
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Milkshakes? Wow, that's totally kinky." );
	self:showDialog( "But it's good, I like it!", { wobbly = true } );
	self:showDialog( "I didn't really expect you to make things move so quickly between us, but I guess, uh, you know me already!" );
	self:showDialog( "It reminds me of how my friend Jenny always knows the best latte every season at StairBux. She's like totally a PSYCHIC. Once she told me I'd be cold wearing shorts and then I totally was. She's magical." );
	self:wait( 1 );
	self:showDialog( "< You seem to have brought this girl to the yard >" );
end

local NoJunkFood = function( self )
	self:addPoints( -1 );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "I guess you're right." );
	self:wait( .5 );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Have you noticed how food seems to taste better when you're really hungry? Sometimes I try to eat grass with my mouth at a weird angle so it will all go into the same stomach and then later I can fill the other ones with tofu tacos." );
	self:setDialogSpeed( 36 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "Then the tofu tacos are like so delicious I can't stop eating them. It's kinda like that time when my friend Robert took Jenny, Jessica, Patty and I to the aquarium and Jessy wouldn't stop eating those carrot dumpling enchiladas." );
	self:setDialogSpeed( 45 );
	self:showDialog( "She ate so many that her face became a tomato. Have you ever eaten so much food that your face becomes a weird color? It happens to her like all the time. It's totally weird but like, in a way that's not creepy. Whatever.", { ignoreInput = true } );
	self:setDialogSpeed();
end

local Concessions = function( self )
	-- TODO, if rework, allow a question about her friends here
	self:wait( 1 );
	self:showDialog( "I'm like so hungry right now. We should totally get something to eat for the movie. I need to keep all these stomachs busy you know." );
	self:showChoice( "What will you do?", {
		{ "We should save room for the restaurant.", NoJunkFood },
		{ "Offer to buy beef jerky.", BeefJerky },
		{ "Offer to buy milkshakes.", Milkshakes },
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
	self:showDialog( "Like...wow.", { ignoreInput = true } );
	self:wait( 1 );
	self:setDialogSpeed();
	self:playCharacterAnimation( "sad" );
	self:showDialog( "I didn't think you would say that." );
	self:playCharacterAnimation( "angry" );
	self:showDialog( "Maybe my friend Amanda was right and I shouldn't have come to this date. You're like, so disappointing." );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "Whatever." );
end

local Beach = function( self )
	self:playCharacterAnimation( "hyped" );
	self:addPoints( 4 );
	self:showDialog( "OMG! OMG! We have like so much in common! I'm a huuuuuuuge beach person, like really. My friend Stephen once told my friend Jessica that he saw my friend Jennifer at the beach once, and since I wasn't there she was totally freaking out, as if." );
	self:playCharacterAnimation( "happy" );
	self:setDialogSpeed( 36 );
	self:showDialog( "So he was like, \"What the duck?\". And she totally kept going for ages. Like how the beach isn't really the beach if I'm not there because I'm like, the main event. She was like so mad. So Stephen told my friend Jerry that Jenny was nuts. And you know what she did?" );
	self:setDialogSpeed( 50 );
	self:showDialog( "She like totally threw a starfish at him! :/\\ As if. I don't know why she would even pick up a starfish in the first place, duh, they're so gross. And they have like a million legs. They better not skip leg day like Stephen always does.", { ignoreInput = true } );
	self:setDialogSpeed( 60 );
	self:showDialog( "I always tell my friends not to skip leg day otherwise they could end up looking like way gross, ;^] but Stephen like never listens to what my other friends say so yeah now he totally looks like that starfish, LOL!", { ignoreInput = true } );
	self:showDialog( "And you know what, my friend Patrick told me yesterday", { ignoreInput = true } );
	self:setDialogSpeed();
	self:playCharacterAnimation( "happy" );
	self:showDialog( "< She's still talking >" );
	self:playCharacterAnimation( "idle" );
end

local Puzzles = function( self )
	self:addPoints( 2 );
	self:showDialog( "ROFLMAO, it's funny you mention that. I'm really good at solving mazes, my friends say there's nothing I can do better than mazes. You wouldn't believe how hard that is, lol!" );
end

local AboutYourself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "So...what about you? I mean like, what kind of stuff are you into?" );
	self:wait( .5 );
	self:showChoice( "It looks like it's your turn to say something.", {
		{ "I'm a huge fan of Texas barbecue. I live for the brisket.", Brisket },
		{ "I'm more of an outdoor person, nothing beats the beach.", Beach },
		{ "I'm the cerebral type, I solve puzzles and riddles.", Puzzles },
	} );
	Concessions( self );
end

local RentMusicVideos = function( self )
	self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "O M G!! Really? That is just like me! I watch music videos all day when I should be helping customers at the store. I'm a big fan of Jigsawchain Puzzle Records and Atomium Organic Sound System. And my friends love them too!" );
	self:showDialog( "They're so haaawt! Like I can't stop listening!" );
	self:playCharacterAnimation( "idle" );
end

local WhatIsVHS = function( self )
	self:playCharacterAnimation( "shocked" );
	self:addPoints( -2 );
	self:showDialog( "Wow." );
	self:wait( 1 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "VHS are like...so hawt right now. You should totally check it out, DUH, it's like vinyl but less-old and gross and it has pictures. I feel so ^_^ just talking about it." );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "How do tou not know VHS? What do you even DO all day?" );
	self:playCharacterAnimation( "idle" );
end

local WishDadRich = function( self )
	self:addPoints( 2 );
	self:showDialog( "I know, right? My friends are soooooo jealous :3. The other day my friend Stephen told me that he heard from Amanda that she would totally dump her family to live with me and my dad." );
	self:showDialog( "That would be so rad!!", { wobbly = true, } );
end

local IntroducesHerself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "So yeah. My name is Minnie Crete, but my friends call me Minnie-T, so I guess you can call me Minnie-T. I guess. I work in my dad's VHS rental store." );
	self:showDialog( "My dad doesn't JUST own the VHS store lol. He's super rich so he owns like half the town. This theater is totally his also." );
	self:wait( .5 );
	self:showChoice( "< She looks very proud >", {
		{ "That's awesome, I rent music videos all the time.", RentMusicVideos },
		{ "What's a VHS?", WhatIsVHS  },
		{ "I wish my dad was that loaded.", WishDadRich },
	} );
	AboutYourself( self );
end

local NeverKnow = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I was totally freaking out on my way here!! Online dates are like, so spooky. My friend Amanda told me not to come because you could be some, like, carnivorous wacko but I mean like, whatever." );
	IntroducesHerself( self );
end

local NiceToMeetYou = function( self )
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "O M G! When you said that, you sounded totally like my friend Amanda. Like, totally the same." );
	IntroducesHerself( self );
end

local TheaterDate = function( self )
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
	self:showDialog( "Hey! Sorry, I was, like, totally not sure you were the right person! You look way different from your DP!" );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Nice to meet you!", { wobbly = true } );
	self:showChoice( "< She looks energetic >", {
		{ "Yeah, you never know with online dates.", NeverKnow },
		{ "Nice to meet you too!", NiceToMeetYou },
	} );
end


local ConfirmProfile;
ConfirmProfile = function( self )
	self:waitForMainInput();
	self:showChoice( "Did you memorize the key information about your date?", {
		{ "I'll take another look", ConfirmProfile },
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
	self:showNarration( "How did you like your first date?", { } );
	self:wait( 1 );
	self:showNarration( "They say exorcists only master the art of dating after a few hundred. \nDon't stress out." );
	self:wait( 1 );
	self:showNarration( "Here is the profile of the next demon to romance." );
	self:stopMusic( gAssets.MUSIC.narration );
	PresentDatingProfile( self );
end

local FailMinnie = function( self )
	self:playCharacterAnimation( "angry" );
	self:wait( 2 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I don't think I'm feeling too well. I think I'm going to head home." );
	self:wait( 2 );
	self:showDialog( "I'll talk to you like, later." );
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