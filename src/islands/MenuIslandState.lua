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

MenuIslandState = class( State )

MenuIslandState.MENU_ITEM_START_GAME = 0
MenuIslandState.MENU_ITEM_OPTION = 1
MenuIslandState.MENU_ITEM_QUIT = 2
LocCursor_X = -45
LocCursor_Y = -10
local gfxQuads, names = load ( 'asset-button.lua',10/100)
function MenuIslandState:init( layer )

    MENU_LEVEL_STATE_BORNEO = MenuLevelStateBorneo( RENDER_SYSTEM.layer )
	State.init( self, "MenuIslandState" )
    partition = MOAIPartition.new ()
    
	self.layer = layer
    self.layer:setPartition ( partition )
	self.map = MOAIProp2D.new()
	self.map:setDeck( MAP_2D_MENU )
	self.map:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
	
	self.bgmap = MOAIProp2D.new()
	self.bgmap:setDeck (BG_MAP_2D)
	self.bgmap:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
	--dot
	
	self.dot = MOAIProp2D.new()
    self.dot:setDeck( gfxQuads )
    self.dot:setIndex( names['button_play.png'] )
    self.dot:setLoc( BASE_LOCATION_X-55, BASE_LOCATION_Y+5 )
  	--end dot
	
end

function MenuIslandState:enter()
	--GAME_TIME:pause()
	self.layer:insertProp( self.bgmap )
	self.layer:insertProp( self.map )
	--dot
	self.layer:insertProp( self.dot )
	
      
    ------------------------------
    mouseX = 0
    mouseY = 0

    priority = 5

local function printf ( ... )
	return io.stdout:write ( string.format ( ... ))
end 

--print ( MOAIInputMgr.configuration )

----------------------------------------------------------------
-- keyboard events

function onKeyboardEvent ( key, down )

	if down == true then
		self.dot:setIndex( names['button_play-hover.png'] )
	else
		GAME_STATE_MACHINE:setCurrentState( MENU_LEVEL_STATE_BORNEO )
	end
end

MOAIInputMgr.device.keyboard:setCallback ( onKeyboardEvent )

----------------------------------------------------------------
-- pointer events

function pointerCallback ( x, y )
    
    local oldX = mouseX
    local oldY = mouseY
    
    mouseX, mouseY = self.layer:wndToWorld ( x, y )
    
    if pick then
        else
    end
end



----------------------------------------------------------------
-- mouse left button events
function clickCallback ( down )
    
    if down then
        
        pick = partition:propForPoint ( mouseX, mouseY )
        
        if pick then
            pick:setIndex( names['button_play-hover.png'] )
        end
    else
        if pick then
	        if pick==self.dot then	        
	            GAME_STATE_MACHINE:setCurrentState( MENU_LEVEL_STATE_BORNEO )
	            pick = nil
	        end
        end
    end
end


if MOAIInputMgr.device.pointer then
    
    -- mouse input
    MOAIInputMgr.device.pointer:setCallback ( pointerCallback )
    MOAIInputMgr.device.mouseLeft:setCallback ( clickCallback )
else

    -- touch input
    MOAIInputMgr.device.touch:setCallback ( 
    
        function ( eventType, idx, x, y, tapCount )

            pointerCallback ( x, y )
        
            if eventType == MOAITouchSensor.TOUCH_DOWN then
                clickCallback ( true )
            elseif eventType == MOAITouchSensor.TOUCH_UP then
                clickCallback ( false )
            end
        end
    )
end
    --end dot
end
--
function MenuIslandState:exit()
	self.layer:clear()
	MOAIInputMgr.device.pointer:setCallback ( nil )
    MOAIInputMgr.device.mouseLeft:setCallback ( nil )
end
--
function MenuIslandState:incrementCursorIndex()
	if ( self.cursorIndex == MenuGameState.MENU_ITEM_QUIT )
	then
		self.cursorIndex = MenuGameState.MENU_ITEM_START_GAME
	else
		self.cursorIndex = self.cursorIndex + 1
	end
end
--
function MenuIslandState:updateCursorLocation()
	local cursorX = LocCursor_X
	local cursorY = LocCursor_Y + self.cursorIndex * -40
	self.cursor:setLoc( cursorX, cursorY )
end
--
function MenuIslandState:onMenuSelected()
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
MENU_ISLAND_STATE = nil
--
function MenuIslandState.onKeyboardEvent( key, down )
	if ( MENU_ISLAND_STATE == nil or down )
	then
		return
	end

	if ( key == KEYBOARD_SPACE )
	then
		MENU_ISLAND_STATE:incrementCursorIndex()
		MENU_ISLAND_STATE:updateCursorLocation()
	elseif ( key == KEYBOARD_ENTER )
	then
		MENU_ISLAND_STATE:onMenuSelected()
	end
end

