local ReportCard = {};

ReportCard.new = function( scene )
	local self = {};
	SetClass( self, ReportCard );
	self.scene = scene;
	return self; 
end

ReportCard.draw = function( self )
	if not ( self.success and self.score ) then
		return;
	end

	if self.alpha then
		love.graphics.setColor( 255, 255, 255, self.alpha );
		love.graphics.setFont( gAssets.FONT.introTextFont );
		local result = love.graphics.printf( self.introName, 0, 700, 1920, "center", 0, 1, 1, ox, oy, 0, 0 );
    
		return result
	end
end

ReportCard.showReport = function( self, success, score )
	self.success = success;
	self.score = score;
end

return ReportCard;