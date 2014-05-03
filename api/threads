local Test = {}

local Threads
do Threads = setmetatable({}, {
        __call = function(class)
            return setmetatable({
                threads = {},
            }, class)
        end
    })
end

Test.Threads = Threads

return Test