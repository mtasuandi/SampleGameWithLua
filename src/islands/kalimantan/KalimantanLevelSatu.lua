require("RNMapFactory")
require("RNMap")
require("RNMapLayer")
require("RNMapObject")
require("RNMapObjectGroup")
require("RNMapTileset")
--require("config")
require("RNFactory")

KalimantanLevelSatu = class( State )

function KalimantanLevelSatu:init( layer )

    State.init( self, "KalimantanLevelSatu" )
    self.layer = layer
	self.bgoption = MOAIProp2D.new()
	self.bgoption:setDeck( BG_OPTION_2D )
	self.bgoption:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
	
	self.option = MOAIProp2D.new()
    self.option:setDeck( OPTION_2D_MENU )
    self.option:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
    
--    camera = MOAITransform.new ()
--
--    parallax_back = MOAILayer2D.new ()
--    parallax_back:setViewport ( RENDER_SYSTEM.viewport )
--    parallax_back:setCamera ( camera )
--    parallax_back:setParallax ( 0.1, 0.2 )
--        
--    parallax_mid = MOAILayer2D.new ()
--    parallax_mid:setViewport ( RENDER_SYSTEM.viewport )
--    parallax_mid:setParallax ( 0.7, 1 )
--    parallax_mid:setCamera ( camera )
--    
--    MOAISim.pushRenderPass( parallax_mid )
--    MOAISim.pushRenderPass( parallax_back )
--    print("test")
    camera = MOAITransform.new ()

    map = RNMapFactory.loadMap(RNMapFactory.TILEDLUA, "asset/image/parallax-ground.lua")
    aTileset = map:getTileset(0)
	aTileset:updateImageSource("asset/image/parallax-ingame-new-01.png")
	map:drawMapLayer(0, 0, aTileset)
	
	map2 = RNMapFactory.loadMap(RNMapFactory.TILEDLUA, "asset/image/parallax-ground.lua")
    aTileset = map2:getTileset(0)
    aTileset:updateImageSource("asset/image/parallax-ingame-new-01.png")
    map2:drawMapLayer(0, 0, aTileset)
    
	self.layer1 = MOAILayer2D.new()
	self.layer1:setViewport( RENDER_SYSTEM.viewport )
	self.layer1:setCamera ( camera )
	self.layer1:setParallax ( 0.1, 0.2 )
	
	self.layer2 = MOAILayer2D.new()
    self.layer2:setViewport( RENDER_SYSTEM.viewport )
    self.layer2:setCamera ( camera )
    self.layer2:setParallax ( 0.4, 1 )
	
	MOAISim.pushRenderPass(self.layer1)
    MOAISim.pushRenderPass(self.layer2)
	--print(self.parallax_mid)
--    
    --drawMapAt(0, 0, aTileset)
    
end

function KalimantanLevelSatu:enter()
    self.layer1:insertProp(self.bgoption)
    self.layer2:insertProp(map2.layerdraw.renderedMap.prop)
    --MOAISim.pushRenderPass ( self.parallax_mid )
end
function KalimantanLevelSatu:exit()
	self.layer:clear()
	self.layer2:clear()
	MOAISim.popRenderPass(self.layer2)
end

function drawMapAt(x,y,aTilesetVar)
for i = 0, layersSize - 1 do
    local layer = layers[i]
    for col = 0, layer:getCols() - 1 do
        local rowTiles = ""
        for row = 0, layer:getRows() - 1 do
            local tileIdx = layer:getTilesAt(row, col)
            local tileX = x + aTilesetVar:getTileWidth() * col + aTilesetVar:getTileWidth() / 2
            local tileY = y + aTilesetVar:getTileHeight() * row + aTilesetVar:getTileHeight() / 2

            if tileX > -aTilesetVar:getTileWidth() and tileX < config.width + aTilesetVar:getTileWidth() and
                    tileY > -aTilesetVar:getTileHeight() and tileY < config.height + aTilesetVar:getTileWidth()
            then
                local aTile = aTilesetVar:getTileImage(tileIdx)
                aTile.x = tileX
                aTile.y = tileY
            end
        end
        rowTiles = ""
    end
end
end