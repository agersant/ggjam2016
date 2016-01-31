local IntroText = {};

IntroText.new = function( scene )
	local self = {};
	SetClass( self, IntroText );
	self.scene = scene;
	return self; 
end

IntroText.draw = function( self )
	if not self.introName then
		return;
	end
	
	if self.alpha then
		love.graphics.setColor( 255, 255, 255, self.alpha );
		love.graphics.setFont( gAssets.FONT.introTextFont );
		local result = love.graphics.printf( self.introName, 0, 700, 1920, "center", 0, 1, 1, ox, oy, 0, 0 );
    
		return result
	end
end

IntroText.setText = function( self, text )
	self.introName = text;
end

IntroText.fadeIn = function( self, duration )
	self.alpha = 0;
	
	local startTime = love.timer.getTime();

	while self.alpha <= 255 do
	
		local now = love.timer.getTime();
		
		self.alpha = ( ( now - startTime ) / duration * 255 );

		coroutine.yield();
	end
end

IntroText.fadeOut = function( self, duration )
	self.alpha = 255;
	
	local startTime = love.timer.getTime();

	while self.alpha >= 0 do
	
		local now = love.timer.getTime();
		
		self.alpha = 255 - ( ( now - startTime ) / duration * 255 );

		coroutine.yield();
	end
end

return IntroText;