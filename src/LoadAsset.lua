Load_Asset = {}

function Load_Asset.init()
	menuWidth = 480
	menuHeight = 320
	MAIN_2D_MENU = MOAIGfxQuad2D.new()
	MAIN_2D_MENU:setTexture( "asset/image/mainmenu.png" )
	MAIN_2D_MENU:setRect( menuWidth/2, -menuHeight/2, -menuWidth/2, menuHeight/2 )
	
	mapWidth = 480
    mapHeight = 320
    MAP_2D_MENU = MOAIGfxQuad2D.new()
    MAP_2D_MENU:setTexture( "asset/image/map.png" )
    MAP_2D_MENU:setRect( -menuWidth/2, -menuHeight/2, menuWidth/2, menuHeight/2 )
    
    bgmapWidth = 480
    bgmapHeight = 320
    BG_MAP_2D = MOAIGfxQuad2D.new()
    BG_MAP_2D:setTexture( "asset/image/back-menu-option.png" )
    BG_MAP_2D:setRect( -menuWidth/2, -menuHeight/2, menuWidth/2, menuHeight/2 )
	
	cursorWidth = 41
    cursorHeight = 51
    QUAD_2D_CURSOR2 = MOAIGfxQuad2D.new()
    QUAD_2D_CURSOR2:setTexture( "asset/image/cur.png" )
    QUAD_2D_CURSOR2:setRect( cursorWidth/2, -cursorHeight/2, -cursorWidth/2, cursorHeight/2 )
    --QUAD_2D_CURSOR2:setSize ( 1, 1 )
    --QUAD_2D_CURSOR:setRect( menuWidth/2, -menuHeight/2, -menuWidth/2, menuHeight/2 )
	
	boardWidth = 138.5
    boardHeight = 317
    BOARD_2D_MENU = MOAITileDeck2D.new()
    BOARD_2D_MENU:setTexture( "asset/image/menu-asset-ingame.png" )
    BOARD_2D_MENU:setSize ( 5, 1 )
    BOARD_2D_MENU:setRect ( -boardWidth/2, -boardHeight/2, 0,0 )
    
    orangutanWidth = 500
    orangutanHeight = 500
    ORANGUTAN_2D = MOAITileDeck2D.new()
    ORANGUTAN_2D:setTexture( "asset/image/orangutan.png" )
    ORANGUTAN_2D:setSize ( 1, 1 )
    ORANGUTAN_2D:setRect ( -orangutanWidth/10, -orangutanHeight/10, orangutanWidth/10,orangutanHeight/10 )
    
    sunnyWidth = 256
    sunnyHeight = 256
    SUNNY_2D = MOAITileDeck2D.new()
    SUNNY_2D:setTexture( "asset/image/sunny.png" )
    SUNNY_2D:setSize ( 1, 1 )
    SUNNY_2D:setRect ( -sunnyWidth/8, -sunnyHeight/8, sunnyWidth/8,sunnyHeight/8 )
    
    sunnyWidth = 519
    sunnyHeight = 278
    SKIES_2D = MOAITileDeck2D.new()
    SKIES_2D:setTexture( "asset/image/skies.png" )
    SKIES_2D:setSize ( 1, 1 )
    SKIES_2D:setRect ( -sunnyWidth/4-100, -sunnyHeight/4+20, sunnyWidth/4+50,sunnyHeight/4 )
    
    sunnyWidth = 480
    sunnyHeight = 320
    SKIES_2D2 = MOAIGfxQuad2D.new()
    SKIES_2D2:setTexture( "asset/image/skies.png" )
    SKIES_2D2:setRect( -menuWidth/2, -menuHeight/2, menuWidth/2, menuHeight/2 )
    --SKIES_2D2:setRect ( -sunnyWidth/4-100, -sunnyHeight/4+20, sunnyWidth/4+50,sunnyHeight/4 )
    
    sunWidth = 162
    sunHeight = 159
    SUN_2D = MOAITileDeck2D.new()
    SUN_2D:setTexture( "asset/image/sun.png" )
    SUN_2D:setSize ( 1, 1 )
    SUN_2D:setRect ( -sunWidth/8, -sunHeight/8, sunWidth/8,sunHeight/8 )
    
    dotWidth = 32   
    dotHeight = 32
    DOT_2D = MOAIGfxQuad2D.new()
    DOT_2D:setTexture("asset/image/blue-dot.png")
    DOT_2D:setRect(-20, -20, 0, 0)
    
    optionWidth = 480
    optionHeight = 320
    OPTION_2D_MENU = MOAIGfxQuad2D.new()
    OPTION_2D_MENU:setTexture("asset/image/view-options.png" )
    OPTION_2D_MENU:setRect( -optionWidth/2, -optionHeight/2, optionWidth/2, optionHeight/2 )
    
    
    
end

function load(lua, resize)
    local frames = dofile ( lua ).frames

    local tex = MOAITexture.new ()
    print(dofile ( lua ).texture)
    tex:load ( dofile ( lua ).texture )
    local xtex, ytex = tex:getSize ()

    -- anotasi untuk array frame dengan uv quads dan geometri rects
    for i, frame in ipairs ( frames ) do
        -- convert frame.uvRect ke frame.uvQuad untuk rotasi (generate texture packer)
        local uv = frame.uvRect
        local q = {}
        if not frame.textureRotated then
            -- Moai docs: "vertex order searah jarum jam dari kiri atas (xMin, yMax)"
            q.x0, q.y0 = uv.u0, uv.v0
            q.x1, q.y1 = uv.u1, uv.v0
            q.x2, q.y2 = uv.u1, uv.v1
            q.x3, q.y3 = uv.u0, uv.v1
        else
            -- Sprite data untuk rotasi 90 derajat CW
            -- u0v0 masih di kiri atas
            q.x3, q.y3 = uv.u0, uv.v0
            q.x0, q.y0 = uv.u1, uv.v0
            q.x1, q.y1 = uv.u1, uv.v1
            q.x2, q.y2 = uv.u0, uv.v1
        end
        frame.uvQuad = q

        -- convert frame.spriteColorRect dan frame.spriteSourceSize
        -- ke frame.geomRect.  awalnya di x0,y0 dari sprite asli
        local cr = frame.spriteColorRect
        local r = {}
        r.x0 = cr.x
        r.y0 = cr.y
        r.x1 = cr.x + cr.width
        r.y1 = cr.y + cr.height
        frame.geomRect = r
    end

    -- buat object deck
    local deck = MOAIGfxQuadDeck2D.new ()
    deck:setTexture ( tex )
    deck:reserve ( #frames )
    local names = {}
    for i, frame in ipairs ( frames ) do
        local q = frame.uvQuad
        local r = frame.geomRect
        names[frame.name] = i
        deck:setUVQuad ( i, q.x0,q.y0, q.x1,q.y1, q.x2,q.y2, q.x3,q.y3 )
        deck:setRect ( i, r.x0*resize,r.y0*resize, r.x1*resize,r.y1*resize )
    end

    return deck, names
end
