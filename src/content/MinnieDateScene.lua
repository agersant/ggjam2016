local Scene = require( "src/Scene" );
local Minnie = require( "src/content/portraits/Minnie" );


local MinnieDateScene = {};

local Concessions = function( self )
	self:showDialog( "TBC" );
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
	self:setDialogSpeed( 36 );
	self:showDialog( "So he was like, \"What the fuck?\". And she totally kept going for ages. Like how the beach isn't really the beach if I'm not here because I'm like, the main star of the event. She was like so mad. So Stephen told my friend Jerry that Jenny was nuts. And you know what she did?" );
	self:setDialogSpeed( 50 );
	self:showDialog( "She like totally threw a starfish at him! As if. I don't know why she would even pick up a starfish in the first place, duh, they're so gross. And they have like a million legs. They better not skip leg day like Stephen always does.", { ignoreInput = true } );
	self:setDialogSpeed( 60 );
	self:showDialog( "I always tell my friends not to skip leg days otherwise they could end up looking like my electronic massage chair that I have at home, but Stephen like never listens what my other friends say so yeah now he totally looks like that starfish, LOL!", { ignoreInput = true } );
	self:showDialog( "And you know what, my friend Patrick told me yesterday", { ignoreInput = true } );
	set:setDialogSpeed();
	set:playCharacterAnimation( "happy" );
	set:wait( 1 );
	self:showDialog( "<Minnie-T keeps talking about her friends for a few minutes>" );
	set:playCharacterAnimation( "idle" );
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
	self:introTextFadeIn( 5 );
	self:introTextFadeOut( 5 );
	self:setDialogSpeed();
	self:showDialog( "Hey! Sorry, I was like totally not sure you were the right person! You look a bit different from your avvy! But it's ok, you look way cool." );
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