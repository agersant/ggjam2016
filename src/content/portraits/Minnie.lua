local Minnie = {};

Minnie.new = function( scene, portrait )
	local self = {};
	SetClass( self, Minnie );
	self.scene = scene;
	self.portrait = portrait;
	return self;
end

Minnie.playAnimation = function( self, animationName )
	if animationName == "angry" then
		return self:playAngry();
	elseif animationName == "exit" then
		return self:playExit();
	elseif animationName == "happy" then
		return self:playHappy();
	elseif animationName == "idle" then
		return self:playIdle();
	elseif animationName == "sad" then
		return self:playSad();
	elseif animationName == "shocked" then
		return self:playShocked();
	else
		print( "Missing animation " .. animationName );
	end
end

Minnie.playAngry = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.angry0 );
end

Minnie.playExit = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.exit0 );
end

Minnie.playHappy = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.happy0 );
end

Minnie.playIdle = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.idle0 );
end

Minnie.playSad = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.sad0 );
end

Minnie.playShocked = function( self )
	self.portrait:setImage( gAssets.CHAR.minnie.shocked0 );
end

return Minnie;