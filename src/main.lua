require "Init"
require "LoadAsset"
require "OptionGameState"
require "MenuGameState"
require "Credit"
require "islands/MenuIslandState"
require "islands/kalimantan/MenuLevelStateBorneo"
require "StateMachine"
require "islands/kalimantan/KalimantanLevelSatu"

RENDER_SYSTEM = {}

function RENDER_SYSTEM.init()
    MOAISim.openWindow( GAME_NAME, SCREEN_WIDTH, SCREEN_HEIGHT )

    RENDER_SYSTEM.viewport = MOAIViewport.new()
    RENDER_SYSTEM.viewport:setScale( SCREEN_UNITS_X, SCREEN_UNITS_Y )
    RENDER_SYSTEM.viewport:setSize( SCREEN_WIDTH, SCREEN_HEIGHT )

    RENDER_SYSTEM.layer = MOAILayer2D.new()
    RENDER_SYSTEM.layer:setViewport( RENDER_SYSTEM.viewport )

    MOAISim.pushRenderPass( RENDER_SYSTEM.layer )
end

function main()
    
    RENDER_SYSTEM.init()
    Load_Asset.init()
    GAME_STATE_MACHINE = StateMachine()
    MENU_GAME_STATE = MenuGameState( RENDER_SYSTEM.layer ) 
    ISLAND_GAME_STATE = MenuIslandState( RENDER_SYSTEM.layer ) 
    OPTION_GAME_STATE = OptionGameState( RENDER_SYSTEM.layer )
    CREDIT_GAME_STATE = Credit( RENDER_SYSTEM.layer )
	--KALIMANTAN_LEVEL_SATU = kalimantanlevel1 (RENDER_SYSTEM.layer)
    --MENU_LEVEL_STATE_BORNEO = MenuLevelStateBorneo( RENDER_SYSTEM.layer )
    run()
end

function run()
    GAME_STATE_MACHINE:run()
    GAME_STATE_MACHINE:setCurrentState( MENU_GAME_STATE )
end

main()
