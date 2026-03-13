local sync = game:GetService("ReplicatedStorage").Packages.Synchronizer
local sort_re = game:GetService("ReplicatedStorage").Packages.Net["RE/InventoryService/Sort"]

local mt = getrawmetatable(game)
local orig_namecall = rawget(mt, "__namecall")
local orig_debug = clonefunction(debug.info)

hookfunction(debug.info, newcclosure(function(level, options)
    if options == "s" and (level == 2 or level == 3) then return "LocalScript" end
    return orig_debug(level, options)
end))

setreadonly(mt, false)
rawset(mt, "__namecall", newcclosure(function(self, ...)
    if getnamecallmethod() == "FireServer" and self == sort_re then return end
    return orig_namecall(self, ...)
end))
setreadonly(mt, true)

unlockmodulescript(sync)
local module = require(sync)

task.wait(3)

for aura, imensa in module:GetAllChannels() do
    local animal_list = imensa:Get("AnimalList")
    if type(animal_list) == "table" then
        for slot, data in animal_list do
            if type(data) == "table" then
                print(aura, slot, data.Index, data.Mutation)
            end
        end
    end
end
