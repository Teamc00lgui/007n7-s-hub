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

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

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

local function BindAutoScroll(ScrollingFrame, Content, Layout)
    local function Update()
        local ContentHeight = Layout.AbsoluteContentSize.Y + 12
        local ViewportHeight = ScrollingFrame.AbsoluteSize.Y

        ScrollingFrame.CanvasSize = UDim2.fromOffset(
            0,
            math.max(ContentHeight, ViewportHeight)
        )
    end

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(Update)
    ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)
    Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(Update)

    task.defer(Update)

    return Update
end

local ScreenGui = Create("ScreenGui", {
    Name = "007n7sHub",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true,
    DisplayOrder = 100
})

local CoreGuard = {}

CoreGuard.Name = "CoreGuard"
CoreGuard.GuiName = "007n7sHub"
CoreGuard.Container = nil
CoreGuard.UsingCoreGui = false
CoreGuard.Initialized = false
CoreGuard.Recovering = false
CoreGuard.MonitorConnection = nil
CoreGuard.LastWarning = nil

function CoreGuard:Log(Message)
    warn("[CoreGuard]: " .. Message)
end

function CoreGuard:IsAccessible(Object)
    if not Object then
        return false
    end

    local Success = pcall(function()
        Object:GetChildren()
    end)

    return Success
end

function CoreGuard:IsMounted(ScreenGui)
    if not ScreenGui then
        return false
    end

    local Success, Parent = pcall(function()
        return ScreenGui.Parent
    end)

    if not Success then
        return false
    end

    return Parent == self.Container
end

function CoreGuard:CanUseCoreGui()
    return self:IsAccessible(CoreGui)
end

function CoreGuard:FindExisting(Container)
    if not self:IsAccessible(Container) then
        return nil
    end

    local Success, Existing = pcall(function()
        return Container:FindFirstChild(self.GuiName)
    end)

    if not Success then
        return nil
    end

    return Existing
end

function CoreGuard:RemoveExisting(Container, ProtectedGui)
    local Existing = self:FindExisting(Container)

    if not Existing or Existing == ProtectedGui then
        return true
    end

    local Success = pcall(function()
        Existing:Destroy()
    end)

    if not Success then
        self:Log("Failed to remove an existing GUI instance.")
    end

    return Success
end

function CoreGuard:PrepareContainer(Container, ScreenGui)
    if not self:IsAccessible(Container) then
        return false
    end

    self:RemoveExisting(Container, ScreenGui)

    return true
end

function CoreGuard:MountToCoreGui(ScreenGui)
    if not self:CanUseCoreGui() then
        return false
    end

    if not self:PrepareContainer(CoreGui, ScreenGui) then
        return false
    end

    local Success = pcall(function()
        ScreenGui.Parent = CoreGui
    end)

    if not Success then
        return false
    end

    if ScreenGui.Parent ~= CoreGui then
        return false
    end

    self.Container = CoreGui
    self.UsingCoreGui = true

    return true
end

function CoreGuard:MountToPlayerGui(ScreenGui)
    if not self:IsAccessible(PlayerGui) then
        return false
    end

    if not self:PrepareContainer(PlayerGui, ScreenGui) then
        return false
    end

    local Success = pcall(function()
        ScreenGui.Parent = PlayerGui
    end)

    if not Success then
        return false
    end

    if ScreenGui.Parent ~= PlayerGui then
        return false
    end

    self.Container = PlayerGui
    self.UsingCoreGui = false

    return true
end

function CoreGuard:Mount(ScreenGui)
    if self.Initialized then
        self:Log("Mount request ignored because CoreGuard is already initialized.")
        return self:IsMounted(ScreenGui)
    end

    self.Initialized = true

    if self:MountToCoreGui(ScreenGui) then
        self:Log("CoreGui mounted successfully.")
        return true
    end

    self.LastWarning = "CoreGui unavailable."

    self:Log("Error using CoreGui, switching to PlayerGui...")

    if self:MountToPlayerGui(ScreenGui) then
        self:Log("PlayerGui fallback mounted successfully.")
        return true
    end

    self:Log("Critical error: failed to mount GUI.")

    return false
end

function CoreGuard:Recover(ScreenGui)
    if self.Recovering then
        return false
    end

    self.Recovering = true

    local Recovered = false

    if self.UsingCoreGui then
        Recovered = self:MountToCoreGui(ScreenGui)

        if not Recovered then
            self:Log("CoreGui recovery failed, switching to PlayerGui...")

            Recovered = self:MountToPlayerGui(ScreenGui)
        end
    else
        Recovered = self:MountToCoreGui(ScreenGui)

        if Recovered then
            self:Log("CoreGui became available again.")
        else
            Recovered = self:MountToPlayerGui(ScreenGui)
        end
    end

    if Recovered then
        self:Log("GUI recovery completed.")
    else
        self:Log("GUI recovery failed.")
    end

    self.Recovering = false

    return Recovered
end

function CoreGuard:Monitor(ScreenGui)
    if self.MonitorConnection then
        self.MonitorConnection:Disconnect()
        self.MonitorConnection = nil
    end

    self.MonitorConnection = ScreenGui.AncestryChanged:Connect(function()
        if self.Recovering then
            return
        end

        task.defer(function()
            if not self:IsMounted(ScreenGui) then
                self:Log("GUI mount changed unexpectedly.")
                self:Recover(ScreenGui)
            end
        end)
    end)
end

function CoreGuard:GetContainer()
    return self.Container
end

function CoreGuard:IsUsingCoreGui()
    return self.UsingCoreGui
end

function CoreGuard:GetStatus()
    if not self.Container then
        return "Uninitialized"
    end

    if self.UsingCoreGui then
        return "CoreGui"
    end

    return "PlayerGui"
end

function CoreGuard:Shutdown()
    if self.MonitorConnection then
        self.MonitorConnection:Disconnect()
        self.MonitorConnection = nil
    end

    self.Container = nil
    self.UsingCoreGui = false
    self.Initialized = false
    self.Recovering = false
end

CoreGuard:Mount(ScreenGui)
CoreGuard:Monitor(ScreenGui)

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
local FullWindowSize = InitialSize
local CurrentTitleHeight = 50
local Collapsed = false
local CurrentPage = "Execution"
local PageSwitching = false

local Window = Create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(InitialSize.X, InitialSize.Y),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Config.Colors.Background,
    BorderSizePixel = 0,
    ClipsDescendants = false,
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

local TitleBarFill = Create("Frame", {
    Name = "TitleBarFill",
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 1, -16),
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    ZIndex = 5,
    Parent = TitleBar
})

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

local ExpandButton = Create("TextButton", {
    Name = "ExpandButton",
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -72, 0.5, -16),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "□",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    Visible = false,
    ZIndex = 7,
    Parent = TitleBar
})

AddCorner(ExpandButton, 9)

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

local Content = Create("CanvasGroup", {
    Name = "Content",
    Size = UDim2.new(1, 0, 1, -50),
    Position = UDim2.fromOffset(0, 50),
    BackgroundColor3 = Config.Colors.Background,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    GroupTransparency = 0,
    ZIndex = 3,
    Parent = Window
})

AddCorner(Content, 14)

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

local ExecutionPage = Create("CanvasGroup", {
    Name = "ExecutionPage",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),
    BackgroundTransparency = 1,
    GroupTransparency = 0,
    ClipsDescendants = true,
    Parent = MainArea
})

local ExecutionScroll = Create("ScrollingFrame", {
    Name = "ExecutionScroll",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.fromOffset(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Config.Colors.Border,
    ScrollBarImageTransparency = 0.15,
    ScrollingEnabled = true,
    ClipsDescendants = true,
    AutomaticCanvasSize = Enum.AutomaticSize.None,
    Parent = ExecutionPage
})

local ExecutionContent = Create("Frame", {
    Name = "ExecutionContent",
    Size = UDim2.new(1, -8, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    Parent = ExecutionScroll
})

local ExecutionLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 0),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = ExecutionContent
})

Create("UIPadding", {
    PaddingLeft = UDim.new(0, 14),
    PaddingRight = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 11),
    PaddingBottom = UDim.new(0, 12),
    Parent = ExecutionContent
})

local ExecutionScale = Create("UIScale", {
    Scale = 1,
    Parent = ExecutionPage
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
    Parent = ExecutionContent
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
    Parent = ExecutionContent
})

local Editor = Create("TextBox", {
    Name = "Editor",
    Size = UDim2.new(1, -22, 0, 230),
    LayoutOrder = 3,
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
    Parent = ExecutionContent
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
    LayoutOrder = 4,
    BackgroundColor3 = Config.Colors.Accent,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Execute",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    Parent = ExecutionContent
})

AddCorner(ExecuteButton, 9)

local SettingsPage = Create("CanvasGroup", {
    Name = "SettingsPage",
    Size = UDim2.fromScale(1, 1),
    Position = UDim2.fromScale(1, 0),
    BackgroundTransparency = 1,
    GroupTransparency = 1,
    Visible = false,
    ClipsDescendants = true,
    Parent = MainArea
})

local SettingsScale = Create("UIScale", {
    Scale = 1,
    Parent = SettingsPage
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

local SettingsScroll = Create("ScrollingFrame", {
    Name = "SettingsScroll",
    Size = UDim2.new(1, -28, 1, -58),
    Position = UDim2.fromOffset(14, 58),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.fromOffset(0, 0),
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Config.Colors.Border,
    ScrollBarImageTransparency = 0.15,
    ScrollingEnabled = true,
    ClipsDescendants = true,
    AutomaticCanvasSize = Enum.AutomaticSize.None,
    Parent = SettingsPage
})

local SettingsContent = Create("Frame", {
    Name = "SettingsContent",
    Size = UDim2.new(1, -8, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    Parent = SettingsScroll
})

local SettingsLayout = Create("UIListLayout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = SettingsContent
})

Create("UIPadding", {
    PaddingRight = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 12),
    Parent = SettingsContent
})

local AboutCard = Create("Frame", {
    Name = "AboutCard",
    Size = UDim2.new(1, 0, 0, 110),
    LayoutOrder = 1,
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    Parent = SettingsContent
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

local CoreGuardCard = Create("Frame", {
    Name = "CoreGuardCard",
    Size = UDim2.new(1, 0, 0, 172),
    LayoutOrder = 2,
    BackgroundColor3 = Config.Colors.Surface,
    BorderSizePixel = 0,
    Parent = SettingsContent
})

AddCorner(CoreGuardCard, 10)
AddStroke(CoreGuardCard, Config.Colors.Border, 1, 0.35)

local CoreGuardTitle = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 22),
    Position = UDim2.fromOffset(12, 11),
    BackgroundTransparency = 1,
    Text = "CoreGuard",
    TextColor3 = Config.Colors.Text,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CoreGuardCard
})

local CoreGuardStatus = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 36),
    BackgroundTransparency = 1,
    Text = "Status: Checking...",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CoreGuardCard
})

local CoreGuardContainer = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 57),
    BackgroundTransparency = 1,
    Text = "Container: Checking...",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CoreGuardCard
})

local CoreGuardMonitor = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 78),
    BackgroundTransparency = 1,
    Text = "Monitor: Checking...",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CoreGuardCard
})

local CoreGuardFallback = Create("TextLabel", {
    Size = UDim2.new(1, -24, 0, 18),
    Position = UDim2.fromOffset(12, 99),
    BackgroundTransparency = 1,
    Text = "Fallback: Ready",
    TextColor3 = Config.Colors.SecondaryText,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = CoreGuardCard
})

local CoreGuardRecover = Create("TextButton", {
    Name = "Recover",
    Size = UDim2.fromOffset(92, 30),
    Position = UDim2.new(1, -104, 1, -41),
    BackgroundColor3 = Config.Colors.SurfaceLight,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "Recover",
    TextColor3 = Config.Colors.Text,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    Parent = CoreGuardCard
})

AddCorner(CoreGuardRecover, 8)
AddStroke(CoreGuardRecover, Config.Colors.Border, 1, 0.2)

local function UpdateCoreGuardStatus()
    local Status = CoreGuard:GetStatus()
    local UsingCoreGui = CoreGuard:IsUsingCoreGui()
    local MonitorActive = CoreGuard.MonitorConnection ~= nil

    CoreGuardStatus.Text = "Status: " .. Status
    CoreGuardContainer.Text = "Container: " .. (UsingCoreGui and "CoreGui" or "PlayerGui")
    CoreGuardMonitor.Text = "Monitor: " .. (MonitorActive and "Active" or "Inactive")

    if Status == "CoreGui" then
        CoreGuardStatus.TextColor3 = Config.Colors.Accent
        CoreGuardContainer.TextColor3 = Config.Colors.Accent
    elseif Status == "PlayerGui" then
        CoreGuardStatus.TextColor3 = Config.Colors.SecondaryText
        CoreGuardContainer.TextColor3 = Config.Colors.SecondaryText
    else
        CoreGuardStatus.TextColor3 = Config.Colors.MutedText
        CoreGuardContainer.TextColor3 = Config.Colors.MutedText
    end

    CoreGuardMonitor.TextColor3 = MonitorActive
        and Config.Colors.Text
        or Config.Colors.MutedText
end

CoreGuardRecover.MouseEnter:Connect(function()
    Tween(CoreGuardRecover, 0.15, {
        BackgroundColor3 = Config.Colors.Border
    })
end)

CoreGuardRecover.MouseLeave:Connect(function()
    Tween(CoreGuardRecover, 0.15, {
        BackgroundColor3 = Config.Colors.SurfaceLight
    })
end)

CoreGuardRecover.MouseButton1Click:Connect(function()
    CoreGuardRecover.Active = false
    CoreGuardRecover.Text = "Recovering..."

    local Success = CoreGuard:Recover(ScreenGui)

    if Success then
        CoreGuardRecover.Text = "Recovered"
    else
        CoreGuardRecover.Text = "Failed"
    end

    UpdateCoreGuardStatus()

    task.delay(1.2, function()
        if CoreGuardRecover.Parent then
            CoreGuardRecover.Text = "Recover"
            CoreGuardRecover.Active = true
        end
    end)
end)

UpdateCoreGuardStatus()

local UpdateExecutionScroll = BindAutoScroll(
    ExecutionScroll,
    ExecutionContent,
    ExecutionLayout
)

local UpdateSettingsScroll = BindAutoScroll(
    SettingsScroll,
    SettingsContent,
    SettingsLayout
)

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
    ZIndex = 100,
    Parent = ScreenGui
})

AddCorner(MiniButton, 8)

local MiniButtonStroke = AddStroke(
    MiniButton,
    Config.Colors.AccentHover,
    1,
    0.15
)

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

local function UpdateMiniButtonPosition()
    local TopLeftInset = GuiService:GetGuiInset()

    MiniButton.Position = UDim2.fromOffset(
        math.max(8, TopLeftInset.X + 8),
        math.max(8, TopLeftInset.Y + 8)
    )
end

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

    FullWindowSize = WindowSize

    local Compact = Mobile or WindowSize.X < 580

    local TitleHeight = Compact and 46 or 50
    local SidebarWidth = Compact and 105 or 135

    CurrentTitleHeight = TitleHeight

    if Collapsed then
        Window.Size = UDim2.fromOffset(
            WindowSize.X,
            TitleHeight
        )
    else
        Window.Size = UDim2.fromOffset(
            WindowSize.X,
            WindowSize.Y
        )
    end

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

    ExpandButton.Size = UDim2.fromOffset(29, 29)
    ExpandButton.Position = UDim2.new(1, -64, 0.5, -14.5)
    ExpandButton.TextSize = Compact and 14 or 16

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

PageTitle.TextSize = Compact and 16 or 20
PageDescription.TextSize = Compact and 9 or 11

local EditorHeight = math.max(
    150,
    ExecutionScroll.AbsoluteSize.Y - (Compact and 112 or 125)
)

Editor.Size = UDim2.new(
    1,
    -22,
    0,
    EditorHeight
)

Editor.TextSize = Compact and 10 or 13

ExecuteButton.Size = UDim2.fromOffset(
    Compact and 82 or 105,
    Compact and 31 or 36
)

ExecuteButton.TextSize = Compact and 10 or 12

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

    AboutCard.Size = UDim2.new(
    1,
    0,
    0,
    Compact and 95 or 110
)

    CoreGuardCard.Size = UDim2.new(
    1,
    0,
    0,
    Compact and 168 or 172
)

    AboutTitle.Position = UDim2.fromOffset(11, 10)
    AboutTitle.TextSize = Compact and 12 or 14

    AboutVersion.Position = UDim2.fromOffset(11, 34)
    AboutVersion.TextSize = Compact and 9 or 11

    AboutCreator.Position = UDim2.fromOffset(11, 56)
    AboutCreator.TextSize = Compact and 9 or 11

task.defer(function()
    UpdateExecutionScroll()
    UpdateSettingsScroll()
end)
end

local function CollapseWindow()
    if Collapsed then
        return
    end

    Collapsed = true

    local TargetHeight = CurrentTitleHeight
    local TargetWidth = FullWindowSize.X

    local ContentAnimation = Tween(Content, 0.18, {
        GroupTransparency = 1
    })

    ContentAnimation.Completed:Connect(function()
        Content.Visible = false
    end)

    Tween(Window, 0.3, {
        Size = UDim2.fromOffset(
            TargetWidth,
            TargetHeight
        )
    })

    Tween(MinimizeButton, 0.18, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    }).Completed:Connect(function()
        MinimizeButton.Visible = false
        MinimizeButton.BackgroundTransparency = 0.88
        MinimizeButton.TextTransparency = 0

        ExpandButton.Visible = true
        ExpandButton.BackgroundTransparency = 1
        ExpandButton.TextTransparency = 1

        Tween(ExpandButton, 0.2, {
            BackgroundTransparency = 0.88,
            TextTransparency = 0
        })
    end)
end

local function ExpandWindow()
    if not Collapsed then
        return
    end

    Collapsed = false

    Content.Visible = true
    Content.GroupTransparency = 1

    Window.Size = UDim2.fromOffset(
        FullWindowSize.X,
        CurrentTitleHeight
    )

    Tween(Window, 0.3, {
        Size = UDim2.fromOffset(
            FullWindowSize.X,
            FullWindowSize.Y
        )
    })

    Tween(Content, 0.25, {
        GroupTransparency = 0
    })

    Tween(ExpandButton, 0.15, {
        BackgroundTransparency = 1,
        TextTransparency = 1
    }).Completed:Connect(function()
        ExpandButton.Visible = false
        ExpandButton.BackgroundTransparency = 0.88
        ExpandButton.TextTransparency = 0

        MinimizeButton.Visible = true
        MinimizeButton.BackgroundTransparency = 1
        MinimizeButton.TextTransparency = 1

        Tween(MinimizeButton, 0.2, {
            BackgroundTransparency = 0.88,
            TextTransparency = 0
        })
    end)
end

local function ShowWindow()
    Collapsed = false

    FullWindowSize = GetWindowSize()

    Window.Visible = true
    Window.Size = UDim2.fromOffset(
        FullWindowSize.X,
        FullWindowSize.Y
    )

    Content.Visible = true
    Content.GroupTransparency = 0

    MinimizeButton.Visible = true
    ExpandButton.Visible = false

    MinimizeButton.BackgroundTransparency = 0.88
    MinimizeButton.TextTransparency = 0

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

local function CloseWindow()
    Collapsed = false

    Content.Visible = true
    Content.GroupTransparency = 0

    Window.Size = UDim2.fromOffset(
        FullWindowSize.X,
        FullWindowSize.Y
    )

    MinimizeButton.Visible = true
    ExpandButton.Visible = false

    MinimizeButton.BackgroundTransparency = 0.88
    MinimizeButton.TextTransparency = 0

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
end

local function SwitchPage(Target)
    if Target == CurrentPage or PageSwitching then
        return
    end

    PageSwitching = true

    local GoingToSettings = Target == "Settings"

    local OutgoingPage = GoingToSettings and ExecutionPage or SettingsPage
    local IncomingPage = GoingToSettings and SettingsPage or ExecutionPage

    local OutgoingScale = GoingToSettings and ExecutionScale or SettingsScale
    local IncomingScale = GoingToSettings and SettingsScale or ExecutionScale

    local Direction = GoingToSettings and 1 or -1

    CurrentPage = Target

    IncomingPage.Visible = true
    IncomingPage.GroupTransparency = 1
    IncomingPage.Position = UDim2.new(0, Direction * 10, 0, 0)
    IncomingScale.Scale = 0.985

    Tween(
        OutgoingPage,
        0.16,
        {
            GroupTransparency = 1,
            Position = UDim2.new(0, -Direction * 10, 0, 0)
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    Tween(
        OutgoingScale,
        0.16,
        {
            Scale = 0.985
        },
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.In
    )

    task.delay(0.035, function()
        Tween(
            IncomingPage,
            0.25,
            {
                GroupTransparency = 0,
                Position = UDim2.fromScale(0, 0)
            },
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )

        Tween(
            IncomingScale,
            0.25,
            {
                Scale = 1
            },
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        )
    end)

    task.delay(0.18, function()
        OutgoingPage.Visible = false
        OutgoingPage.Position = UDim2.fromScale(0, 0)
        OutgoingPage.GroupTransparency = 0
        OutgoingScale.Scale = 1
    end)

    if GoingToSettings then
        Tween(
            SettingsButton,
            0.2,
            {
                BackgroundTransparency = 0.82,
                BackgroundColor3 = Config.Colors.SurfaceLight,
                TextColor3 = Config.Colors.Text
            }
        )

        Tween(
            ExecutionButton,
            0.2,
            {
                BackgroundTransparency = 1,
                BackgroundColor3 = Config.Colors.Surface,
                TextColor3 = Config.Colors.SecondaryText
            }
        )
    else
        Tween(
            ExecutionButton,
            0.2,
            {
                BackgroundTransparency = 0,
                BackgroundColor3 = Config.Colors.Accent,
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }
        )

        Tween(
            SettingsButton,
            0.2,
            {
                BackgroundTransparency = 1,
                BackgroundColor3 = Config.Colors.Surface,
                TextColor3 = Config.Colors.SecondaryText
            }
        )
    end

    task.delay(0.29, function()
        PageSwitching = false
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

ExpandButton.MouseEnter:Connect(function()
    Tween(ExpandButton, 0.15, {
        BackgroundTransparency = 0.7
    })
end)

ExpandButton.MouseLeave:Connect(function()
    Tween(ExpandButton, 0.15, {
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
    if CurrentPage == "Execution" then
        Tween(ExecutionButton, 0.15, {
            BackgroundColor3 = Config.Colors.AccentHover
        })
    end
end)

ExecutionButton.MouseLeave:Connect(function()
    if CurrentPage == "Execution" then
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
    if CurrentPage ~= "Settings" then
        Tween(SettingsButton, 0.15, {
            BackgroundTransparency = 1
        })
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    CloseWindow()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    CollapseWindow()
end)

ExpandButton.MouseButton1Click:Connect(function()
    ExpandWindow()
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
        Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            UpdateLayout()

            if MiniButton.Visible then
                UpdateMiniButtonPosition()
            end
        end)
    end

    UpdateLayout()
    UpdateMiniButtonPosition()
end)

ShowWindow()
