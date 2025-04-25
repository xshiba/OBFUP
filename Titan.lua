local library = {}

local reload = function(args)
	if args then
		if game:GetService("CoreGui"):FindFirstChild("") then
			game:GetService("CoreGui"):FindFirstChild(""):Destroy()
		end
	end
end

local abbreviate = function(args)
	local data = {
		"K", "M", "B", "T", "QD", "QT", "SXT", "SEPT", "OCT", "NON", "DEC", "UDEC", "DDEC"
	}
	if args < 1000 then
		return tostring(args)
	end

	local digits = math.floor(math.log10(args)) + 1
	local index = math.min(#data, math.floor((digits - 1) / 3))
	local front = args / 10^(index * 3)

	return string.format("%i%s", front, data[index])
end

local comma = function(args)
	local str = string.format("%.f", args)
	return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

local notation = function(args)
	return string.gsub(string.format("%.1e", args), "+", "")
end

local tween = function(args, args2, args3, ...)
	game:GetService("TweenService"):Create(args, TweenInfo.new(args2, args3), ...):Play()
end

local table_check = function(args, args2)
	for index, value in pairs(args) do
		if value == args2 then
			return true
		end
	end
	return false
end

local text_write = function(args)
	for index = 1, #args, 1 do
		return string.sub(args, 1, index)
	end
end

local create_corner = function(args, args2)
	local name = "Corner"
	name = Instance.new("UICorner", args)
	name.CornerRadius = UDim.new(0, args2)
end

local create_stroke = function(args,thickness,color,transp)
	local name = "Stroke"; 
	name = Instance.new("UIStroke",args)
	name.Thickness = thickness
	name.LineJoinMode = Enum.LineJoinMode.Round
	name.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	name.Color = color
	name.Transparency = transp
end

-- [Create Library]

function library:create(args,args2)
	args2 = typeof(args2) == "table" and args2 or {}
	local inst = Instance.new(args)
	for property, value in next, args2 do
		inst[property] = value
	end
	return inst
end

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	game:GetService("UserInputService").InputChanged:Connect(
	function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end
	)
end

function library:Init(data)

	local data_logo = data.Logo or tonumber(9681970193)
	local layout,focus = -1,false

	reload(true)

	local Maru_Screen = library:create("ScreenGui",{
		DisplayOrder = 999,
		Enabled = true,
		IgnoreGuiInset = true,
		Name = "",
		Parent = game:GetService("CoreGui"),
		ResetOnSpawn = false,
	})

	local Main = library:create("Frame",{
		Active = true,
		AnchorPoint = Vector2.new(0.5,0.5),
		BackgroundColor3 = Color3.fromRGB(33,33,33),
		BackgroundTransparency = 0,
		LayoutOrder = 0,
		Name = "Main",
		Parent = Maru_Screen,
		Position = UDim2.new(0.5,0,0.5,0),
		Rotation = 0,
		Size = UDim2.new(0,0,0,0),
		Visible = true,
	})

	create_corner(Main,8)
	tween(Main,0.5,Enum.EasingStyle.Back,{Size = UDim2.new(0,549,0,386)})

	local Topbar = library:create("Frame",{
		Active = true,
		AnchorPoint = Vector2.new(0,0),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0,0,0),
		BorderSizePixel = 0,
		LayoutOrder = 0,
		Name = "Topbar",
		Position = UDim2.new(0,0,0,0),
		Rotation = 0,
		Size = UDim2.new(0,549,0,48),
		Visible = true,
		Parent = Main,
	})

	MakeDraggable(Topbar,Main)

	local Logo = library:create("ImageLabel",{
		Active = false,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.06,0,0.5,0),
		Size = UDim2.new(0,42,0,42),
		Visible = true,
		Image = "rbxassetid://"..data_logo,
		ImageColor3 = Color3.fromRGB(255,255,255),
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Fit,
		Parent = Topbar,
		Name = "Logo",
	})

	local Line = library:create("Frame",{
		Active = true,
		AnchorPoint = Vector2.new(0,0),
		BackgroundTransparency = 0.95,
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		LayoutOrder = 0,
		Position = UDim2.new(-0,0,0.126,0),
		Size = UDim2.new(0,549,0,1),
		Visible = true,
		Parent = Main,
		Name = "Line",
	})

	local Frame_Scrollbar = library:create("Frame",{
		Active = true,
		BackgroundColor3 = Color3.fromRGB(23,23,23),
		Name = "Frame_Scrollbar",
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.534,0,0.5,0),
		Size = UDim2.new(0,473,0,38),
		Visible = true,
		Parent = Topbar,
		ClipsDescendants = true,
	})

	create_corner(Frame_Scrollbar,8)

	local Scollbar = library:create("ScrollingFrame",{
		Active = true,
		AnchorPoint = Vector2.new(0,0),
		BackgroundColor3 = Color3.fromRGB(255,255,255),
		BackgroundTransparency = 1,
		LayoutOrder = 0,
		Name = "Scrollbar",
		Parent = Frame_Scrollbar,
		Position = UDim2.new(0,0,0,0),
		Rotation = 0,
		Size = UDim2.new(0,557,0,38),
		Visible = true,
		ClipsDescendants = true,
		ScrollingEnabled = true,
		ScrollBarThickness = 0,
	})

	local Scrollbar_list = library:create("UIListLayout",{
		Padding = UDim.new(0,10),
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Name = "Scrollbar_list",
		Parent = Scollbar,
	})

	local Scrollbar_padding = library:create("UIPadding",{
		Name = "Scrollbar_padding",
		Parent = Scollbar,
		PaddingLeft = UDim.new(0,8),
		PaddingTop = UDim.new(0,8),
	})

	local Page = library:create("Frame",{
		Name = "Page",
		Parent = Main,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(-7.7850963e-08, 0, 0.127, 0),
		Size = UDim2.new(0, 549, 0, 337),
	})

	local UIPageLayout = library:create("UIPageLayout",{
		Parent = Page,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Circular = true,
		EasingStyle = Enum.EasingStyle.Circular,
		GamepadInputEnabled = false,
		ScrollWheelInputEnabled = false,
		TouchInputEnabled = false,
		TweenTime = 0.250,
	})

	local createtab = {}

	function createtab:Tabs(data)
		local data_tab_title = data.Title or "Tabs"
		local data_tab_logo = data.Logo or tonumber(6034227075)
		local data_name_random = math.random(1,9999)
		layout = layout + 1

		local Button = library:create("TextButton",{
			Active = true,
			AnchorPoint = Vector2.new(0,0),
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(67,67,67),
			LayoutOrder = 0,
			Name = "Button_"..tostring(data_name_random),
			Parent = Scollbar,
			Size = UDim2.new(0,227,0,23),
			Visible = true,
			AutoButtonColor = false,
			ZIndex = 2,
			Font = Enum.Font.Gotham,
			Text = data_tab_title,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 12.000,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
		})

		create_corner(Button,8)
		create_stroke(Button,1.6,Color3.fromRGB(255,255,255),0.98)

		if Button.Name == "Button_"..tostring(data_name_random) then
			Button.Size = UDim2.new(0, 70 + Button.TextBounds.X, 0, 23)
		end

		local Frame = library:create("Frame",{
			Parent = Page,
			Active = true,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(0, 549, 0, 337),
			Name = "Frame_"..tostring(data_name_random),
			LayoutOrder = layout,
		})

		local Frame_ListLayout = library:create("UIListLayout",{
			Parent = Frame,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		-- [Left Side]

		local Left_Side = library:create("ScrollingFrame",{
			Name = "LeftFrame",
			Parent = Frame,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.496938705, 0, 0, 0),
			Size = UDim2.new(0, 274, 0, 337),
			ScrollBarThickness = 0,
		})

		local Left_Side_List = library:create("UIListLayout",{
			Name = "LeftFrameUIListLayout",
			Parent = Left_Side,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		local Left_Side_Padding = library:create("UIPadding",{
			Name = "LeftFrameUIPadding",
			Parent = Left_Side,
			PaddingLeft = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		})

		-- [Right Side]

		local Right_Side = library:create("ScrollingFrame",{
			Name = "RightFrame",
			Parent = Frame,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1.000,
			BorderSizePixel = 0,
			Position = UDim2.new(0.496938705, 0, 0, 0),
			Size = UDim2.new(0, 274, 0, 337),
			ScrollBarThickness = 0,
		})

		local Right_Side_List = library:create("UIListLayout",{
			Name = "RightFrameUIListLayout",
			Parent = Right_Side,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 5),
		})

		local Right_Side_Padding = library:create("UIPadding",{
			Name = "RightFrameUIPadding",
			Parent = Right_Side,
			PaddingLeft = UDim.new(0, 5),
			PaddingTop = UDim.new(0, 5),
		})

		local getside = function(args)
			if args == 1 then
				return Left_Side
			elseif args == 2 then
				return Right_Side
			else
				return Left_Side
			end
		end

		Button.MouseButton1Click:Connect(function()
			if Frame.Name == "Frame_"..tostring(data_name_random) then
				UIPageLayout:JumpToIndex(Frame.LayoutOrder)
			end
			for i , v in pairs(Scollbar:GetChildren()) do
				if v:IsA("TextButton") then
					tween(v,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0,BackgroundColor3 = Color3.fromRGB(67,67,67)})

				end
				tween(Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0,BackgroundColor3 = Color3.fromRGB(162,162,162)})
			end
		end)

		if not focus then
			for i , v in pairs(Scollbar:GetChildren()) do
				if v:IsA("TextButton") then
					tween(v,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0,BackgroundColor3 = Color3.fromRGB(67,67,67)})
				end
				tween(Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0,BackgroundColor3 = Color3.fromRGB(162,162,162)})
			end
			focus = true
		end

		local createpage = {}

		function createpage:Page(data)
			local Title = data.Title or "PAGES"
			local GetSide = data.Type or 1

			local Page_Main = library:create("Frame",{
				Name = "PageMain",
				Parent = getside(GetSide),
				Active = true,
				BackgroundColor3 = Color3.fromRGB(23, 23, 23),
				ClipsDescendants = false,
				Size = UDim2.new(0, 264, 0, 401),
			})

			create_corner(Page_Main,8)

			local TitlePage = library:create("TextLabel",{
				Name = "TitlePage",
				Parent = Page_Main,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(0.0257509016, 0, 0, 0),
				Size = UDim2.new(0, 248, 0, 30),
				Font = Enum.Font.Gotham,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 12.000,
				TextTransparency = 0.450,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = Title,
			})

			local LinePage = library:create("Frame",{
				Name = "LinePage",
				Parent = TitlePage,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.900,
				BorderSizePixel = 0,
				Position = UDim2.new(-0.027, 0, 1.001, 0),
				Size = UDim2.new(0, 264, 0, 1),
			})

			local Page = library:create("Frame",{
				Name = "Page",
				Parent = TitlePage,
				Active = true,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1.000,
				Position = UDim2.new(-0.0273972191, 0, 1.19480646, 0),
				Size = UDim2.new(0, 380, 0, 40),
			})

			local Page_list = library:create("UIListLayout",{
				Name = "PageUIListLayout",
				Parent = Page,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 5),
			})

			local Page_padding = library:create("UIPadding",{
				Name = "PageUIPadding",
				Parent = Page,
				PaddingLeft = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 5),
			})

			game:GetService("RunService").Heartbeat:Connect(function()
				Scollbar.CanvasSize = UDim2.new(0,Scrollbar_list.AbsoluteContentSize.X + 100,0,0)
				Right_Side.CanvasSize = UDim2.new(0,0,0,Right_Side_List.AbsoluteContentSize.Y + 10)
				Left_Side.CanvasSize = UDim2.new(0,0,0,Left_Side_List.AbsoluteContentSize.Y + 10)
				Page_Main.Size = UDim2.new(0,264,0,50 + Page_list.AbsoluteContentSize.Y + 1.5)
			end)

			local createfunction = {}

			function createfunction:Toggle(title,def,callback)
				local focus_toggle = def or false
				local Toggle = library:create("Frame",{
					Name = "Toggle",
					Parent = Page,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(39, 39, 39),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 255, 0, 39),
				})

				create_corner(Toggle,4)

				local Button = library:create("TextButton",{
					Name = "Button",
					Parent = Toggle,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 304, 0, 39),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 12.000,
					TextTransparency = 1.000,
					ZIndex = 2,
				})

				local Title = library:create("TextLabel",{
					Name = "Title",
					Parent = Toggle,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0361842103, 0, 0, 0),
					Size = UDim2.new(0, 200, 0, 39),
					Font = Enum.Font.Gotham,
					Text = tostring(title),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextTransparency = 0.450,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local Inner = library:create("Frame",{
					Name = "Inner",
					Parent = Toggle,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(76, 76, 76),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.88, 0, 0.5, 0),
					Size = UDim2.new(0, 21, 0, 21),
				})

				create_corner(Inner,30)

				local Circle = library:create("ImageLabel",{
					Name = "Check",
					Parent = Inner,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 0, 0, 0),
					Image = "http://www.roblox.com/asset/?id=6023426945",
					ImageColor3 = Color3.fromRGB(21, 212, 255),
				})

				create_corner(Circle,30)

				if def then
					tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
					tween(Circle,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 21, 0, 21)})
					callback(focus_toggle)
				end

				Button.MouseButton1Click:Connect(function()
					if not focus_toggle then
						tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
						tween(Circle,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 21, 0, 21)})
					else
						tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
						tween(Circle,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 0, 0, 0)})
					end
					focus_toggle = not focus_toggle
					callback(focus_toggle)
				end)
			end

			function createfunction:Button(title,callback)
				local ButtonFrame = library:create("Frame",{
					Name = "ButtonFrame",
					Parent = Page,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(67,67,67),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 1.2571429, 0),
					Size = UDim2.new(0, 255, 0, 25),
				})

				create_corner(ButtonFrame,4)

				local Button = library:create("TextButton",{
					Name = "Button",
					Parent = ButtonFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 255, 0, 25),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 12.000,
					TextTransparency = 1.000,
					ZIndex = 2,
				})

				local Title = library:create("TextLabel",{
					Name = "Title",
					Parent = ButtonFrame,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0361842103, 0, 0, 0),
					Size = UDim2.new(0, 232, 0, 25),
					Font = Enum.Font.Gotham,
					Text = tostring(title),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextTransparency = 0.450,
					TextWrapped = true,
				})

				Button.MouseEnter:Connect(function()
					tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0,BackgroundColor3 = Color3.fromRGB(255,255,255)})
					tween(ButtonFrame,0.25,Enum.EasingStyle.Circular,{BackgroundColor3 = Color3.fromRGB(162,162,162)})
				end)

				Button.MouseLeave:Connect(function()
					tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
					tween(ButtonFrame,0.25,Enum.EasingStyle.Circular,{BackgroundColor3 = Color3.fromRGB(67,67,67)})
				end)

				Button.MouseButton1Click:Connect(function()
					Title.TextSize = 0
					tween(Title,0.4,Enum.EasingStyle.Back,{TextSize = 12})
					pcall(callback)
				end)
			end

			function createfunction:Slider(title,min,max,def,callback)
				local SliderFrame = library:create("Frame",{
					Name = "SliderFrame",
					Parent = Page,
					BackgroundColor3 = Color3.fromRGB(35, 36, 41),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 2.11428571, 0),
					Size = UDim2.new(0, 255, 0, 40),
				})

				local SliderFrame2 = library:create("TextButton",{
					Name = "SliderFrame2",
					Parent = SliderFrame,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(45, 45, 45),
					BackgroundTransparency = 1.000,
					BorderSizePixel = 0,
					Position = UDim2.new(0.49932012, 0, 0.516666412, 0),
					Size = UDim2.new(0, 255, 0, 32),
					Text = "",
				})

				create_corner(SliderFrame2,4)

				local SliderValueFrame = library:create("Frame",{
					Name = "SliderValueFrame",
					Parent = SliderFrame2,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(79, 84, 92),
					BorderSizePixel = 0,
					Position = UDim2.new(0.491888136, 0, 0.679718971, 0),
					Size = UDim2.new(0, 245, 0, 9),
				})

				local SliderValueFrame_2 = library:create("Frame",{
					Name = "SliderValueFrame",
					Parent = SliderValueFrame,
					BackgroundColor3 = Color3.fromRGB(21, 212, 255),
					BorderSizePixel = 0,
					Size = UDim2.new((def)/ max, 0, 0, 9),
					ZIndex = 2
				})

				create_corner(SliderValueFrame_2,8)
				create_corner(SliderValueFrame,84)

				local SliderValueFrame_3 = library:create("Frame",{
					Name = "SliderValueFrame",
					Parent = SliderValueFrame,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.new((def or 0)/max, 0.5, 0.5,0.5, 0),
					Size = UDim2.new(0, 9, 0, 15),
					ZIndex = 2
				})

				create_corner(SliderValueFrame_3,3)

				local texthead = library:create("TextLabel",{
					Name = "texthead",
					Parent = SliderFrame,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0125900069, 0, 0, 0),
					Size = UDim2.new(0, 264, 0, 18),
					Font = Enum.Font.Gotham,
					Text = tostring(title),
					TextColor3 = Color3.fromRGB(150, 152, 157),
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local valuedragspeed = library:create("TextBox",{
					Name = "valuedragspeed",
					Parent = SliderFrame,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.876999974, 0, 0, 0),
					Size = UDim2.new(0, 28, 0, 18),
					Font = Enum.Font.Gotham,
					PlaceholderColor3 = Color3.fromRGB(96, 97, 100),
					PlaceholderText = tostring(math.floor(((def - min) / (max - min)) * (max - min) + min)),
					Text = "",
					TextColor3 = Color3.fromRGB(150, 152, 157),
					TextSize = 12.000,
					TextWrapped = true,
				})

				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - SliderValueFrame.AbsolutePosition.X) / SliderValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0.5,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - SliderValueFrame.AbsolutePosition.X) / SliderValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							9
						)

					SliderValueFrame_2:TweenSize(pos1, "Out", "Sine", 0.2, true)
					SliderValueFrame_3:TweenPosition(pos, "Out", "Sine", 0.2, true)
					local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
					valuedragspeed.Text = tostring(value)
					callback(value)
				end

				SliderFrame2.MouseEnter:Connect(function()

					local dragging = false

					SliderFrame2.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								dragging = true
							end
						end
					)
					SliderFrame2.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								dragging = false
							end
						end
					)

					game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
				end)

				valuedragspeed.FocusLost:Connect(function()
					if valuedragspeed.Text == "" then
						valuedragspeed.Text  = def
					end
					if tonumber(valuedragspeed.Text) > max then
						valuedragspeed.Text  = max
						tween(SliderValueFrame_2,0.5,Enum.EasingStyle.Circular,{Size = UDim2.new((max)/ max, 0, 0, 9)})
						tween(SliderValueFrame_3,0.5,Enum.EasingStyle.Circular,{Position = UDim2.new((max)/ max, 0, 0.5, 0)})
					elseif tonumber(valuedragspeed.Text) < min then
						valuedragspeed.Text  = min
						tween(SliderValueFrame_2,0.5,Enum.EasingStyle.Circular,{Size = UDim2.new((min)/ max, 0, 0, 9)})
						tween(SliderValueFrame_3,0.5,Enum.EasingStyle.Circular,{Position = UDim2.new((min)/ max, 0, 0.5, 0)})
					else
						valuedragspeed.Text = tostring(valuedragspeed.Text) -- tostring(valuedragspeed.Text and math.floor( (valuedragspeed.Text / max) * (max - min) + min) )
						tween(SliderValueFrame_2,0.5,Enum.EasingStyle.Circular,{Size = UDim2.new(tonumber(valuedragspeed.Text)/ max, 0, 0, 9)})
						tween(SliderValueFrame_3,0.5,Enum.EasingStyle.Circular,{Position = UDim2.new(tonumber(valuedragspeed.Text)/ max, 0, 0.5, 0)})
					end
					pcall(callback, valuedragspeed.Text)
				end)
			end

			function createfunction:TextBox(title,def,callback)
				local TextBox = library:create("Frame",{
					Name = "TextBox",
					Parent = Page,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(39, 39, 39),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 3.4000001, 0),
					Size = UDim2.new(0, 255, 0, 55),
				})

				create_corner(TextBox,4)

				local Title = library:create("TextLabel",{
					Name = "Title",
					Parent = TextBox,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0359999016, 0, 0.159999847, 0),
					Size = UDim2.new(0, 235, 0, 12),
					Font = Enum.Font.Gotham,					
					Text = tostring(title),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextTransparency = 0.450,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local Frame_Box = library:create("Frame",{
					Parent = TextBox,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0329999998, 0, 0.479999989, 0),
					Size = UDim2.new(0, 235, 0, 24),
				})

				create_corner(Frame_Box,4)

				local Box = library:create("TextBox",{
					Name = "Box",
					Parent = Frame_Box,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.028070176, 0, 0, 0),
					Size = UDim2.new(0, 217, 0, 24),
					Font = Enum.Font.Gotham,
					Text = tostring(def) or "",
					PlaceholderText = tostring(def) or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextTransparency = 0.450,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 2
				})

				Box.FocusLost:Connect(function()
					pcall(callback, Box.Text)
					print(Box.Text)
				end)
			end

			function createfunction:Label(text)

				local Label_Frame = library:create("Frame",{
					Name = "LabelFrame",
					Parent = Page,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 5.11428595, 0),
					Size = UDim2.new(0, 255, 0, 22),
				})

				local Label = library:create("TextLabel",{
					Name = "Label",
					Parent = Label_Frame,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BorderSizePixel = 0,
					Position = UDim2.new(0.502209485, 0, 0.5, 0),
					Size = UDim2.new(0, 255, 0, 22),
					Font = Enum.Font.Gotham,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					Text = tostring(text)
				})

				local Labelfunc = {}

				function Labelfunc:Set(text)
					Label.Text = text
				end
				return Labelfunc
			end

			function createfunction:Dropdown(text,def,mode,list,callback)
				local dropfocus = false
				local Dropdown = library:create("Frame",{
					Name = "Dropdown",
					Parent = Page,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(39, 39, 39),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 255, 0, 39),
				})

				create_corner(Dropdown,4)

				local Button_Dropdown = library:create("TextButton",{
					Name = "Button",
					Parent = Dropdown,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 255, 0, 39),
					Font = Enum.Font.SourceSans,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 12.000,
					TextTransparency = 1.000,
					ZIndex = 2,
				})

				local Title = library:create("TextLabel",{
					Name = "Title",
					Parent = Dropdown,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.0361842103, 0, 0, 0),
					Size = UDim2.new(0, 138, 0, 39),
					Font = Enum.Font.Gotham,
					Text = tostring(text),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12.000,
					TextTransparency = 0.450,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local Selected = library:create("Frame",{
					Name = "Selected",
					Parent = Dropdown,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.72, 0, 0.5, 0),
					Size = UDim2.new(0, 123, 0, 27),
				})

				create_corner(Selected,6)
				create_stroke(Selected,1,Color3.fromRGB(255,255,255),0.89)

				local Selected_text = library:create("TextLabel",{
					Name = "Selected_text",
					Parent = Selected,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.048780486, 0, 0, 0),
					Size = UDim2.new(0, 65, 0, 26),
					Font = Enum.Font.Gotham,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 11.000,
					TextTransparency = 0.450,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "N/A"
				})

				local Arrow = library:create("ImageLabel",{
					Name = "Arrow",
					Parent = Selected,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.850000024, 0, 0.5, 0),
					Rotation = -90.000,
					Size = UDim2.new(0, 17, 0, 17),
					Image = "rbxassetid://16119135578",
					ImageTransparency = 0.450,
					ScaleType = Enum.ScaleType.Fit,
				})

				local Inner = library:create("Frame",{
					Name = "Inner",
					Parent = Page,
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0, 255, 0, 0),
					BackgroundTransparency = 1,
				})

				create_corner(Inner,4)

				local Scrollbar = library:create("ScrollingFrame",{
					Name = "Scrollbar",
					Parent = Inner,
					Active = true,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 255, 0, 0),
					ScrollBarThickness = 0,
					ClipsDescendants = true,
				})

				local UIListLayout = library:create("UIListLayout",{
					Parent = Scrollbar,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 3),
				})


				local dropdownfunc = {}
				task.spawn(function()
					if not mode then
						for i,v in pairs(list) do
							local Button = library:create("TextButton",{
								Parent = Scrollbar,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Size = UDim2.new(0, 255, 0, 33),
								Font = Enum.Font.SourceSans,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								TextSize = 12.000,
								TextTransparency = 1.000,
								ZIndex = 5,
							})

							local Title = library:create("TextLabel",{
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.552651703, 0, 0.5, 0),
								Size = UDim2.new(0.894696534, 0, 0.5, 0),
								Font = Enum.Font.Gotham,
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 11.000,
								TextTransparency = 0.45,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
								Text = v,
								Name = "Title",
							})

							local Selected_Button = library:create("Frame",{
								Name = "Selected_Button",
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1, --0.89
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.496805191, 0, 0.500000119, 0),
								Size = UDim2.new(0.9380548, 0, 0.770075262, 0),
							})

							local Line = library:create("Frame",{
								Name = "Line",
								Parent = Selected_Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(21, 212, 255),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.0250000004, 0, 0.5, 0),
								Size = UDim2.new(0, 3, 0, 15),
								BackgroundTransparency = 1,
							})

							create_corner(Line,30)
							create_corner(Selected_Button,4)

							if def == v then
								for i,v in pairs(Scrollbar:GetChildren()) do
									if v:IsA("TextButton") then
										if v:FindFirstChild("Selected_Button") then
											tween(v:FindFirstChild("Selected_Button"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Selected_Button"):FindFirstChild("Line") then
											tween(v:FindFirstChild("Selected_Button"):FindFirstChild("Line"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Title") then
											tween(v:FindFirstChild("Title"),0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
										end
									end
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
								end
								callback(v)
								Selected_text.Text = v
							end

							Button.MouseButton1Click:Connect(function()
								for i,v in pairs(Scrollbar:GetChildren()) do
									if v:IsA("TextButton") then
										if v:FindFirstChild("Selected_Button") then
											tween(v:FindFirstChild("Selected_Button"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Selected_Button"):FindFirstChild("Line") then
											tween(v:FindFirstChild("Selected_Button"):FindFirstChild("Line"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Title") then
											tween(v:FindFirstChild("Title"),0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
										end
									end
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
								end
								callback(v)
								Selected_text.Text = v
								tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 255, 0, 0)})
								tween(Inner,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1,Size = UDim2.new(0, 255, 0, 0),})
								tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{ScrollBarThickness = 0})
								dropfocus = not dropfocus
							end)
						end

						function dropdownfunc:Clear()
							for i,v in pairs(Scrollbar:GetChildren()) do
								if v:IsA("TextButton") then
									v:Destroy()
								end
							end
							callback("")
							Selected_text.Text = ""
						end

						function dropdownfunc:Add(v)
							local Button = library:create("TextButton",{
								Parent = Scrollbar,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Size = UDim2.new(0, 255, 0, 33),
								Font = Enum.Font.SourceSans,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								TextSize = 12.000,
								TextTransparency = 1.000,
								ZIndex = 5,
							})

							local Title = library:create("TextLabel",{
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.552651703, 0, 0.5, 0),
								Size = UDim2.new(0.894696534, 0, 0.5, 0),
								Font = Enum.Font.Gotham,
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 11.000,
								TextTransparency = 0.45,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
								Text = v,
								Name = "Title",
							})

							local Selected_Button = library:create("Frame",{
								Name = "Selected_Button",
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1, --0.89
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.496805191, 0, 0.500000119, 0),
								Size = UDim2.new(0.9380548, 0, 0.770075262, 0),
							})

							local Line = library:create("Frame",{
								Name = "Line",
								Parent = Selected_Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(21, 212, 255),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.0250000004, 0, 0.5, 0),
								Size = UDim2.new(0, 3, 0, 15),
								BackgroundTransparency = 1,
							})

							create_corner(Line,30)
							create_corner(Selected_Button,4)

							Button.MouseButton1Click:Connect(function()
								for i,v in pairs(Scrollbar:GetChildren()) do
									if v:IsA("TextButton") then
										if v:FindFirstChild("Selected_Button") then
											tween(v:FindFirstChild("Selected_Button"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Selected_Button"):FindFirstChild("Line") then
											tween(v:FindFirstChild("Selected_Button"):FindFirstChild("Line"),0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
										end
										if v:FindFirstChild("Title") then
											tween(v:FindFirstChild("Title"),0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
										end
									end
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
								end
								callback(v)
								Selected_text.Text = v
								Selected_text.Text = v
								tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 255, 0, 0)})
								tween(Inner,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1,Size = UDim2.new(0, 255, 0, 0),})
								tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{ScrollBarThickness = 0})
								dropfocus = not dropfocus
							end)
						end
					else
						local MultiDropdown = {}
						if typeof(list) ~= "table" then
							list = {list}
						end
						for i,v in pairs(list) do
							local Button = library:create("TextButton",{
								Parent = Scrollbar,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Size = UDim2.new(0, 255, 0, 33),
								Font = Enum.Font.SourceSans,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								TextSize = 12.000,
								TextTransparency = 1.000,
								ZIndex = 5,
							})

							local Title = library:create("TextLabel",{
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.552651703, 0, 0.5, 0),
								Size = UDim2.new(0.894696534, 0, 0.5, 0),
								Font = Enum.Font.Gotham,
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 11.000,
								TextTransparency = 0.45,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
								Text = v,
								Name = "Title",
							})

							local Selected_Button = library:create("Frame",{
								Name = "Selected_Button",
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1, --0.89
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.496805191, 0, 0.500000119, 0),
								Size = UDim2.new(0.9380548, 0, 0.770075262, 0),
							})

							local Line = library:create("Frame",{
								Name = "Line",
								Parent = Selected_Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(21, 212, 255),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.0250000004, 0, 0.5, 0),
								Size = UDim2.new(0, 3, 0, 15),
								BackgroundTransparency = 1,
							})
							
							create_corner(Line,30)
							create_corner(Selected_Button,4)

							for i,value in pairs(def) do
								if v == value then
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
									table.insert(MultiDropdown,value)
									Selected_text.Text = table.concat(MultiDropdown,",")
									pcall(callback,MultiDropdown)
								end
							end

							Button.MouseButton1Click:Connect(function()
								if table_check(MultiDropdown,v) == false then
									table.insert(MultiDropdown,v)
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
								else
									for ine,va in pairs(MultiDropdown) do
										if va == v then
											table.remove(MultiDropdown,ine)
										end
									end
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
								end
								Selected_text.Text = table.concat(MultiDropdown,",")
								pcall(callback,MultiDropdown)
							end)											
						end

						function dropdownfunc:Clear()
							MultiDropdown = {}
							for i,v in pairs(Scrollbar:GetChildren()) do
								if v:IsA("TextButton") then
									v:Destroy()
								end
							end
							callback("")
							Selected_text.Text = ""
						end

						function dropdownfunc:Add(v)
							local Button = library:create("TextButton",{
								Parent = Scrollbar,
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Size = UDim2.new(0, 255, 0, 33),
								Font = Enum.Font.SourceSans,
								TextColor3 = Color3.fromRGB(0, 0, 0),
								TextSize = 12.000,
								TextTransparency = 1.000,
								ZIndex = 5,
							})

							local Title = library:create("TextLabel",{
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1.000,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.552651703, 0, 0.5, 0),
								Size = UDim2.new(0.894696534, 0, 0.5, 0),
								Font = Enum.Font.Gotham,
								TextColor3 = Color3.fromRGB(255, 255, 255),
								TextSize = 11.000,
								TextTransparency = 0.45,
								TextWrapped = true,
								TextXAlignment = Enum.TextXAlignment.Left,
								Text = v,
								Name = "Title",
							})

							local Selected_Button = library:create("Frame",{
								Name = "Selected_Button",
								Parent = Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1, --0.89
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.496805191, 0, 0.500000119, 0),
								Size = UDim2.new(0.9380548, 0, 0.770075262, 0),
							})

							local Line = library:create("Frame",{
								Name = "Line",
								Parent = Selected_Button,
								Active = true,
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(21, 212, 255),
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Position = UDim2.new(0.0250000004, 0, 0.5, 0),
								Size = UDim2.new(0, 3, 0, 15),
								BackgroundTransparency = 1,
							})
							
							create_corner(Line,30)
							create_corner(Selected_Button,4)

							Button.MouseButton1Click:Connect(function()
								if table_check(MultiDropdown,v) == false then
									table.insert(MultiDropdown,v)
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0.89})
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0})
								else
									for ine,va in pairs(MultiDropdown) do
										if va == v then
											table.remove(MultiDropdown,ine)
										end
									end
									tween(Selected_Button,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
									tween(Title,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0.45})
									tween(Line,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1})
								end
								Selected_text.Text = table.concat(MultiDropdown,",")
								pcall(callback,MultiDropdown)
							end)
						end			
					end
				end)

				function dropdownfunc:Set(value)
					if type(value) == "table" then
						Selected_text.Text = table.concat(value,",")
						pcall(callback, value)
					else
						pcall(callback, value)
						Selected_text.Text = value
					end
				end

				game:GetService("RunService").Heartbeat:Connect(function()
					Scrollbar.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y + 5)
				end)

				Button_Dropdown.MouseButton1Click:Connect(function()
					if not dropfocus then
						tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 255, 0, 109)})
						tween(Inner,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 0,Size = UDim2.new(0, 255, 0, 109),})
						tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{ScrollBarThickness = 2})
					else
						tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 255, 0, 0)})
						tween(Inner,0.25,Enum.EasingStyle.Circular,{BackgroundTransparency = 1,Size = UDim2.new(0, 255, 0, 0),})
						tween(Scrollbar,0.25,Enum.EasingStyle.Circular,{ScrollBarThickness = 0})
					end
					dropfocus = not dropfocus
				end)
				return dropdownfunc
			end

			return createfunction
		end

		return createpage
	end
	return createtab
end
if game:GetService("CoreGui"):FindFirstChild(" ") then
	game:GetService("CoreGui"):FindFirstChild(" "):Destroy()
end
local a = game:GetService("RbxAnalyticsService"):GetClientId()
if string.lower(a) == game:GetService("RbxAnalyticsService"):GetClientId() then
	local PidUi = Instance.new("ScreenGui")
	local Main = Instance.new("ImageButton")
	local UICorner = Instance.new("UICorner")
	PidUi.Name = " "
	PidUi.Parent = game:GetService("CoreGui")
	PidUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Main.Name = "Main"
	Main.Parent = PidUi
	Main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.081166774, 0, 0.0841463208, 0)
	Main.Size = UDim2.new(0, 50, 0, 50)
	Main.Image = "http://www.roblox.com/asset/?id=9681970193"
	local function MakeDraggable(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos =
				UDim2.new(
					StartPosition.X.Scale,
					StartPosition.X.Offset + Delta.X,
					StartPosition.Y.Scale,
					StartPosition.Y.Offset + Delta.Y
				)
			local Tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end

		topbarobject.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = input.Position
					StartPosition = object.Position

					input.Changed:Connect(
						function()
							if input.UserInputState == Enum.UserInputState.End then
								Dragging = false
							end
						end
					)
				end
			end
		)

		topbarobject.InputChanged:Connect(
			function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
				then
					DragInput = input
				end
			end
		)

		game:GetService("UserInputService").InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
		)
	end
	MakeDraggable(Main, Main)
	Main.MouseButton1Click:Connect(function()
		game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible = not game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible
	end)
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = Main
	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftAlt then
			game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible = not game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible
		end
	end)
else
	game:GetService("UserInputService").InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftControl then
			game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible = not game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/ProductPurchasePrompt").Main.Visible
		end
	end)
end
return library
