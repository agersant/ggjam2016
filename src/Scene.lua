local Scene = {}

Scene.new = function( runtime )
	local self = {};
	SetClass( self, Scene );
	self.threads = {};
	self:startThread( runtime );
	return self;
end

Scene.update = function( self )
	for i = #self.threads, 1, -1 do
		local thread = self.threads[i];
		local ok, errorMessage = coroutine.resume( thread, self );
		if not ok then
			error( errorMessage );
		end
		if coroutine.status( thread ) == "dead" then
			table.remove( self.threads, i );
		end
	end
end

Scene.draw = function( self )
	if self.currentDialog then
		local ox = 0;
		local oy = 0;
		if self.wobblyDialog then
			local amplitude = 2.5;
			ox = amplitude * math.random() - amplitude/2;
			oy = amplitude * math.random() - amplitude/2;
		end
		love.graphics.printf( self.currentDialog, 50, 200, 700, "left", 0, 1, 1, ox, oy, 0, 0 );
	end
end

Scene.startThread = function( self, runtime )
	local thread = coroutine.create( runtime );
	table.insert( self.threads, thread );
end

Scene.wait = function( self, seconds )
	local startTime = love.timer.getTime();
	while true do
		local now = love.timer.getTime();
		if now - startTime > seconds then
			break;
		else
			coroutine.yield();
		end
	end
end

Scene.waitForInput = function( self )
	while IsMainInputDown() do
		coroutine.yield();
	end
	while not IsMainInputDown() do
		coroutine.yield();
	end
end

Scene.setDialogSpeed = function( self, speed )
	self.dialogSpeed = speed;
end

Scene.showDialog = function( self, text, options )
	options = options or {};
	self.currentDialog = "";
	self.wobblyDialog = options.wobbly;
	local textSpeed = self.dialogSpeed or 12;
	local startTime = love.timer.getTime();
	local releasedInput = false;
	while #self.currentDialog < #text do
		releasedInput = releasedInput or not IsMainInputDown();
		local now = love.timer.getTime();
		local textSpeedScale = 1;
		local numChars = math.ceil( ( now - startTime ) * textSpeed * textSpeedScale );
		if releasedInput and IsMainInputDown() then
			numChars = #text;
		end
		self.currentDialog = string.sub( text, 1, numChars );
		coroutine.yield();
	end
	self:waitForInput();
	self.currentDialog = nil;
end

return Scene;