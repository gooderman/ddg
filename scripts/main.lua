
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

-- require("app.MyApp").new():run()
require("apptest.TstApp").new():run()
-- require("appeditor.EditorApp").new():run()

