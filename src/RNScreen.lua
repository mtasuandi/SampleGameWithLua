------------------------------------------------------------------------------------------------------------------------
--
-- RapaNui
--
-- by Ymobe ltd  (http://ymobe.co.uk)
--
-- LICENSE:
--
-- RapaNui uses the Common Public Attribution License Version 1.0 (CPAL) http://www.opensource.org/licenses/cpal_1.0.
-- CPAL is an Open Source Initiative approved
-- license based on the Mozilla Public License, with the added requirement that you attribute
-- Moai (http://getmoai.com/) and RapaNui in the credits of your program.
--
------------------------------------------------------------------------------------------------------------------------

RNScreen = {}

function RNScreen:new(o)

    o = o or {
        name = "",
        sprites = {},
        numSprites=0,
        width = 0,
        height = 0,
        spriteIndex = 0,
        viewport = nil,
        layer = nil,
        visible = true
    }

    setmetatable(o, self)
    self.__index = self
    self.images = {}
    self.images_size = 0
    return o
end

function RNScreen:getName()
    return self.name
end

function RNScreen:setName(name)
    self.name = name
end

function RNScreen:initWith(width, height)
    self.width = width
    self.height = height
    self.viewport = MOAIViewport.new()
    self.viewport:setSize(width, height)
    self.viewport:setScale(width, -height)
    self.viewport:setOffset(-1, 1)
    self.layer = MOAILayer2D.new()
    self.layer:setViewport(self.viewport)
    MOAISim.pushRenderPass(self.layer)
end

function RNScreen:addRNObject(object, mode)

    if object == nil then
        return
    end

    --self.images[self.images_size] = object

   -- self.images_size = self.images_size + 1
    self.layer = MOAILayer2D.new()
    object:setLocatingMode(mode)
    self.layer:insertProp(object:getProp())
    --print(object:getProp())
    --print(self.layer)
    MOAISim.pushRenderPass(self.layer)
    object:setParentScene(self)
    object:updateLocation()
    --self.sprites[self.spriteIndex] = object
    --self.spriteIndex = self.spriteIndex + 1
    self.numSprites = self.numSprites + 1
    self.sprites[self.numSprites] = object
    object:setIDInScreen(self.numSprites)
end

function RNScreen:removeRNObject(object)
    self.layer:removeProp(object:getProp())
    id=object.idInScreen
    len = table.getn(self.sprites)
    ind = id
    for i = 1, len, 1 do
        if (i == ind) then
            for k = ind + 1, len, 1 do
				self.sprites[k - 1] = self.sprites[k]
				self.sprites[k].idInScreen = k - 1
			end
            self.sprites[len] = nil
        end
    end
    --refresh other objects id
    for i, v in ipairs(self.sprites) do v.idInScreen = i end
    --
    self.numSprites=table.getn(self.sprites)
     
end

function RNScreen:getImages()
    return self.images
end