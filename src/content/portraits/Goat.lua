local Goat = {};

Goat.new = function( scene, portrait )
	local self = {};
	SetClass( self, Goat );
	self.scene = scene;
	self.portrait = portrait;
	return self;
end

Goat.playAnimation = function( self, animationName )
	self.portrait:setOffset( 780, 0 );
	self.portrait:setFXPosition( 230, 250 );
	if animationName == "exit" then
		return self:playExit();
	else
		print( "Missing animation " .. animationName );
	end
end

Goat.playExit = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.exit0 );
end

return Goat;