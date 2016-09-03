

EffectConfig =
{
    STONE ={"StoneShader.vsh","StoneShader.fsh"},
    GREY  ={"GrayScalingShader.vsh","GrayScalingShader.fsh"},
    GREYJPGMASK  ={"JpgMaskShaderGrey.vsh","JpgMaskShaderGrey.fsh"},
    FROZEN  ={"FrozenShader.vsh","FrozenShader.fsh"},
    ICE  ={"IceShader.vsh","IceShader.fsh"},
    BLUR  ={"Blur.vsh","Blur.fsh"},
    --------------------------------------------
    HIDE  = {"InvisibleShader.vsh","InvisibleShader.fsh"},
    LIGHT  = {"LightShader.vsh","LightShader.fsh"},
    LIGHTF  = {"LightFShader.vsh","LightFShader.fsh"},
    TRANS  = {"TransShader.vsh","TransShader.fsh"},
    LK  = {"LKShader.vsh","LKShader.fsh"},
    GOLD  = {"GoldShader.vsh","GoldShader.fsh"},
    FADEINUV  = {"FadeInUV.vsh","FadeInUV.fsh"},

    RED  = {"RedShader.vsh","RedShader.fsh"},
    BLUE  = {"BlueShader.vsh","BlueShader.fsh"},
    GREEN  = {"GreenShader.vsh","GreenShader.fsh"},
    WBULE = {"BuleWaterShader.vsh","BuleWaterShader.fsh"},
    --------------------------------------------
    LIGHTBAND = {"LightbandShader.vsh","LightbandShader.fsh"},
    WATERWAVE = {"WaterWaveShader.vsh","WaterWaveShader.fsh"},
}

EFT_SHADER_PATH = "shader/"

function getShaderInfo(name) 
	if(EffectConfig[name]) then
		return EFT_SHADER_PATH .. EffectConfig[name][1],EFT_SHADER_PATH .. EffectConfig[name][2]
	end
end

--战斗信息
FT_INFO_ARM = {arm="playing_effect",file="img/UI/fight/playing_effect.xml"}
--战斗动画
FT_INFO_ANIMA = {
	--boss战动画
	boss = 		{anim='common1',	arc={0.5,0.5},off={0,0},order=1},
	--宝箱法阵
	box = 		{anim='common2',	arc={0.5,0.5},off={0,0},order=2},
	--仙将头像升级
	uplv = 		{anim='common3',	arc={0.5,0.5},off={0,0},order=1},
	--仙兽能量条闪动
	petEfull = 	{anim='common4',	arc={0.5,0.5},off={0,0},order=1},
	--仙兽能量加点
	petEadd = 	{anim='common5',	arc={0.5,0.5},off={0,0},order=1},
	--仙兽能量满绕身
	petEround = {anim='common6',	arc={0.5,0.5},off={0,0},order=1},
	--仙将能量满头像框环绕
	gRound = 	{anim='common7',	arc={0.5,0.5},off={0,0},order=1},
	--仙将能量条闪电
	gEmax = 	{anim='common8',	arc={0.5,0.5},off={0,0},order=1},
	--仙将能量满一次闪动
	gLight = 	{anim='common9',	arc={0.5,0.5},off={0,0},order=1},
	--仙兽最后一个能量满
	petELast = 	{anim='common10',	arc={0.5,0.5},off={0,0},order=1},
	--仙兽能量清空
	petEempty = {anim='common11',	arc={0.5,0.5},off={0,0},order=1},
}

--BOSS战粒子
FT_INFO_BOSS_LIZI = {						
						arc={0.5,0.5},
						res="img/UI/fight/zjtx_lizi_03.plist",
						pos={622,356},
						scale={3,15},
						rotate=-240,
						autodel=true,
						delay=1.0,
}

--战斗帧动画
FT_INFO_FRAME_ANIM = {
	uplv  =
		    {
		    	arc={70/160,88/210},
		        res="img/UI/fight/playing_effect.plist",
		        name="tx-xjsj_tsb%d.png",
		        a=1,
		        b=18,
		        reverse = false,
		        loop=false,
		        autodel=true,
		        onfinish = nil,
		        delay=0.5,
		        dt=0.05,		        	        
		    },
	gEmaxD = {
				arc={0.5,0.5},
		        res="img/UI/fight/playing_effect.plist",
		        name="tx-nknmb_sblbs1.png",
		        a=1,
		        b=1,
		        reverse = false,
		        loop=true,
		        autodel=false,
		        onfinish = nil,
		        delay=0.03*8,
		        dt=0.12,

		        ac='fadeinout',
		        acparam={from=0,to=255,dt=1.0,delay=0.5,loop=true},
			},		
	gLight = {
                arc={0.5,0.5},
                res="img/UI/fight/playing_effect.plist",
                name="tx-fklian_cgf.png",
                a=1,
                b=1,
                reverse = false,
                loop=false,
                autodel=false,
                onfinish = nil,
                delay=0.0,
                dt=0.03,

                ac='bomb',
                acparam={from=0,to=255,dt=0.03,frame=7,loop=false},

			},

}
------------------------------------------------
-----------------出生光效-----------------------
---天兵---
EFT_BORN_TB = 
{
	arm = "effect_system",
	res = "effect_system.xml",
	anima = "bomb13",
	arc = {0.5,-0.6},
	bone = 'b_bottom'
}
------------------------------------------------
