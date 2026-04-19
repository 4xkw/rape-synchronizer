local sort_re = game:GetService("ReplicatedStorage").Packages.Net["RE/InventoryService/Sort"]
local sync = game:GetService("ReplicatedStorage").Packages.Synchronizer

unlockmodulescript(sync)

for i = 1, 100 do
    local name, val = debug.getupvalue(require, i)
    if not name then break end
end

local func_list = {}
for _, v in debug.getprotos and debug.getprotos(sync) or {} do
    table.insert(func_list, v)
end

for _, proto in func_list do
    for i = 1, 100 do
        local ok, name = pcall(debug.getupvaluename or function() end, proto, i)
        if not ok or not name then break end
        if name == "v_u_8" then
            debug.setupvalue(proto, i, true)
        end
    end
end

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
