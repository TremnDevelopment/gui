local Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/TremnDevelopment/gui/refs/heads/main/Framework.lua", true))()

local Window = Framework:CreateWindow({
    Title = "Framework Showcase",
    Subtitle = "Man this is sexy",
})

local Main = Window:CreateTab("Main")

local AutoFarm = Main:CreateSection("Farming")

_G.AutoAmmo = true
_G.SelectedTarget = "Basic Target"

_G.AutoHitWall = true
_G.AutoRebirth = false
_G.AutoRollTitles = false

task.spawn(function()
    AutoFarm:AddToggle("Auto Ammo", true, function(state)
        _G.AutoAmmo = state
        repeat
            for i = 1, 3 do
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("KickService"):WaitForChild("RF"):WaitForChild("AddKick"):InvokeServer(_G.SelectedTarget)
            end
            task.wait(0.03)
        until (not _G.AutoAmmo)
    end)

    AutoFarm:AddDropdown("Selected Target", {"Basic Target","Blue Target","Noob Target","Emerald Target","Dark Target","Frost Target"}, "Basic Target", function(selected)
        _G.SelectedTarget = selected
    end)

    AutoFarm:AddToggle("Auto Hit Wall", true, function(state)
        _G.AutoHitWall = state
        repeat
            for i = 1, 3 do
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("BreakWallService"):WaitForChild("RF"):WaitForChild("HitWall"):InvokeServer()
            end
            task.wait(0.03)
        until (not _G.AutoHitWall)
    end)

    AutoFarm:AddToggle("Auto Rebirth", false, function(state)
        _G.AutoRebirth = state
        repeat
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RebirthService"):WaitForChild("RF"):WaitForChild("Rebirth"):InvokeServer()
            task.wait(0.07)
        until (not _G.AutoRebirth)
    end)

    AutoFarm:AddToggle("Auto Roll Titles", false, function(state)
        _G.AutoRollTitles = state
        repeat
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("TitleService"):WaitForChild("RF"):WaitForChild("Roll"):InvokeServer()
            task.wait(0.07)
        until (not _G.AutoRollTitles)
    end)
end)
