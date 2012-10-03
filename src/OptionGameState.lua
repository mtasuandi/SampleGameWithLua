--
--------------------------------------------------------------------------------
--         FILE:  MenuGameState.lua
--        USAGE:  ./InPlayGameState.lua 
--  DESCRIPTION:  Game State of menu selecting 
--      OPTIONS:  ---
-- REQUIREMENTS:  ---
--         BUGS:  ---
--        NOTES:  ---
--       AUTHOR:   (Benny Chen), <rockerbenny@gmail.com>
--      COMPANY:  
--      VERSION:  1.0
--      CREATED:  08/09/2011 21:21:44 CST
--     REVISION:  ---
--------------------------------------------------------------------------------
--

require "State"
require "StateMachine"
require "LoadAsset"
require "Init"

OptionGameState = class( State )

OptionGameState.MENU_ITEM_START_GAME = 0
OptionGameState.MENU_ITEM_OPTION = 1
OptionGameState.MENU_ITEM_QUIT = 2
LocCursor_X = -45
LocCursor_Y = -10
function OptionGameState:init( layer )
    State.init( self, "OptionGameState" )

    self.layer = layer
	
	self.option = MOAIProp2D.new()
    self.option:setDeck( OPTION_2D_MENU )
    self.option:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
    
    self.bgoption = MOAIColor.new()
    self.bgoption:setColor ( 0, 0, 0, 1)
    
end

function OptionGameState:enter()
    --GAME_TIME:pause()
    self.layer:setColor( self.bgoption )
    self.layer:insertProp( self.option )
end
function OptionGameState:exit()
	self.layer:clear()
end
--
--function MenuGameState:exit()
--  self.layer:removeProp( self.menu )
--  self.layer:removeProp( self.cursor )
--  MOAIInputMgr.device.keyboard:setCallback( nil )
--  --MOAIInputMgr.device.touch:setCallback( nil )
--end
--
function OptionGameState:incrementCursorIndex()
    if ( self.cursorIndex == MenuGameState.MENU_ITEM_QUIT )
    then
        self.cursorIndex = MenuGameState.MENU_ITEM_START_GAME
    else
        self.cursorIndex = self.cursorIndex + 1
    end
end
--
function OptionGameState:updateCursorLocation()
    local cursorX = LocCursor_X
    local cursorY = LocCursor_Y + self.cursorIndex * -40
    self.cursor:setLoc( cursorX, cursorY )
end
--
function OptionGameState:onMenuSelected()
    if ( self.cursorIndex == MenuGameState.MENU_ITEM_START_GAME )
    then
        GAME_STATE_MACHINE:setCurrentState( ISLAND_GAME_STATE )
    elseif ( self.cursorIndex == MenuGameState.MENU_ITEM_OPTION )
    then
        GAME_STATE_MACHINE:setCurrentState( OPTION_GAME_STATE )
    elseif ( self.cursorIndex == MenuGameState.MENU_ITEM_QUIT )
    then
    end
end
--
---- singleton, will be initialized when initializing game
OPTION_GAME_STATE = nil
--
function OptionGameState.onKeyboardEvent( key, down )
    -- if ( OPTION_GAME_STATE == nil or down )
    -- then
        -- return
    -- end

    if ( key == KEYBOARD_SPACE )
    then
        OPTION_GAME_STATE:exit()
        --OPTION_GAME_STATE:updateCursorLocation()
    elseif ( key == KEYBOARD_ENTER )
    then
        OPTION_GAME_STATE:exit()
    end
end
--
--function MenuGameState.onTouchEvent( eventType, idx, x, y, tapCount )
--  if ( MENU_GAME_STATE == nil or down )
--  then
--      return
--  end
--
--  GAME_STATE_MACHINE:setCurrentState( STAGE_INTRO_GAME_STATE )
--end
