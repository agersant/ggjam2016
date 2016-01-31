local Portrait = {};

Portrait.new = function( scene )
	local self = {};
	SetClass( self, Portrait );
	self.scene = scene;
	self:reset();
	return self;
end

Portrait.reset = function( self )
	self.image = nil;
	self.offset = { x = 0, y = 0, };
	self.wobbleAmount = 0;
end

Portrait.draw = function( self )
	if self.image then
		love.graphics.push();
		if self.wobbleAmount > 0 then
			local xAmount = self.wobbleAmount * math.random() - self.wobbleAmount / 2;
			local yAmount = self.wobbleAmount * math.random() - self.wobbleAmount / 2;
			love.graphics.translate( xAmount, yAmount );
		end
		love.graphics.translate( self.offset.x, self.offset.y );
		love.graphics.setColor( 255, 255, 255, 255 );
		love.graphics.draw( self.image );
		love.graphics.pop();
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
	self:reset();
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

Portrait.setWobble = function( self, amplitude )
	self.wobbleAmount = amplitude;
end

Portrait.setOffset = function( self, x, y )
	self.offset.x = x;
	self.offset.y = y;
end

return Portrait;