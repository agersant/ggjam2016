local Goat = {};

Goat.new = function( scene, portrait )
	local self = {};
	SetClass( self, Goat );
	self.scene = scene;
	self.portrait = portrait;
	return self;
end

Goat.playAnimation = function( self, animationName )
	self.portrait:setOffset( 900, -100 );
	self.portrait:setFXPosition( 400, 320 );
	if animationName == "exit" then
		return self:playExit();
	elseif animationName == "happy" then
		return self:playHappy();
	elseif animationName == "shocked" then
		return self:playShocked();
	elseif animationName == "idle" then
		return self:playIdle();
	elseif animationName == "sad" then
		return self:playSad();
	elseif animationName == "mad" then
		return self:playMad();
	else
		print( "Missing animation " .. animationName );
	end
end

Goat.playExit = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.exit0 );
end

Goat.playSad = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.sad0 );
end

Goat.playShocked = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.shocked0 );
end

Goat.playIdle = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.idle0 );
end

Goat.playMad = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.mad0 );
end

Goat.playHappy = function( self )
	self.portrait:setImage( gAssets.CHAR.goat.happy0 );
end


return Goat;