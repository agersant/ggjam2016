local Minnie = {};

Minnie.new = function( scene, portrait )
	local self = {};
	SetClass( self, Minnie );
	self.scene = scene;
	self.portrait = portrait;
	return self;
end

Minnie.playAnimation = function( self, animationName )
	self.portrait:setOffset( 780, 0 );
	self.portrait:setFXPosition( 230, 250 );
	if animationName == "angry" then
		return self:playAngry();
	elseif animationName == "exit" then
		return self:playExit();
	elseif animationName == "happy" then
		return self:playHappy();
	elseif animationName == "hyped" then
		return self:playHyped();
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
	self.portrait:setWobble( 15 );
	self.portrait:setImage( gAssets.CHAR.minnie.angry0 );
end

Minnie.playExit = function( self )
	self.portrait:setWobble( 25 );
	self.portrait:setImage( gAssets.CHAR.minnie.hyped0 );
	self.scene:wait( 5 );
	self.portrait:setWobble( 0 );
	self.portrait:setImage( gAssets.CHAR.minnie.exit0 );
end

Minnie.playHappy = function( self )
	while true do
		self.portrait:setImage( gAssets.CHAR.minnie.happy0 );
		self.scene:wait( .5 );
		self.portrait:setImage( gAssets.CHAR.minnie.happy1 );
	end
end

Minnie.playHyped = function( self )
	self.portrait:setWobble( 15 );
	self.portrait:setImage( gAssets.CHAR.minnie.hyped0 );
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