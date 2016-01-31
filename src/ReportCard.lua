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

	
	love.graphics.draw( gAssets.BG.reportCard, 0, 0 );
	
	
	
		love.graphics.setColor( 255, 255, 255, 255 );
		love.graphics.setFont( gAssets.FONT.introTextFont );
		
		
		love.graphics.printf( self.score * 100 .. "% IN LOVE", 0, 100, 1920, "center", 0, 1, 1, ox, oy, 0, 0 );
		
		
		if ( self.success ) then
			love.graphics.printf( "SUCCESS!", 0, 700, 1920, "center", 0, 1, 1, ox, oy, 0, 0 );
		else
			love.graphics.printf( "FAILURE!", 0, 700, 1920, "center", 0, 1, 1, ox, oy, 0, 0 );
		end
		
		
    
		

end

ReportCard.showReport = function( self, success, score )
	self.success = success;
	self.score = score;
end

return ReportCard;