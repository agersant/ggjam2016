local Scene = {}

Scene.new = function()
	local self = {};
	SetClass( self, Scene );
	return self;
end

Scene.draw = function( self )
	love.graphics.print( "Oink oink!", 40, 20 );
end

return Scene;