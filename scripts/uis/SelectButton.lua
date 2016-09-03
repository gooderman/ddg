
local UIButton = import("framework.cc.ui.UIButton")
local UIPushButton = import("framework.cc.ui.UIPushButton")
local SelectButton = class("SelectButton",UIPushButton)



function SelectButton:ctor(images, options)
    SelectButton.super.ctor(self, images, options)
end

function SelectButton:onTouch_(event)
   local name, x, y = event.name, event.x, event.y
    if name == "began" then
        if not self:checkTouchInSprite_(x, y) then return false end
        if self.fsm_:canDoEvent("press") then
            self.fsm_:doEvent("press")        
            self:dispatchEvent({name = UIButton.PRESSED_EVENT, x = x, y = y, touchInTarget = true})
            --按下
            app:dispatchEventForMusic(1,self.musicName)
        end
        return true
    end

    local touchInTarget = self:checkTouchInSprite_(x, y)
    if name == "moved" then
        if touchInTarget and self.fsm_:canDoEvent("press") then
            self.fsm_:doEvent("press")
            self:dispatchEvent({name = UIButton.PRESSED_EVENT, x = x, y = y, touchInTarget = true})
        elseif not touchInTarget and self.fsm_:canDoEvent("release") then
            self.fsm_:doEvent("release")
            self:dispatchEvent({name = UIButton.RELEASE_EVENT, x = x, y = y, touchInTarget = false})
        end
    else
        if self.fsm_:canDoEvent("release") then
            self.fsm_:doEvent("release")
            self:dispatchEvent({name = UIButton.RELEASE_EVENT, x = x, y = y, touchInTarget = touchInTarget})
        end
        if name == "ended" and touchInTarget then
            if self.fsm_:canDoEvent("disable") then
                self.fsm_:doEvent("disable")
            end
            self:dispatchEvent({name = UIButton.CLICKED_EVENT, x = x, y = y, touchInTarget = true})
            --放开
            app:dispatchEventForMusic(2,self.musicName)
        end
    end
end


return SelectButton
