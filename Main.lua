local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local highlightTemplate = Instance.new("Frame")
highlightTemplate.Name = "PlayerHighlight"
highlightTemplate.BackgroundColor3 = Color3.new(1, 1, 0)  -- Cor amarela para destaque
highlightTemplate.Size = UDim2.new(2, 0, 2, 0)  -- Tamanho da UI
highlightTemplate.BorderSizePixel = 0
highlightTemplate.Visible = false  -- Inicialmente, a UI de destaque está desligada

-- Botão de ligar/desligar o ESP
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Text = "Ligar ESP"
espButton.Size = UDim2.new(0.2, 0, 0.1, 0)
espButton.Position = UDim2.new(0.4, 0, 0.9, 0)
espButton.Parent = game.Players.LocalPlayer.PlayerGui

local espEnabled = false  -- Inicialmente, o ESP está desligado

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "Desligar ESP"
    else
        espButton.Text = "Ligar ESP"
    end
end)

function addHighlight(player)
    local character = player.Character
    if character and not character:FindFirstChild("PlayerHighlight") and espEnabled then
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
