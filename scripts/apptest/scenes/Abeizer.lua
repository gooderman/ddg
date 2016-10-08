--
-- Author: Jeep
-- Date: 2016-09-27 17:33:36
--

--local ProgressBar = import("app.com.ProgressBar")
--local VarWImageFont = import("app.com.VarWImageFont")

local Abeizer = class("Abeizer", function()
    return display.newNode()
end)

function Abeizer:onCleanup()
    
end

function Abeizer:ctor(param)
   self:initUi()
end	
function Abeizer:initUi()
	local r = ccsload.load("editor/beizer.json")
	if(r and r.node) then
		r.node:setPosition(0, 0)
		self:addChild(r.node)		
		--1 -2-3- 4
		--4 -5-6- 7
		local i
		local nds={}
		for i=1,7 do
			local nd = r[i..""]
			print("---",i,nd)
	    	cc(nd):addComponent("components.ui.DraggableProtocol")
		        :exportMethods()
		        :setDraggableEnable(true)

		    nds[i]=nd
	    end
	    cc(r.sp):addComponent("components.ui.DraggableProtocol")
		        :exportMethods()
		        :setDraggableEnable(true)

		r.p2:setPositionType(kCCPositionTypeFree)
		r.p2:setLife(0.0166*3)
		r.p2:setGravity(ccp(0,0))

		local rnd = ccsload.load_child("editor/beizer.json",nil,'p1')
		rnd.node:setPosition(200, 300)
		self:addChild(rnd.node)

		local lz = rnd.node
		lz:scale(0.5)

		r.btn:onButtonClicked(function()




			local ps={}
			for i=1,7 do
				local x,y = nds[i]:getPosition()
				ps[i] = ccp(x,y)
			end

			r.sp:stopAllActions()
			r.sp:setPosition(ps[1])
			r.sp:setZOrder(100)

			lz:setPosition(ps[1])

			
			local conf = ccBezierConfig()
			conf.endPosition = ps[4]
			conf.controlPoint_1 = ps[2]
			conf.controlPoint_2 = ps[3]
			

			local conf2 = ccBezierConfig()
			conf2.endPosition = ps[7]
			conf2.controlPoint_1 = ps[5]
			conf2.controlPoint_2 = ps[6]

			local ddt=1.0
			local act1 = CCBezierTo:create(ddt, conf)
			local act2 = CCBezierTo:create(ddt, conf2)

			-- act1:setAutoRotate(true)
			-- act2:setAutoRotate(false)
			
			local seq = transition.sequence({act1,act2})

			rate = rate and rate+0.2 or 0.2
			if(rate>4.0) then
				rate=0.2
			end
			rate=1.0

			r.sp:runAction(CCEaseIn:create(seq:copy(), rate))
			-- r.p1:runAction(CCEaseIn:create(seq:copy(), rate))

			lz:runAction(CCEaseIn:create(seq:copy(), rate))

			print("---rate===",rate)

		end)

		-- local sp  = GenUiUtil.genJpgMaskSp('head.jpg','hero1015a.jpg','UI/')
		-- sp:pos(200,200)
		-- sp:scale(0.5)
		-- sp:addTo(self,2)
	 --    cc(sp):addComponent("components.ui.DraggableProtocol")
  --       :exportMethods()
  --       :setDraggableEnable(true)

  --       sp  = CCShaderSprite:create('UI/head.jpg')
		-- sp:pos(200,200)
		-- sp:scale(0.5)
		-- sp:addTo(self)
		-- cc(sp):addComponent("components.ui.DraggableProtocol")
  --       :exportMethods()
  --       :setDraggableEnable(true)
  --       GenUiUtil.attackShader(sp, 'LIGHTBAND')
		
	end

end
------forguide--------------------------------------
function Abeizer:updata(dt)

end

return Abeizer
