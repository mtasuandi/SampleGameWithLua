MenuLevelStateBorneo = class( State )

MenuLevelStateBorneo.MENU_ITEM_START_GAME = 0
MenuLevelStateBorneo.MENU_ITEM_OPTION = 1
MenuLevelStateBorneo.MENU_ITEM_QUIT = 2
LocCursor_X = -45
LocCursor_Y = -10
local gfxQuads, names = load ( 'button-level.lua', 100/100 )

function MenuLevelStateBorneo:init( layer )
    print("oke")
	KALIMANTAN_LEVEL_STATE = KalimantanLevelSatu( RENDER_SYSTEM.layer )
	print("oke2")
    State.init( self, "MenuLevelStateBorneo" )
	partition = MOAIPartition.new ()
    self.layer = layer
	
    self.bglevel = MOAIProp2D.new()
    self.bglevel:setDeck( SKIES_2D2 )
    self.bglevel:setLoc( BASE_LOCATION_X, BASE_LOCATION_Y )
    
	self.btnlevel = MOAIProp2D.new()
	self.btnlevel:setDeck ( gfxQuads )
	self.btnlevel:setIndex ( names ['btn-on.png'] )
	self.btnlevel:setLoc ( BASE_LOCATION_X-170, BASE_LOCATION_Y+60 )
	
	self.btnlevel2 = MOAIProp2D.new()
	self.btnlevel2:setDeck ( gfxQuads )
	self.btnlevel2:setIndex ( names ['btn-off.png'] )
	self.btnlevel2:setLoc ( BASE_LOCATION_X-90, BASE_LOCATION_Y+60 )
	
	self.btnlevel3 = MOAIProp2D.new()
	self.btnlevel3:setDeck ( gfxQuads )
	self.btnlevel3:setIndex ( names ['btn-off.png'] )
	self.btnlevel3:setLoc ( BASE_LOCATION_X-10, BASE_LOCATION_Y+60 )
	
	self.btnlevel4 = MOAIProp2D.new()
	self.btnlevel4:setDeck ( gfxQuads )
	self.btnlevel4:setIndex ( names ['btn-off.png'] )
	self.btnlevel4:setLoc ( BASE_LOCATION_X+70, BASE_LOCATION_Y+60 )
	
	self.btnlevel5 = MOAIProp2D.new()
	self.btnlevel5:setDeck ( gfxQuads )
	self.btnlevel5:setIndex ( names ['btn-off.png'] )
	self.btnlevel5:setLoc ( BASE_LOCATION_X+150, BASE_LOCATION_Y+60 )
	
	-- button 6-10
	self.btnlevel6 = MOAIProp2D.new()
	self.btnlevel6:setDeck ( gfxQuads )
	self.btnlevel6:setIndex ( names ['btn-off.png'] )
	self.btnlevel6:setLoc ( BASE_LOCATION_X-170, BASE_LOCATION_Y-10 )
	
	self.btnlevel7 = MOAIProp2D.new()
	self.btnlevel7:setDeck ( gfxQuads )
	self.btnlevel7:setIndex ( names ['btn-off.png'] )
	self.btnlevel7:setLoc ( BASE_LOCATION_X-90, BASE_LOCATION_Y-10 )
	
	self.btnlevel8 = MOAIProp2D.new()
	self.btnlevel8:setDeck ( gfxQuads )
	self.btnlevel8:setIndex ( names ['btn-off.png'] )
	self.btnlevel8:setLoc ( BASE_LOCATION_X-10, BASE_LOCATION_Y-10 )
	
	self.btnlevel9 = MOAIProp2D.new()
	self.btnlevel9:setDeck ( gfxQuads )
	self.btnlevel9:setIndex ( names ['btn-off.png'] )
	self.btnlevel9:setLoc ( BASE_LOCATION_X+70, BASE_LOCATION_Y-10 )
	
	self.btnlevel10 = MOAIProp2D.new()
	self.btnlevel10:setDeck ( gfxQuads )
	self.btnlevel10:setIndex ( names ['btn-off.png'] )
	self.btnlevel10:setLoc ( BASE_LOCATION_X+150, BASE_LOCATION_Y-10 )
	-- end button 6-10
	
	--self.layer = MOAILayer2D.new()
	--self.layer:setViewport (viewport)
	--MOAISim.pushRenderPass (self.layer)
	charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
	self.font = MOAIFont.new ()
	self.font:loadFromTTF ( 'asset/font/arial-rounded.TTF', charcodes, 20, 163 )
	
	self.textbox = MOAITextBox.new ()
	self.textbox:setString ( '<c:f70>1<c>' )
	self.textbox:setFont ( self.font )
	self.textbox:setTextSize ( self.font:getScale ())
	self.textbox:setRect ( -155, -117, 155, 117 )
	self.textbox:setLoc ( BASE_LOCATION_X, BASE_LOCATION_Y )
	self.textbox:setYFlip ( true )
	
	self.textbox2 = MOAITextBox.new ()
    self.textbox2:setString ( '<c:f70>2<c>' )
    self.textbox2:setFont ( self.font )
    self.textbox2:setTextSize ( self.font:getScale ())
    self.textbox2:setRect ( -155, -117, 155, 117 )
    self.textbox2:setLoc ( BASE_LOCATION_X+80, BASE_LOCATION_Y )
    self.textbox2:setYFlip ( true )
    
    self.textbox3 = MOAITextBox.new ()
    self.textbox3:setString ( '<c:f70>3<c>' )
    self.textbox3:setFont ( self.font )
    self.textbox3:setTextSize ( self.font:getScale ())
    self.textbox3:setRect ( -155, -117, 155, 117 )
    self.textbox3:setLoc ( BASE_LOCATION_X+160, BASE_LOCATION_Y )
    self.textbox3:setYFlip ( true )
    
    self.textbox4 = MOAITextBox.new ()
    self.textbox4:setString ( '<c:f70>4<c>' )
    self.textbox4:setFont ( self.font )
    self.textbox4:setTextSize ( self.font:getScale ())
    self.textbox4:setRect ( -155, -117, 155, 117 )
    self.textbox4:setLoc ( BASE_LOCATION_X+240, BASE_LOCATION_Y )
    self.textbox4:setYFlip ( true )
    
    self.textbox5 = MOAITextBox.new ()
    self.textbox5:setString ( '<c:f70>5<c>' )
    self.textbox5:setFont ( self.font )
    self.textbox5:setTextSize ( self.font:getScale ())
    self.textbox5:setRect ( -155, -117, 155, 117 )
    self.textbox5:setLoc ( BASE_LOCATION_X+320, BASE_LOCATION_Y )
    self.textbox5:setYFlip ( true )
    
    self.textbox6 = MOAITextBox.new ()
    self.textbox6:setString ( '<c:f70>6<c>' )
    self.textbox6:setFont ( self.font )
    self.textbox6:setTextSize ( self.font:getScale ())
    self.textbox6:setRect ( -155, -117, 155, 117 )
    self.textbox6:setLoc ( BASE_LOCATION_X, BASE_LOCATION_Y-70 )
    self.textbox6:setYFlip ( true )
    
    self.textbox7 = MOAITextBox.new ()
    self.textbox7:setString ( '<c:f70>7<c>' )
    self.textbox7:setFont ( self.font )
    self.textbox7:setTextSize ( self.font:getScale ())
    self.textbox7:setRect ( -155, -117, 155, 117 )
    self.textbox7:setLoc ( BASE_LOCATION_X+80, BASE_LOCATION_Y-70 )
    self.textbox7:setYFlip ( true )

	self.textbox8 = MOAITextBox.new ()
    self.textbox8:setString ( '<c:f70>8<c>' )
    self.textbox8:setFont ( self.font )
    self.textbox8:setTextSize ( self.font:getScale ())
    self.textbox8:setRect ( -155, -117, 155, 117 )
    self.textbox8:setLoc ( BASE_LOCATION_X+160, BASE_LOCATION_Y-70 )
    self.textbox8:setYFlip ( true )
    
    self.textbox9 = MOAITextBox.new ()
    self.textbox9:setString ( '<c:f70>9<c>' )
    self.textbox9:setFont ( self.font )
    self.textbox9:setTextSize ( self.font:getScale ())
    self.textbox9:setRect ( -155, -117, 155, 117 )
    self.textbox9:setLoc ( BASE_LOCATION_X+240, BASE_LOCATION_Y-70 )
    self.textbox9:setYFlip ( true )
    
    self.textbox10 = MOAITextBox.new ()
    self.textbox10:setString ( '<c:f70>10<c>' )
    self.textbox10:setFont ( self.font )
    self.textbox10:setTextSize ( self.font:getScale ())
    self.textbox10:setRect ( -155, -117, 155, 117 )
    self.textbox10:setLoc ( BASE_LOCATION_X+306, BASE_LOCATION_Y-70 )
    self.textbox10:setYFlip ( true )
end

function MenuLevelStateBorneo:enter()
	self.layer:insertProp( self.bglevel )
	self.layer:insertProp( self.btnlevel )
    self.layer:insertProp( self.textbox )
    self.layer:insertProp( self.textbox2 )
	self.layer:insertProp( self.btnlevel2 )
	self.layer:insertProp( self.textbox3)
	self.layer:insertProp( self.btnlevel3 )
	self.layer:insertProp( self.textbox4)
	self.layer:insertProp( self.btnlevel4 )
	self.layer:insertProp( self.textbox5)
	self.layer:insertProp( self.btnlevel5 )
	-- button 6-10
	self.layer:insertProp( self.textbox6 )
	self.layer:insertProp( self.btnlevel6 )
	self.layer:insertProp( self.textbox7 )
	self.layer:insertProp( self.btnlevel7 )
	self.layer:insertProp( self.textbox8 )
	self.layer:insertProp( self.btnlevel8 )
	self.layer:insertProp( self.textbox9)
	self.layer:insertProp( self.btnlevel9 )
	self.layer:insertProp( self.textbox10)
	self.layer:insertProp( self.btnlevel10 )
	-- end button 6-10
	
	function pointerCallback ( x,y )
		local oldX = mouseX
		local oldY = mouseY
		
		mouseX, mouseY = self.layer:wndToWorld ( x,y )
		
		if pick then
			else
		end
	end
		function clickCallback (down)
			if down then
				pick = partition:propForPoint ( mouseX, mouseY )
				
				if pick then
					if pick == self.btnlevel or pick == self.textbox then
						pick:setIndex ( names ['btn-off.png'] )
						else if pick == self.btnlevel2 then
						pick:setIndex( names ['btn-on.png'] )
						end
					end
				end
			else
				if pick then
					if pick == self.btnlevel then
					print ("Entry Game Level 1 Kalimantan")
					GAME_STATE_MACHINE:setCurrentState ( KALIMANTAN_LEVEL_STATE )
					pick = nil
					else if pick == self.btnlevel2 then
					--GAME_STATE_MACHINE:setCurrentState ( KALIMANTAN_LEVEL_STATE )
					pick = nil
				end
				end
			end
		end	
end
	MOAIInputMgr.device.pointer:setCallback ( pointerCallback )
	MOAIInputMgr.device.mouseLeft:setCallback ( clickCallback )
end

function MenuLevelStateBorneo:exit()
	self.layer:clear()
	
end

MENU_LEVEL_STATE_BORNEO = nil
