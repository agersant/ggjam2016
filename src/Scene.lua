local MessageBox = require( "src/MessageBox" );
local Fading = require( "src/Fading" );
local ChoiceBox = require( "src/ChoiceBox" );
local Portrait = require( "src/Portrait" );
local IntroText = require( "src/IntroText" );

local Scene = {}

Scene.new = function( runtime )
	local self = {};
	SetClass( self, Scene );
	self.threads = {};
	self.portrait = Portrait.new( self );
	self.dialogBox = MessageBox.new( self );
	self.narrationBox = MessageBox.new( self, { showBox = false, y = 400, textAlign = "center" } );
	self.fading = Fading.new( self );
	self.introText = IntroText.new( self );
	self.choiceBox = ChoiceBox.new( self );
	self.points = 10;
	self:startThread( runtime );
	return self;
end

Scene.update = function( self )
	for i = 1, #self.threads do
		local thread = self.threads[i];
		if not thread.kill then
			local ok, errorMessage = coroutine.resume( thread.routine, self );
			if not ok then
				error( errorMessage );
			end
		end
	end
	for i = #self.threads, 1, -1 do
		local thread = self.threads[i];
		if coroutine.status( thread.routine ) == "dead" or thread.kill then
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
	self.introText:draw();
	self.narrationBox:draw();
	self.dialogBox:draw();
	self.choiceBox:draw();
	self.fading:draw();
end

Scene.startThread = function( self, runtime )
	local routine = coroutine.create( runtime );
	local thread = { routine = routine };
	table.insert( self.threads, thread );
	local ok, errorMessage = coroutine.resume( thread.routine, self );
	if not ok then
		error( errorMessage );
	end
	return thread;
end

Scene.stopThread = function( self, thread )
	for i = #self.threads, 1, -1 do
		if thread == self.threads[i] then
			self.threads[i].kill = true;
			break;
		end
	end
end

Scene.isThreadAlive = function( self, thread )
	for i = #self.threads, 1, -1 do
		if thread == self.threads[i] then
			return not thread.kill;
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
	if self.points < 0 then
		self:kill();
	elseif pointsToAdd >= 4 then
		self:playSuccessFX();
	end
end

Scene.getPoints = function( self )
	return self.points;
end

Scene.setIntroText = function( self, text )
	self.introText:setText( text );
end

Scene.setIntroTextBlinking = function( self, blinking )
	self.introText:setBlinking( blinking );
end

Scene.introTextFadeIn = function( self, duration )
	self.introText:fadeIn( duration );
end

Scene.introTextFadeOut = function( self, duration )
	self.introText:fadeOut( duration );
end

Scene.playMusic = function( self, musicName )
	if ( gCurrentMusic and gCurrentMusic ~= musicName ) then
		love.audio.stop( gCurrentMusic );
	end

	gCurrentMusic = musicName;
	gCurrentMusic:setLooping( true );

	love.audio.play( gCurrentMusic );
end

Scene.stopMusic = function( self, musicName )
	love.audio.stop( gCurrentMusic );
	gCurrentMusic = nil;
end


return Scene;
