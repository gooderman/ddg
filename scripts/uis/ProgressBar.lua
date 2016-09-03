
ProgressBar = class("ProgressBar", function()
    return display.newNode()
end)

--sp
--direct 0 x, 1 y 横向,竖向
--adddirect 0,1  进度正方向 进度负方向

function ProgressBar:ctor(bgsp,sp,direct,adddirect,rd)
    if(not sp) then return end    
    direct = direct or 0
    adddirect = adddirect or 0
    self.direct = direct
    self.adddirect = adddirect
    local sz = sp:getContentSize()
    self.progress = CCProgressTimer:create(sp)  
    if(rd) then
        self.progress:setType(kCCProgressTimerTypeRadial)
    else
        self.progress:setType(kCCProgressTimerTypeBar)
    end    

    self.bSp = sp

    self.progress:ignoreAnchorPointForPosition(false)
    self.progress:setContentSize(sz)
    self.progress:setAnchorPoint(ccp(0.0, 0.0))    
    if(not rd) then
        self.progress:setMidpoint(ccp(0, 0))
        if(direct>0) then   
            self.progress:setBarChangeRate(ccp(0,1))    --对应方向上是否进行设置
            if(adddirect>0) then
                self.progress:setMidpoint(ccp(0, 1))        --进度方向 
            end
        else
            self.progress:setBarChangeRate(ccp(1,0))    --对应方向上是否进行设置
            if(adddirect>0) then
                self.progress:setMidpoint(ccp(1, 0))        --进度方向 
            end
        end 
    else
       -- self.progress:setBarChangeRate(ccp(1,1))    --对应方向上是否进行设置
       -- self.progress:setMidpoint(ccp(1, 1))        --进度方向 
    end

    if(bgsp) then
        bgsp:setAnchorPoint(ccp(0.5, 0.5))
        bgsp:setPositionX(sz.width/2)
        bgsp:setPositionY(sz.height/2)
        self:addChild(bgsp) 
        self.bgSp = bgsp       
    end

    self:addChild(self.progress)

    self:ignoreAnchorPointForPosition(false)
    self:setContentSize(sp:getContentSize())
    self:setAnchorPoint(ccp(0.5, 0.5))

    self.processWidth = sp:getContentSize().width
    self.processHeight = sp:getContentSize().height
    --目的

    self.perwill = 100
end

function ProgressBar:setStageEft(eft)
    self.stgEft = eft
end
function ProgressBar:setZeroEft(eft)
    self.stgZeroEft = eft
end
function ProgressBar:setFullEft(eft)
    self.stgFullEft = eft
end
function ProgressBar:setLastEft(eft)
    self.stgLastEft = eft
end

function ProgressBar:setStage(stg)
    self.perStg = {}
    local a = 1
    for i=1,stg do
        local pper = math.floor((100*i)/stg)
        self.perStg[i] = {a,pper}
        a = pper + 1
    end
    self.perStg[stg][2] = 100
end
--修正
function ProgressBar:stagePer(per)
    if(self.perStg) then
        -- print("---------ProgressBar:stagePer",per)
        -- dump(self.perStg)
        local cc = 0
        local ct = #self.perStg
        for i,tb in pairs(self.perStg) do
            if(per>= tb[1] and per<tb[2]) then
                cc = i-1
                break
            elseif(per==tb[2]) then
                cc = i    
            end
        end        
        if(cc==0) then
            self.perStgIdx = 0
            return 0
        elseif(cc<=ct) then
            self.perStgIdx = cc
            return self.perStg[cc][2]        
        end
    end
    return per
end

function ProgressBar:changeSkin(old,cur)
    if(not self.skinParam) then
        return
    end
    local oldskin = 1
    local curskin = 1
    for i,tb in pairs(self.skinParam) do
        if(old>=tb[3] and old<=tb[4]) then
            oldskin = i
        end
        if(cur>=tb[3] and cur<=tb[4]) then
            curskin = i
        end
    end
    -- dump(self.skinParam,"====" .. oldskin .. "---------"..curskin)
    if(oldskin~=curskin) then
        local tb = self.skinParam[curskin]
        local nBgSp = display.newSprite(tb[1])
        local nSp = display.newSprite(tb[2])
        if(self.bgSp and nBgSp) then
            self.bgSp:setTexture(nBgSp:getTexture())
        end
        if(self.bSp and nSp) then
            self.bSp:setTexture(nSp:getTexture())
        end
    end
end
--param()
--{bg,sp,rga,rgb}
function ProgressBar:setSkin(param)
    self.skinParam = param
end

--0-100
function ProgressBar:setIndicate(sp)
    self.indicateSp = sp
    self.progress:addChild(sp)
end

--0-100
function ProgressBar:setPercent(per)
    per = math.max(per,0)
    per = math.min(per,100)
    local oldper = self:getPercent()   
    self:changeSkin(math.floor(oldper),math.floor(per))
    per = self:stagePer(math.floor(per))  
    self.perwill = per
    if(per<100) then
        if(self.flashNd and not tolua.isnull(self.flashNd)) then
            self.flashNd:removeSelf()
        end    
        self.flashNd = nil
    end
    --阶段增长一格子光效 
    if(self.stgEft and self.perStgIdx and self.direct==1 and self.adddirect==0 and per~=oldper and self.perStg) then            
        local ct = #self.perStg
        local x,y,param,param2
        if(self.perStgIdx<ct and self.perStgIdx>0) then
            x = self.processWidth/2
            y = self.processHeight/ct*(self.perStgIdx-0.5)       
            param = self.stgEft
        elseif(self.perStgIdx==0) then
            x = self.processWidth/2
            y = self.processHeight/2       
            param = self.stgZeroEft
        elseif(self.perStgIdx==ct) then
            x = self.processWidth/2
            y = self.processHeight/2
            param = self.stgLastEft
            param2 = self.stgFullEft
        end
        print("-----------",x,y,self.perStgIdx,ct,param)
        if(x and y and param) then              
            local upStg = GenUiUtil.genFrameAnim(param)   
            if(upStg) then           
                local arc = ccp(param.arc[1],param.arc[2])
                upStg:setAnchorPoint(arc)
                upStg:setPosition(x,y)
                upStg:addTo(self)
            end
        end 
        if(x and y and param2) then              
            local upStg = GenUiUtil.genFrameAnim(param2)   
            if(upStg) then           
                local arc = ccp(param2.arc[1],param2.arc[2])
                upStg:setAnchorPoint(arc)
                upStg:setPosition(x,y)
                upStg:addTo(self)
                self.flashNd = upStg
            end
        end  

    end
    --通用处理
    self.progress:setPercentage(per)
    if(self.indicateSp) then
        self.indicateSp:setPosition(per*self.processWidth/100, self.processHeight/2)       
    end 
end
--动画结束重点进度
function ProgressBar:getPercentWill()
    return self.perwill
end 

function ProgressBar:getPercent()
    return self.progress:getPercentage()
end

function ProgressBar:stopPerAnim()
    self.progress:stopActionByTag(10010)
    self.progress:stopActionByTag(10011)
end

function ProgressBar:gotoPercent(dt,per,delay)    
    local oldper = self:getPercent()  
    if(math.floor(oldper) == math.floor(per)) then return end
    --print("gotoPercent",dt,oldper,per)
    --local acc =  CCProgressTo:create(dt,per)

    self.progress:stopActionByTag(10010)
    self.progress:stopActionByTag(10011)
    self:changeSkin(math.floor(oldper),math.floor(per))
    per = self:stagePer(math.floor(per))
    self.perwill = per
    if(delay) then
        local acc =  CCProgressFromTo:create(dt,oldper,per)
        local seqac = transition.sequence(
                {
                    CCDelayTime:create(delay),
                    acc
                }
            )
        seqac:setTag(10010)
        self.progress:runAction(seqac)
    else
        local acc =  CCProgressFromTo:create(dt,oldper,per)
        acc:setTag(10011)
        self.progress:runAction(acc)
    end    
end
function ProgressBar:gotoPercent2(dt,per1,per2)
    local oldper = self:getPercent()    
    -- if(math.floor(oldper) == math.floor(per1)) then return end
    local acc =  CCArray:create();
    acc:addObject(CCProgressFromTo:create(dt,oldper,per1));
    acc:addObject(CCProgressFromTo:create(dt,0,per2));
    self.progress:runAction(CCSequence:create(acc));
end
function ProgressBar:setColor(color)
    return self.progress:setColor(color)
end



return ProgressBar
