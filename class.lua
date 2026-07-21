local assert = _G.assert
local type = _G.type
local pairs = _G.pairs
local setmetatable = _G.setmetatable
local getmetatable = _G.getmetatable

local Object = {}

Object.__index = Object
Object.__name__ = "Object"
Object.__super__ = nil
Object.__class__ = Object

function Object:init(...)
end

function Object:isInstanceOf(parent)
    local current = getmetatable(self)

    while current do

        if current == parent then
            return true
        end
        
        current = current.__super__
    end

    return false

end

function Object:getBase()
    return self.__super__
end

function Object:getName()
    return self.__name__
end    

function Object:getClass()
    return self.__class__ 
end

function Object:new(...)
    return getmetatable(self)(...)
end

function Object:getFields()
    local fields = {}
    for key, value in pairs(getmetatable(self)) do
        if type(value) ~= "function" then
            fields[key] = value
        end
    end
    return fields
end

function Object:getMethods()
    local methods = {}
    for key, value in pairs(getmetatable(self)) do
        if type(value) == "function" then
            methods[key] = value
        end
    end
    return methods
end

setmetatable(Object, {
                      __call = function (cls, ...)

                                        local object = setmetatable({}, cls)

                                        if object.init then
                                            object:init(...)
                                        end

                                return object 
                                
                      end,
                      __tostring = function (t)
                                    return t.__name__
        
                      end

                     }
            )
Object.__class__ = Object            
            
local function class(def) 
    assert(type(def) == "table", [[Class definition should be 'Table data type']])

    local cls = {}
    
    cls.__name__ = def.__name__
    cls.__super__ = def.__super__ or Object
    cls.__index = cls

    for key, value in pairs(def) do
        cls[key] = value
    end

    setmetatable(cls, {
                            __index = cls.__super__,
                            __call = function (t, ...)
                                              local object = setmetatable({},t)
                                              if object.init then
                                                object:init(...)
                                              end
                                        return object      
                            end,
                            __tostring = function (t)
                                return t.__name__
                                
                            end
                      }
                )
    cls.__class__ = cls            
    return cls            
end

return class, Object