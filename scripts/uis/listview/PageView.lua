
local ListView = import(".ListView")
local PageView = class("PageView", ListView)
--过半翻页
function PageView:oooo(x, y)
    local index = self.touchidx
    local count = #self.cells
    --print("----------oooo--",index,count)
    if (index < 1 or index>count) then        
        return
    end
    local dx = self.drag.ex-self.drag.sx
    local dy = self.drag.ey-self.drag.sy
    local offset = self.offset[1]
    local curoff = self.offset[1]
    for i = 1, index do
        local cell = self.cells[i]
        local size = cell:getContentSize()
        if self.direction == 2 then
            curoff = offset
            offset = offset + size.width
        else
            curoff = offset
            offset = offset - size.height
        end
    end
    --print("----------oooo",dx,dy,curoff,offset)
    if(self.direction==2) then
        if(dx<0) then
            if (offset <= self.clipsz.width/2) then
                index = index+1
            else
                index = index    
            end
        else
            if (curoff >= self.clipsz.width/2) then
                index = index-1
            else
                index = index    
            end
        end
    else
        if(dy<0) then
            if (curoff <= self.clipsz.height/2) then
                index = index-1
            else
                index = index   
            end
        else
            if (offset >= self.clipsz.height/2) then
                index = index+1
            else
                index = index    
            end
        end    
    end
    --print("----------oooo",index)
    if(index < 1) then
        index=1
    elseif(index>count) then 
        index=count   
    end    
    self:skipToCell(index)
    return index
end


--时间，速度控制翻页
function PageView:onTouchEnded_tap(x, y)
    if(not self:backscroll()) then  
        --print("PageView onTouchEnded_tap")
        if(self:autoscroll()) then
            --print("PageView speed",self.speed)
            --速度400翻页
            local index = self.touchidx
            local count = #self.cells
            if(self.speed<0 and self.speed<-400) then
                if(self.direction==2) then
                    index = index + 1
                else
                    index = index - 1
                end
            elseif(self.speed>0 and self.speed>400) then
                if(self.direction==2) then
                    index = index - 1
                else
                    index = index + 1
                end
            end
            self:resetspeed()
            if(index < 1) then
                index=1
            elseif(index>count) then 
                index=count   
            end
            self:skipToCell(index)
        else          
            self:oooo()    
        end
    end
end

function PageView:onTouchEnded_notap(x, y)
    self.touchidx = 0
    self.touchcell = nil
end

return PageView
