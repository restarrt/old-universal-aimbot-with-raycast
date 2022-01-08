local mouse = game.Players.LocalPlayer:GetMouse()
local ting = false
local accessories = {}
local function getzeclose()
    local daplayer = nil
    local ting = math.huge
    for i,v in pairs(workspace:GetChildren()) do
        if v.ClassName == "Model" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild("Head") and v.Head.Material ~= Enum.Material.ForceField and not v:FindFirstChild("ForceField") then
         local lol = CFrame.new(game.Players.LocalPlayer.Character.Head.Position, v.Head.Position)
         local rp = RaycastParams.new()
         for i,v in pairs(v:GetChildren()) do
             if v.Name ~= "Head" then
                 table.insert(accessories, v)
            end
         end
         rp.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, accessories}
         rp.FilterType = Enum.RaycastFilterType.Blacklist
         local a = workspace:Raycast(game.Players.LocalPlayer.Character.Head.Position, (v.Head.Position - game.Players.LocalPlayer.Character.Head.Position), rp)
           if a and a.Instance.Parent == v then
               print(a.Instance.Parent.Name)
            local pos = (v.Head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude
            if pos < ting then
                daplayer = v
                ting = pos
            end
        end
      end
     end
     accessories = {}
    return daplayer
end
mouse.Button2Down:connect(function()
    ting = true
end)
mouse.Button2Up:connect(function()
    ting = false
end)
repeat
game.RunService.Heartbeat:wait()
if ting and getzeclose() then
    local cc = workspace:FindFirstChild("Camera").CFrame
    workspace:FindFirstChild("Camera").CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, getzeclose().Head.CFrame.p)
    mouse1press()
else
    mouse1release()
end
until nil
