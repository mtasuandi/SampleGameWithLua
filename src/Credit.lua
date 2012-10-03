Credit = class ( State )

function Credit:init(layer)
viewport = MOAIViewport.new ()
viewport:setSize ( 480, 320)
viewport:setScale ( 480, 320)

self.layer = MOAILayer2D.new ()
self.layer:setViewport ( viewport )
MOAISim.pushRenderPass ( self.layer )
end

function Credit:enter()
font = MOAIFont.new ()
font:loadFromTTF ( "arial-rounded.ttf", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?!", 12, 163 )
self.textbox = MOAITextBox.new ()
self.textbox:setFont ( font )
self.textbox:setTextSize ( font:getScale () )
self.textbox:setRect ( -160, -80, 160, 80 )
self.textbox:setLoc ( 0, 50 )
self.textbox:setYFlip ( true )
self.textbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY )
self.layer:insertProp ( self.textbox )
self.textbox:setString ( "<c:0F0>Pertamax Gan.... :mahos<c>" )
self.textbox:spool ()
end