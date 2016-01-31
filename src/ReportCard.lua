local ReportCard = {};

ReportCard.new = function( scene )
	local self = {};
	SetClass( self, ReportCard );
	self.scene = scene;
	return self; 
end

ReportCard.draw = function( self )
	if not ( self.score ) then
		return;
	end

	love.graphics.setColor( 255, 0, 0, 255 );
	love.graphics.rectangle( "fill", 800, 930, -700, -510 * self.score );

	love.graphics.setColor( 255, 255, 255, 255 );
	love.graphics.draw( gAssets.BG.reportCard, 0, 0 );

	love.graphics.setColor( 255, 255, 255, 255 );
	love.graphics.setFont( gAssets.FONT.introTextFont );

	love.graphics.printf( self.score * 100 .. "% IN LOVE", 850, 500, 1920, "left", 0, 1, 1, ox, oy, 0, 0 );

	if ( self.success ) then
		love.graphics.printf( "SUCCESS!", 850, 650, 1920, "left", 0, 1, 1, ox, oy, 0, 0 );
	else
		love.graphics.printf( "FAILURE!", 850, 650, 1920, "left", 0, 1, 1, ox, oy, 0, 0 );
	end
end

ReportCard.showReport = function( self, success, score )
	self.success = success;
	self.score = score;
end

return ReportCard;