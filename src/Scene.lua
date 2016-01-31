local MessageBox = require( "src/MessageBox" );
local ChoiceBox = require( "src/ChoiceBox" );
local Portrait = require( "src/Portrait" );

local Scene = {}

Scene.new = function( runtime )
	local self = {};
	SetClass( self, Scene );
	self.threads = {};
	self:startThread( runtime );
	self.portrait = Portrait.new( self );
	self.dialogBox = MessageBox.new( self );
	self.choiceBox = ChoiceBox.new( self );
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
	self.portrait:draw();
	self.dialogBox:draw();
	self.choiceBox:draw();
end

Scene.startThread = function( self, runtime )
	local thread = coroutine.create( runtime );
	table.insert( self.threads, thread );
	return thread;
end

Scene.stopThread = function( self, thread )
	for i = #self.threads, 1, -1 do
		if thread == self.threads[i] then
			table.remove( self.threads, i );
			break;
		end
	end
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

Scene.waitForKeyPress = function( self, isDown )
	while isDown() do
		coroutine.yield();
	end
	while not isDown() do
		coroutine.yield();
	end
end

Scene.waitForInput = function( self, key )
	local isDown = function()
		return love.keyboard.isDown( key )
	end;
	self:waitForKeyPress( isDown );
end

Scene.waitForMainInput = function( self )
	self:waitForKeyPress( IsMainInputDown );
end

Scene.setDialogSpeed = function( self, speed )
	self.dialogBox:setSpeed( speed );
end

Scene.showDialog = function( self, text, options )
	self.dialogBox:showText( text, options );
end

Scene.showChoice = function( self, question, choices )
	self.choiceBox:showChoice( question, choices );
end

Scene.setBackground = function( self, imageName )
	self.currentBackground = imageName;
end

Scene.playSound = function( self, soundName )
	self.currentSound = soundName;
end

Scene.playMusic = function( self, musicName )
	if ( self.currentMusic and self.currentMusic ~= musicName ) then
		love.audio.stop( self.currentMusic );
	end

	self.currentMusic = musicName;
--	musicName:setLooping( true );

	love.audio.play(self.currentMusic);
end

Scene.fadeIn = function( duration )
	A = 0;
end

Scene.fadeOut = function( duration )
	A = 255;
end

return Scene;
