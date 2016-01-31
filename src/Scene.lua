local MessageBox = require( "src/MessageBox" );
local Fading = require( "src/Fading" );
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
	self.narrationBox = MessageBox.new( self, { showBox = false, y = 400, textAlign = "center" } );
	self.fading = Fading.new( self );
	self.choiceBox = ChoiceBox.new( self );
	self.points = 0;
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
	love.graphics.setColor( 255, 255, 255, 255 );
	if self.currentBackground then
		love.graphics.draw( self.currentBackground, 0, 0 );
	end
	self.portrait:draw();
	self.narrationBox:draw();
	self.dialogBox:draw();
	self.choiceBox:draw();
	self.fading:draw();
end

Scene.startThread = function( self, runtime )
	local thread = coroutine.create( runtime );
	table.insert( self.threads, 1, thread );
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

Scene.isThreadAlive = function( self, thread )
	for i = #self.threads, 1, -1 do
		if thread == self.threads[i] then
			return true;
		end
	end
	return false;
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

Scene.waitFrame = function( self )
	coroutine.yield();
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

Scene.setNarrationSpeed = function( self, speed )
	self.narrationBox:setSpeed( speed );
end

Scene.showNarration = function( self, text, options )
	self.narrationBox:showText( text, options );
end

Scene.showChoice = function( self, question, choices )
	self.choiceBox:showChoice( question, choices );
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

Scene.setCharacter = function( self, character )
	self.portrait:setCharacter( character );
end

Scene.playCharacterAnimation = function( self, animationName )
	self.portrait:playAnimation( animationName );
end

Scene.waitForCharacterAnimation = function( self )
	self.portrait:waitForAnimation();
end

Scene.playSuccessFX = function( self )
	self.portrait:playSuccessFX();
end

Scene.playSound = function( self, soundName )
	self.currentSound = soundName;
	love.audio.play( self.soundName );
end

Scene.addPoints = function( self, pointsToAdd )
	self.points = self.points + pointsToAdd;
	if self.points < -10 then
		--self.kill;
	end
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
