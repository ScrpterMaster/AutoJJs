local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local espEnabled = false  -- Inicialmente, o ESP está desligado
local hubOpen = false    -- Inicialmente, o "Hub" está fechado

-- Variáveis para suporte a toque e arrastar o "Hub"
local isDragging = false
local touchStartPos = UDim2.new(0, 0, 0, 0)
local hubStartPosition = UDim2.new(0.5, 0, 0.5, 0)  -- Posição inicial do "Hub" no centro da tela

-- Função para criar o "Hub"
local function createHub()
    -- Destruir a UI existente
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("PlayerHighlight") then
        game.Players.LocalPlayer.PlayerGui.PlayerHighlight:Destroy()
    end
    
    -- Criar o "Hub" ou qualquer outra interface desejada
    local hub = Instance.new("ScreenGui")
    hub.Name = "Hub"
    hub.IgnoreGuiInset = true  -- Ignorar margens do GUI para suporte a dispositivos móveis
    hub.Parent = game.Players.LocalPlayer.PlayerGui

    -- Incluir elementos do "Hub" aqui, como botões, quadros, etc.
    
    -- Botão "X" para fechar o "Hub"
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0.05, 0, 0.05, 0)
    closeButton.Position = UDim2.new(0.95, 0, 0, 0)
    closeButton.Parent = hub

    -- Definir a ação de clique do botão "X" para fechar o "Hub"
    closeButton.MouseButton1Click:Connect(function()
        destroyHub()
    end)

    -- Suporte a toque e arrastar para mover o "Hub"
    local touchInput = Instance.new("Frame")
    touchInput.Size = UDim2.new(1, 0, 1, 0)
    touchInput.Parent = hub

    touchInput.InputBegan:Connect(function(input, isProcessed)
        if input.UserInputType == Enum.UserInputType.Touch and not isDragging then
            isDragging = true
            touchStartPos = UDim2.new(0, input.Position.X, 0, input.Position.Y)
        end
    end)

    touchInput.InputChanged:Connect(function(input, isProcessed)
        if isDragging then
            local delta = UDim2.new(0, input.Position.X - touchStartPos.X, 0, input.Position.Y - touchStartPos.Y)
            hubStartPosition = hubStartPosition + delta
            hub.Position = hubStartPosition
            touchStartPos = UDim2.new(0, input.Position.X, 0, input.Position.Y)
        end
    end)

    touchInput.InputEnded:Connect(function(input, isProcessed)
        if isDragging then
            isDragging = false
        end
    end)
end

-- Função para destruir o "Hub"
local function destroyHub()
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Hub") then
        game.Players.LocalPlayer.PlayerGui.Hub:Destroy()
    end
    hubOpen = false  -- Definir o status do "Hub" como fechado
end

-- Função para ligar/desligar o ESP
local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "Desligar ESP"
        if not hubOpen then
            createHub()  -- Quando o ESP é ligado e o "Hub" está fechado, criar o "Hub"
            hubOpen = true
        end
    else
        espButton.Text = "Ligar ESP"
        if hubOpen then
            destroyHub()  -- Quando o ESP é desligado e o "Hub" está aberto, destruir o "Hub"
            hubOpen = false
        end
    end
end

-- Botão de ligar/desligar o ESP
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Text = "Ligar ESP"
espButton.Size = UDim2.new(0.2, 0, 0.1, 0)
espButton.Position = UDim2.new(0.4, 0, 0.9, 0)
espButton.Parent = game.Players.LocalPlayer.PlayerGui

espButton.MouseButton1Click:Connect(toggleESP)
