local Scene = require( "src/Scene" );
local GoatDateScene = require( "src/content/GoatDateScene" );

local TitleScene = {};


local PlayNarration = function( self )

	self:fadeOut( 0.1 );
	self:setBackground( gAssets.BG.logo );
	self:fadeIn( 1 );
	self:wait( 1 );
	self:fadeOut( 1 );
	
	self:setBackground( gAssets.BG.titleScreen );
	self:fadeIn( 1 );
	self:setIntroText( "Press Space to Start" );
	local introSceneBlink = self:startThread( function( self ) self.introText:setBlinking( true ); end );

	self:waitForMainInput();
	self:stopThread( introSceneBlink );
	
	ChangeScene( GoatDateScene.new() );
end

local run = function( self )
	PlayNarration( self );
end


TitleScene.new = function()
	return Scene.new( run );
end


return TitleScene;