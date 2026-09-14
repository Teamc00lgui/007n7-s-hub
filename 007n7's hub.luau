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

    DesktopSize = Vector2.new(620, 400),
    MobileWidthScale = 0.88,
    MobileHeightScale = 0.68,

    MinimizedSize = 30,

    Colors = {
        Background = Color3.fromRGB(13, 15, 18),
        Surface = Color3.fromRGB(18, 20, 24),
        SurfaceLight = Color3.fromRGB(25, 28, 33),
        Border = Color3.fromRGB(45, 49, 57),
        Accent = Color3.fromRGB(0, 170, 255),
        AccentHover = Color3.fromRGB(35, 185, 255),
        Text = Color3.fromRGB(245, 247, 250),
        SecondaryText = Color3.fromRGB(160, 165, 175),
        MutedText = Color3.fromRGB(95, 100, 110)
    }
}

local ExistingGui = CoreGui:FindFirstChild("007n7sHub")

if ExistingGui then
    ExistingGui:Destroy()
end

local Camera = Workspace.CurrentCamera

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

local function IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local ScreenGui = Create("ScreenGui", {
    Name = "007n7sHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    Parent = CoreGui
})

local function GetWindowSize()
    if not Camera then
        return Config.DesktopSize
    end

    local Viewport = Camera.ViewportSize

    if IsMobile() then
        return Vector2.new(
            math.floor(Viewport.X * Config.MobileWidthScale),
            math.floor(Viewport.Y * Config.MobileHeightScale)
        )
    end

    return Config.DesktopSize
end

local InitialSize = GetWindowSize()

local Window = Create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(InitialSize.X, InitialSize.Y),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = ScreenGui
})

AddCorner(Window, 14)
AddStroke(Window, Config.Colors.Border, 1, 0.15)

local WindowScale = Create("UIScale", {
    Scale = 0.92,
    Parent = Window
})

local Shadow = Create("ImageLabel", {
    Name = "Shadow",
    Size = UDim2.new(1, 36, 1, 36),
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
    Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    ZIndex = 5,
    Parent = Window
})

AddCorner(TitleBar, 14)

local Title = Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -120, 0, 23),
    Position = UDim2.fromOffset(16, 6),
    BackgroundTransparency = 1,
    Text = Config.Name,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
    Parent = TitleBar
})

local Subtitle = Create("TextLabel", {
    Name = "Subtitle",
    Size = UDim2.new(1, -120, 0, 14),
    Position = UDim2.fromOffset(17, 28),
    BackgroundTransparency = 1,
    Text = "Luau execution environment",
    TextColor3 = Color3.fromRGB(225, 245, 255),
    TextTransparency = 0.15,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
    Parent = TitleBar
})

local MinimizeButton = Create("TextButton", {
    Name = "MinimizeButton",
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -72, 0.5, -16),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    ZIndex = 7,
    Parent = TitleBar
})

AddCorner(MinimizeButton, 9)

local CloseButton = Create("TextButton", {
    Name = "CloseButton",
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -38, 0.5, -16),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    ZIndex = 7,
    Parent = TitleBar
})

AddCorner(CloseButton, 9)

local Content = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(1, 0, 1, -50),
    Position = UDim2.fromOffset(0, 50),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    ZIndex = 3,
    Parent = Window
})

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 135, 1, 0),
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    ZIndex = 4,
    Parent = Content
})

local SidebarPadding = Create("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    Parent = Sidebar
})

local Navigation = Create("Frame", {
    Name = "Navigation",
    Size = UDim2.new(1, 0, 0, 82),
    BackgroundTransparency = 1,
    Parent = Sidebar
})

local NavigationLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = Navigation
})

local ExecutionButton = Create("TextButton", {
    Name = "Execution",
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = Config.Colors.Accent,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Execution",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Navigation
})

AddCorner(ExecutionButton, 9)

Create("UIPadding", {
    PaddingLeft = UDim.new(0, 11),
    Parent = ExecutionButton
})

local SettingsButton = Create("TextButton", {
    Name = "Settings",
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = Config.Colors.Surface,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Settings",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Navigation
})

AddCorner(SettingsButton, 9)

Create("UIPadding", {
    PaddingLeft = UDim.new(0, 11),
    Parent = SettingsButton
})

local Creator = Create("TextLabel", {
    Name = "Creator",
    Size = UDim2.new(1, -16, 0, 35),
    Position = UDim2.new(0, 8, 1, -47),
    BackgroundTransparency = 1,
    Text = "Made by x_c00lkidd_x",
    TextColor3 = Config.Colors.MutedText,
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Sidebar
})

local MainArea = Create("Frame", {
    Name = "MainArea",
    Size = UDim2.new(1, -135, 1, 0),
    Position = UDim2.fromOffset(135, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    Parent = Content
})

local ExecutionPage = Create("Frame", {
    Name = "ExecutionPage",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),
    BackgroundTransparency = 1,
    Parent = MainArea
})

local PageTitle = Create("TextLabel", {
    Size = UDim2.new(1, -32, 0, 26),
    Position = UDim2.fromOffset(16, 14),
    BackgroundTransparency = 1,
    Text = "Execution",
    TextColor3 = Config.Colors.Text,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ExecutionPage
})

local PageDescription = Create("TextLabel", {
    Size = UDim2.new(1, -32, 0, 18),
    Position = UDim2.fromOffset(16, 39),
    BackgroundTransparency = 1,
    Text = "Write and execute Luau code.",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = ExecutionPage
})

local Editor = Create("TextBox", {
    Name = "Editor",
    Size = UDim2.new(1, -32, 1, -116),
    Position = UDim2.fromOffset(16, 68),
    BackgroundColor3 = Color3.fromRGB(10, 12, 15),
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
    MultiLine = true,
    Text = "",
    PlaceholderText = "Enter Luau code...",
    PlaceholderColor3 = Color3.fromRGB(75, 80, 90),
    TextColor3 = Config.Colors.Text,
    TextSize = 13,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = false,
    Parent = ExecutionPage
})

AddCorner(Editor, 10)
AddStroke(Editor, Config.Colors.Border, 1, 0.25)

Create("UIPadding", {
    PaddingTop = UDim.new(0, 11),
    PaddingBottom = UDim.new(0, 11),
    PaddingLeft = UDim.new(0, 11),
    PaddingRight = UDim.new(0, 11),
    Parent = Editor
})

local ExecuteButton = Create("TextButton", {
    Name = "Execute",
    Size = UDim2.fromOffset(105, 36),
    Position = UDim2.new(1, -121, 1, -48),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Execute",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    Parent = ExecutionPage
})

AddCorner(ExecuteButton, 9)

local SettingsPage = Create("Frame", {
    Name = "SettingsPage",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(1, 0),
    BackgroundTransparency = 1,
    Visible = false,
    Parent = MainArea
})

local SettingsTitle = Create("TextLabel", {
    Size = UDim2.new(1, -32, 0, 26),
    Position = UDim2.fromOffset(16, 14),
    BackgroundTransparency = 1,
    Text = "Settings",
    TextColor3 = Config.Colors.Text,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsPage
})

local SettingsDescription = Create("TextLabel", {
    Size = UDim2.new(1, -32, 0, 18),
    Position = UDim2.fromOffset(16, 39),
    BackgroundTransparency = 1,
    Text = "Configure your 007n7's hub experience.",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = SettingsPage
})

local AboutCard = Create("Frame", {
    Name = "AboutCard",
    Size = UDim2.new(1, -32, 0, 110),
    Position = UDim2.fromOffset(16, 70),
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    Parent = SettingsPage
})

AddCorner(AboutCard, 10)
AddStroke(AboutCard, Config.Colors.Border, 1, 0.35)

local AboutTitle = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 22),
    Position = UDim2.fromOffset(12, 12),
    BackgroundTransparency = 1,
    Text = Config.Name,
    TextColor3 = Config.Colors.Text,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local AboutVersion = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 38),
    BackgroundTransparency = 1,
    Text = "Version " .. Config.Version,
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local AboutCreator = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 62),
    BackgroundTransparency = 1,
    Text = "Made by " .. Config.Creator,
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = AboutCard
})

local Dragging = false
local DragStart
local StartPosition

TitleBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

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
    if not Dragging then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = Input.Position - DragStart

    Window.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end)

local function UpdateLayout()
    if not Camera then
        Camera = Workspace.CurrentCamera
    end

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    local Mobile = IsMobile()

    local WindowSize

    if Mobile then
        WindowSize = Vector2.new(
            math.floor(Viewport.X * Config.MobileWidthScale),
            math.floor(Viewport.Y * Config.MobileHeightScale)
        )
    else
        WindowSize = Config.DesktopSize
    end

    Window.Size = UDim2.fromOffset(WindowSize.X, WindowSize.Y)

    local Compact = Mobile or WindowSize.X < 580

    local TitleHeight = Compact and 46 or 50
    local SidebarWidth = Compact and 105 or 135

    TitleBar.Size = UDim2.new(1, 0, 0, TitleHeight)

    Title.Size = UDim2.new(1, -105, 0, 21)
    Title.Position = UDim2.fromOffset(13, 5)
    Title.TextSize = Compact and 14 or 17

    Subtitle.Size = UDim2.new(1, -105, 0, 13)
    Subtitle.Position = UDim2.fromOffset(14, 25)
    Subtitle.TextSize = Compact and 8 or 10

    MinimizeButton.Size = UDim2.fromOffset(29, 29)
    MinimizeButton.Position = UDim2.new(1, -64, 0.5, -14.5)
    MinimizeButton.TextSize = Compact and 14 or 16

    CloseButton.Size = UDim2.fromOffset(29, 29)
    CloseButton.Position = UDim2.new(1, -34, 0.5, -14.5)
    CloseButton.TextSize = Compact and 17 or 19

    Content.Position = UDim2.fromOffset(0, TitleHeight)
    Content.Size = UDim2.new(1, 0, 1, -TitleHeight)

    Sidebar.Size = UDim2.new(0, SidebarWidth, 1, 0)

    SidebarPadding.PaddingTop = UDim.new(0, 9)
    SidebarPadding.PaddingLeft = UDim.new(0, 6)
    SidebarPadding.PaddingRight = UDim.new(0, 6)

    Navigation.Size = UDim2.new(1, 0, 0, 76)

    ExecutionButton.Size = UDim2.new(1, 0, 0, 35)
    SettingsButton.Size = UDim2.new(1, 0, 0, 35)

    ExecutionButton.TextSize = Compact and 10 or 13
    SettingsButton.TextSize = Compact and 10 or 13

    MainArea.Position = UDim2.fromOffset(SidebarWidth, 0)
    MainArea.Size = UDim2.new(1, -SidebarWidth, 1, 0)

    Creator.Size = UDim2.new(1, -12, 0, 30)
    Creator.Position = UDim2.new(0, 6, 1, -40)
    Creator.TextSize = Compact and 7 or 9

    PageTitle.Position = UDim2.fromOffset(14, 11)
    PageTitle.TextSize = Compact and 16 or 20

    PageDescription.Position = UDim2.fromOffset(14, 34)
    PageDescription.TextSize = Compact and 9 or 11

    Editor.Position = UDim2.fromOffset(14, 58)
    Editor.Size = UDim2.new(1, -28, 1, -101)
    Editor.TextSize = Compact and 10 or 13

    ExecuteButton.Size = UDim2.fromOffset(
        Compact and 82 or 105,
        Compact and 31 or 36
    )

    ExecuteButton.Position = UDim2.new(
        1,
        -(Compact and 96 or 121),
        1,
        -(Compact and 40 or 48)
    )

    ExecuteButton.TextSize = Compact and 10 or 12

    SettingsTitle.Position = UDim2.fromOffset(14, 11)
    SettingsTitle.TextSize = Compact and 16 or 20

    SettingsDescription.Position = UDim2.fromOffset(14, 34)
    SettingsDescription.TextSize = Compact and 9 or 11

    AboutCard.Position = UDim2.fromOffset(14, 58)
    AboutCard.Size = UDim2.new(1, -28, 0, Compact and 95 or 110)

    AboutTitle.Position = UDim2.fromOffset(11, 10)
    AboutTitle.TextSize = Compact and 12 or 14

    AboutVersion.Position = UDim2.fromOffset(11, 34)
    AboutVersion.TextSize = Compact and 9 or 11

    AboutCreator.Position = UDim2.fromOffset(11, 56)
    AboutCreator.TextSize = Compact and 9 or 11
end

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
    Size = UDim2.fromOffset(Config.MinimizedSize, Config.MinimizedSize),
    Position = UDim2.fromOffset(12, 12),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "7",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    Visible = false,
    Parent = ScreenGui
})

AddCorner(MiniButton, 8)

local MiniButtonStroke = AddStroke(
    MiniButton,
    Config.Colors.AccentHover,
    1,
    0.15
)

local MiniButtonInset = Create("Frame", {
    Name = "SafeArea",
    Size = UDim2.fromOffset(1, 1),
    Position = UDim2.fromOffset(0, 0),
    BackgroundTransparency = 1,
    Parent = MiniButton
})

local function UpdateMiniButtonPosition()
    local TopLeftInset = GuiService:GetGuiInset()

    MiniButton.Position = UDim2.fromOffset(
        math.max(8, TopLeftInset.X + 8),
        math.max(8, TopLeftInset.Y + 8)
    )
end

local function SwitchPage(Target)
    local GoingToSettings = Target == "Settings"
    local CurrentPage = GoingToSettings and ExecutionPage or SettingsPage
    local TargetPage = GoingToSettings and SettingsPage or ExecutionPage

    if TargetPage.Visible then
        return
    end

    TargetPage.Visible = true
    TargetPage.Position = UDim2.fromScale(GoingToSettings and 1 or -1, 0)

    Tween(CurrentPage, 0.28, {
        Position = UDim2.fromScale(GoingToSettings and -1 or 1, 0)
    })

    Tween(TargetPage, 0.28, {
        Position = UDim2.fromScale(0, 0)
    })

    if GoingToSettings then
        Tween(SettingsButton, 0.2, {
            BackgroundTransparency = 0.82,
            BackgroundColor3 = Config.Colors.SurfaceLight,
            TextColor3 = Config.Colors.Text
        })

        Tween(ExecutionButton, 0.2, {
            BackgroundTransparency = 1,
            BackgroundColor3 = Config.Colors.Surface,
            TextColor3 = Config.Colors.SecondaryText
        })
    else
        Tween(ExecutionButton, 0.2, {
            BackgroundTransparency = 0,
            BackgroundColor3 = Config.Colors.Accent,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        })

        Tween(SettingsButton, 0.2, {
            BackgroundTransparency = 1,
            BackgroundColor3 = Config.Colors.Surface,
            TextColor3 = Config.Colors.SecondaryText
        })
    end

    task.delay(0.3, function()
        CurrentPage.Visible = false
    end)
end

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

        UpdateMiniButtonPosition()

        Tween(MiniButton, 0.25, {
            Size = UDim2.fromOffset(
                Config.MinimizedSize,
                Config.MinimizedSize
            )
        })
    end)
end)

MiniButton.MouseEnter:Connect(function()
    Tween(MiniButton, 0.15, {
        BackgroundColor3 = Config.Colors.AccentHover
    })

    Tween(MiniButtonStroke, 0.15, {
        Transparency = 0
    })
end)

MiniButton.MouseLeave:Connect(function()
    Tween(MiniButton, 0.15, {
        BackgroundColor3 = Config.Colors.Accent
    })

    Tween(MiniButtonStroke, 0.15, {
        Transparency = 0.15
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
    local CurrentHeight = Window.AbsoluteSize.Y

    Tween(WindowScale, 0.25, {
        Scale = 0.98
    })

    task.delay(0.12, function()
        Content.Visible = false

        Tween(Window, 0.28, {
            Size = UDim2.fromOffset(
                math.max(190, Window.AbsoluteSize.X),
                50
            )
        })
    end)

    MinimizeButton.Text = "□"

    Tween(MinimizeButton, 0.2, {
        BackgroundTransparency = 0.72
    })
end)

TitleBar.InputBegan:Connect(function(Input)
    if MinimizeButton.Text ~= "□" then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseButton1
        and Input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    if Input.Position.X >= MinimizeButton.AbsolutePosition.X
        and Input.Position.X <= MinimizeButton.AbsolutePosition.X + MinimizeButton.AbsoluteSize.X then
        return
    end

    if Input.Position.X >= CloseButton.AbsolutePosition.X
        and Input.Position.X <= CloseButton.AbsolutePosition.X + CloseButton.AbsoluteSize.X then
        return
    end

    Content.Visible = true
    Window.Size = UDim2.fromOffset(
        GetWindowSize().X,
        50
    )

    local TargetSize = GetWindowSize()

    Tween(Window, 0.28, {
        Size = UDim2.fromOffset(
            TargetSize.X,
            TargetSize.Y
        )
    })

    MinimizeButton.Text = "—"

    Tween(MinimizeButton, 0.2, {
        BackgroundTransparency = 0.88
    })
end)

ExecutionButton.MouseButton1Click:Connect(function()
    SwitchPage("Execution")
end)

SettingsButton.MouseButton1Click:Connect(function()
    SwitchPage("Settings")
end)

UpdateLayout()
UpdateMiniButtonPosition()

if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        UpdateLayout()

        if MiniButton.Visible then
            UpdateMiniButtonPosition()
        end
    end)
end

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = Workspace.CurrentCamera

    if Camera then
        Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateLayout)
    end

    UpdateLayout()
    UpdateMiniButtonPosition()
end)

ShowWindow()
