local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- 1. Create the Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeptoKidScanner"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- ==========================================
-- DRAGGABLE HELPER FUNCTION
-- ==========================================
local function makeDraggable(guiObject)
	local dragging, dragInput, dragStart, startPos

	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = guiObject.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	guiObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- ==========================================
-- FLOATING LOGO (CIRCLE WITH 'K')
-- ==========================================
local logoBtn = Instance.new("TextButton")
logoBtn.Name = "LogoButton"
logoBtn.Size = UDim2.new(0, 60, 0, 60)
logoBtn.Position = UDim2.new(0, 20, 0, 20) -- Top left corner default
logoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
logoBtn.Text = "K"
logoBtn.Font = Enum.Font.FredokaOne
logoBtn.TextSize = 35
logoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
logoBtn.Parent = screenGui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0) -- Makes it a perfect circle
logoCorner.Parent = logoBtn

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(255, 255, 255)
logoStroke.Thickness = 2.5
logoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
logoStroke.Parent = logoBtn

makeDraggable(logoBtn)

-- ==========================================
-- MAIN WINDOW UI
-- ==========================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 400) 
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
mainFrame.BackgroundTransparency = 1 
mainFrame.Visible = false -- Starts hidden
mainFrame.Active = true
mainFrame.Parent = screenGui

makeDraggable(mainFrame)

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -40, 0, 50)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Kepto Kid"
title.Font = Enum.Font.FredokaOne
title.TextSize = 45
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(0, 0, 0)
titleStroke.Thickness = 2.5
titleStroke.Parent = title

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextSize = 35
closeBtn.TextColor3 = Color3.fromRGB(231, 76, 60)
closeBtn.Parent = mainFrame

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(0, 0, 0)
closeStroke.Thickness = 2
closeStroke.Parent = closeBtn

-- Script Box (Blue)
local scriptBox = Instance.new("TextBox")
scriptBox.Name = "ScriptBox"
scriptBox.Size = UDim2.new(1, 0, 1, -110) 
scriptBox.Position = UDim2.new(0, 0, 0, 50)
scriptBox.BackgroundColor3 = Color3.fromRGB(70, 100, 220) 
scriptBox.BorderSizePixel = 0
scriptBox.Text = ""
scriptBox.PlaceholderText = "Type script..."
scriptBox.PlaceholderColor3 = Color3.fromRGB(200, 220, 255)
scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptBox.Font = Enum.Font.SourceSansBold
scriptBox.TextSize = 22
scriptBox.TextXAlignment = Enum.TextXAlignment.Left
scriptBox.TextYAlignment = Enum.TextYAlignment.Top
scriptBox.ClearTextOnFocus = false
scriptBox.MultiLine = true
scriptBox.Parent = mainFrame

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.PaddingTop = UDim.new(0, 12)
UIPadding.Parent = scriptBox

-- Button Container Bar
local buttonBar = Instance.new("Frame")
buttonBar.Name = "ButtonBar"
buttonBar.Size = UDim2.new(1, 0, 0, 50)
buttonBar.Position = UDim2.new(0, 0, 1, -50)
buttonBar.BackgroundTransparency = 1
buttonBar.Parent = mainFrame

local function createStyleButton(name, text, position, size, color)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Text = text
	btn.Position = position
	btn.Size = size
	btn.BackgroundColor3 = color
	btn.Font = Enum.Font.FredokaOne
	btn.TextSize = 24
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Parent = buttonBar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn

	local border = Instance.new("UIStroke")
	border.Color = Color3.fromRGB(0, 0, 0)
	border.Thickness = 2.5
	border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	border.Parent = btn

	local txtStroke = Instance.new("UIStroke")
	txtStroke.Color = Color3.fromRGB(0, 0, 0)
	txtStroke.Thickness = 1.5
	txtStroke.Parent = btn
	
	return btn
end

local executeBtn = createStyleButton("ExecuteBtn", "Execute", UDim2.new(0, 0, 0, 5), UDim2.new(0, 120, 0, 40), Color3.fromRGB(46, 204, 113)) 
local injectBtn  = createStyleButton("InjectBtn", "Inject", UDim2.new(0, 130, 0, 5), UDim2.new(0, 120, 0, 40), Color3.fromRGB(230, 126, 34)) 
local clearBtn   = createStyleButton("ClearBtn", "Clear", UDim2.new(0, 260, 0, 5), UDim2.new(0, 100, 0, 40), Color3.fromRGB(231, 76, 60)) 
local scanBtn    = createStyleButton("ScanBtn", "Scan", UDim2.new(1, -120, 0, 5), UDim2.new(0, 120, 0, 40), Color3.fromRGB(52, 152, 219)) 

-- ==========================================
-- LOGIC & EVENTS
-- ==========================================

-- Toggle Window Visibility
logoBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Clear Button
clearBtn.MouseButton1Click:Connect(function()
	scriptBox.Text = ""
end)

-- Inject Button
injectBtn.MouseButton1Click:Connect(function()
	injectBtn.Text = "Injecting..."
	task.wait(1)
	injectBtn.Text = "Injected!"
	injectBtn.BackgroundColor3 = Color3.fromRGB(155, 89, 182) 
end)

-- Execute Button
executeBtn.MouseButton1Click:Connect(function()
	local codeToRun = scriptBox.Text
	if codeToRun == "" then return end

	local success, err = pcall(function()
		if loadstring then
			local func = loadstring(codeToRun)
			if func then func() else warn("Syntax error.") end
		else
			warn("Client loadstring() is disabled. Pass to server via RemoteEvent.")
		end
	end)

	if not success then warn(err) end
end)

-- Scan Button
scanBtn.MouseButton1Click:Connect(function()
	print("Scanning...")
end)
