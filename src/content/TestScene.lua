local Scene = require( "src/Scene" );
local Minnie = require( "src/content/portraits/Minnie" );

local TestScene = {};

oink = function( self )
	while true do
		print( "oink" );
		self:wait( 3 );
	end
end

run = function( self )
	-- self:startThread( oink );

--	self:setBackground( gAssets.BG.mockup );

--	self:fadeIn( 2 );
--	self:fadeOut( 2 );
	
	self:showNarration( "I love tacos and demons, who doesnt love tacos or demons?", { ignoreInput = true, } );

--	self:setBackground( gAssets.BG.mockup );
	self:setCharacter( Minnie );
	self:playCharacterAnimation( "idle" );

	self:fadeIn( 2 );


	self:showChoice( "Hey, do you like tacos?", {
		{ "Love 'em", function( scene ) print( "said love" ) end },
		{ "Meh", function( scene ) print( "said meh" ) end },
		{ "Hate", function( scene ) print( "said hate" ) end },
	} );
	self:playCharacterAnimation( "angry" );
	self:showDialog( "Lorem Ipsum is simply dummy text of the printing and typesetting industry." );
	self:showDialog( "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", { wobbly = true } );

	self:fadeOut( 2 );
end

TestScene.new = function()
	return Scene.new( run );
end


return TestScene;
