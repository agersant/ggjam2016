local ChoiceBox = {};

ChoiceBox.new = function( scene )
	options = options or {};
	local self = {};
	SetClass( self, ChoiceBox );
	self.scene = scene;
	
	self.width = 1600;
	self.height = 330;
	self.x = options.x or ( 1920 - self.width ) / 2;
	self.y = options.y or 1080 - 40 - self.height;
	
	return self;
end

ChoiceBox.draw = function( self )
	if not self.question then
		return;
	end
	
	local paddingX = 50;
	local paddingYQuestion = 4;
	local paddingYAnswers = 15;

	love.graphics.setColor( 28, 28, 28, 255 );
	love.graphics.rectangle( "fill", self.x, 1080 - (40 + 70 + (98 + 18) * #self.choices), self.width, 80 );
	
	love.graphics.setColor( 255, 255, 255, 255 );
	love.graphics.printf( self.question, self.x + paddingX, 1080 - (40 + 70 + (98 + 18) * #self.choices) + paddingYQuestion, self.width - 2 * paddingX, "left", 0, 1, 1, ox, oy, 0, 0 );

	for i, choice in ipairs( self.choices ) do
		if i == self.focusedChoice then
			love.graphics.setColor( 36, 56, 97, 180 );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, self.width, 98 );
			
			love.graphics.setColor( 0, 255, 252 );
			
			-- Borders
			local thickness = 3;
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, thickness, 98 );
			love.graphics.rectangle( "fill", self.x + self.width - thickness, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, thickness, 98 );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, self.width, thickness );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + 98, self.width, thickness );
			-- Enough with the borders
			
			-- Triangle
			love.graphics.polygon('fill', self.x + 6, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + 98 - 3, 
										  self.x + 40, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + 98 - 3,
										  self.x + 6, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + 98 - 37);

			love.graphics.printf( choice[1], self.x + paddingX, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + paddingYAnswers, self.width - 2 * paddingX, "left", 0, 1, 1, ox, oy, 0, 0 );
		else
			love.graphics.setColor( 0, 0, 0, 180 );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, self.width, 98 );
			love.graphics.setColor( 255, 255, 255, 255 );
			
			-- Borders
			local thickness = 3;
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, thickness, 98 );
			love.graphics.rectangle( "fill", self.x + self.width - thickness, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, thickness, 98 );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18, self.width, thickness );
			love.graphics.rectangle( "fill", self.x, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + 98, self.width, thickness );
			-- Enough with the borders
			
			love.graphics.printf( choice[1], self.x + paddingX, 1080 - (40 + (98 + 18) * (#self.choices + 1 - i)) + 18 + paddingYAnswers, self.width - 2 * paddingX, "left", 0, 1, 1, ox, oy, 0, 0 );
		end
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