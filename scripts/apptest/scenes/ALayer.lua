
--local ProgressBar = import("app.com.ProgressBar")
--local VarWImageFont = import("app.com.VarWImageFont")

local ALayer = class("ALayer", function()
    return display.newNode()
end)
local pathflag = 'UI/'
local UI_POS = 
{   
    --头像背景
    {n="bg",        t="sp",       x=display.cx,y=display.cy,   tg = 100,  ftg = 0, res="cpt_bg_02.png"},  
    {n="crit",      t="mcbtn",  x=display.cx,y=display.cy,   tg = 101,  ftg = 0, res={"crit.png","crit.png"}},
    {n="black",     t="color",    x=display.cx,y=display.cy,   tg = 102,  ftg = 0, od = 1000,color={0,0,0,0}},
    {n="blacktxt",  t="txt",      x=display.cx,y=display.cy-40,   tg = 103,  ftg = 0, color={255,255,255},size=20,txt="do It" },
 }


local FIGHT_FONT_HP_NUM=
{    
     "UI/ZD_shuzi_01.png",
     "x,1,2,3,4,5,6,7,8,9,0",
     {27,27,27,27,27,27,27,27,27,27,27}
}

function ALayer:onCleanup()
    self.delegate = nil
end

function ALayer:ctor(param)
    ---------------------------
    self.uis={}    
    self.uis = GenUiUtil.genUis(UI_POS,self,pathflag)
    --点击开启
    self.uis["crit"]:onButtonClicked(
        function()
        end
        )
    self:setContentSize(CCSize(display.width,display.height-200))

end	

------forguide--------------------------------------
function ALayer:updata(dt)

end

return ALayer
