local Gradient = require( "src/Gradient" );

local MessageBox = {};

MessageBox.new = function( scene, options )
	options = options or {};
	local self = {};
	SetClass( self, MessageBox );
	self.scene = scene;
	
	self.width = 1600;
	self.height = 330;
	self.x = options.x or ( 1920 - self.width ) / 2;
	self.y = options.y or 1080 - 40 - self.height;
	self.showBox = options.showBox ~= false;
	self.textAlign = options.textAlign or "left";
	
	self.boxGradient = Gradient.new( self ).gradient( {
		direction = "horizontal",
		{ 0, 100, 176, 200 },
		{ 0, 100, 176, 0 },
	} );
	return self;
end

MessageBox.draw = function( self )
	
	if not self.currentText then
		return;
	end

	if self.showBox then
		love.graphics.setColor( 115, 189, 143, 102 );
		love.graphics.rectangle( "fill", self.x, self.y, self.width, self.height );
		love.graphics.setColor( 255, 255, 255, 255 );
		Gradient.drawinrect( self.boxGradient, self.x, self.y, self.width, self.height );
		
		-- Borders
		local thickness = 6;
		love.graphics.setColor( 255, 255, 255, 255 );
		love.graphics.rectangle( "fill", self.x, self.y, thickness, self.height );
		love.graphics.rectangle( "fill", self.x + self.width - thickness, self.y, thickness, self.height );
		love.graphics.rectangle( "fill", self.x, self.y, self.width, thickness );
		love.graphics.rectangle( "fill", self.x, self.y + self.height - thickness, self.width, thickness );
		-- Enough with the borders
	end
	
	local ox = 0;
	local oy = 0;
	if self.wobbly then
		local amplitude = 4;
		ox = amplitude * math.random() - amplitude/2;
		oy = amplitude * math.random() - amplitude/2;
	end

	love.graphics.setColor( 255, 255, 255, 255 );
	love.graphics.setFont( gAssets.FONT.dialogFont );

	local paddingX = 50;
	local paddingY = 20;
	love.graphics.printf( self.currentText, self.x + paddingX, self.y + paddingY, self.width - 2 * paddingX, self.textAlign, 0, 1, 1, ox, oy, 0, 0 );
end

MessageBox.showText = function( self, text, options )
	options = options or {};
	self.currentText = "";
	self.wobbly = options.wobbly;
	self.allowInput = not options.ignoreInput;
	local textSpeed = self.textSpeed or 28;
	local startTime = love.timer.getTime();
	local releasedInput = false;
	while #self.currentText < #text do
		releasedInput = releasedInput or not IsMainInputDown();
		local now = love.timer.getTime();
		local textSpeedScale = 1;
		local numChars = math.ceil( ( now - startTime ) * textSpeed * textSpeedScale );
		if releasedInput and IsMainInputDown() and self.allowInput then
			numChars = #text;
		end
		self.currentText = string.sub( text, 1, numChars );
		coroutine.yield();
	end
	if self.allowInput then
		self.scene:waitForMainInput();
	else
		self.scene:wait( 0.3 );
	end
	self.currentText = nil;
end

MessageBox.setSpeed = function( self, speed )
	self.textSpeed = speed;
end

return MessageBox;
