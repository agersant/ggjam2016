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
	love.graphics.printf( self.question, 40, 200, 700, "left" );
end

ChoiceBox.showChoice = function( self, question, choices )
	self.question = question;
	self.choices = choices;
	self.scene:waitForInput();
	self.question = nil;
end

return ChoiceBox;