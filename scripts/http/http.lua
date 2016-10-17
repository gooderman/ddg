http={}
function http.req(id,url,reqtype,data,waittime,handle)
    local rp = reqtype == 'get' and kCCHTTPRequestMethodGET or kCCHTTPRequestMethodPOST
    local request = CCHTTPRequest:createWithUrl(function(event)
            http.response(id,event,handle)
    end, url, rp)
    if request then
        if(rp==kCCHTTPRequestMethodPOST and data) then
            request:setPOSTData(data)
        end
        request:setTimeout(waittime or 60)
        request:start()
    end
    return request
end
function http.get(id,url,waittime,handle)
    return http.req(id,url,"get",nil,waittime,handle)
end
function http.post(id,url,data,waittime,handle)
    return http.req(id,url,"post",data,waittime,handle)
end
--
-- ing:     handle(id, 1, {dl,all})
-- succ:    handle(id, 0, data)
-- error:   handle(id,-1, code)
-- timeout: handle(id,-2, -2)
function http.response(id,event,handle)
    local request = event.request
    if event.name == "completed" then
        local rspcode = request:getResponseStatusCode()
        if rspcode ~= 200 then
            handle(id,-1,rspcode)
        else
            local datarecv = request:getResponseData()
            handle(id,0,datarecv)
        end
    elseif event.name == "inprogress" then
        if(event.dlnow~=0) then
            handle(id,1,{event.dlnow,event.dltotal})
        end    
    else
        handle(id,-2,-2)
    end
end
