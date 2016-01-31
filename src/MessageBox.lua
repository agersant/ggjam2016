local Gradient = require( "src/Gradient" );

local MessageBox = {};

MessageBox.new = function( scene )
	local self = {};
	SetClass( self, MessageBox );
	self.scene = scene;
	self.gradient = Gradient.new( self );
	
	self.rainbow = self.gradient.gradient {
    direction = 'horizontal';
    {0, 100, 176, 200};
    {0, 100, 176, 0};
}
	
	

	
	
	return self;
end

MessageBox.draw = function( self )

	love.graphics.setColor(115, 189, 143, 102);
	love.graphics.rectangle( "fill", (1920-1600)/2, 1080-40-330, 1600, 330 );
	love.graphics.setColor(255, 255, 255, 255);
	Gradient.drawinrect(self.rainbow, (1920-1600)/2, 1080-40-330, 1600, 330);
	
	-- Borders
	love.graphics.setColor(255, 255, 255, 255);
	love.graphics.rectangle( "fill", (1920-1600)/2, 1080-40-330, 3, 330 );
	love.graphics.rectangle( "fill", (1920-1600)/2 + 1600, 1080-40-330, 3, 330 );
	love.graphics.rectangle( "fill", (1920-1600)/2, 1080-40-330, 1600, 3 );
	love.graphics.rectangle( "fill", (1920-1600)/2, 1080-40-3, 1600, 3 );
	-- Enough with the borders

	if self.currentText then
		local ox = 0;
		local oy = 0;
		if self.wobbly then
			local amplitude = 2.5;
			ox = amplitude * math.random() - amplitude/2;
			oy = amplitude * math.random() - amplitude/2;
		end

		love.graphics.setColor(255, 255, 255, 255);
		love.graphics.setFont( gAssets.FONT.dialogFont );

		love.graphics.printf( self.currentText, (1920-1600)/2 + 50, 1080-40-330+20, 1600-100, "left", 0, 1, 1, ox, oy, 0, 0 );
	end
end

MessageBox.showText = function( self, text, options )
	options = options or {};
	self.currentText = "";
	self.wobbly = options.wobbly;
	local textSpeed = self.textSpeed or 12;
	local startTime = love.timer.getTime();
	local releasedInput = false;
	while #self.currentText < #text do
		releasedInput = releasedInput or not IsMainInputDown();
		local now = love.timer.getTime();
		local textSpeedScale = 1;
		local numChars = math.ceil( ( now - startTime ) * textSpeed * textSpeedScale );
		if releasedInput and IsMainInputDown() then
			numChars = #text;
		end
		self.currentText = string.sub( text, 1, numChars );
		coroutine.yield();
	end
	self.scene:waitForMainInput();
	self.currentText = nil;
end

MessageBox.setSpeed = function( self, speed )
	self.textSpeed = speed;
end

return MessageBox;
