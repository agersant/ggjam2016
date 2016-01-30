local ChoiceBox = {};

ChoiceBox.new = function( scene )
	local self = {};
	SetClass( self, ChoiceBox );
	self.scene = scene;
	return self;
end

ChoiceBox.draw = function( self )
	if not self.question then
		return;
	end
	love.graphics.setColor( 255, 255, 255 );
	love.graphics.printf( self.question, 40, 200, 700, "left" );
	local y = 0;
	for i, choice in ipairs( self.choices ) do
		if i == self.focusedChoice then
			love.graphics.setColor( 0, 255, 0 );
		else
			love.graphics.setColor( 255, 255, 255 );
		end
		love.graphics.printf( choice[1], 40, 220 + y, 700, "left" );
		y = y + 20;
	end
end

ChoiceBox.showChoice = function( self, question, choices )
	assert( #choices > 0 );
	self.question = question;
	self.choices = choices;
	self.focusedChoice = 1;
	
	local nav = function( key, offset )
		return function( scene )
			while true do
				scene:waitForInput( key );
				self.focusedChoice = self.focusedChoice + offset;
				if self.focusedChoice > #choices then
					self.focusedChoice = 1;
				elseif self.focusedChoice <= 0 then
					self.focusedChoice = #choices;
				end
			end
		end
	end
	
	local downNav = self.scene:startThread( nav( "down", 1 ) );
	local upNav = self.scene:startThread( nav( "up", -1 ) );
	
	self.scene:waitForMainInput();
	self.scene:stopThread( downNav );
	self.scene:stopThread( upNav );
	
	local pickedChoice = self.choices[self.focusedChoice];
	self.question = nil;
	self.choices = nil;
	
	assert( type( pickedChoice[2] ) == "function" );
	pickedChoice[2]( self.scene );
end

return ChoiceBox;