local Portrait = {};

Portrait.new = function( scene )
	local self = {};
	SetClass( self, Portrait );
	self.scene = scene;
	return self;
end

Portrait.draw = function( self )
	
end

return Portrait;