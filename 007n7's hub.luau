local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Workspace = game:GetService("Workspace")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StarterGui = game:GetService("StarterGui")
local StarterPack = game:GetService("StarterPack")
local StarterPlayer = game:GetService("StarterPlayer")

local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local ContentProvider = game:GetService("ContentProvider")

local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")
local TextService = game:GetService("TextService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local VoiceChatService = game:GetService("VoiceChatService")

local Teams = game:GetService("Teams")
local CollectionService = game:GetService("CollectionService")
local PathfindingService = game:GetService("PathfindingService")
local PhysicsService = game:GetService("PhysicsService")

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local PolicyService = game:GetService("PolicyService")
local LocalizationService = game:GetService("LocalizationService")

local UserService = game:GetService("UserService")
local GroupService = game:GetService("GroupService")
local BadgeService = game:GetService("BadgeService")
local AvatarEditorService = game:GetService("AvatarEditorService")
local SocialService = game:GetService("SocialService")

local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local HapticService = game:GetService("HapticService")

local LogService = game:GetService("LogService")
local Stats = game:GetService("Stats")
local TestService = game:GetService("TestService")

local InsertService = game:GetService("InsertService")
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")
local AnimationClipProvider = game:GetService("AnimationClipProvider")

local DataStoreService = game:GetService("DataStoreService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local MessagingService = game:GetService("MessagingService")

local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Selection = game:GetService("Selection")
local ChangeHistoryService = game:GetService("ChangeHistoryService")

local Config = {
    Name = "007n7's hub",
    Version = "0.1.0",
    Creator = "x_c00lkidd_x",

    WindowSize = UDim2.fromOffset(900, 560),
    MinimizedSize = UDim2.fromOffset(36, 36),

    Colors = {
        Background = Color3.fromRGB(13, 15, 18),
        Surface = Color3.fromRGB(18, 20, 24),
        SurfaceLight = Color3.fromRGB(25, 28, 33),
        Border = Color3.fromRGB(45, 49, 57),
        Accent = Color3.fromRGB(0, 170, 255),
        AccentHover = Color3.fromRGB(35, 185, 255),
        Text = Color3.fromRGB(245, 247, 250),
        SecondaryText = Color3.fromRGB(160, 165, 175)
    }
}

local ExistingGui = CoreGui:FindFirstChild("007n7sHub")

if ExistingGui then
    ExistingGui:Destroy()
end

local function Create(ClassName, Properties)
    local Object = Instance.new(ClassName)

    for Property, Value in pairs(Properties) do
        Object[Property] = Value
    end

    return Object
end

local function Tween(Object, Duration, Properties, EasingStyle, EasingDirection)
    local Animation = TweenService:Create(
        Object,
        TweenInfo.new(
            Duration or 0.25,
            EasingStyle or Enum.EasingStyle.Quint,
            EasingDirection or Enum.EasingDirection.Out
        ),
        Properties
    )

    Animation:Play()

    return Animation
end

local function AddCorner(Object, Radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, Radius),
        Parent = Object
    })
end

local function AddStroke(Object, Color, Thickness, Transparency)
    return Create("UIStroke", {
        Color = Color,
        Thickness = Thickness or 1,
        Transparency = Transparency or 0,
        Parent = Object
    })
end

local ScreenGui = Create("ScreenGui", {
    Name = "007n7sHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    Parent = CoreGui
})

local Window = Create("Frame", {
    Name = "Window",
    Size = Config.WindowSize,
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = ScreenGui
})

AddCorner(Window, 16)
AddStroke(Window, Config.Colors.Border, 1, 0.15)

local WindowScale = Create("UIScale", {
    Scale = 0.92,
    Parent = Window
})

local Shadow = Create("ImageLabel", {
    Name = "Shadow",
    Size = UDim2.new(1, 40, 1, 40),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://6014261993",
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 0.45,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
    ZIndex = 0,
    Parent = Window
})

Window.ZIndex = 2

local TitleBar = Create("Frame", {
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    ZIndex = 5,
    Parent = Window
})

AddCorner(TitleBar, 16)

local TitleBarCover = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 18),
    Position = UDim2.new(0, 0, 1, -18),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    ZIndex = 5,
    Parent = TitleBar
})

local Title = Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -150, 0, 26),
    Position = UDim2.fromOffset(20, 9),
    BackgroundTransparency = 1,
    Text = Config.Name,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
    Parent = TitleBar
})

local Subtitle = Create("TextLabel", {
    Name = "Subtitle",
    Size = UDim2.new(1, -150, 0, 16),
    Position = UDim2.fromOffset(21, 32),
    BackgroundTransparency = 1,
    Text = "Luau execution environment",
    TextColor3 = Color3.fromRGB(225, 245, 255),
    TextTransparency = 0.15,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
    Parent = TitleBar
})

local MinimizeButton = Create("TextButton", {
    Name = "MinimizeButton",
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -86, 0.5, -19),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    ZIndex = 7,
    Parent = TitleBar
})

AddCorner(MinimizeButton, 10)

local CloseButton = Create("TextButton", {
    Name = "CloseButton",
    Size = UDim2.fromOffset(38, 38),
    Position = UDim2.new(1, -44, 0.5, -19),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    ZIndex = 7,
    Parent = TitleBar
})

AddCorner(CloseButton, 10)

local Content = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, 0, 1, -58),
    Position = UDim2.fromOffset(0, 58),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    ZIndex = 3,
    Parent = Window
})

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 165, 1, 0),
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    ZIndex = 4,
    Parent = Content
})

local SidebarPadding = Create("UIPadding", {
    PaddingTop = UDim.new(0, 18),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
    Parent = Sidebar
})

local Navigation = Create("Frame", {
    Name = "Navigation",
    Size = UDim2.new(1, 0, 0, 100),
    BackgroundTransparency = 1,
    Parent = Sidebar
})

local NavigationLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = Navigation
})

local ExecutionButton = Create("TextButton", {
    Name = "Execution",
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundColor3 = Config.Colors.Accent,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Execution",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Navigation
})

AddCorner(ExecutionButton, 10)

Create("UIPadding", {
    PaddingLeft = UDim.new(0, 14),
    Parent = ExecutionButton
})

local SettingsButton = Create("TextButton", {
    Name = "Settings",
    Size = UDim2.new(1, 0, 0, 44),
    BackgroundColor3 = Config.Colors.Surface,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Settings",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 14,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Navigation
})

AddCorner(SettingsButton, 10)

Create("UIPadding", {
    PaddingLeft = UDim.new(0, 14),
    Parent = SettingsButton
})

local Creator = Create("TextLabel", {
    Name = "Creator",
    Size = UDim2.new(1, -24, 0, 40),
    Position = UDim2.new(0, 12, 1, -55),
    BackgroundTransparency = 1,
    Text = "Made by x_c00lkidd_x",
    TextColor3 = Color3.fromRGB(95, 100, 110),
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Sidebar
})

local MainArea = Create("Frame", {
    Name = "MainArea",
    Size = UDim2.new(1, -165, 1, 0),
    Position = UDim2.fromOffset(165, 0),
    BackgroundTransparency = 1,
    Parent = Content
})

local ExecutionPage = Create("Frame", {
    Name = "ExecutionPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Parent = MainArea
})

local PageTitle = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.fromOffset(20, 20),
    BackgroundTransparency = 1,
    Text = "Execution",
    TextColor3 = Config.Colors.Text,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ExecutionPage
})

local PageDescription = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 22),
    Position = UDim2.fromOffset(20, 49),
    BackgroundTransparency = 1,
    Text = "Write and execute Luau code.",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ExecutionPage
})

local Editor = Create("TextBox", {
    Name = "Editor",
    Size = UDim2.new(1, -40, 1, -125),
    Position = UDim2.fromOffset(20, 82),
    BackgroundColor3 = Color3.fromRGB(10, 12, 15),
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    Text = "",
    PlaceholderText = "Enter Luau code...",
    PlaceholderColor3 = Color3.fromRGB(75, 80, 90),
    TextColor3 = Config.Colors.Text,
    TextSize = 14,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = false,
    Parent = ExecutionPage
})

AddCorner(Editor, 12)
AddStroke(Editor, Config.Colors.Border, 1, 0.25)

Create("UIPadding", {
    PaddingTop = UDim.new(0, 14),
    PaddingBottom = UDim.new(0, 14),
    PaddingLeft = UDim.new(0, 14),
    PaddingRight = UDim.new(0, 14),
    Parent = Editor
})

local ExecuteButton = Create("TextButton", {
    Name = "Execute",
    Size = UDim2.fromOffset(120, 40),
    Position = UDim2.new(1, -140, 1, -58),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Execute",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    Parent = ExecutionPage
})

AddCorner(ExecuteButton, 10)

local SettingsPage = Create("Frame", {
    Name = "SettingsPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    Parent = MainArea
})

local SettingsTitle = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 30),
    Position = UDim2.fromOffset(20, 20),
    BackgroundTransparency = 1,
    Text = "Settings",
    TextColor3 = Config.Colors.Text,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsPage
})

local SettingsDescription = Create("TextLabel", {
    Size = UDim2.new(1, -40, 0, 22),
    Position = UDim2.fromOffset(20, 49),
    BackgroundTransparency = 1,
    Text = "Configure your 007n7's hub experience.",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsPage
})

local AboutCard = Create("Frame", {
    Name = "AboutCard",
    Size = UDim2.new(1, -40, 0, 125),
    Position = UDim2.fromOffset(20, 90),
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    Parent = SettingsPage
})

AddCorner(AboutCard, 12)
AddStroke(AboutCard, Config.Colors.Border, 1, 0.35)

local AboutTitle = Create("TextLabel", {
    Size = UDim2.new(1, -28, 0, 24),
    Position = UDim2.fromOffset(14, 14),
    BackgroundTransparency = 1,
    Text = Config.Name,
    TextColor3 = Config.Colors.Text,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local AboutVersion = Create("TextLabel", {
    Size = UDim2.new(1, -28, 0, 20),
    Position = UDim2.fromOffset(14, 42),
    BackgroundTransparency = 1,
    Text = "Version " .. Config.Version,
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local AboutCreator = Create("TextLabel", {
    Size = UDim2.new(1, -28, 0, 20),
    Position = UDim2.fromOffset(14, 68),
    BackgroundTransparency = 1,
    Text = "Made by " .. Config.Creator,
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local Dragging = false
local DragStart
local StartPosition

TitleBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Window.Position

        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = Input.Position - DragStart

        Window.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

local function ShowWindow()
    Window.Visible = true
    WindowScale.Scale = 0.92

    Tween(WindowScale, 0.3, {
        Scale = 1
    })
end

local function HideWindow()
    local Animation = Tween(WindowScale, 0.22, {
        Scale = 0.82
    })

    Animation.Completed:Connect(function()
        Window.Visible = false
    end)
end

local MiniButton = Create("TextButton", {
    Name = "ReopenButton",
    Size = Config.MinimizedSize,
    Position = UDim2.fromOffset(14, 14),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "7",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Visible = false,
    Parent = ScreenGui
})

AddCorner(MiniButton, 10)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, 0.15, {
        BackgroundTransparency = 0.7
    })
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, 0.15, {
        BackgroundTransparency = 0.88
    })
end)

MinimizeButton.MouseEnter:Connect(function()
    Tween(MinimizeButton, 0.15, {
        BackgroundTransparency = 0.7
    })
end)

MinimizeButton.MouseLeave:Connect(function()
    Tween(MinimizeButton, 0.15, {
        BackgroundTransparency = 0.88
    })
end)

ExecuteButton.MouseEnter:Connect(function()
    Tween(ExecuteButton, 0.15, {
        BackgroundColor3 = Config.Colors.AccentHover
    })
end)

ExecuteButton.MouseLeave:Connect(function()
    Tween(ExecuteButton, 0.15, {
        BackgroundColor3 = Config.Colors.Accent
    })
end)

ExecutionButton.MouseEnter:Connect(function()
    if ExecutionPage.Visible then
        Tween(ExecutionButton, 0.15, {
            BackgroundColor3 = Config.Colors.AccentHover
        })
    end
end)

ExecutionButton.MouseLeave:Connect(function()
    if ExecutionPage.Visible then
        Tween(ExecutionButton, 0.15, {
            BackgroundColor3 = Config.Colors.Accent
        })
    end
end)

SettingsButton.MouseEnter:Connect(function()
    Tween(SettingsButton, 0.15, {
        BackgroundTransparency = 0.82
    })
end)

SettingsButton.MouseLeave:Connect(function()
    if not SettingsPage.Visible then
        Tween(SettingsButton, 0.15, {
            BackgroundTransparency = 1
        })
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    HideWindow()

    task.delay(0.22, function()
        MiniButton.Visible = true
        MiniButton.Size = UDim2.fromOffset(0, 0)

        Tween(MiniButton, 0.25, {
            Size = Config.MinimizedSize
        })
    end)
end)

MiniButton.MouseEnter:Connect(function()
    Tween(MiniButton, 0.15, {
        BackgroundColor3 = Config.Colors.AccentHover
    })
end)

MiniButton.MouseLeave:Connect(function()
    Tween(MiniButton, 0.15, {
        BackgroundColor3 = Config.Colors.Accent
    })
end)

MiniButton.MouseButton1Click:Connect(function()
    Tween(MiniButton, 0.18, {
        Size = UDim2.fromOffset(0, 0)
    }).Completed:Connect(function()
        MiniButton.Visible = false
        ShowWindow()
    end)
end)

MinimizeButton.MouseButton1Click:Connect(function()
    HideWindow()

    task.delay(0.22, function()
        MiniButton.Visible = true
        MiniButton.Size = UDim2.fromOffset(0, 0)

        Tween(MiniButton, 0.25, {
            Size = Config.MinimizedSize
        })
    end)
end)

ExecutionButton.MouseButton1Click:Connect(function()
    if ExecutionPage.Visible then
        return
    end

    SettingsPage.Visible = false
    ExecutionPage.Visible = true

    Tween(ExecutionButton, 0.2, {
        BackgroundColor3 = Config.Colors.Accent,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })

    Tween(SettingsButton, 0.2, {
        BackgroundTransparency = 1,
        TextColor3 = Config.Colors.SecondaryText
    })
end)

SettingsButton.MouseButton1Click:Connect(function()
    if SettingsPage.Visible then
        return
    end

    ExecutionPage.Visible = false
    SettingsPage.Visible = true

    Tween(SettingsButton, 0.2, {
        BackgroundTransparency = 0.82,
        BackgroundColor3 = Config.Colors.SurfaceLight,
        TextColor3 = Config.Colors.Text
    })

    Tween(ExecutionButton, 0.2, {
        BackgroundColor3 = Config.Colors.Surface,
        TextColor3 = Config.Colors.SecondaryText
    })
end)

ShowWindow()
