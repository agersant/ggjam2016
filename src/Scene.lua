local MessageBox = require( "src/MessageBox" );
local Fading = require( "src/Fading" );

local Scene = {}

Scene.new = function( runtime )
	local self = {};
	SetClass( self, Scene );
	self.threads = {};
	self:startThread( runtime );
	self.dialogBox = MessageBox.new( self );
	self.fading = Fading.new( self );
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

	self.fading:draw();
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

Scene.fadeIn = function( self, duration )
	self.fading:fadeIn( duration );
end

Scene.fadeOut = function( self, duration )
	self.fading:fadeOut( duration );
end

Scene.setBackground = function( self, imageName )
	self.currentBackground = imageName;
end

Scene.playSound = function( self, soundName )
	self.currentSound = soundName;
	
	love.audio.play(self.soundName);
end

Scene.playMusic = function( self, musicName )
	if ( self.currentMusic and self.currentMusic ~= musicName ) then
		love.audio.stop( self.currentMusic );
	end

	self.currentMusic = musicName;
	musicName:setLooping( true );

	love.audio.play(self.currentMusic);
end










return Scene;
