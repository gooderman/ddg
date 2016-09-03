--
-- Author: Your Name
-- Date: 2014-06-05 10:02:1

local TableViewLayer = class("TableViewLayer",function ()
    return display.newNode()
end)
-- getCellSize
-- getCellCount
-- getCellAtIdx
-- cellHighLight
-- cellUnHighLight
function TableViewLayer:ctor(w,h,direct)
    self.tbview = CCTableView:create(CCSizeMake(w,h))    
    --self:initWithViewSize(CCSize(w,h))
    self.tbview:setDirection(direct==0 and kCCScrollViewDirectionHorizontal or kCCScrollViewDirectionVertical)
    self:addChild(self.tbview)

    self.datasouce = {}
    self.delegate = {}
    self:setTouchEnabled(true);
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if (event.name == "began") then
            print("table began")
            return false;
        elseif (event.name == "ended") then
            print("table ended")
        end
    end)
end

function TableViewLayer:scrollViewDidScroll(view)
    print("scrollViewDidScroll")
    if (self.datasouce) then
        return self.datasouce["tableViewDidScroll"](view);
    end
end

function TableViewLayer:scrollViewDidZoom(view)
    print("scrollViewDidZoom")
    if (self.datasouce) then
        return self.datasouce["tableViewDidZoom"](view);
    end
end

function TableViewLayer:tableCellTouched(table,cell)
    print("cell touched at index: " .. cell:getIdx())
    if (self.datasouce) then
        return self.datasouce["tableViewTouched"](table,cell);
    end
end

function TableViewLayer:cellSizeForTable(table,idx) 
    if(self.datasouce) then
        local a,b = self.datasouce["getCellSize"](table,idx)
        --print("cellSizeForTable",a,b)
        return a,b
    end
    return 0,0
end

function TableViewLayer:tableCellAtIndex(table, idx)
    if(self.datasouce) then        
        if(type(self.datasouce)=="userdata") then
            return self.datasouce["getCellAtIdx"](self.datasouce,table,idx)
        else
            return self.datasouce["getCellAtIdx"](table,idx)
        end
    end
end
function TableViewLayer:numberOfCellsInTableView(table)    
    if(self.datasouce) then
        if(type(self.datasouce)=="userdata") then
            return self.datasouce["getCellCount"](self.datasouce,table)
        else
            return self.datasouce["getCellCount"](table)
        end
    end
   return 0
end

function TableViewLayer:init()
    --registerScriptHandler functions must be before the reloadData function
    --self.tbview:registerScriptHandler(TableViewLayer.scrollViewDidScroll,CCTableView.kTableViewScroll)
    --self.tbview:registerScriptHandler(TableViewLayer.scrollViewDidZoom,CCTableView.kTableViewZoom)
    --self.tbview:registerScriptHandler(TableViewLayer.tableCellTouched,CCTableView.kTableCellTouched)
    -- self.tbview:registerScriptHandler(function(table,idx) 
    --                             return self:cellSizeForTable(table,idx)
    --                         end
    --                         ,CCTableView.kTableCellSizeForIndex)

    -- self.tbview:registerScriptHandler(function(table,idx) 
    --                             return self:tableCellAtIndex(table,idx)
    --                         end,CCTableView.kTableCellSizeAtIndex)

    -- self.tbview:registerScriptHandler(function(table) 
    --                             return self:numberOfCellsInTableView(table)
    --                         end,CCTableView.kNumberOfCellsInTableView) 

    --exception catch
    local function cellsize(table,idx) 
        return self:cellSizeForTable(table,idx)
    end
    local function cellat(table,idx) 
        return self:tableCellAtIndex(table,idx)
    end
    local function cellnumb(table,idx) 
        return self:numberOfCellsInTableView(table)
    end
    local function hightLight(table,cell)
        return self:cellHighLight(table,cell);
    end
    local function unHightLight(table,cell)
        return self:cellUnHighLight(table, cell);
    end
    local function tableTouched(table,cell)
        return self:tableCellTouched(table, cell);
    end
    self.tbview:registerScriptHandler(function(table,cell) 
                                tableTouched(table,cell);
                            end
                            ,CCTableView.kTableCellTouched)
    self.tbview:registerScriptHandler(function(table,cell) 
                                local rst, a,b = pcall(unHightLight,table,cell)
                                if(rst) then
                                    return a,b
                                else
                                    print("TableViewLayer:Error setCellUnHightLight")
                                    print("--------------------------------------")
                                    return 0,0
                                end
                            end
                            ,CCTableView.kTableCellUnhighLight)
    self.tbview:registerScriptHandler(function(table,cell) 
                                local rst, a,b = pcall(hightLight,table,cell)
                                if(rst) then
                                    return a,b
                                else
                                    print("TableViewLayer:Error setCellHightLight")
                                    print("--------------------------------------")
                                    return 0,0
                                end
                            end
                            ,CCTableView.kTableCellHighLight)

    self.tbview:registerScriptHandler(function(table,idx) 
                                local rst, a,b = pcall(cellsize,table,idx)
                                if(rst) then
                                    --print("self.tbview:registerScriptHandler",a,b)
                                    return a,b
                                else
                                    print("TableViewLayer:Error cellSizeForTable")
                                    print("--------------------------------------")
                                    return 0,0
                                end
                            end
                            ,CCTableView.kTableCellSizeForIndex)

    self.tbview:registerScriptHandler(function(table,idx) 
                                local rst, a = pcall(cellat,table,idx)
                                if(rst) then
                                    return a
                                else
                                    print("TableViewLayer:Error tableCellAtIndex")
                                    print("------------------------------------")
                                    return CCTableViewCell:new()
                                end
                            end,CCTableView.kTableCellSizeAtIndex)

    self.tbview:registerScriptHandler(function(table) 
                                local rst, a = pcall(cellnumb,table,idx)
                                if(rst) then
                                    return a
                                else
                                    print("TableViewLayer:Error numberOfCellsInTableView")
                                    print("--------------------------------------------")
                                    return 0
                                end
                            end,CCTableView.kNumberOfCellsInTableView) 


    self.tbview:reloadData()

    --self.tbview:setContentOffsetInDuration(ccp(-1800,0), 0.3);
    return true
end

function TableViewLayer:setTbDataSouce(param)
    if(param["getCellSize"] and param["getCellCount"] and param["getCellAtIdx"]) then        
        self.datasouce = param
        print("TableViewLayer:setTbDataSouce",self.datasouce)
        return true
    end
    return false
end

function TableViewLayer:setTbDelegate(param) 
    --print("setTbDelegate",type(param))   
    if(param["cellHighLight"] and param["cellUnHighLight"]) then
        self.delegate = param
        return true
    end
    return false
end

function TableViewLayer:getCellSize(tb,idx)
    return 120,120
end
function TableViewLayer:getCellCount(tb)
    return 20
end
function TableViewLayer:getCellAtIdx(tb,idx)
    local strValue = string.format("%d",idx)
    local cell = tb:dequeueCell()
    local label = nil
    if nil == cell then
        cell = CCTableViewCell:new()
        local sprite = CCSprite:create("img/mainlayer/zjm_1_01.png")
        sprite:setAnchorPoint(CCPointMake(0,0))
        sprite:setPosition(CCPointMake(0, 0))
        cell:addChild(sprite)

        sprite:setTouchEnabled(true)
        sprite:setTouchSwallowEnabled(false) -- 是否吞噬事件，默认值为 true
        sprite:addTouchEventListener(function (evt,x,y)
            print("tableView cell sp evt",evt)
            if(evt == "began") then
                local ac
                ac=CCScaleTo:create(0.1, 1.5)
                sprite:runAction(ac)
                return true
            elseif evt == "moved" then
                
            elseif(evt == "ended") then
                local ac
                ac=CCScaleTo:create(0.1, 1.0)
                sprite:runAction(ac)
                --self:gotoFight()
            end
            -- body
        end, false,kCCMenuHandlerPriority, true)

        label = CCLabelTTF:create(strValue, "Helvetica", 20.0)
        label:setPosition(CCPointMake(0,0))
        label:setAnchorPoint(CCPointMake(0,0))
        label:setTag(123)
        cell:addChild(label)
    else
        label = tolua.cast(cell:getChildByTag(123),"CCLabelTTF")
        if nil ~= label then
            label:setString(strValue)
        end
    end
    return cell
end
function TableViewLayer:cellHighLight(tb,cell)
    if (self.datasouce) then
        return self.datasouce["setCellHightLight"](tb,cell)
    end
end
function TableViewLayer:cellUnHighLight(tb,cell)
     if (self.datasouce) then
         return self.datasouce["setCellUnHightLight"](tb,cell)
     end
end

return TableViewLayer