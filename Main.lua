-- Crie o Frame principal do hub
local hubFrame = Instance.new("Frame")
hubFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
hubFrame.Position = UDim2.new(0.8, 0, 0.2, 0)
hubFrame.BackgroundColor3 = Color3.new(0, 0, 0)
hubFrame.BackgroundTransparency = 0.5
hubFrame.Parent = game.Players.LocalPlayer.PlayerGui

-- Adicione um botão para ligar/desligar os destaques
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.5, 0, 0.2, 0)
toggleButton.Position = UDim2.new(0.25, 0, 0.4, 0)
toggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
toggleButton.Text = "Ligar Destaques"
toggleButton.Parent = hubFrame

-- Adicione um botão para fechar o hub
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.9, 0, 0.1, 0)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.Text = "X"
closeButton.Parent = hubFrame

local highlightEnabled = true

-- Função para ligar/desligar os destaques
local function toggleHighlights()
    if highlightEnabled then
        toggleButton.Text = "Ligar Destaques"
        -- Desligue os destaques aqui
    else
        toggleButton.Text = "Desligar Destaques"
        -- Ligue os destaques aqui
    end
    highlightEnabled = not highlightEnabled
end

-- Conecte a função de alternar aos botões
toggleButton.MouseButton1Click:Connect(toggleHighlights)
closeButton.MouseButton1Click:Connect(function()
    -- Feche o hub
    hubFrame:Destroy()
end)
