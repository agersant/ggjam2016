local Portrait = {};

Portrait.new = function( scene )
	local self = {};
	SetClass( self, Portrait );
	self.scene = scene;
	return self;
end

Portrait.reset = function( self )
	self.image = nil;
end

Portrait.draw = function( self )
	if self.image then
		love.graphics.setColor( 255, 255, 255, 255 );
		love.graphics.draw( self.image );
	end
end



-- API for scene

Portrait.setCharacter = function( self, character )
	self.character = character.new( self.scene, self );
	assert( self.character.playAnimation );
end

Portrait.playAnimation = function( self, animationName )
	if self.currentAnimation then
		self.scene:stopThread( self.currentAnimation );
	end
	local animate = function()
		self.character:playAnimation( animationName );
	end;
	self.currentAnimation = self.scene:startThread( animate );
end

Portrait.waitForAnimation = function( self )
	if not self.currentAnimation then
		return;
	end
	while self.scene:isThreadAlive( self.currentAnimation ) do
		coroutine.yield();
	end
end



-- API for character

Portrait.setImage = function( self, image )
	self.image = image;
end


return Portrait;