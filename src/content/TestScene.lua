local Scene = require( "src/Scene" );

local TestScene = {};

oink = function( self )
	while true do
		print( "oink" );
		self:wait( 3 );
	end
end

run = function( self )
	-- self:startThread( oink );
	self:showChoice( "Hey, do you like tacos?", {
		{ "Love 'em", function( scene ) print( "said love" ) end },
		{ "Meh", function( scene ) print( "said meh" ) end },
		{ "Hate", function( scene ) print( "said hate" ) end },
	} );
	self:showDialog( "Lorem Ipsum is simply dummy text of the printing and typesetting industry." );
	self:showDialog( "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", { wobbly = true } );
end

TestScene.new = function()
	return Scene.new( run );
end


return TestScene;