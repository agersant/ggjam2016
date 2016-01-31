local SuccessFX = require( "src/SuccessFX" );

local Portrait = {};

Portrait.new = function( scene )
	local self = {};
	SetClass( self, Portrait );
	self.scene = scene;
	
	self.image = nil;
	self.offset = { x = 0, y = 0, };
	self.fxPosition = { x = 0, y = 0, };
	self.wobbleAmount = 0;
	
	return self;
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
		
		if self.successFX then
			self.successFX:draw();
		end
		
		love.graphics.pop();
	end
end

Portrait.stopAnimation = function( self )
	if self.currentAnimation then
		self.scene:stopThread( self.currentAnimation );
	end
end



-- API for scene

Portrait.setCharacter = function( self, character )
	self.image = nil;
	self.wobbleAmount = 0;
	self.offset = { x = 0, y = 0, };
	self.fxPosition = { x = 0, y = 0, };
	self:stopAnimation();
	self.character = character.new( self.scene, self );
	assert( self.character.playAnimation );
end

Portrait.playAnimation = function( self, animationName )
	self:stopAnimation();
	self.image = nil;
	self.wobbleAmount = 0;
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

Portrait.playSuccessFX = function( self )
	if self.successFXThread then
		self.scene:stopThread( self.successFXThread );
	end
	self.successFX = SuccessFX.new( self.scene );
	local play = function()
		self.successFX:play( self.fxPosition );
	end
	self.successFXThread = self.scene:startThread( play );
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

Portrait.setFXPosition = function( self, x, y )
	self.fxPosition.x = x;
	self.fxPosition.y = y;
end

return Portrait;