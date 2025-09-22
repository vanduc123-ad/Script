-- VanDucModz Menu - Tiếng Việt + Tab Thay Chữ (Đổi chữ + Đổi font + Đổi màu)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanDucModzUI"
ScreenGui.Parent = game.CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Title
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1,0,0,40)
TitleLabel.BackgroundColor3 = Color3.fromRGB(30,30,30)
TitleLabel.TextColor3 = Color3.fromRGB(200,200,200)
TitleLabel.Text = "VanDucModz"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.Parent = MainFrame

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0,80,0,30)
ToggleButton.Position = UDim2.new(1,-90,0,5)
ToggleButton.Text = "Modz"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Parent = MainFrame

local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

-- Tab Buttons
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0,120,1,-40)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
TabFrame.Parent = MainFrame

local TabButtons = {}
local TabContents = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = TabFrame
    table.insert(TabButtons,btn)

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1,-120,1,-40)
    content.Position = UDim2.new(0,120,0,40)
    content.BackgroundColor3 = Color3.fromRGB(15,15,15)
    content.Visible = false
    content.Parent = MainFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-20,1,-20)
    label.Position = UDim2.new(0,10,0,10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Text = name.." Nội dung"
    label.Font = Enum.Font.SourceSans
    label.TextWrapped = true
    label.Parent = content

    table.insert(TabContents,{Button=btn,Frame=content,Label=label})
end

-- Tạo Tabs chính
createTab("🧑 Người chơi")
createTab("🌍 Thông tin Game")
createTab("📡 Server")
createTab("⚙️ Cài đặt")
createTab("✍️ Thay Chữ")

-- Bật tab khi click
for i,tab in ipairs(TabContents) do
    tab.Button.MouseButton1Click:Connect(function()
        for j,t in ipairs(TabContents) do
            t.Frame.Visible = false
        end
        tab.Frame.Visible = true
    end)
end

-- Tab Cài đặt: đổi màu menu
local settingsFrame = TabContents[4].Frame
TabContents[4].Label.Text = "⚙️ Đổi màu giao diện"

local colors = {
    ["Đen"] = {bg=Color3.fromRGB(20,20,20), text=Color3.fromRGB(200,200,200)},
    ["Trắng"] = {bg=Color3.fromRGB(240,240,240), text=Color3.fromRGB(20,20,20)},
    ["Hồng"] = {bg=Color3.fromRGB(255,180,200), text=Color3.fromRGB(50,0,50)},
    ["Đỏ"] = {bg=Color3.fromRGB(200,50,50), text=Color3.fromRGB(255,255,255)},
    ["Xanh lá"] = {bg=Color3.fromRGB(50,200,100), text=Color3.fromRGB(20,20,20)},
}

local yColor = 40
for name,colorData in pairs(colors) do
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(0,120,0,30)
    colorButton.Position = UDim2.new(0,10,0,yColor)
    colorButton.Text = name
    colorButton.BackgroundColor3 = colorData.bg
    colorButton.TextColor3 = colorData.text
    colorButton.Parent = settingsFrame

    colorButton.MouseButton1Click:Connect(function()
        MainFrame.BackgroundColor3 = colorData.bg
        TitleLabel.BackgroundColor3 = colorData.bg
        TitleLabel.TextColor3 = colorData.text
        for _,tab in pairs(TabContents) do
            tab.Label.TextColor3 = colorData.text
        end
        for _,btn in pairs(TabButtons) do
            btn.TextColor3 = colorData.text
        end
    end)
    yColor = yColor + 40
end

-- Tab Thay Chữ
local changeTextFrame = TabContents[5].Frame
TabContents[5].Label.Text = "✍️ Thay chữ & kiểu chữ cho menu"

-- TextBox nhập chữ
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0,200,0,30)
inputBox.Position = UDim2.new(0,10,0,40)
inputBox.PlaceholderText = "Nhập chữ mới..."
inputBox.Text = ""
inputBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
inputBox.TextColor3 = Color3.fromRGB(255,255,255)
inputBox.Parent = changeTextFrame

-- Nút Áp dụng
local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0,100,0,30)
applyButton.Position = UDim2.new(0,220,0,40)
applyButton.Text = "Áp dụng"
applyButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
applyButton.TextColor3 = Color3.fromRGB(255,255,255)
applyButton.Parent = changeTextFrame

applyButton.MouseButton1Click:Connect(function()
    if inputBox.Text ~= "" then
        TitleLabel.Text = inputBox.Text
    end
end)

-- Các font chữ
local fonts = {
    ["Arial"] = Enum.Font.Arial,
    ["ComicSans"] = Enum.Font.ComicSans,
    ["SourceSansBold"] = Enum.Font.SourceSansBold,
    ["Fantasy"] = Enum.Font.Fantasy,
    ["GothamBlack"] = Enum.Font.GothamBlack
}

-- Nút chọn font
local y = 90
for fontName,fontEnum in pairs(fonts) do
    local fontButton = Instance.new("TextButton")
    fontButton.Size = UDim2.new(0,150,0,30)
    fontButton.Position = UDim2.new(0,10,0,y)
    fontButton.Text = "🅰 "..fontName
    fontButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    fontButton.TextColor3 = Color3.fromRGB(255,255,255)
    fontButton.Parent = changeTextFrame

    fontButton.MouseButton1Click:Connect(function()
        TitleLabel.Font = fontEnum
        for _,btn in pairs(TabButtons) do
            btn.Font = fontEnum
        end
        for _,tab in pairs(TabContents) do
            tab.Label.Font = fontEnum
        end
    end)
    y = y + 40
end
