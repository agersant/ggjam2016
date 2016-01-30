local MessageBox = require( "src/MessageBox" );

local Scene = {}

Scene.new = function( runtime )
	local self = {};
	SetClass( self, Scene );
	self.threads = {};
	self:startThread( runtime );
	self.dialogBox = MessageBox.new( self );
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
	self.dialogBox:draw();
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
	self.dialogBox:showText( text, options );
end

return Scene;