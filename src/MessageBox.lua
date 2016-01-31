local MessageBox = {};

MessageBox.new = function( scene )
	local self = {};
	SetClass( self, MessageBox );
	self.scene = scene;
	return self;
end

MessageBox.draw = function( self )
	if self.currentText then
		local ox = 0;
		local oy = 0;
		if self.wobbly then
			local amplitude = 2.5;
			ox = amplitude * math.random() - amplitude/2;
			oy = amplitude * math.random() - amplitude/2;
		end
		love.graphics.setColor(255, 255, 255, 255);
		love.graphics.printf( self.currentText, 50, 200, 700, "left", 0, 1, 1, ox, oy, 0, 0 );
	end
end

MessageBox.showText = function( self, text, options )
	options = options or {};
	self.currentText = "";
	self.wobbly = options.wobbly;
	local textSpeed = self.dialogSpeed or 12;
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
	self.scene:waitForInput();
	self.currentText = nil;
end

return MessageBox;