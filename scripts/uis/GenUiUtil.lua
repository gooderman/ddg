local McButton = import(".McButton")
local SelectButton = import(".SelectButton")
local CellButton = import(".listview.CellButton")
local ProgressBar    =import(".ProgressBar")
local UIButton = import("framework.cc.ui.UIButton")
import(".EffectConfig")
GenUiUtil={}

function GenUiUtil.genUis(ustb,parent,pathflag)
    if pathflag == nil then
        pathflag=""
    end
    local uis = {}
    for _,ps in pairs(ustb) do
        local t= ps.t
        local parentNode = (ps.ftg and ps.ftg>0) and parent:getChildByTag(ps.ftg) or parent
        if(t=="sp") then
            if ps.size then
                uis[ps.n] = display.newScale9Sprite(pathflag .. ps.res,0,0,CCSize(ps.size[1],ps.size[2]))
            else
                uis[ps.n] = display.newSprite( pathflag .. ps.res )
            end
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:pos(ps.x,ps.y)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if ps.scale then
                    uis[ps.n]:setScale(ps.scale)
                end
            end

        elseif(t=="clip") then
            uis[ps.n] = display.newClippingRegionNode(CCRectMake(ps.cx,ps.cy,ps.cw,ps.ch))
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:pos(0,0)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if ps.scale then
                    uis[ps.n]:setScale(ps.scale)
                end
                uis[ps.n]:setClippingRegion(CCRectMake(ps.cliprect[1], ps.cliprect[2], ps.cliprect[3], ps.cliprect[4]))
            end

        elseif(t=="btn" or t=='selectbtn') then
            uis[ps.n] = nil
            if(t=='btn') then
                 uis[ps.n] = cc.ui.UIPushButton.new(
                                        {
                                            normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                            pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                            disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                        },
                                        {scale9 = false}
                                    )
            else
                 uis[ps.n] = SelectButton.new(
                                        {
                                            normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                            pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                            disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                        },
                                        {scale9 = false}
                                    )
            end
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:pos(ps.x,ps.y)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if (ps.zd) then
                    uis[ps.n]:setZOrder(ps.zd)
                end
                if ps.scale then
                    uis[ps.n]:setScale(ps.scale)
                end
                if ps.shader then
                    GenUiUtil.attackShader(uis[ps.n].sprite_,ps.shader)
                    local sdd = ps.shader
                    uis[ps.n]:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                        GenUiUtil.attackShader(evt.sprite,sdd)
                    end)
                end
            end
        elseif(ps.t=="cellbtn") then
            uis[ps.n] = CellButton.new(
                                    {
                                        normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                        pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                        disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                    },
                                    {scale9 = false}
                                )
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:pos(ps.x,ps.y)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if(ps.pressanima) then
                    uis[ps.n]:setPressAnima(ps.pressanima)
                end
                if ps.scale then
                    uis[ps.n]:setOscale(ps.scale)
                    uis[ps.n]:setScale(ps.scale)
                end
                if ps.anim == false then
                    uis[ps.n]:setPressAnima(false)
                elseif(ps.animscale) then
                    uis[ps.n]:setPressScale(ps.animscale)
                elseif(ps.animdt) then
                    uis[ps.n]:setPressAnimaDt(ps.animdt)
                end
                if ps.shader then
                    GenUiUtil.attackShader(uis[ps.n].sprite_,ps.shader)
                    local sdd = ps.shader
                    uis[ps.n]:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                        GenUiUtil.attackShader(evt.sprite,sdd)
                    end)
                end
            end
        elseif(t=="mcbtn") then
            --uis[ps.n] = cc.ui.UIPushButton.new(
            uis[ps.n] = McButton.new(
                                    {
                                        normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                        pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                        disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                    },
                                    {scale9 = false}
                                )
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:pos(ps.x,ps.y)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if (ps.zd) then
                    uis[ps.n]:setZOrder(ps.zd)
                end
                if ps.scale then
                    uis[ps.n]:setOscale(ps.scale)
                    uis[ps.n]:setScale(ps.scale)
                end
                if ps.anim == false then
                    uis[ps.n]:setPressAnima(false)
                elseif(ps.animscale) then
                    uis[ps.n]:setPressScale(ps.animscale)
                elseif(ps.animdt) then
                    uis[ps.n]:setPressAnimaDt(ps.animdt)
                end
                if ps.shader then
                    GenUiUtil.attackShader(uis[ps.n].sprite_,ps.shader)
                    local sdd = ps.shader
                    uis[ps.n]:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                        GenUiUtil.attackShader(evt.sprite,sdd)
                    end)
                end
            end
        elseif(t=="txt") then
            if(ps.rect) then
                local align  = ps.align or ui.TEXT_ALIGN_CENTER
                local valign  = ps.valign or ui.TEXT_VALIGN_CENTER
                uis[ps.n] = CCLabelTTF:create(ps.txt, CFG_SYSTEM_FONT, ps.size, CCSize(ps.rect[1],ps.rect[2]), align, valign)
            else
                uis[ps.n] = CCLabelTTF:create(ps.txt,CFG_SYSTEM_FONT,ps.size)
            end
            uis[ps.n]:pos(ps.x,ps.y)
            if(ps.color) then
                uis[ps.n]:setColor(ccc3(ps.color[1], ps.color[2], ps.color[3]))
            end
            if(ps.hd) then
                uis[ps.n]:setVisible(false)
            end
            if(ps.arc) then
                uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
        elseif(t=="vTxt")then
            uis[ps.n] = ui.newTTFLabel({
                text = ps.txt,
                font = CFG_SYSTEM_FONT,
                size = ps.size or CFG_FONT_SIZE_S,
                color = ccc3(ps.color[1], ps.color[2], ps.color[3]) or ccc3(255, 255, 255),
                align = ui.TEXT_ALIGN_LEFT,
                valign = ui.TEXT_VALIGN_CENTER,
                dimensions = CCSize(ps.w,ps.h)
            })
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:setPosition(ccp(ps.x,ps.y))
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
            end
        elseif (t == "font") then

        elseif(t=="color") then
            local defalpha = ps.alpha or CFG_COMMON_MASK_ALPHA
            local color = ccc4(0, 0, 0, defalpha)
            if(ps.color) then
                color = ccc4(ps.color[1], ps.color[2], ps.color[3] ,ps.color[4])
            end
            uis[ps.n] = display.newColorLayer(color)
            uis[ps.n]:pos(ps.x,ps.y)
            if(ps.hd) then
                uis[ps.n]:setVisible(false)
            end
            if(ps.arc) then
                uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
        elseif(ps.t=="node") then
            uis[ps.n] = display.newNode()
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                if(ps.rect) then
                    uis[ps.n]:setContentSize(CCSize(ps.rect[1],ps.rect[2]))
                    uis[ps.n]:ignoreAnchorPointForPosition(false)
                end
                uis[ps.n]:setPosition(ccp(ps.x,ps.y))
                --print("GenUiUtil.genUi node",uis[ps.n]:getPosition(),ps.x,ps.y)
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
            end
        elseif(ps.t=="clipnode") then
            uis[ps.n] = display.newClippingRegionNode(CCRectMake(0, 0, ps.rect[1],ps.rect[2]))
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:setPosition(ccp(ps.x,ps.y))
                if(ps.rect) then
                    uis[ps.n]:setContentSize(CCSize(ps.rect[1],ps.rect[2]))
                    uis[ps.n]:ignoreAnchorPointForPosition(false)
                end
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
            end
        elseif(ps.t=="editbox") then
            uis[ps.n] = ui.newEditBox(
                        {
                            image = ps.res or "",
                            size = CCSize(ps.rect[1],ps.rect[2]),
                            imageOpacity = 255,
                            listener = ps.listener,
                        }
                    )
            if(uis[ps.n]) then
                if(ps.arc) then
                    uis[ps.n]:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
                end
                uis[ps.n]:setPosition(ccp(ps.x,ps.y))
                if(ps.hd) then
                    uis[ps.n]:setVisible(false)
                end
                if(ps.txt) then
                   uis[ps.n]:setText(ps.txt)
                end
                if(ps.font and ps.size) then
                   uis[ps.n]:setFont(ps.font,ps.size)
                end
                if(ps.maxlen) then
                   uis[ps.n]:setMaxLength(ps.maxlen)
                end
                if(ps.txt) then
                   uis[ps.n]:setText(ps.txt)
                end
            end
        end
        if(uis[ps.n] and parentNode) then
            local x,y = ps.x,ps.y
            if(ps.posarc and ps.posarc[1] and ps.posarc[2]) then
                local sz = parentNode:getContentSize()
                x = sz.width*ps.posarc[1]+x
                y = sz.height*ps.posarc[2]+y
            end
            uis[ps.n]:setPosition(ccp(x,y))
            uis[ps.n]:addTo(parentNode, ps.od or 0, ps.tg)
        end
    end
    return uis
end

function GenUiUtil.genUi(ps,parent,pathflag)
    if pathflag == nil then
        pathflag=""
    end
    local parentNode = (ps.ftg and ps.ftg>0) and parent:getChildByTag(ps.ftg) or parent
    local btnn
    if(ps.t=="sp") then
        btnn = display.newSprite( pathflag .. ps.res )
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:pos(ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
            if ps.scale then
                btnn:setScale(ps.scale)
            end
        end
    elseif(ps.t=="mcbtn") then
        btnn = McButton.new(
                                {
                                    normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                    pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                    disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                },
                                {scale9 = false}
                            )
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:pos(ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
            if ps.scale then
                btnn:setOscale(ps.scale)
                btnn:setScale(ps.scale)
            end
            if ps.anim == false then
                btnn:setPressAnima(false)
            elseif(ps.animscale) then
                btnn:setPressScale(ps.animscale)
            elseif(ps.animdt) then
                btnn:setPressAnimaDt(ps.animdt)
            end
            if ps.shader then
                GenUiUtil.attackShader(btnn.sprite_,ps.shader)
                local sdd = ps.shader
                btnn:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                    GenUiUtil.attackShader(evt.sprite,sdd)
                end)
            end
        end
    elseif(ps.t=="btn") then
        btnn = cc.ui.UIPushButton.new(
                                {
                                    normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                    pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                    disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                },
                                {scale9 = false}
                            )
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:pos(ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
            if ps.shader then
                GenUiUtil.attackShader(btnn.sprite_,ps.shader)
                local sdd = ps.shader
                btnn:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                    GenUiUtil.attackShader(evt.sprite,sdd)
                end)
            end
        end
    elseif(ps.t=="cellbtn") then
        btnn = CellButton.new(
                                {
                                    normal  = ps.res[1] and (pathflag .. ps.res[1]) or nil,
                                    pressed = ps.res[2] and (pathflag .. ps.res[2]) or nil,
                                    disabled = ps.res[3] and (pathflag .. ps.res[3]) or nil,
                                },
                                {scale9 = false}
                            )
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:pos(ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
            if(ps.pressanima) then
                btnn:setPressAnima(ps.pressanima)
            end
            if ps.scale then
                btnn:setOscale(ps.scale)
                btnn:setScale(ps.scale)
            end
            if ps.anim == false then
                btnn:setPressAnima(false)
            elseif(ps.animscale) then
                btnn:setPressScale(ps.animscale)
            elseif(ps.animdt) then
                btnn:setPressAnimaDt(ps.animdt)
            end
            if ps.shader then
                GenUiUtil.attackShader(btnn.sprite_,ps.shader)
                local sdd = ps.shader
                btnn:addEventListener(UIButton.IMAGE_CHANGE_EVENT, function(evt)
                    GenUiUtil.attackShader(evt.sprite,sdd)
                end)
            end
        end
    elseif(ps.t=="txt") then
        if(ps.rect) then
            local align  = ps.align or ui.TEXT_ALIGN_CENTER
            local valign  = ps.valign or ui.TEXT_VALIGN_CENTER
            btnn = CCLabelTTF:create(ps.txt, CFG_SYSTEM_FONT, ps.size, CCSize(ps.rect[1],ps.rect[2]), align, valign)
        else
            btnn = CCLabelTTF:create(ps.txt,CFG_SYSTEM_FONT,ps.size)
        end
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            --print("GenUiUtil.genUi txt",btnn:getPosition(),ps.x,ps.y)
            if(ps.color) then
                btnn:setColor(ccc3(ps.color[1], ps.color[2], ps.color[3]))
            end
            if(ps.hd) then
                btnn:setVisible(false)
            end
        end
    elseif(ps.t=="vTxt")then
        btnn = ui.newTTFLabel({
            text = ps.txt,
            font = CFG_SYSTEM_FONT,
            size = ps.size or CFG_FONT_SIZE_S,
            color = ccc3(ps.color[1], ps.color[2], ps.color[3]) or ccc3(255, 255, 255),
            align = ui.TEXT_ALIGN_LEFT,
            valign = ui.TEXT_VALIGN_CENTER,
            dimensions = CCSize(ps.w,ps.h)
        })
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            if(ps.hd) then
                btnn:setVisible(false)
            end
        end
    elseif (ps.t == "font") then
       if ps.nType then
          btnn = FontPlugins:fontType(ps.nType);
       end
       if btnn then
           if ps.txt then
               btnn:setString(ps.txt);
           end
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
        btnn:pos(ps.x,ps.y);
       end
    elseif(ps.t=="arm" or ps.t=="armref") then
        --{n="lock4",  t="sp", x=1060, y=200,  tg = 28, ftg = 0, od=1, res = {"arm","armfile"} },
        --skin 数据
        local arm,file = ps.res[1],ps.res[2]
        if(file and arm) then
            GenUiUtil.addArmatureFile(pathflag .. file)
        else
            return
        end
        if(ps.t=="arm") then
            btnn = GenUiUtil.createArmature(arm)
        else
            btnn = GenUiUtil.createArmatureRef(arm)
        end
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            if(ps.scale) then
                btnn:setScaleX(ps.scale[1])
                btnn:setScaleY(ps.scale[2])
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            --print("GenUiUtil.genUi txt",btnn:getPosition(),ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
        end
    elseif(ps.t=="node") then
        btnn = display.newNode()
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            if(ps.rect) then
                btnn:setContentSize(CCSize(ps.rect[1],ps.rect[2]))
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            --print("GenUiUtil.genUi node",btnn:getPosition(),ps.x,ps.y)
            if(ps.hd) then
                btnn:setVisible(false)
            end
        end
    elseif(ps.t=="blood") then
        local bgsp = display.newSprite(pathflag .. (ps.res[1] or ""))
        local sp = display.newSprite(pathflag .. (ps.res[2] or ""))
        if(sp) then
            btnn = ProgressBar.new(bgsp,sp,ps.dir or 0,ps.adddir or 0)
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            if(ps.per) then
                btnn:setPercent(ps.per)
                -- if(ps.newper) then

                -- end
            end
            if ps.scale then
                btnn:setScale(ps.scale)
            end
        end
    elseif(ps.t=="mblood") then
    elseif(ps.t=="clipnode") then
        btnn = display.newClippingRegionNode(CCRectMake(0, 0, ps.rect[1],ps.rect[2]))
        if(btnn) then
            if(ps.arc) then
                btnn:setAnchorPoint(ccp(ps.arc[1],ps.arc[2]))
            end
            if(ps.rect) then
                btnn:setContentSize(CCSize(ps.rect[1],ps.rect[2]))
                btnn:ignoreAnchorPointForPosition(false)
            end
            btnn:setPosition(ccp(ps.x,ps.y))
            print("GenUiUtil.genUi clipnode",ps.ftg)
            if(ps.hd) then
                btnn:setVisible(false)
            end
        end
    end
    if(btnn and parentNode) then
        --坐标基准点
        local x,y = ps.x,ps.y
        if(ps.posarc and ps.posarc[1] and ps.posarc[2]) then
            local sz = parentNode:getContentSize()
            x = sz.width*ps.posarc[1]+x
            y = sz.height*ps.posarc[2]+y
        end
        btnn:addTo(parentNode, ps.od or 0, ps.tg)
    end
    return btnn
end

--example
-- self.uis = GenUiUtil.genUis(UI_POS,self,pathflag)
-- if(self.uis["back"]) then
--     self.uis["back"]:onButtonClicked(handler(self, self.goback))
-- end
------------------------------------------------------------------------
function GenUiUtil.genJpgMaskSp(name,maskName,pathflag)
    if(pathflag) then
        name = pathflag .. name
        maskName = pathflag .. maskName
    end

    local spp = CCShaderSprite:create(name)
    if(spp) then
        local maskTexture = CCTextureCache:sharedTextureCache():addImageForMask(maskName)
        if(maskTexture) then
            spp:setCC_Texture1(maskTexture)
        end
        spp:setShaderFromFile("shader/JpgMaskShader.vsh","shader/JpgMaskShader.fsh")
        --Png图片渲染，混合处理
        --如果原图是jpg不需要设置
        local __mb = ccBlendFunc()
        __mb.src = GL_SRC_ALPHA
        __mb.dst = GL_ONE_MINUS_SRC_ALPHA
        spp:setBlendFunc(__mb)
    end
    return spp
end
function GenUiUtil.genJpgMaskClipSp(name,maskName,clipName,pathflag)
    if(pathflag) then
        name = pathflag .. name
        maskName = pathflag .. maskName
        clipName = pathflag .. clipName
    end

    local spp = CCShaderSprite:create(name)
    if(spp) then

        -- local masksp =  display.newSprite(maskName)
        -- if(masksp) then
        --     spp:setCC_Texture1_s(masksp:getTexture())
        --     --print("-------masksp stringForFormat",masksp:getTexture():stringForFormat())
        -- end

        local maskTexture = CCTextureCache:sharedTextureCache():addImageForMask(maskName)
        if(maskTexture) then
            spp:setCC_Texture1(maskTexture)
        end


        -- local clipsp =  display.newSprite(clipName)
        -- if(clipsp) then
        --     spp:setCC_Texture2_s(clipsp:getTexture())
        -- end

        local clipTexture = CCTextureCache:sharedTextureCache():addImageForMask(clipName)
        if(clipTexture) then
            spp:setCC_Texture2(clipTexture)
        end
        --print("-------spp stringForFormat",masksp:getTexture():stringForFormat())
        spp:setShaderFromFile("shader/JpgMaskClipShader.vsh","shader/JpgMaskClipShader.fsh")
        --Png图片渲染，混合处理
        --如果原图是jpg不需要设置
        local __mb = ccBlendFunc()
        __mb.src = GL_SRC_ALPHA
        __mb.dst = GL_ONE_MINUS_SRC_ALPHA
        spp:setBlendFunc(__mb)
    end
    return spp
end

function GenUiUtil.attackShader(sp,name)
    local name = string.upper(name)
    local a,b = getShaderInfo(name)
    if(sp and a and b) then
        sp:setShaderFromFile(a,b)
    end
end
function GenUiUtil.deattackShader(sp)
    sp:resetShader()
end
function GenUiUtil.setDraggable(sp)
    cc(sp):addComponent("components.ui.DraggableProtocol")
          :exportMethods()
          :setDraggableEnable(true)
end
-----------------------------------------------------------------------

--帧动画生成
function GenUiUtil.genFrameAnim(param)
    -- local param =
    -- {
    --     res=
    --     name=
    --     a=
    --     b=
    --     reverse =
    --     loop=
    --     autodel=
    --     onfinish=
    --     delay=
    --     dt=
    -- }
    local sharedSpriteFrameCache = CCSpriteFrameCache:sharedSpriteFrameCache()
    if(param.res and param.res~='') then
        sharedSpriteFrameCache:addSpriteFramesWithFile(param.res)
    else
        --单个文件处理
        for i=param.a,param.b do
            local str = string.format(param.name,i)
            local sp = display.newSprite(str)
            if(sp) then
                local sz = sp:getContentSize()
                local ssfm = CCSpriteFrame:createWithTexture(sp:getTexture(),CCRectMake(0, 0, sz.width, sz.height))
                sharedSpriteFrameCache:addSpriteFrame(ssfm, str)
            end
        end
    end
    if(param.name) then
        local frames = display.newFrames(param.name, param.a, param.b, param.reverse)
        if(frames) then
            local dt = param.dt or 0.01
            local delay = param.delay or 0
            local light = display.newSprite(frames[1])
            if(param.a~=param.b) then
                if(param.loop) then
                    light:playAnimationForever(display.newAnimation(frames, dt),delay)
                else
                    light:playAnimationOnce(display.newAnimation(frames, dt),param.autodel,param.onfinish,delay)
                end
            else
                -- ac='fadeinout',
                -- acparam={from=0,to=255,dt=0.2,loop=true},
                local rmdt = 0
                local acparam = param.acparam
                local seq
                local seq2
                if(param.ac=='bomb') then
                    local dtt= acparam.dt or 0.03
                    local seqa = transition.sequence(
                                {
                                    CCCallFunc:create(
                                            function()
                                                light:setOpacity(255)
                                                light:setScale(1.0)
                                            end
                                        ),
                                    CCScaleTo:create(dtt, 1.05),
                                    CCScaleTo:create(dtt, 1.10),
                                    CCScaleTo:create(5*dtt, 1.12),
                                }
                            )
                    local seqb = transition.sequence(
                                {
                                    CCDelayTime:create(2*dtt),
                                    CCFadeTo:create(5*dtt, 0)
                                }
                            )
                    if(acparam.loop) then
                        seq = CCRepeatForever:create(CCSpawn:createWithTwoActions(seqa, seqb))
                    else
                        seq = CCSpawn:createWithTwoActions(seqa, seqb)
                        rmdt = 7*dtt
                    end
                elseif(param.ac=='fadeinout') then
                    light:setOpacity(acparam.from)
                    if(acparam.loop) then
                        seq = transition.sequence(
                                {
                                    CCFadeTo:create(acparam.dt,acparam.to),
                                    CCFadeTo:create(acparam.dt,acparam.from)
                                }
                            )
                        seq = CCRepeatForever:create(seq)
                    else
                        seq = transition.sequence(
                                {
                                    CCDelayTime:create(acparam.delay or 0),
                                    CCFadeTo:create(acparam.dt,acparam.to),
                                    CCFadeTo:create(acparam.dt,acparam.from)
                                }
                            )
                        rmdt = 2*dt
                    end
                end

                if(seq) then
                    light:runAction(seq)
                end

                if(param.autodel and rmdt>0) then
                    seq2 =  transition.sequence(
                            {
                                CCDelayTime:create(rmdt),
                                CCCallFunc:create(function()
                                        if(param.onfinish) then
                                            param.onfinish()
                                        end
                                        light:removeSelf()
                                    end)
                            }
                        )
                end
                if(seq2) then
                    light:runAction(seq2)
                end
            end
            return light
        end
    end
end

--粒子node
function GenUiUtil.genParticleNd(param)
    -- arc={0.5,0.5},
    -- res="img/UI/fight/zjtx_lizi_03.plist"}
    -- pos={622,356},
    -- scale={3,15},
    -- rotate=-240,
    -- autodel=true,
    -- delay=0.5,
    local nd = CCParticleSystemQuad:create(param.res)
    if(nd) then
        if(param.pos) then
            nd:setPosition(ccp(param.pos[1],param.pos[2]))
        end
        if(param.arc) then
            nd:setAnchorPoint(ccp(param.arc[1],param.arc[2]))
        end
        if(param.scale) then
            nd:setScaleX(param.scale[1])
            nd:setScaleY(param.scale[2])
        end
        if(param.rotate) then
            nd:setRotation(param.rotate)
        end
        if(param.autodel and param.delay) then
            local seq = transition.sequence(
                    {
                        CCDelayTime:create(param.delay),
                        CCRemoveSelf:create(true)
                    }
                )
            nd:runAction(seq)
        end
    end
    return nd

end

--遮罩透明
function GenUiUtil.genMaskNode(img,alpha)
    --img reverse alpha, need show to set black , need hide to set white
    local nd  = display.newNode()
    local ly1 = display.newColorLayer(ccc4(255,255,255,alpha))
    local sp  = display.newSprite(img)
    local ly2 = display.newColorLayer(ccc4(0,0,0,0))
    
    if(not sp) then
        return
    end

    ly1:addTo(nd)
    sp:addTo(nd)
    ly2:addTo(nd)
 
    --keep rgb && use a of ly1 
    local __mb1 = ccBlendFunc()
    __mb1.src = GL_ZERO
    __mb1.dst = GL_SRC_COLOR
    --keep rgb && add a of sp to a
    local __mb = ccBlendFunc()
    __mb.src = GL_ONE
    __mb.dst = GL_ONE
    --use dst alpha && ly2 completely no use just call draw
    local __mb2 = ccBlendFunc()
    __mb2.src = GL_ZERO
    __mb2.dst = GL_DST_ALPHA
    
    ly1:setBlendFunc(__mb1)
    sp:setBlendFunc(__mb)
    ly2:setBlendFunc(__mb2)
    return nd,sp
end

--剪切遮罩
function GenUiUtil.genClipNode(img,clip)
    --img reverse alpha, need show to set black , need hide to set white
    local nd  = display.newNode()
    local sp  = display.newSprite(img)
    local clip = display.newSprite(clip)
    if(not sp) then
        return
    end
    if(not clip) then
        return
    end

    clip:addTo(nd)
    sp:addTo(nd)
 
    --use src alpha && clip alpha
    local __mb2 = ccBlendFunc()
    __mb2.src = GL_ZERO
    __mb2.dst = GL_SRC_ALPHA
    --keep rgb && add a of sp to a
    local __mb = ccBlendFunc()
    __mb.src = GL_ONE_MINUS_DST_ALPHA
    __mb.dst = GL_DST_ALPHA
    
    clip:setBlendFunc(__mb2)
    sp:setBlendFunc(__mb)
    
    return nd,sp,clip
end

function GenUiUtil.genClipLoadingBar(img,clip,s9cap)
    local nd  = display.newNode()
    local sp  = display.newSprite(img)
    if(not sp) then
        return
    end
    local sz = sp:getContentSize()
    nd:setContentSize(sz)
    local clip = display.newScale9Sprite(clip,0,0,CCSize(s9cap[1]*2,s9cap[1]*2),CCRect(s9cap[1], s9cap[2], s9cap[3], s9cap[4]))
    if(not clip) then
        return
    end
    clip:pos(0,sz.height/2):arch(0,0.5)
    clip:addTo(nd,0,1)
    sp:pos(0,0):arch(0,0)
    sp:addTo(nd,0,2)
    --use src alpha && clip alpha
    local __mb2 = ccBlendFunc()
    __mb2.src = GL_ZERO
    __mb2.dst = GL_SRC_ALPHA
    --keep rgb && add a of sp to a
    local __mb = ccBlendFunc()
    __mb.src = GL_ONE_MINUS_DST_ALPHA
    __mb.dst = GL_DST_ALPHA
    
    clip:setBlendFunc(__mb2)
    sp:setBlendFunc(__mb)

    nd.setPercent=function(node,per)
        local clip = node:getChildByTag(1)
        local sz = clip:getContentSize()
        local w = node:getContentSize().width
        w = w*per/100
        if(w>sz.width) then
            sz.width=w
            clip:setContentSize(sz)
        end
    end
    return nd
end

--贝塞尔
function GenUiUtil.genBezier(ddt,endpos,cpos1,cpos2,autort)
    local conf = ccBezierConfig()
    conf.endPosition = endpos
    conf.controlPoint_1 = cpos1
    conf.controlPoint_2 = cpos2
    local act = CCBezierTo:create(ddt, conf)
    act:setAutoRotate(autort or false)
    return act
end

--fsp 父节点
--ksspname 扩散节点
function GenUiUtil.runKsEffect(fsp,ksspname,dt)
    if(not fsp) then return end
    local sz = fsp:getContentSize()
    local eftSp
    if(ksspname) then
        eftSp = display.newSprite(ksspname)
    else
        eftSp = display.newSprite()
        eftSp:setTexture(fsp:getTexture())
        eftSp:setTextureRect(fsp:getTextureRect())
        eftSp:setFlipX(fsp:isFlipX())
    end
    GenUiUtil.runKsEffectSp(fsp,eftSp,dt)
end

function GenUiUtil.runKsEffectSp(fsp,eftSp,dt,delaydt)
    if(not (fsp and eftSp) ) then return end
    local sz = fsp:getContentSize()
    eftSp:setPosition(ccp(sz.width/2,sz.height/2))
    fsp:addChild(eftSp)
    local seq = transition.sequence({
            CCDelayTime:create(delaydt or 0.0),
            CCSpawn:createWithTwoActions(CCFadeOut:create(dt or 0.5), CCScaleTo:create(0.5,2.0)),
            --CCCallFunc:create(function() eftSp:removeSelf() end)
            CCRemoveSelf:create(false)

        })
    print("GenUiUtil.runKsEffectSp(fsp,eftSp)")
    eftSp:runAction(seq)
end

-----------------------------------------------------------------------

-----------------------------------------------------------------------
function GenUiUtil.genKeyValueTTF(key,value,fontsz,color1,color2)
    local namestr = key
    local numbstr = "+" .. value

    local nameNd = CCLabelTTF:create(namestr,CFG_SYSTEM_FONT,fontsz)
    local numbNd = CCLabelTTF:create(numbstr,CFG_SYSTEM_FONT,fontsz)
    local nd = display.newNode()
    local w,h = 0,fontsz
    if(nameNd) then
        nameNd:setColor(color1)
        nd:addChild(nameNd)
        local sz = nameNd:getContentSize()
        nameNd:setAnchorPoint(ccp(0,0.5))
        nameNd:setPosition(w, h/2)
        w = w + sz.width
        h = math.max(h,sz.height)
        w = w + 10
    end
    if(numbNd) then
        numbNd:setColor(color2)
        nd:addChild(numbNd)
        local sz = numbNd:getContentSize()
        numbNd:setAnchorPoint(ccp(0,0.5))
        numbNd:setPosition(w, h/2)
        h = math.max(h,sz.height)
    end

    return nd
end

--数字节点
-- {
-- s_numb
-- e_numb
-- step_dt
-- end_dt
-- fmt
-- }
function GenUiUtil.runNumEffect(lb,cur,endnum,dt,maxdt)
    GenUiUtil.runNumEffectParam(lb,{s_numb=cur,e_numb=endnum,step_dt=dt,end_dt=maxdt,fontType = 2})
end

function GenUiUtil.runNumEffectParam(lb,param)
    if(not lb) then return end
    lb.s_numb = lb.s_numb or param.s_numb
    lb.e_numb = param.e_numb or lb.e_numb
    local delay = param.delay
    if(true) then
        local dt = param.step_dt or 0.03
        local maxdt = param.end_dt or 1.0
        local fmt = param.fmt or 0
        lb.e_numDt=0
        lb.e_numDtMax=dt
        lb.e_numStep=1
        if(maxdt and maxdt>0) then
            if(lb.e_numb > lb.s_numb) then
                lb.e_numStep = math.ceil((lb.e_numb - lb.s_numb)/math.ceil(maxdt/dt))
                lb.e_numStep = math.ceil(math.max(1,lb.e_numStep))
            elseif(lb.e_numb < lb.s_numb) then
                lb.e_numStep = 0-math.floor((lb.e_numb - lb.s_numb)/math.ceil(maxdt/dt))
                lb.e_numStep = math.ceil(math.max(1,lb.e_numStep))
            else
                return
            end
        end
        if(not lb.addnumb_hd) then
            lb.addnumb_hd = lb:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,
                function(dtt)
                    lb.e_numDt = lb.e_numDt+dtt
                    if(lb.e_numDt>lb.e_numDtMax) then
                        lb.e_numDt = 0
                        if(lb.s_numb<lb.e_numb) then
                            lb.s_numb = lb.s_numb + lb.e_numStep
                            lb.s_numb = math.min(lb.s_numb,lb.e_numb)
                        elseif(lb.s_numb>lb.e_numb) then
                            lb.s_numb = lb.s_numb - lb.e_numStep
                            lb.s_numb = math.max(lb.s_numb,lb.e_numb)
                        else
                           lb:unscheduleUpdate()
                           lb:removeNodeEventListener(lb.addnumb_hd)
                           lb.addnumb_hd = nil
                           return
                        end
                        if(fmt==1) then
                            --lb:setString(string.formatnumberthousands(lb.s_numb))
                            lb:setString(GenUiUtil.formatCyByFlag(lb.s_numb,param.fontType))
                        else
                            lb:setString("" .. lb.s_numb)
                        end
                   end
                end)
            if(delay) then
                lb:performWithDelay(function()
                    lb:scheduleUpdate()
                end, delay)
            else
                lb:scheduleUpdate()
            end
        end
    end
end

--放大
function GenUiUtil.runBigEffect(fsp,delay)
    if(not fsp) then return end
    local actb = {}
    if(delay) then
        table.insert(actb,CCDelayTime:create(delay))
    end
    table.insert(actb,CCEaseIn:create(CCScaleTo:create(0.1,2.0),0.5))
    table.insert(actb,CCDelayTime:create(0.2))
    table.insert(actb,CCEaseIn:create(CCScaleTo:create(0.2,1.0),0.5))
    local seq = transition.sequence(actb)
    fsp:runAction(seq)
end
-----------------------------------------------------------------
--Pop弹出
function GenUiUtil.runPopOpenEffect(spp,bg,hd)
    GenUiUtil.runScale2OpenEffect(spp,bg,hd)
end
--Pop消失
function GenUiUtil.runPopCloseEffect(spp,bg,hd)
    spp:stopAllActions()
    if(bg) then
        spp:stopAllActions()
    end
    GenUiUtil.runScale2CloseEffect(spp,bg,hd)
end

--弹性
function GenUiUtil.runTxOpenEffect(spp,bg,hd)
    spp:setScale(0.5)
    hd = hd or function()end
    local seq =transition.sequence(
            {
                CCShow:create(),
                CCEaseIn:create(CCScaleTo:create(0.02, 1.4),0.5),
                CCDelayTime:create(0.02),
                CCScaleTo:create(0.08, 0.85),
                CCScaleTo:create(0.08, 1.05),
                CCScaleTo:create(0.06, 0.95),
                CCScaleTo:create(0.06, 1.0),
                CCCallFunc:create(hd)
                -- CCDelayTime:create(2.0),
                -- CCHide:create(),
                -- CCEaseBounce:create(pAction)
            }
        )
    spp:runAction(seq)

    spp:setOpacity(0)
    seq =transition.sequence(
            {
                CCFadeTo:create(0.03, 255)
            }
        )
    spp:runAction(seq)
    if(bg) then
        local opt = bg:getOpacity()
        bg:setOpacity(0)
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.04),
                    CCFadeTo:create(0.08, opt),
                }
            )
        bg:runAction(seq)
    end
end

----弹性
function GenUiUtil.runTxCloseEffect(spp,bg,hd)
    spp:setScale(1.0)
    hd = hd or function()end
    local seq =transition.sequence(
            {
                CCEaseIn:create(CCScaleTo:create(0.2, 1.3),0.5),
                CCEaseIn:create(CCScaleTo:create(0.1, 0.2),0.3),
                CCHide:create(),
                -- CCDelayTime:create(2.0),
                -- CCEaseBounce:create(pAction)
                CCCallFunc:create(hd)
            }
        )
    spp:runAction(seq)

    if(bg) then
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.2),
                    CCFadeTo:create(0.08, 0),
                }
            )
        bg:runAction(seq)
    end
end

--scale弹出
function GenUiUtil.runScaleOpenEffect(spp,bg,hd)
    spp:setScale(0.2)
    hd = hd or function()end
    local seq =transition.sequence(
            {
                CCShow:create(),
                CCEaseOut:create(CCScaleTo:create(0.1,1.2),0.5),
                CCEaseOut:create(CCScaleTo:create(0.08,1.0),0.5),
                CCCallFunc:create(hd)
            }
        )
    spp:runAction(seq)

    spp:setOpacity(0)
    seq =transition.sequence(
            {
                CCFadeTo:create(0.03, 255)
            }
        )
    spp:runAction(seq)

    if(bg) then
        local opt = bg:getOpacity()
        bg:setOpacity(0)
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.03),
                    CCFadeTo:create(0.08, opt),
                }
            )
        bg:runAction(seq)
    end
end

--Pop消失
function GenUiUtil.runScaleCloseEffect(spp,bg,hd)
    spp:setScale(1.0)
    hd = hd or function()end
    local seq =transition.sequence(
            {
                CCEaseIn:create(CCScaleTo:create(0.2, 1.3),0.5),
                CCEaseIn:create(CCScaleTo:create(0.1, 0.2),0.3),
                CCHide:create(),
                -- CCDelayTime:create(2.0),
                -- CCEaseBounce:create(pAction)
                CCCallFunc:create(hd)
            }
        )
    spp:runAction(seq)

    if(bg) then
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.2),
                    CCFadeTo:create(0.08, 0),
                }
            )
        bg:runAction(seq)
    end
end

--scale弹出
function GenUiUtil.runScale2OpenEffect(spp,bg,hd)
    spp:setScale(0.2)
    hd = hd or function()end
    local seq =transition.sequence(
            {
                CCShow:create(),
                CCEaseIn:create(CCScaleTo:create(0.1,1.0),0.5),
                CCCallFunc:create(hd)
            }
        )
    spp:runAction(seq)

    spp:setOpacity(0)
    seq =transition.sequence(
            {
                CCFadeTo:create(0.03, 255)
            }
        )
    spp:runAction(seq)

    if(bg) then
        local opt = bg:getOpacity()
        bg:setOpacity(0)
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.03),
                    CCFadeTo:create(0.08, opt),
                }
            )
        bg:runAction(seq)
    end
end

--Pop消失
function GenUiUtil.runScale2CloseEffect(spp,bg,hd)
    spp:setScale(1.0)
    hd = hd or function()end
    local seq =transition.sequence(
            {

                CCEaseOut:create(CCScaleTo:create(0.1, 0.0),0.5),
                CCHide:create(),
                CCCallFunc:create(hd)
            }
        )
    spp:runAction(seq)

    if(bg) then
        seq =transition.sequence(
                {
                    CCDelayTime:create(0.2),
                    CCFadeTo:create(0.08, 0),
                }
            )
        bg:runAction(seq)
    end
end
-- direct
    --方向 1 上到下
    --方向 2 下到上
    --方向 3 左到右
    --方向 4 右到左
-- fadeRg 渐变边缘宽度
-- addRg  每一帧卷动宽度
function GenUiUtil.runJzEffect(sp,direct,fadeRg,addRg,isout,callback)
    GenUiUtil.attackShader(sp,"FADEINUV")
    local __mb = ccBlendFunc()
    __mb.src = GL_SRC_ALPHA
    __mb.dst = GL_ONE_MINUS_SRC_ALPHA
    sp:setBlendFunc(__mb)
    --方向 1 上到下
    --方向 2 下到上
    --方向 3 左到右
    --方向 4 右到左
    sp:setSdf(1,direct or 3)
    --起点
    fadeRg = fadeRg or 20
    if(not isout) then
        local posRg = 1.0
        local possk = 0.01
        local w = sp:getContentSize().width
        local h = sp:getContentSize().height
        if(direct<3) then
            sp:setSdf(2,0-fadeRg/h)
            sp:setSdf(3,fadeRg/h)
            posRg = posRg + fadeRg/h
            possk = addRg/h
        else
            sp:setSdf(2,0-fadeRg/w)
            sp:setSdf(3,fadeRg/w)
            posRg = posRg + fadeRg/w
            possk = addRg/w
        end
        --[[
        local ac = sp:schedule(
                    function()
                        local dd = sp:getSdf(2)
                        sp:setSdf(2,dd+possk)
                        if(dd>posRg) then
                            sp:stopActionByTag(105808)
                            -- GenUiUtil.deattackShader(sp)
                            if(callback) then
                                callback()
                            end
                        end
                    end,
        0.0)
        actg = ac:setTag(105808)
        --]]
        local act = CCActionTween:create(1.0,"uv",sp:getSdf(2),posRg,function(v,key)
            sp:setSdf(2,v)
        end)
        callback = callback or function()end
        local ac = transition.sequence({
                CCEaseOut:create(act,0.2),
                CCCallFunc:create(callback)
            })
        sp:runAction(ac)
    else
        local posRg = 0.0
        local possk = 0.01
        local w = sp:getContentSize().width
        local h = sp:getContentSize().height
        if(direct<3) then
            sp:setSdf(2,1+fadeRg/h)
            sp:setSdf(3,fadeRg/h)
            posRg = posRg - fadeRg/h
            possk = addRg/h
        else
            sp:setSdf(2,1+fadeRg/w)
            sp:setSdf(3,fadeRg/w)
            posRg = posRg - fadeRg/w
            possk = addRg/w
        end
        --[[
        local ac = sp:schedule(
                    function()
                        local dd = sp:getSdf(2)
                        sp:setSdf(2,dd-possk)
                        if(dd<posRg) then
                            sp:stopActionByTag(105808)
                            -- GenUiUtil.deattackShader(sp)
                            if(callback) then
                                callback()
                            end
                        end
                    end,
        0.0)
        actg = ac:setTag(105808)
        --]]
        local act = CCActionTween:create(1.0,"uv",sp:getSdf(2),posRg,function(v,key)
            sp:setSdf(2,v)
        end)
        callback = callback or function()end
        local ac = transition.sequence({
                CCEaseOut:create(act,0.2),
                CCCallFunc:create(callback)
            })
        sp:runAction(ac)
    end
end

function GenUiUtil.runFadeOutEffect(sp,direct,fadeRg,endrg)
    GenUiUtil.attackShader(sp,"FADEINUV")
    local __mb = ccBlendFunc()
    __mb.src = GL_SRC_ALPHA
    __mb.dst = GL_ONE_MINUS_SRC_ALPHA
    sp:setBlendFunc(__mb)
    --方向 1 上到下
    --方向 2 下到上
    --方向 3 左到右
    --方向 4 右到左
    sp:setSdf(1,direct or 3)
    --起点
    fadeRg = fadeRg or 20
    endrg = endrg or 0.8
    if(1) then
        local w = sp:getContentSize().width
        local h = sp:getContentSize().height
        if(direct<3) then
            sp:setSdf(2,endrg)
            sp:setSdf(3,fadeRg/h)
        else
            sp:setSdf(2,endrg)
            sp:setSdf(3,fadeRg/w)
        end
    end
end

------------------------------------------------------------------------

return GenUiUtil
