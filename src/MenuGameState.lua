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


MenuGameState = class( State )

MenuGameState.MENU_ITEM_START_GAME = 0
MenuGameState.MENU_ITEM_OPTION = 1
MenuGameState.MENU_ITEM_QUIT = 2
LocCursor_X = -45
LocCursor_Y = -10
width = 480
height = 320

function MenuGameState:init( layer )
    
    State.init( self, "MenuGameState" )
	
    viewport = MOAIViewport.new()
	viewport:setSize(width, height)
	viewport:setScale(width, height)
	
	self.layer = MOAILayer2D.new()
	self.layer:setViewport(viewport)
	MOAISim.pushRenderPass(self.layer)
	
	self.menu = MOAIProp2D.new()
	self.menu:setDeck( MAIN_2D_MENU )
	self.menu:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
	
    self.board = MOAIProp2D.new ()
	gfxQuads, names = load ( 'game-asset-01.lua',40/100)
	self.board:setDeck ( gfxQuads )
    self.board:setIndex ( names['tiang-menu.png'] )
	self.board:setLoc(-60,-115)
	
	-- adding by te
	
	self.boardPlay = MOAIProp2D.new ()
	gfxQuads, names = load ( 'game-asset-01.lua',40/100)
	self.boardPlay:setDeck ( gfxQuads )
    self.boardPlay:setIndex ( names['papan-play!.png'] )
	self.boardPlay:setLoc(-60,-15)
	
	self.boardOption = MOAIProp2D.new ()
	gfxQuads, names = load ( 'game-asset-01.lua',40/100)
	self.boardOption:setDeck ( gfxQuads )
	self.boardOption:setIndex ( names['papan-option.png'] )
	self.boardOption:setLoc ( -60, -95 )
	
	self.boardQuit = MOAIProp2D.new ()
	gfxQuads, names = load ( 'game-asset-01.lua',40/100)
	self.boardQuit:setDeck ( gfxQuads )
	self.boardQuit:setIndex ( names['papan-quit.png'] )
	self.boardQuit:setLoc ( -60, -175 )
	
	-- end adding by te
    
    self.orangutan = MOAIProp2D.new()
    self.orangutan:setDeck( ORANGUTAN_2D )
    self.orangutan:setLoc(-130,-50)
    
    self.sunny = MOAIProp2D.new()
    self.sunny:setDeck( SUNNY_2D )
    self.sunny:setLoc(LocCursor_X+180, LocCursor_Y+140)
    
    self.skies = MOAIProp2D.new()
    self.skies:setDeck( SKIES_2D )
    self.skies:setLoc(LocCursor_X+180, LocCursor_Y+140)
    
    self.sun = MOAIProp2D.new()
    self.sun:setDeck( SUN_2D )
    self.sun:setLoc(LocCursor_X+180, LocCursor_Y+140)
	
--	self.cursor = MOAIProp2D.new()
--	self.cursor:setDeck( QUAD_2D_CURSOR2 )
--	self.cursor:setLoc(LocCursor_X, LocCursor_Y)
	
	aniOrangUtan = MOAIAnimCurve.new ()
	aniOrangUtan:reserveKeys ( 3 )
	aniOrangUtan:setKey ( 1, 0, 0 )
	aniOrangUtan:setKey ( 2, 0.55, 20 )
	aniOrangUtan:setKey ( 3, 0.75, 0 )
end

function MenuGameState:enter()

    --GAME_TIME:pause()
	self.layer:insertProp( self.skies )
	self.layer:insertProp( self.sunny )
	self.layer:insertProp( self.sun )
	self.layer:insertProp( self.menu )
	-- self.layer:insertProp( self.board )
	-- add by te
	-- self.layer:insertProp( self.boardPlay )
	-- self.layer:insertProp( self.boardOption )
	-- self.layer:insertProp( self.boardQuit )
	-- end add by te
--	self.layer:insertProp( self.cursor )
	self.layer:insertProp( self.orangutan )
	self.cursorIndex = MenuGameState.MENU_ITEM_START_GAME
	--self:updateCursorLocation()
	--MOAIInputMgr.device.keyboard:setCallback( MenuGameState.onKeyboardEvent )
	--MOAIInputMgr.device.touch:setCallback( MenuGameState.onTouchEvent )
	
	anim = MOAIAnim.new ()
	anim:reserveLinks ( 1 )
	print(MOAIProp2D.ATTR_Y_LOC)
	anim:setLink ( 1, aniOrangUtan, self.orangutan, MOAIProp2D.ATTR_Y_LOC, true )
	anim:setMode ( MOAITimer.LOOP )
	anim:start ()
	
	self.sunny:moveRot ( 360, 30 , MOAIEaseType.LINEAR)
	
	require "gui\\support\\class"

    local gui = require "gui\\gui"
    local resources = require "gui\\support\\resources"
    local filesystem = require "gui\\support\\filesystem"
    local inputconstants = require "gui\\support\\inputconstants"
    
    ButtonHandler = class()
    
    -- Respond to button 1 being clicked
    function _handleButton1Click(event, data)
        -- print("Button 1 Click")
        GAME_STATE_MACHINE:setCurrentState ( ISLAND_GAME_STATE )
    end
    
    -- Respond to button 2 being clicked
    function _handleButton2Click(event, data)
        -- print("Button 2 Click")
        GAME_STATE_MACHINE:setCurrentState ( OPTION_GAME_STATE )
    end
    
    function _handleButton3Click(event, data)
        print("Button 3 Click")
    end
    function _handleButton4Click(event, data)
        GAME_STATE_MACHINE:setCurrentState ( CREDIT_GAME_STATE )
    end
    
    function ButtonHandler:init()
    
    end
    MOAILogMgr.setLogLevel(MOAILogMgr.LOG_NONE)
    
    local g = gui.GUI(width, height)

-- Resource paths - search through these for specified resources
    g:addToResourcePath("resources", "fonts")
    g:addToResourcePath("resources", "gui")
    g:addToResourcePath("resources", "media")
    g:addToResourcePath("resources", "themes")
    
    -- This sets up the theme to be used for widgets. If images aren't set
    -- manually for a widget, the system looks to the theme for the images
    -- to use.
    g:setTheme("basetheme.lua")
    
    -- The font used for text
    g:setCurrFont("default")
    local button = g:createButton()
    button:setPos(40, 40)
    button:setDim(20, 10)
    button:setText("Play")
    button:registerEventHandler(button.EVENT_BUTTON_CLICK, nil, _handleButton1Click)
	
	local button = g:createButton()
    button:setPos(40, 50)
    button:setDim(20, 10)
    button:setText("Option")
    button:registerEventHandler(button.EVENT_BUTTON_CLICK, nil, _handleButton2Click)
    
    local button = g:createButton()
    button:setPos(40, 60)
    button:setDim(20, 10)
    button:setText("Quit")
    button:registerEventHandler(button.EVENT_BUTTON_CLICK, nil, _handleButton3Click)
    
    local button = g:createButton()
    button:setPos(40, 70)
    button:setDim(20, 10)
    button:setText("Credit")
    button:registerEventHandler(button.EVENT_BUTTON_CLICK, nil, _handleButton4Click)
    
	function onPointerEvent(x, y)
    g:injectMouseMove(x, y)
	end
	
	function onMouseLeftEvent(down)
	    if (down) then
	        g:injectMouseButtonDown(inputconstants.LEFT_MOUSE_BUTTON)
	    else
	        g:injectMouseButtonUp(inputconstants.LEFT_MOUSE_BUTTON)
	    end
	end
	
	function onMouseMiddleEvent(down)
	    if (down) then
	        g:injectMouseButtonDown(inputconstants.MIDDLE_MOUSE_BUTTON)
	    else
	        g:injectMouseButtonUp(inputconstants.MIDDLE_MOUSE_BUTTON)
	    end
	end
	
	function onMouseRightEvent(down)
	    if (down) then
	        g:injectMouseButtonDown(inputconstants.RIGHT_MOUSE_BUTTON)
	    else
	        g:injectMouseButtonUp(inputconstants.RIGHT_MOUSE_BUTTON)
	    end
	end
	
	-- Register the callbacks for input
	
			if MOAIInputMgr.device.pointer then
		    MOAIInputMgr.device.pointer:setCallback(onPointerEvent)
		    MOAIInputMgr.device.mouseLeft:setCallback(onMouseLeftEvent)
		    MOAIInputMgr.device.mouseMiddle:setCallback(onMouseMiddleEvent)
		    MOAIInputMgr.device.mouseRight:setCallback(onMouseRightEvent)
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
		
		self.getlayer = g:layer()
			
end


--
function MenuGameState:exit()
    --g:destroyWindow(win)
    self.layer:clear()
    self.getlayer:clear()
    --self._windows:clear()
	MOAIInputMgr.device.keyboard:setCallback( nil )
	if MOAIInputMgr.device.pointer then
	MOAIInputMgr.device.pointer:setCallback ( nil )
    MOAIInputMgr.device.mouseLeft:setCallback ( nil )
    else
    MOAIInputMgr.device.touch:setCallback( nil )
    end
end
--
function MenuGameState:incrementCursorIndex()
	if ( self.cursorIndex == MenuGameState.MENU_ITEM_QUIT )
	then
		self.cursorIndex = MenuGameState.MENU_ITEM_START_GAME
	else
		self.cursorIndex = self.cursorIndex + 1
	end
end
--
function MenuGameState:updateCursorLocation()
	local cursorX = LocCursor_X
	local cursorY = LocCursor_Y + self.cursorIndex * -40
	self.cursor:setLoc( cursorX, cursorY )
end
--
function MenuGameState:onMenuSelected()
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
MENU_GAME_STATE = nil
--
function MenuGameState.onKeyboardEvent( key, down )
	if ( MENU_GAME_STATE == nil or down )
	then
		return
	end

	if ( key == KEYBOARD_SPACE )
	then
		MENU_GAME_STATE:incrementCursorIndex()
		MENU_GAME_STATE:updateCursorLocation()
	elseif ( key == KEYBOARD_ENTER )
	then
		MENU_GAME_STATE:onMenuSelected()
	end
end



--
--function MenuGameState.onTouchEvent( eventType, idx, x, y, tapCount )
--	if ( MENU_GAME_STATE == nil or down )
--	then
--		return
--	end
--
--	GAME_STATE_MACHINE:setCurrentState( STAGE_INTRO_GAME_STATE )
--end
