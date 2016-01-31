local Fading = {};

Fading.new = function( scene )
	local self = {};
	SetClass( self, Fading );
	self.scene = scene;
	return self;
end

Fading.draw = function( self )
	if self.alpha then
		love.graphics.setColor(166, 166, 166, self.alpha);
		love.graphics.rectangle("fill", 0, 0, 1920, 1080 );
	end
end

Fading.fadeIn = function( self, duration )
	self.alpha = 255;
	
	local startTime = love.timer.getTime();

	while self.alpha >= 0 do
	
		local now = love.timer.getTime();
		
		self.alpha = 255 - ( ( now - startTime ) / duration * 255 );

		coroutine.yield();
	end
end

Fading.fadeOut = function( self, duration )
	self.alpha = 0;
	
	local startTime = love.timer.getTime();

	while self.alpha <= 255 do
	
		local now = love.timer.getTime();
		
		self.alpha = ( ( now - startTime ) / duration * 255 );

		coroutine.yield();
	end
end

return Fading;