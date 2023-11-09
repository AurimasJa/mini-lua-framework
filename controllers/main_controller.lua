-- controller.lua

local controller = {
    index = function(req, params, data)
        print("ind")
        print(req, params, data)
    end,

    create = function(req, params, data)
        print("cre")
        print(req, params, data)
    end,

    update = function(req, params, data)
        print("upd")
        print(req, params, data)
    end,

    destroy = function(req, params, data)
        print("del")
        print(req, params, data)
    end
}

return controller
