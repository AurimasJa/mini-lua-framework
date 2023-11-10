local MainController = {}


function MainController.index(body)
    return "Index, main controller"
end

function MainController.create(body)
    return "Create, main controller"
end

function MainController.update(body)
    return "Put/patch, main controller"
end

function MainController.destroy(body)
    return "Destroy, main controller"
end

function MainController.default(body)
    return "default, main controller"
end

return MainController
