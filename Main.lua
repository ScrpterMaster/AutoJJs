local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local highlightTemplate = Instance.new("Frame")
highlightTemplate.Name = "PlayerHighlight"
highlightTemplate.BackgroundColor3 = Color3.new(1, 1, 0)  -- Cor amarela para destaque
highlightTemplate.Size = UDim2.new(2, 0, 2, 0)  -- Tamanho da UI
highlightTemplate.BorderSizePixel = 0

function addHighlight(player)
    local character = player.Character
    if character and not character:FindFirstChild("PlayerHighlight") then
        local highlight = highlightTemplate:Clone()
        highlight.Parent = player.PlayerGui
    end
end

function removeHighlight(player)
    local character = player.Character
    if character and character:FindFirstChild("PlayerHighlight") then
        player.PlayerGui.PlayerHighlight:Destroy()
    end
end

Players.PlayerAdded:Connect(addHighlight)
Players.PlayerRemoving:Connect(removeHighlight)

RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        addHighlight(player)
    end
end)
