local Scene = require( "src/Scene" );

local FinalScene = {};


local run = function( self )
	self:setCharacter();
	self:setBackground( gAssets.BG.black );
	self:fadeIn( 1 );
	self:setNarrationSpeed( 15 );
	self:showNarration( "And so our story ends.", { ignoreInput = true, } );
	self:wait( 5 );
	self:showNarration( "Another day in the endless war against and demons comes to its end, thanks to the power of love." );
	self:wait( 1 );
	self:setNarrationSpeed();
	self:showNarration( "Thank you for playing Love, Live, Lucifer!" );
	while true do
		self:waitFrame();
	end
end


FinalScene.new = function()
	return Scene.new( run );
end


return FinalScene;