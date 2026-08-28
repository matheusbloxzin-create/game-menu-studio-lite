-- Game Menu Script para Studio Lite
-- Criado por GOOD1x0 STUDIOS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variáveis de configuração
local gameSettings = {
	shadowsEnabled = true,
	realisticMode = false,
	soundEnabled = true,
	nametagsEnabled = true,
	masterVolume = 1,
	gameVolume = 0.7
}

-- Função para criar a ScreenGui principal
local function createMainMenu()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MainMenuGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	-- Fundo verde com textura de lego
	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.new(1, 0, 1, 0)
	background.BackgroundColor3 = Color3.fromRGB(34, 177, 76) -- Verde Lego
	background.BorderSizePixel = 0
	background.Parent = screenGui

	-- Adicionar textura de lego ao fundo
	local legoBrickPattern = Instance.new("ImageLabel")
	legoBrickPattern.Name = "LegoBrickPattern"
	legoBrickPattern.Size = UDim2.new(1, 0, 1, 0)
	legoBrickPattern.BackgroundTransparency = 0.3
	legoBrickPattern.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	legoBrickPattern.Image = "rbxasset://textures/Bricks.png"
	legoBrickPattern.ScaleType = Enum.ScaleType.Tile
	legoBrickPattern.BorderSizePixel = 0
	legoBrickPattern.Parent = background

	-- Painel central com título
	local titlePanel = Instance.new("Frame")
	titlePanel.Name = "TitlePanel"
	titlePanel.Size = UDim2.new(0, 600, 0, 150)
	titlePanel.Position = UDim2.new(0.5, -300, 0, 50)
	titlePanel.BackgroundColor3 = Color3.fromRGB(20, 120, 55)
	titlePanel.BorderSizePixel = 2
	titlePanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	titlePanel.Parent = screenGui

	-- Título
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, 0, 1, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "🎮 MENU PRINCIPAL"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 48
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = titlePanel

	-- Container de botões
	local buttonContainer = Instance.new("Frame")
	buttonContainer.Name = "ButtonContainer"
	buttonContainer.Size = UDim2.new(0, 600, 0, 450)
	buttonContainer.Position = UDim2.new(0.5, -300, 0, 250)
	buttonContainer.BackgroundTransparency = 1
	buttonContainer.Parent = screenGui

	return screenGui, buttonContainer
end

-- Função para criar um botão estilizado
local function createButton(parent, position, name, text, icon, callback)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, 0, 0, 100)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(34, 177, 76) -- Verde Lego
	button.BorderSizePixel = 2
	button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	button.Text = ""
	button.Parent = parent

	-- Adicionar efeito hover
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(50, 200, 90)
	end)

	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
	end)

	button.MouseButton1Click:Connect(callback)

	-- Label de texto
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "TextLabel"
	textLabel.Size = UDim2.new(0.6, 0, 1, 0)
	textLabel.Position = UDim2.new(0, 10, 0, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = text
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextSize = 32
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = button

	-- Ícone/Imagem
	if icon then
		local iconLabel = Instance.new("ImageLabel")
		iconLabel.Name = "IconLabel"
		iconLabel.Size = UDim2.new(0, 80, 0, 80)
		iconLabel.Position = UDim2.new(0.7, 0, 0.5, -40)
		iconLabel.BackgroundTransparency = 1
		iconLabel.Image = icon
		iconLabel.Parent = button
	end

	return button
end

-- Função para criar menu de configurações
local function createSettingsMenu(screenGui)
	-- Limpar menu anterior
	for _, child in pairs(screenGui:GetChildren()) do
		if child.Name ~= "Background" then
			child:Destroy()
		end
	end

	-- Painel de configurações
	local settingsPanel = Instance.new("Frame")
	settingsPanel.Name = "SettingsPanel"
	settingsPanel.Size = UDim2.new(0, 700, 0, 600)
	settingsPanel.Position = UDim2.new(0.5, -350, 0.5, -300)
	settingsPanel.BackgroundColor3 = Color3.fromRGB(20, 120, 55)
	settingsPanel.BorderSizePixel = 2
	settingsPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	settingsPanel.Parent = screenGui

	-- Título
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, 0, 0, 60)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "⚙️ CONFIGURAÇÕES"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 40
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = settingsPanel

	-- ScrollingFrame para configurações
	local scrollingFrame = Instance.new("ScrollingFrame")
	scrollingFrame.Name = "ScrollingFrame"
	scrollingFrame.Size = UDim2.new(1, -20, 1, -100)
	scrollingFrame.Position = UDim2.new(0, 10, 0, 70)
	scrollingFrame.BackgroundTransparency = 1
	scrollingFrame.ScrollBarThickness = 12
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
	scrollingFrame.Parent = settingsPanel

	local settingsList = Instance.new("Frame")
	settingsList.Name = "SettingsList"
	settingsList.Size = UDim2.new(1, 0, 0, 400)
	settingsList.BackgroundTransparency = 1
	settingsList.Parent = scrollingFrame

	-- Função auxiliar para criar toggle
	local function createToggleSetting(parent, position, label, initialValue, settingKey)
		local setting = Instance.new("Frame")
		setting.Name = label
		setting.Size = UDim2.new(1, -20, 0, 60)
		setting.Position = position
		setting.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
		setting.BorderSizePixel = 1
		setting.BorderColor3 = Color3.fromRGB(0, 0, 0)
		setting.Parent = parent

		local labelText = Instance.new("TextLabel")
		labelText.Name = "LabelText"
		labelText.Size = UDim2.new(0.6, 0, 1, 0)
		labelText.BackgroundTransparency = 1
		labelText.Text = label
		labelText.TextColor3 = Color3.fromRGB(255, 255, 255)
		labelText.TextSize = 20
		labelText.Font = Enum.Font.Gotham
		labelText.TextXAlignment = Enum.TextXAlignment.Left
		labelText.Parent = setting

		local toggleButton = Instance.new("TextButton")
		toggleButton.Name = "ToggleButton"
		toggleButton.Size = UDim2.new(0, 80, 0, 40)
		toggleButton.Position = UDim2.new(0.7, 0, 0.5, -20)
		toggleButton.BackgroundColor3 = initialValue and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(200, 0, 0)
		toggleButton.BorderSizePixel = 1
		toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		toggleButton.Text = initialValue and "ON" or "OFF"
		toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggleButton.TextSize = 16
		toggleButton.Font = Enum.Font.GothamBold
		toggleButton.Parent = setting

		toggleButton.MouseButton1Click:Connect(function()
			gameSettings[settingKey] = not gameSettings[settingKey]
			toggleButton.BackgroundColor3 = gameSettings[settingKey] and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(200, 0, 0)
			toggleButton.Text = gameSettings[settingKey] and "ON" or "OFF"
		end)

		return setting
	end

	-- Criar toggles
	createToggleSetting(settingsList, UDim2.new(0, 0, 0, 0), "Sombras", gameSettings.shadowsEnabled, "shadowsEnabled")
	createToggleSetting(settingsList, UDim2.new(0, 0, 0, 70), "Modo Realista", gameSettings.realisticMode, "realisticMode")
	createToggleSetting(settingsList, UDim2.new(0, 0, 0, 140), "Som do Jogo", gameSettings.gameVolume > 0, "soundEnabled")
	createToggleSetting(settingsList, UDim2.new(0, 0, 0, 210), "Nametags", gameSettings.nametagsEnabled, "nametagsEnabled")

	-- Controle de Volume
	local volumeFrame = Instance.new("Frame")
	volumeFrame.Name = "VolumeControl"
	volumeFrame.Size = UDim2.new(1, -20, 0, 60)
	volumeFrame.Position = UDim2.new(0, 0, 0, 280)
	volumeFrame.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
	volumeFrame.BorderSizePixel = 1
	volumeFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	volumeFrame.Parent = settingsList

	local volumeLabel = Instance.new("TextLabel")
	volumeLabel.Name = "VolumeLabel"
	volumeLabel.Size = UDim2.new(0.6, 0, 1, 0)
	volumeLabel.BackgroundTransparency = 1
	volumeLabel.Text = "Editar Volume"
	volumeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	volumeLabel.TextSize = 20
	volumeLabel.Font = Enum.Font.Gotham
	volumeLabel.TextXAlignment = Enum.TextXAlignment.Left
	volumeLabel.Parent = volumeFrame

	local volumeSlider = Instance.new("TextBox")
	volumeSlider.Name = "VolumeSlider"
	volumeSlider.Size = UDim2.new(0, 80, 0, 40)
	volumeSlider.Position = UDim2.new(0.7, 0, 0.5, -20)
	volumeSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	volumeSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
	volumeSlider.TextSize = 16
	volumeSlider.Text = tostring(math.floor(gameSettings.masterVolume * 100))
	volumeSlider.Parent = volumeFrame

	volumeSlider.FocusLost:Connect(function()
		local volume = tonumber(volumeSlider.Text) or 100
		volume = math.clamp(volume, 0, 100) / 100
		gameSettings.masterVolume = volume
		volumeSlider.Text = tostring(math.floor(volume * 100))
	end)

	-- Botão Voltar
	local backButton = Instance.new("TextButton")
	backButton.Name = "BackButton"
	backButton.Size = UDim2.new(0.3, 0, 0, 50)
	backButton.Position = UDim2.new(0.35, 0, 1, -60)
	backButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	backButton.BorderSizePixel = 1
	backButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	backButton.Text = "Voltar"
	backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	backButton.TextSize = 24
	backButton.Font = Enum.Font.GothamBold
	backButton.Parent = settingsPanel

	backButton.MouseButton1Click:Connect(function()
		createMainMenuUI(screenGui)
	end)
end

-- Função para criar menu de créditos
local function createCreditsMenu(screenGui)
	-- Limpar menu anterior
	for _, child in pairs(screenGui:GetChildren()) do
		if child.Name ~= "Background" then
			child:Destroy()
		end
	end

	-- Painel de créditos
	local creditsPanel = Instance.new("Frame")
	creditsPanel.Name = "CreditsPanel"
	creditsPanel.Size = UDim2.new(0, 600, 0, 400)
	creditsPanel.Position = UDim2.new(0.5, -300, 0.5, -200)
	creditsPanel.BackgroundColor3 = Color3.fromRGB(20, 120, 55)
	creditsPanel.BorderSizePixel = 2
	creditsPanel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	creditsPanel.Parent = screenGui

	-- Título
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "TitleLabel"
	titleLabel.Size = UDim2.new(1, 0, 0, 80)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "👑 CRÉDITOS"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 48
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = creditsPanel

	-- Conteúdo dos créditos
	local creditsLabel = Instance.new("TextLabel")
	creditsLabel.Name = "CreditsLabel"
	creditsLabel.Size = UDim2.new(0.9, 0, 0, 200)
	creditsLabel.Position = UDim2.new(0.05, 0, 0, 100)
	creditsLabel.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
	creditsLabel.BorderSizePixel = 1
	creditsLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	creditsLabel.Text = "CRIADO POR\nGOOD1x0 STUDIOS\n\n🎮 Game Development Team\n✨ Desenvolvido com ❤️"
	creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	creditsLabel.TextSize = 28
	creditsLabel.Font = Enum.Font.GothamBold
	creditsLabel.TextWrapped = true
	creditsLabel.Parent = creditsPanel

	-- Botão Voltar
	local backButton = Instance.new("TextButton")
	backButton.Name = "BackButton"
	backButton.Size = UDim2.new(0.4, 0, 0, 50)
	backButton.Position = UDim2.new(0.3, 0, 0.85, 0)
	backButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	backButton.BorderSizePixel = 1
	backButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	backButton.Text = "Voltar"
	backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	backButton.TextSize = 24
	backButton.Font = Enum.Font.GothamBold
	backButton.Parent = creditsPanel

	backButton.MouseButton1Click:Connect(function()
		createMainMenuUI(screenGui)
	end)
end

-- Função para criar o menu principal com botões
function createMainMenuUI(screenGui)
	local screenGui, buttonContainer = createMainMenu()

	-- Botão 1: Jogar
	createButton(buttonContainer, UDim2.new(0, 0, 0, 0), "PlayButton", "🎮 JOGAR", "rbxasset://textures/GameAssets/DarkUtility/RightArrow.png", function()
		print("Iniciando jogo...")
		screenGui:Destroy()
		-- Aqui você pode adicionar a lógica para iniciar o jogo
	end)

	-- Botão 2: Configurações
	createButton(buttonContainer, UDim2.new(0, 0, 0, 120), "SettingsButton", "⚙️ CONFIGURAÇÕES", "rbxasset://textures/Cursors/MouseLockedCursor.png", function()
		createSettingsMenu(screenGui)
	end)

	-- Botão 3: Créditos
	createButton(buttonContainer, UDim2.new(0, 0, 0, 240), "CreditsButton", "👑 CRÉDITOS", "rbxasset://textures/GameAssets/DarkUtility/Help.png", function()
		createCreditsMenu(screenGui)
	end)

	-- Botão 4: Sair (Opcional)
	createButton(buttonContainer, UDim2.new(0, 0, 0, 360), "ExitButton", "❌ SAIR", "", function()
		screenGui:Destroy()
	end)
end

-- Função principal para inicializar o menu
local function initializeMenu()
	-- Remover qualquer menu anterior
	local existingGui = playerGui:FindFirstChild("MainMenuGui")
	if existingGui then
		existingGui:Destroy()
	end

	-- Criar novo menu
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MainMenuGui"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	-- Fundo verde com textura de lego
	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.new(1, 0, 1, 0)
	background.BackgroundColor3 = Color3.fromRGB(34, 177, 76)
	background.BorderSizePixel = 0
	background.Parent = screenGui

	-- Textura de lego
	local legoBrickPattern = Instance.new("ImageLabel")
	legoBrickPattern.Name = "LegoBrickPattern"
	legoBrickPattern.Size = UDim2.new(1, 0, 1, 0)
	legoBrickPattern.BackgroundTransparency = 0.3
	legoBrickPattern.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	legoBrickPattern.Image = "rbxasset://textures/Bricks.png"
	legoBrickPattern.ScaleType = Enum.ScaleType.Tile
	legoBrickPattern.BorderSizePixel = 0
	legoBrickPattern.Parent = background

	-- Criar menu principal
	createMainMenuUI(screenGui)

	print("✅ Menu carregado com sucesso!")
	print("Configurações do jogo:", gameSettings)
end

-- Inicializar menu quando o player entrar
initializeMenu()

-- Sistema de salvamento de configurações (Opcional)
local function saveSettings()
	local dataStore = game:GetService("DataStoreService"):GetDataStore("GameSettings")
	pcall(function()
		dataStore:SetAsync(player.UserId, gameSettings)
	end)
end

-- Salvar configurações ao sair
Players.PlayerRemoving:Connect(function(leftPlayer)
	if leftPlayer == player then
		saveSettings()
	end
end)

print("🎮 Sistema de Menu para Studio Lite inicializado!")