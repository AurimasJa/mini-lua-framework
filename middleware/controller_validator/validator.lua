local Validation = {}
Validation.__index = Validation

function Validation.new(data)
    local instance = {
        data = data
    }
    setmetatable(instance, Validation)
    return instance
end

function Validation:validate_all_data()
    local username = self.data.username
    local password = self.data.password
    local age = self.data.age
    local is_username_valid, username_error = Validation:validate_username(username)
    local is_password_valid, password_error = Validation:validate_password(password)
    local is_age_valid, age_error = Validation:validate_age(age)
    local isDataValid = is_username_valid and is_password_valid and is_age_valid

    local error_message = ""
    if not is_username_valid then
        error_message = error_message .. username_error .. " "
    end
    if not is_password_valid then
        error_message = error_message .. password_error .. " "
    end
    if not is_age_valid then
        error_message = error_message .. age_error .. " "
    end

    return isDataValid, error_message
end

function Validation:validate_username(username)
    if username == "" or username == nil then return false, "Username is required" end
    if #username < 2 or #username > 100 then
        return false,
            "Username must be longer than 2 symbols and can not be longer than 100"
    end

    if string.match(username, "%d") ~= nil then
        return false, "Username can not contain numbers"
    end

    return true
end

function Validation:validate_password(password)
    if password == "" or password == nil then return false, "Password is required" end
    if #password < 2 or #password > 50 then
        return false,
            "Password must be longer than 2 symbols and can not be longer than 50"
    end

    return true
end

function Validation:validate_age(age)
    if age == "" or age == nil then return false, "Age is required" end
    if type(age) ~= "number" then return false, "Provided age is incorrect!" end
    if age < 1 or age > 99 then
        return false,
            "Provided age is incorrect!"
    end

    if string.match(age, "%a") ~= nil then
        return false, "Provided age is incorrect!"
    end

    return true
end

return Validation
