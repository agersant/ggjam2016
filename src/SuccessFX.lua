local SuccessFX = {};

SuccessFX.new = function( scene )
	local self = {};
	SetClass( self, SuccessFX );
	self.scene = scene;
	return self;
end

SuccessFX.play = function( self, position )
	print( position.x );
	print( position.y );
	self.hearts = {};
	for i = 1, 5 do
		local heart = {
			x = position.x + math.random() * 200 - 100,
			y = position.y + math.random() * 100 - 50,
			scale = math.random() + .5,
			phase = math.random() * math.pi,
		};
		table.insert( self.hearts, heart );
	end
	
	local startTime = love.timer.getTime();
	while true do
		local now = love.timer.getTime();
		self.scaleFactor = math.min( startTime - now, 1 );
		if now - startTime > 5 then
			break;
		end
		for i, heart in ipairs( self.hearts ) do
			local dt = love.timer.getDelta();
			heart.y = heart.y - dt * 120;
			local xSpeed = 80 * math.sin( ( now - startTime ) * 4 + heart.phase );
			heart.x = heart.x + dt * xSpeed;
		end
		self.scene:waitFrame();
	end
	
end

SuccessFX.draw = function( self )
	for i, heart in ipairs( self.hearts ) do
		love.graphics.setColor( 255, 0, 0, 255 );
		love.graphics.rectangle( "fill", heart.x, heart.y, 32 * self.scaleFactor, 32 * self.scaleFactor );
	end
end

return SuccessFX;