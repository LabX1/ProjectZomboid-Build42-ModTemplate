-- Create mod structure in: /SimpleAmmoDisplay/common/media/lua/client/AmmoDisplayUI.lua

require "ISUI/ISUIElement"

SimpleAmmoDisplay = ISUIElement:derive("SimpleAmmoDisplay")

function SimpleAmmoDisplay:new(x, y, width, height)
    local o = {}
    o = ISUIElement:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y
    o.width = width
    o.height = height
    o.borderColor = {r=0.6, g=0.6, b=0.6, a=0.8}
    o.backgroundColor = {r=0.1, g=0.1, b=0.1, a=0.9}
    o.moveWithMouse = false
    o.isDragging = false
    return o
end

function SimpleAmmoDisplay:onMouseDown(x, y)
    self.isDragging = true
    self.dragX = x
    self.dragY = y
    return true
end

function SimpleAmmoDisplay:onMouseUp(x, y)
    self.isDragging = false
    return true
end

function SimpleAmmoDisplay:onMouseMoveOutside(dx, dy)
    if self.isDragging then
        self:setX(self:getX() + dx)
        self:setY(self:getY() + dy)
    end
end

function SimpleAmmoDisplay:onMouseMove(dx, dy)
    if self.isDragging then
        self:setX(self:getX() + dx)
        self:setY(self:getY() + dy)
    end
end

function SimpleAmmoDisplay:prerender()
    if self:isMouseOver() then
        self.borderColor = {r=1, g=1, b=1, a=1}
    else
        self.borderColor = {r=0.6, g=0.6, b=0.6, a=0.8}
    end
end

function SimpleAmmoDisplay:render()
    local player = getSpecificPlayer(0)
    if not player then return end
    
    local primaryItem = player:getPrimaryHandItem()
    if primaryItem and primaryItem:isRanged() then
        -- Get the current magazine and chambered round
        local magazineType = primaryItem:getMagazineType()
        local magazine = magazineType and primaryItem:getCurrentAmmoCount() or 0
        local maxAmmo = primaryItem:getMaxAmmo() or 0
        local chamberedRound = primaryItem:isRoundChambered() and 1 or 0
        local totalAmmo = magazine + chamberedRound
        
        -- Draw panel background
        self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, 
            self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
        
        -- Draw border with hover effect
        self:drawRectBorder(0, 0, self.width, self.height, 
            self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
        
        -- Draw title
        self:drawText("Simple Ammo Display", 10, 8, 0.8, 0.8, 0.8, 1.0, UIFont.Small)
        
        -- Draw ammo count with color based on amount
        local textColor = {r=1, g=1, b=1, a=1}
        if totalAmmo <= math.floor(maxAmmo * 0.25) then
            textColor = {r=1, g=0.3, b=0.3, a=1} -- Red for low ammo
        elseif totalAmmo <= math.floor(maxAmmo * 0.5) then
            textColor = {r=1, g=0.8, b=0.3, a=1} -- Yellow for medium ammo
        end
        
        -- Draw main ammo count
        self:drawText(tostring(totalAmmo) .. "/" .. tostring(maxAmmo), 10, 25, 
            textColor.r, textColor.g, textColor.b, textColor.a, UIFont.Medium)
        
        -- Draw chambered round indicator if there is one
        if chamberedRound > 0 then
            self:drawText("+1", self.width - 25, 25, textColor.r, textColor.g, textColor.b, 0.7, UIFont.Small)
        end
    end
end

-- Initialize the display
local function createAmmoDisplay()
    local display = SimpleAmmoDisplay:new(100, 100, 150, 50)
    display:initialise()
    display:addToUIManager()
end

Events.OnGameStart.Add(createAmmoDisplay)