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
	love.graphics.print( "Oink oink!", 40, 20 );
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

Scene.showDialog = function( self, text )
	-- self.currentText = "";
	-- local textSpeed = 20;
	-- local startTime = love.timer.getTime();
	-- while #currentText < #text do
		-- local now = love.timer.getTime();
		-- local numChars = math.ceil( ( now - start ) * #currentText );
		-- self.currentText = string.sub( text, ???? );
		-- coroutine.yield();
	-- end
end

return Scene;