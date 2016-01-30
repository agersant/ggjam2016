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
		coroutine.resume( thread, self );
		if coroutine.status( thread ) == "dead" then
			table.remove( self.threads, i );
		end
	end
end

Scene.draw = function( self )
	if self.currentText then
		love.graphics.print( self.currentText, 40, 20 );
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

Scene.showDialog = function( self, text )
	self.currentText = "";
	local textSpeed = 12;
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
	self:waitForInput();
	self.currentText = nil;
end

return Scene;