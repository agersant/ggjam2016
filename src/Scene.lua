local Scene = {}

Scene.new = function()
	local self = {};
	SetClass( self, Scene );
	return self;
end

Scene.draw = function( self )
	love.graphics.print( "Oink oink!", 40, 20 );
	love.graphics.draw(self.currentBackground, 0, 0);
end

Scene.setBackground = function( self, imageName )
	self.currentBackground = imageName;
end

Scene.playSound = function( self, soundName )
	self.currentSound = soundName;
end

Scene.playMusic = function( self, musicName )
	if ( self.currentMusic and self.currentMusic ~= musicName ) then
		love.audio.stop( self.currentMusic );
	end
	
	self.currentMusic = musicName;
--	musicName:setLooping( true );

	love.audio.play(self.currentMusic);
end

Scene.fadeIn = function( duration )
	A = 0;
end


Scene.fadeOut = function( duration )
	A = 255;
end







return Scene;