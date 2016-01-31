local Scene = require( "src/Scene" );
local Minnie = require( "src/content/portraits/Minnie" );


local MinnieDateScene = {};

local PostMovie = function( self )
	self:showDialog( "TBC" );
end

local IgnoreThem = function( self )
	self:addPoints( 3 );
	self:showDialog( "<You try to ignore the obnoxious spectators.>" );
	self:setDialogSpeed( 8 );
	self:showDialog( "<...>", { ignoreInput = true, } );
	self:setDialogSpeed();
	self:showDialog( "<The babbling intensifies!>" );
	self:wait( 1 );
	self:showDialog( "<Minnie-T decides to intervene.>" );
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
	self:setDialogSpeed( 40 );
	self:showDialog( "I know because my dad organized a party for his company two years ago and he invited Joey and also other stars and they all were like d", { ignoreInput = true} );
	self:showDialog( "<Before she can continue on, you are asked by a manager to leave the theater.>", {} );
	self.kicked = true;
end

local PleaseLeave = function( self )
	self:showDialog( "<You rudely ask the other spectators to leave.>" );
	self:wait( 1 );
	self:showDialog( "I don't think you really had to do that." );
	self:wait( .5 );
	self:showDialog( "They were just enjoying the movie with their friends." );
	self:addPoints( -2 );
	self:showDialog( "<You watch the rest of the movie peacefully.>" );
end

local BeQuiet = function( self )
	self:addPoints( 2 );
	self:showDialog( "<You ask the other spectators to be quiet.>" );
	self:wait( .5 );
	self:showDialog( "Thanks, these guys were like, so annoying." );
	self:showDialog( "Joey Pellagio doesn't even have a big nose, lol! They have no idea what they're talking about." );
	self:showDialog( "<You watch the rest of the movie peacefully.>" );
end

local WatchMovie = function( self )
	self:fadeOut( 2 );
	self:setBackground( gAssets.BG.black );
	self:fadeIn( 1 );
	self:showDialog( "<While the movie is playing, the spectators next to you start talking about how the lead actor's nose looks like a potato.>" );
	self:showChoice( "How will you react", {
		{ "Ignore them.", IgnoreThem },
		{ "Politely ask them to be quiet.", BeQuiet },
		{ "Exhort them to leave the theater.", PleaseLeave },
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
		self:showDialog( "<The date has been going pretty well so far. You can tell there is a bond forming between the two of you.>" );
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
	self:showDialog( "Oh! I didn't think you would choose that type of movie. And I haven't seen it before!" );
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
	self:showDialog( "I used to eat meat when my father had me in the labyrinth, but I was always like, totally disgusted by it." );
	self:showDialog( "My friend Matt says that when he becomes like King President of the country he'll make meat illegal. But I don't think he'll remember it, because he's like so forgetful. He even forgot where he parked his car at the mall once, lol!" );
end

local Milkshakes = function( self )
	self:addPoints( 1 );
	self.gotMilk = true;
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Milkshakes? Wow, that's totally kinky." );
	self:showDialog( "But it's good, I like it!", { wobbly = true } );
	self:showDialog( "I didn't really expect you to make things move so quickly between us, but I guess, uh, you know me already!" );
	self:showDialog( "It reminds me of how my friend Jenny always knows what's the best latte every season at StairBux. She's like totally a medium. Once she told me I'd be cold wearing shorts and then I totally was. She's magical." );
	self:wait( 1 );
	self:showDialog( "<You buy milkshakes for the two of you.>" );
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
	self:showDialog( "She ate so many that her face became red like a carrot. Have you ever eaten so much food that your face becomes a weird color? It happens to her like all the time. It's totally weird but like, in a way that's not creepy. Whatever.", { ignoreInput = true } );
	self:setDialogSpeed();
end

local Concessions = function( self )
	-- TODO, if rework, allow a question about her friends here
	self:wait( 1 );
	self:showDialog( "I'm like so hungry right now. We should totally get something to eat for the movie. I need to keep all these stomachs busy you know." );
	self:showChoice( "What will you do?", {
		{ "Offer to buy beef jerky", BeefJerky },
		{ "Offer to buy milkshakes", Milkshakes },
		{ "We should keep some room the restaurant food", NoJunkFood },
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
	self:showDialog( "So he was like, \"What the duck?\". And she totally kept going for ages. Like how the beach isn't really the beach if I'm not here because I'm like, the main star of the event. She was like so mad. So Stephen told my friend Jerry that Jenny was nuts. And you know what she did?" );
	self:setDialogSpeed( 50 );
	self:showDialog( "She like totally threw a starfish at him! As if. I don't know why she would even pick up a starfish in the first place, duh, they're so gross. And they have like a million legs. They better not skip leg day like Stephen always does.", { ignoreInput = true } );
	self:setDialogSpeed( 60 );
	self:showDialog( "I always tell my friends not to skip leg days otherwise they could end up looking like my electronic massage chair that I have at home, but Stephen like never listens what my other friends say so yeah now he totally looks like that starfish, LOL!", { ignoreInput = true } );
	self:showDialog( "And you know what, my friend Patrick told me yesterday", { ignoreInput = true } );
	self:setDialogSpeed();
	self:playCharacterAnimation( "happy" );
	self:wait( 1 );
	self:showDialog( "<Minnie-T keeps talking about her friends for a few minutes>" );
	self:playCharacterAnimation( "idle" );
end

local Puzzles = function( self )
	self:addPoints( 2 );
	self:showDialog( "Haha, it's funny you mention that. I'm really good at solving mazes, my friends say there's nothing I can do better than mazes other than eating grass with chopsticks. You wouldn't believe how hard that is, lol!" );
end

local AboutYourself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "So...what about yourself? I mean like, what kind of stuff are you into?" );
	self:wait( .5 );
	self:showChoice( "It looks like it's your turn to say something", {
		{ "I'm a huge fan of Texas barbecue. I live for the brisket.", Brisket },
		{ "I'm more of an outdoor person, nothing beats the beach.", Beach },
		{ "I'm the cerebral type, I solve puzzles and riddles.", Puzzles },
	} );
	Concessions( self );
end

local RentMusicVideos = function( self )
	self:playCharacterAnimation( "happy" );
	self:addPoints( 4 );
	self:showDialog( "O M G!! Really? That is like, so much like me. I watch music videos all day when I should be helping customers at the store. I'm a big fan of Jigsawchain Puzzle Records and Atomium Organic Sound System. And my friends love them too!" );
	self:showDialog( "They're so fashion! Like I can't stop listening!!" );
	self:playCharacterAnimation( "idle" );
end

local WhatIsVHS = function( self )
	self:playCharacterAnimation( "shocked" );
	self:addPoints( -2 );
	self:showDialog( "Wow." );
	self:wait( 1 );
	self:playCharacterAnimation( "idle" );
	self:showDialog( "VHS are like...so fashion right now. You should totally check it out, duh, it's like vinyl but with pictures. I feel so JPG just talking about it." );
	self:playCharacterAnimation( "sad" );
	self:showDialog( "It's kinda sad you don't know about them. What do you even do with you days?" );
	self:playCharacterAnimation( "idle" );
end

local WishDadRich = function( self )
	self:addPoints( 2 );
	self:showDialog( "I know, right. My friends are like so jealous about it. The other day my friend Stephen told me that he heard from Amanda that she would totally dump her familiy to live with me and my dad." );
	self:showDialog( "That would be so rad!!", { wobbly = true, } );
end

local IntroducesHerself = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "So yeah. My name is Minnie Crete, but my friends call me Minnie-T, so I guess you can call me Minnie-T also. I guess. I work in my dad's VHS rental store." );
	self:showDialog( "My dad doesn't just deal with the VHS store lol. He's super rich so he owns like half the town. This theater is totally his estate also." );
	self:wait( .5 );
	self:showChoice( "Minnie-T looks very proud", {
		{ "It's awesome, I rent VHS of music videos all the time.", RentMusicVideos },
		{ "What's a VHS?", WhatIsVHS  },
		{ "I wish my dad was that rich.", WishDadRich },
	} );
	AboutYourself( self );
end

local NeverKnow = function( self )
	self:playCharacterAnimation( "idle" );
	self:showDialog( "I know right, I was totally freaking out on my way here!! Online dates are like, so spooky. My friend Amanda told me not to come because you were most likely some sort of carnivorous wacko but I mean like, whatever." );
	IntroducesHerself( self );
end

local NiceToMeetYou = function( self )
	self:playCharacterAnimation( "shocked" );
	self:showDialog( "O M G! When you said that, you sounded totally like my friend Amanda. Like, totally the same." );
	IntroducesHerself( self );
end

local TheaterDate = function( self )
	self:setBackground( gAssets.BG.theater );
	--self:playMusic( gAssets.MUSIC.theaterLobby );
	self:setCharacter( Minnie );
	self:playCharacterAnimation( "idle" );
	self:fadeIn( 3 );
	self:setIntroText( "Minnie-T" );
	self:introTextFadeIn( 1 );
	self:wait( 2 );
	self:introTextFadeOut( 2 );
	self:setDialogSpeed();
	self:showDialog( "Hey! Sorry, I was like totally not sure you were the right person! You look a bit different from your DP! But it's ok, you look way cool." );
	self:playCharacterAnimation( "happy" );
	self:showDialog( "Nice to meet you at last!", { wobbly = true } );
	self:showChoice( "Minnie-T looks energetic.", {
		{ "Nice to meet you too!", NiceToMeetYou },
		{ "Yeah, you never know with online dates.", NeverKnow },
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
	self:showNarration( "Hopefully you will enjoy your next one too. They say exorcists only become real date-masters after a few hundreds so don't stress out." );
	self:wait( 1 );
	self:showNarration( "Here is the profile for your next date, take a good look at it." );
	self:stopMusic( gAssets.MUSIC.narration );
	PresentDatingProfile( self );
end

local run = function( self )
	PlayNarration( self );
end


MinnieDateScene.new = function()
	return Scene.new( run );
end


return MinnieDateScene;