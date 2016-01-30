local Scene = require( "src/Scene" );

local TestScene = {};

oink = function( self )
	while true do
		print( "oink" );
		self:wait( 3 );
	end
end

run = function( self )
	self:startThread( oink );
	while true do
		print( "yo" );
		self:wait( 2 );
	end
end

TestScene.new = function()
	return Scene.new( run );
end


return TestScene;