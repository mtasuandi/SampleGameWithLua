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

--require("RNInputManager")
--require("RNUtil")


TOP_LEFT_MODE = 1
CENTERED_MODE = 2

RNObject = {}


local function fieldChangedListener(self, key, value)

    getmetatable(self).__object[key] = value
    self = getmetatable(self).__object

    if key ~= nil and key == "visible" then
        self:setVisible(value)
    end


    if key ~= nil and key == "isVisible" then
        self:setVisible(value)
    end

    if self.isAnim == true then

        if key ~= nil and key == "sizex" then
            self:setTileSizeX(value)
        end

        if key ~= nil and key == "sizey" then
            self:setTileSizeY(value)
        end
        if key ~= nil and key == "scalex" then
            self:setTileScaleX(value)
        end
        if key ~= nil and key == "scaley" then
            self:setTileScaleY(value)
        end
        if key ~= nil and key == "frame" then
            self.prop:setIndex(value)
        end
    end

    if self.isPhysical == false then

        if key ~= nil and key == "x" then
            local tmpX = self.currentRefX + value
            local tmpY = self.y

            if (self:getProp() ~= nil) then
                self:getProp():setLoc(tmpX, tmpY);
            end
        end

        if key ~= nil and key == "y" then
            local tmpX = self.x
            local tmpY = self.currentRefY + value

            if (self:getProp() ~= nil) then
                self:getProp():setLoc(tmpX, tmpY);
            end
        end

        if key ~= nil and key == "rotation" then
            self:getProp():setRot(value)
        end

        if key == "isFocus" and value == true then
            -- TODO: implement focus handling
        end
    end

    if self.isPhysical == true then
        if key ~= nil and key == "name" then
            self.physicObject.name = value
        end

        if key ~= nil and key == "rotation" then
            self.physicObject:setAngle(value)
        end

        if key ~= nil and key == "collision" then
            self.physicObject.collision = value
        end

        if key ~= nil and key == "x" then
            self.physicObject:setX(value)
        end

        if key ~= nil and key == "y" then
            self.physicObject:setY(value)
        end

        if key ~= nil and key == "awake" then
            self.physicObject:setAwake(value)
        end

        if key ~= nil and key == "active" then
            self.physicObject:setActive(value)
        end

        if key ~= nil and key == "bullet" then
            self.physicObject:setBullet(value)
        end

        if key ~= nil and key == "fixedRotation" then
            self.physicObject:setFixedRotation(value)
        end

        if key ~= nil and key == "angularVelocity" then
            self.physicObject:setAngularVelocity(value)
        end

        if key ~= nil and key == "angularDamping" then
            self.physicObject:setAngularDamping(value)
        end

        if key ~= nil and key == "linearVelocityX" then
            self.physicObject:setLinearVelocity(value, self.linearVelocityY)
        end

        if key ~= nil and key == "linearVelocityY" then
            self.physicObject:setLinearVelocity(self.linearVelocityX, value)
        end

        if key ~= nil and key == "linearDamping" then
            self.physicObject:setLinearDamping(value)
        end

        if key ~= nil and key == "isSensor" then
            self.physicObject:setSensor(value)
        end

        if key ~= nil and key == "isSleepingAllowed" then
            print("isSleepingAllowed not available at the moment")
        end
        if key ~= nil and key == "bodyType" then
            print("bodyType not available at the moment")
        end
        if key ~= nil and key == "restitution" then
            self:setAllFixture("restitution", value)
        end
        if key ~= nil and key == "friction" then
            self:setAllFixture("friction", value)
        end
        if key ~= nil and key == "density" then
            self:setAllFixture("density", value)
        end
        if key ~= nil and key == "filter" then
            self:setAllFixture("filter", value)
        end
        if key ~= nil and key == "sensor" then
            self:setAllFixture("sensor", value)
        end
    end
end


local function fieldAccessListener(self, key)

    local object = getmetatable(self).__object


    if key ~= nil and key == "isVisible" then
        object.isVisible = object.visible
    end

    if object.isAnim == true then

        if key ~= nil and key == "frame" then
            object.frame = object.prop:getIndex()
        end
    end



    if object.isPhysical == true then

        if key ~= nil and key == "rotation" then
            object.rotation = object.physicObject:getAngle()
        end


        if key ~= nil and key == "x" then
            object.x = object.physicObject:getX()
        end

        if key ~= nil and key == "y" then
            object.y = object.physicObject:getY()
        end

        if key ~= nil and key == "collision" then
            object.collision = object.physicObject.collision
        end


        if key ~= nil and key == "isAwake" then
            object.isAwake = object.physicObject:isAwake()
        end

        if key ~= nil and key == "isBodyActive" then
            object.isActive = object.physicObject:isActive()
        end

        if key ~= nil and key == "isBullet" then
            object.isBullet = object.physicObject:isBullet()
        end

        if key ~= nil and key == "isFixedRotation" then
            object.isFixedRotation = object.physicObject:isFixedRotation()
        end

        if key ~= nil and key == "angularVelocity" then
            object.angularVelocity = object.physicObject:getAngularVelocity()
        end

        if key ~= nil and key == "angularDamping" then
            object.angularDamping = object.physicObject:getAngularDamping()
        end

        if key ~= nil and key == "linearVelocityX" then
            object.linearVelocityX, object.linearVelocityY = object.physicObject:getLinearVelocity()
        end

        if key ~= nil and key == "linearVelocityY" then
            object.linearVelocityX, object.linearVelocityY = object.physicObject:getLinearVelocity()
        end

        if key ~= nil and key == "linearDamping" then
            object.linearDamping = object.physicObject:getLinearDamping()
        end
        if key ~= nil and key == "isSleepingAllowed" then
            print("isSleepingAllowed not available at the moment")
        end
        if key ~= nil and key == "bodyType" then
            print("bodyType not available at the moment")
        end
        if key ~= nil and key == "fixture" then
            object.fixture = object.physicObject.fixturelist
        end
        if key ~= nil and key == "restitution" then
            object.restitution = object.fixture[1].restitution
        end
        if key ~= nil and key == "friction" then
            object.friction = object.fixture[1].friction
        end
        if key ~= nil and key == "filter" then
            object.filter = object.fixture[1].filter
        end
        if key ~= nil and key == "density" then
            object.density = object.fixture[1].density
        end
        if key ~= nil and key == "sensor" then
            object.sensor = object.fixture[1].sensor
        end
    end

    return getmetatable(self).__object[key]
end

-- Create a new proxy for RNObject Object


function RNObject:new(o)
    local displayobject = RNObject:innerNew(o)
    local proxy = setmetatable({}, { __newindex = fieldChangedListener, __index = fieldAccessListener, __object = displayobject })
    return proxy, displayobject
end

-- Create a new RNObject Object
function RNObject:innerNew(o)

    o = o or {
        name = "",
        myName = nil,
        image = nil,
        originalHeight = 0,
        originalWidth = 0,
        pow2Widht = 0,
        pow2Height = 0,
        x = 0,
        y = 0,
        gfxQuad = nil,
        shader = nil,
        screenX = 0,
        screenY = 0,
        visible = true,
        touchListener = nil,
        onTouchDownListener = nil,
        children = {},
        childrenSize = 0,
        currentRefX = 0,
        currentRefY = 0,
        isVisible = true,
        tileDeck = nil,
        --physic metamerge
        isPhysical = false,
        physicObject = nil,
        collision = nil,
        userdata = nil,
        bodyType = "",
        myName = nil,
        isAwake = nil,
        awake = nil,
        isActive = nil,
        active = nil,
        isBullet = nil,
        setBullet = nil,
        fixedRotation = nil,
        angularVelocity = nil,
        angularDamping = nil,
        linearVelocityX = nil,
        linearVelocityY = nil,
        linearDamping = nil,
        isSensor = nil,
        isSleepingAllowed = true,
        fixture = {},
        restitution = nil,
        friction = nil,
        density = nil,
        filter = nil,
        sensor = nil,
        --per l'anim
        scaleX = nil,
        scaleY = nil,
        sizex = nil,
        sizey = nil,
        isAnim = false,
        frame = nil,
        speed = nil,
        pause = true,
        animCounter = 0,
        sequenceList = {},
        currentSequence = nil,
        frameNumberTotal = 0,
    }

    self.stageBounds = {
        xMin = 0,
        yMin = 0,
        xMax = 0,
        yMax = 0
    }

    self.isFocus = false

    setmetatable(o, self)
    self.__index = self
    return o
end


function RNObject:initCopyRect(src, params)
    self.visible = true
    self.childrenSize = 0

    self.alpha = 1
    self:loadCopyRect(src, params)
end


function RNObject:initBlank(width, height)

    self.name = image

    self.gfxQuad = MOAIGfxQuad2D.new()

    self.image = MOAIImage.new()
    self.image:init(width, height)


    self.originalWidth, self.originalHeight = self.image:getSize()

    self.image = self.image:padToPow2()
    self.gfxQuad:setTexture(self.image)

    self.pow2Widht, self.pow2Height = self.image:getSize()

    self.prop = MOAIProp2D.new()

    local u = self.originalWidth / self.pow2Widht
    local v = self.originalHeight / self.pow2Height

    self.gfxQuad:setUVRect(0, 0, u, v)


    self.prop:setDeck(self.gfxQuad)
    self.gfxQuad:setRect(-self.originalWidth / 2, -self.originalHeight / 2, (self.originalWidth) / 2, (self.originalHeight) / 2)
    self.prop:setPriority(1)
end

function RNObject:loadCopyRect(src, params)

    local image

    if (type(src) == "string") then
        image = MOAIImage.new()
        image:load(src, MOAIImage.TRUECOLOR + MOAIImage.PREMULTIPLY_ALPHA)
    elseif (type(src) == "userdata") then -- light check should be a MOAIImage.
        image = src
    end

    self.name = ""

    self.gfxQuad = MOAIGfxQuad2D.new()

    self.image = MOAIImage.new()

    local tmpWidth = params.srcXMax - params.srcXMin
    local tmpEight = params.srcYMax - params.srcYMin

    self.image:init(tmpWidth, tmpEight)

    self.image:copyRect(image, params.srcXMin, params.srcYMin, params.srcXMax, params.srcYMax, params.destXMin, params.destYMin, params.destXMax, params.destYMax, params.filter)

    -- self.image.

    self.originalWidth, self.originalHeight = self.image:getSize()

    self.image = self.image:padToPow2()
    self.gfxQuad:setTexture(self.image)

    self.pow2Widht, self.pow2Height = self.image:getSize()

    self.prop = MOAIProp2D.new()

    local u = self.originalWidth / self.pow2Widht
    local v = self.originalHeight / self.pow2Height

    self.gfxQuad:setUVRect(0, 0, u, v)


    self.prop:setDeck(self.gfxQuad)
    self.gfxQuad:setRect(-self.originalWidth / 2, -self.originalHeight / 2, (self.originalWidth) / 2, (self.originalHeight) / 2)
    self.prop:setPriority(1)
end


function RNObject:initWith(image)
    self.visible = true
    self.childrenSize = 0

    self.alpha = 1
    self:loadImage(image)
end

function RNObject:initWithMoaiImage(moaiImage)
    self.visible = true
    self.childrenSize = 0

    self.alpha = 1
    self.name = ""

    self.gfxQuad = MOAIGfxQuad2D.new()

    self.image = moaiImage

    self.originalWidth, self.originalHeight = self.image:getSize()

    self.image = self.image:padToPow2()
    self.gfxQuad:setTexture(self.image)

    self.pow2Widht, self.pow2Height = self.image:getSize()

    self.prop = MOAIProp2D.new()

    local u = self.originalWidth / self.pow2Widht
    local v = self.originalHeight / self.pow2Height

    self.gfxQuad:setUVRect(0, 0, u, v)


    self.prop:setDeck(self.gfxQuad)
    self.gfxQuad:setRect(-self.originalWidth / 2, -self.originalHeight / 2, (self.originalWidth) / 2, (self.originalHeight) / 2)
    self.prop:setPriority(1)
end


function RNObject:loadImage(image)
    self.name = image

    self.gfxQuad = MOAIGfxQuad2D.new()

    self.image = MOAIImage.new()
    self.image:load(image, MOAIImage.TRUECOLOR + MOAIImage.PREMULTIPLY_ALPHA)

    self.originalWidth, self.originalHeight = self.image:getSize()

    self.image = self.image:padToPow2()
    self.gfxQuad:setTexture(self.image)

    self.pow2Widht, self.pow2Height = self.image:getSize()

    self.prop = MOAIProp2D.new()

    local u = self.originalWidth / self.pow2Widht
    local v = self.originalHeight / self.pow2Height

    self.gfxQuad:setUVRect(0, 0, u, v)


    self.prop:setDeck(self.gfxQuad)
    self.gfxQuad:setRect(-self.originalWidth / 2, -self.originalHeight / 2, (self.originalWidth) / 2, (self.originalHeight) / 2)
    self.prop:setPriority(1)
end


function RNObject:getDebugName()
    return self.name
end


function RNObject:initAnimWith(image, sx, sy, scaleX, scaleY)
    self.visible = true
    self.childrenSize = 0

    self.alpha = 1
    self:loadAnim(image, sx, sy, scaleX, scaleY)
end


function RNObject:setIDInGroup(id)
    self.idInGroup = id
end

function RNObject:setIDInScreen(id)
    self.idInScreen = id
end

function RNObject:loadAnim(image, sx, sy, scaleX, scaleY)
    self.name = image

    self.tileDeck = MOAITileDeck2D.new()


    self.image = MOAIImage.new()
    self.image:load(image, MOAIImage.TRUECOLOR + MOAIImage.PREMULTIPLY_ALPHA)
    -- self.image = self.image:padToPow2()
    self.originalWidth, self.originalHeight = self.image:getSize()


    self.image = self.image:padToPow2()


    local oWnotPadded = self.originalWidth
    local oHnotPadded = self.originalHeight


    self.originalWidth, self.originalHeight = self.image:getSize()


    self.tileDeck:setTexture(self.image)
    local px = self.originalWidth / sx
    local py = self.originalHeight / sy
    --self.tileDeck:setSize(number width, number height [, number cellWidth, number cellHeight, number xOff, number yOff, number tileWidth, number tileHeight ] )
    self.tileDeck:setSize(px, py, 1 / px, 1 / py, 0, 0, 1 / px, 1 / py)
    self.prop = MOAIProp2D.new()
    self.prop:setIndex(1)

    self.prop:setDeck(self.tileDeck)

    local oW = self.originalWidth
    local oH = self.originalHeight

    self.tileDeck:setRect(sx * scaleX, sy * scaleY, -sx * scaleX, -sy * scaleY)
    self.originalWidth = sx * scaleX * 2
    self.originalHeight = sy * scaleY * 2
    self.scaleX = scaleX
    self.scaleY = scaleY
    self.sizex = sx
    self.sizey = sy
    self.isAnim = true
    self.frameNumberTotal = oW / sx * oH / sy

    --we check for default sequence frame Order
    local defaultFrameOrder = {}
    for j = 1, self.frameNumberTotal, 1 do defaultFrameOrder[j] = j end
    --we create a new sequence
    self:newSequence("default", defaultFrameOrder, 12, 1, nil)
    --and set it as current
    self.currentSequence = "default"
    self.frame = 1
    RNListeners:addEventListener("enterFrame", self)
end

function RNObject:enterFrame(event)
    --takes self as himself
    self = self.source
    --uptades counter
    self.animCounter = self.animCounter + 1
    --if it's not paused
    if self.pause == false then
        --we check for the right sequence to play
        local rightSequenceToPlay = nil
        if self.sequenceList ~= nil then
            for i = 1, table.getn(self.sequenceList), 1 do
                if self.sequenceList[i].name == self.currentSequence then rightSequenceToPlay = i end
            end
        end
        local rightSequence = self.sequenceList[rightSequenceToPlay]
        --if the counter reachs the sequence speed
        if self.animCounter == rightSequence.speed then
            --we check for the next sequence's frame to play
            local nextSequenceFrame
            if rightSequence.frameOrder[rightSequence.currentFrame + 1] ~= nil then
                nextSequenceFrame = rightSequence.frameOrder[rightSequence.currentFrame + 1]
                rightSequence.currentFrame = rightSequence.currentFrame + 1
            else
                nextSequenceFrame = rightSequence.frameOrder[1]
                rightSequence.currentFrame = 1
            end
            --we upgrade the sequence repeated times, if it is not -1 (infinite loop)
            if rightSequence.reapeatTimes ~= -1 then rightSequence.timeRepeated = rightSequence.timeRepeated + 1 end
            --the object goes to the right frame
            self.frame = nextSequenceFrame
            --the counter goes back to 0
            self.animCounter = 0
            --if we have repeated the sequence enough
            if rightSequence.timeRepeated == rightSequence.repeatTimes * rightSequence.speed then
                self.pause = true
                if rightSequence.onStop ~= nil then
                    local funct = rightSequence.onStop
                    funct()
                end
            end
        end
    end
end

function RNObject:togglePause()
    if self.isAnim == true then
        if self.pause == true then self.pause = false else self.pause = true end
    end
end

function RNObject:stop()
    if self.isAnim == true then
        self.pause = true
        self.frame = 1
        local rightSequenceToPlay = nil
        if self.sequenceList ~= nil then
            for i = 1, table.getn(self.sequenceList), 1 do
                if self.sequenceList[i].name == self.currentSequence then rightSequenceToPlay = i end
            end
        end
        local rightSequence = self.sequenceList[rightSequenceToPlay]
        rightSequence.timeRepeated = 0
        rightSequence.currentFrame = 1
    end
end

function RNObject:play(sequenceName, speed, repeatTimes, onStop)
    if self.isAnim == true then
        if sequenceName == nil then sequenceName = "default" end
        self.pause = false
        self.currentSequence = sequenceName

        local rightSequenceToPlay = nil
        if self.sequenceList ~= nil then
            for i = 1, table.getn(self.sequenceList), 1 do
                if self.sequenceList[i].name == sequenceName then rightSequenceToPlay = i end
            end
        end
        local rightSequence = self.sequenceList[rightSequenceToPlay]

        rightSequence.timeRepeated = 0
        rightSequence.currentFrame = 1

        if speed ~= nil then rightSequence.speed = speed end
        if repeatTimes ~= nil then rightSequence.repeatTimes = repeatTimes end
        if onStop ~= nil then rightSequence.onStop = onStop end
    end
end

function RNObject:newSequence(name, frameOrder, speed, repeatTimes, onStop)
    if self.isAnim == true then
        local listn = table.getn(self.sequenceList)
        local sequence = {}
        if speed == nil then speed = 24 end
        if repeatTimes == nil then repeatTimes = 1 end
        if frameOrder == nil then frameOrder = self.sequenceList[1].frameOrder end
        sequence.name = name
        sequence.frameOrder = frameOrder
        sequence.speed = speed
        sequence.repeatTimes = repeatTimes
        sequence.onStop = onStop
        sequence.currentFrame = 1
        sequence.timeRepeated = 0

        self.sequenceList[listn + 1] = sequence
    end
end

function RNObject:removeSequence(name)
    if name ~= "default" then
        if self.isAnim == true then
            local tempValue
            if self.sequenceList ~= nil then
                for i = 1, table.getn(self.sequenceList), 1 do
                    if self.sequenceList[i].name == name then
                        tempValue = i
                    end
                end
            end
            for k = tempValue, table.getn(self.sequenceList), 1 do
                if k < table.getn(self.sequenceList) then
                    self.sequenceList[k] = self.sequenceList[k + 1]
                else
                    self.sequenceList[k] = nil
                end
            end
        end
    end
end

function RNObject:flipHorizzontal()
    self.scalex = -1
end

function RNObject:flipVertical()
    self.scaley = -1
end

function RNObject:setTileSizeX(value)
    self.tileDeck:setSize(value, self.scaleY)
end

function RNObject:setTileSizeY(value)
    self.tileDeck:setSize(self.scaleX, value)
end

function RNObject:setSize(Sx, Sy)
    self.tileDeck:setSize(Sx, Sy)
end

function RNObject:setLevel(value)
    self.prop:setPriority(value)
    self.parentGroup:inserLevel(self:getLevel())
end

function RNObject:getLevel()
    return self.prop:getPriority()
end

function RNObject:sendToBottom()
    self.parentGroup:sendToBottom(self)
end

function RNObject:bringToFront()
    self.parentGroup:bringToFront(self)
end

function RNObject:putOver(object)
    self.prop:setPriority(object:getLevel() + 1)
    self.parentGroup:inserLevel(self:getLevel())
end

function RNObject:setTileScaleX(value)
    self.originalWidth = (self.originalWidth / 2 / self.scaleX / self.sizex) * value * 2 * self.sizex
    self.tileDeck:setRect(self.originalWidth / 2, self.originalHeight / 2, -self.originalWidth / 2, -self.originalHeight / 2)
end

function RNObject:setTileScaleY(value)
    self.originalHeight = (self.originalHeight / 2 / self.scaleY / self.sizey) * value * 2 * self.sizey
    self.tileDeck:setRect(self.originalWidth / 2, self.originalHeight / 2, -self.originalWidth / 2, -self.originalHeight / 2)
end

function RNObject:getChildren()
    return self.children
end

function RNObject:getChildat(index)
    return self.children[index]
end

function RNObject:addChild(sprite)
    self.children[self.childrenSize] = sprite
    self.childrenSize = self.childrenSize + 1
end

function RNObject:setParentScene(scene)
    self.scene = scene
end

function RNObject:getChildrenSize()
    return self.childrenSize
end

function RNObject:getImageName()
    return self.name
end

function RNObject:getGfxQuad()
    return self.gfxQuad
end

function RNObject:getProp()
    return self.prop
end

function RNObject:updateLocation()
    self:setLocation(self.x, self.y)
end

function RNObject:setLocatingMode(mode)
    self.locatingMode = mode
end

function RNObject:getOriginalWidth()
    return self.originalWidth
end

function RNObject:getOriginalHeight()
    return self.originalHeight
end


function RNObject:getLocation()
    return self.x, self.y
end

function RNObject:getX()
    if self.isPhyisic == false then
        return self.x
    else
        return self.physicObject:getX()
    end
end

function RNObject:getY()
    if self.isPhyisic == false then
        return self.y
    else
        return self.physicObject:getY()
    end
end

function RNObject:getAlpha()
    return self.alpha
end

function RNObject:setAlpha(value)
    self.alpha = value
    self.prop:setColor(value, value, value, value, 0)
end

function RNObject:getShader()
    return self.shader
end

function RNObject:getImage()
    return self.image
end

function RNObject:getLocatingMode()
    return self.locatingMode
end

function RNObject:setVisible(value)
    if self.isPhysical == false then
        if self.prop ~= nil then
            self.prop:setVisible(value)
        end
    else
        if self.prop ~= nil then
            self.prop:setVisible(value)
            if value == true then
                self.prop:setParent(self.physicObject.body)
            else
                self.prop:setParent(nil)
            end
        end
    end
end

function RNObject:getVisible()
    return self.visible
end


function RNObject:TOP_LEFT_MODE()
    return TOP_LEFT_MODE
end

function RNObject:getSDType()
    return "RNObject"
end

function RNObject:setLocation(x, y)

    local tmpX = x
    local tmpY = y

    if (self:getProp() ~= nil) then
        self:getProp():setLoc(tmpX, tmpY);
    end

    self.x = x
    self.y = y
end


function RNObject:setY(y)

    if self.isPhysical == false then
        local tmpX = self.x
        local tmpY = self.currentRefY + y

        if (self:getProp() ~= nil) then
            self:getProp():setLoc(tmpX, tmpY);
        end
    else
        self.physicObject:setY()
    end

    self.y = self.currentRefY + y
end

function RNObject:setX(x)

    if self.isPhysical == false then
        local tmpX = self.currentRefX + x
        local tmpY = self.y


        if (self:getProp() ~= nil) then
            self:getProp():setLoc(tmpX, tmpY);
        end
    else
        self.physicObject:setX()
    end
    self.x = self.currentRefX + x
end

function RNObject:addEventListener(eventName, func)
    if eventName == "collision" then
        self.physicObject:addEventListener("collision")
    else
        RNInputManager.addListenerToEvent(eventName, func, self)
    end
end

function RNObject:isInRange(x, y)

    local buttonx = x
    local buttony = y

    buttonx = x + self.originalWidth / 2
    buttony = y + self.originalHeight / 2

    if self.visible
            and buttonx >= self.x
            and buttonx <= self.x + self.originalWidth
            and buttony >= self.y
            and buttony <= self.y + self.originalHeight
    then

        return true
    end

    return false
end

function RNObject:onTouchDown(x, y, source)

    x = x + self.originalWidth / 2
    y = y + self.originalHeight / 2

    if self.visible and self.onTouchDownListener ~= nil and x >= self.x and x <= self.x + self.originalWidth and y >= self.y and y <= self.y + self.originalHeight then
        self.onTouchDownListener(x, y, source)
        return true
    end
end

function RNObject:onTouchMove(x, y, source)
    if self.visible and self.touchListener ~= nil and x >= self.x and x <= self.x + self.originalWidth and y >= self.y and y <= self.y + self.originalHeight then
        self.onTouchMoveListener(x, y, source)
        return true
    end
end

function RNObject:onTouchUp(x, y, source)
    if self.visible and self.touchListener ~= nil and x >= self.x and x <= self.x + self.originalWidth and y >= self.y and y <= self.y + self.originalHeight then
        self.onTouchUpListener(x, y, source)
        return true
    end
end

function RNObject:onTouchCancel(x, y, source)
    if self.visible and self.touchListener ~= nil and x >= self.x and x <= self.x + self.originalWidth and y >= self.y and y <= self.y + self.originalHeight then
        self.onTouchCancelListener(x, y, source)
        return true
    end
end

function RNObject:setOnTouchDown(func)
    self.onTouchDownListener = func
end

function RNObject:setOnTouchMove(func)
end

function RNObject:setOnTouchUp(func)
    self.onOnTouchUpListener = func
end

function RNObject:setOnTouchCancel(func)
end

function RNObject:getTranslatedLocation(x, y)
end

function RNObject:setParentGroup(group)
    self.parentGroup = group
end

function RNObject:setAllFixture(field, value)

    for i = 1, table.getn(self.fixture), 1 do
        if field == "restitution" then
            self.fixture[i].restitution = value
        elseif field == "friction" then
            self.fixture[i].friction = value
        elseif field == "filter" then
            self.fixture[i].filter = value
        elseif field == "density" then
            self.fixture[i].density = value
        elseif field == "sensor" then
            self.fixture[i].sensor = value
        end
    end
end

--
-- calls to phsyic object methods
--
function RNObject:remove()
    self.scene:removeRNObject(self)
    --print_r(self.scene)
    if self.isPhysical == true then
        self.physicObject:remove()
    else
        self.prop:setDeck(nil)
    end
    --print("remove", self.idInGroup)
    self.parentGroup:removeChild(self.idInGroup)
end

--if it's awake (returns boolean)
function RNObject:isAwake()
    return self.physicObject:isAwake()
end

--sets the body as awake (true or false)
function RNObject:setAwake(value)
    self.physicObject:setAwake(value)
end


--if it's active (returns boolean)

function RNObject:isActive()
    return self.physicObject:isActive()
end

--sets the body as active (true or false)
function RNObject:setActive(value)
    self.physicObject:setActive(value)
end


--if it's bullet
function RNObject:isBullet()
    return self.physicObject:isBullet()
end


--sets the body as bullet[a bullet body is under continuous collision checking] (true or false)
function RNObject:setBullet(value)
    self.physicObject:setBullet(value)
end

--if its rotation is fixed (returns boolean)
function RNObject:isFixedRotation()
    return self.physicObject:isFixedRotation()
end

--prevents the body from rotation (true or false)
function RNObject:setFixedRotation(value)
    self.physicObject:setFixedRotation(value)
end

--gets the angular velocity
function RNObject:getAngularVelocity()
    return self.physicObject:getAngularVelocity()
end

--sets the angular velocity
function RNObject:setAngularVelocity(value)
    self.physicObject:setAngularVelocity(value)
end

--gets the linear damping
function RNObject:getLinearDamping()
    return self.physicObject:getLinearDamping()
end

--sets the linear damping
function RNObject:setLinearDamping(value)
    self.physicObject:setLinearDamping(value)
end

--gets the angular damping
function RNObject:getAngularDamping()
    return self.physicObject:getAngularDamping()
end

--sets the angular damping
function RNObject:setAngularDamping(value)
    self.physicObject:setAngularDamping(value)
end


--gets the linear velocity
function RNObject:getLinearVelocity()
    return self.physicObject:getLinearVelocity()
end

--sets the linear velocity
function RNObject:setLinearVelocity(valuex, valuey)
    self.physicObject:setLinearVelocity(valuex, valuey)
end


--sets all fixture of this body as sensors
function RNObject:setSensor(value)
    self.physicObject:setSensor(value)
end

--
-- Additional working accessible proprieties and methods from MOAIbox2d (check moai documentation)
--
--body:getAngle()
function RNObject:getAngle()
    return self.physicObject:getAngle()
end

--body:getLocalCenter()
function RNObject:getLocalCenter()
    return self.physicObject:getLocalCenter()
end

--body:getPosition()
function RNObject:getPosition()
    return self.physicObject:getPosition()
end

--body:getWorldCenter()
function RNObject:getWorldCenter()
    return self.physicObject:getWorldCenter()
end

--body:resetMassData()
function RNObject:resetMassData()
    self.physicObject:resetMassData()
end

--body:setMassData(number mass [, number I, number centerX, number centerY ])
function RNObject:setMassData(mass, I, centerX, centerY)
    self.physicObject:setMassData(mass, I, centerX, centerY)
end


--body:setTransform([, number positionX, number positionY, number angle ])
function RNObject:setTransform(positionX, positionY, angle)
    self.physicObject:setTransform(positionX, positionY, angle)
end

function RNObject:setAngle(Angle)
    self.physicObject:setAngle(Angle)
end

--
-- physic bodies common working methods--------------------------------------------
--

--body:applyForce(number forceX, number forceY [, number pointX, number pointY ] )
function RNObject:applyForce(forceX, forceY, pointX, pointY)
    self.physicObject:applyForce(forceX, forceY, pointX, pointY)
end

--body:applyTorque(number torque)
function RNObject:applyTorque(value)
    self.physicObject:applyTorque(value)
end

--body:applyLinearImpulse(number impulseX, number impulseY [, number pointX, number pointY ] )
function RNObject:applyLinearImpulse(impulseX, impulseY, pointX, pointY)
    self.physicObject:applyLinearImpulse(impulseX, impulseY, pointX, pointY)
end

--body:applyAngularImpulse( number impulse )
function RNObject:applyAngularImpulse(value)
    self.physicObject:applyAngularImpulse(value)
end




-- additional methods from last update

function RNObject:getInertia()
    return self.physicObject:getInertia()
end

function RNObject:getMass()
    return self.physicObject:getInertia()
end

function RNObject:setMassData(mass, I, centerX, centerY)
    if I ~= nil then
        self.physicObject:setMassData(mass, I, centerX, centerY)
    else
        self.physicObject:setMassData(mass)
    end
end