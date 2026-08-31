Gass. Ini full script dengan ritme Awal → Beat 1–5 → ulang persis sesuai urutan yang lu kasih. GUI tetap draggable, ON/OFF, speed custom, dan move posisi depan/belakang tetap ada.

--========================================================
-- CDT RHYTHM STROBE LIGHT
--========================================================
-- 4 VISUAL LIGHT TERPISAH:
--
-- FRONT LEFT   = PUTIH
-- FRONT RIGHT  = PUTIH
-- REAR LEFT    = PUTIH
-- REAR RIGHT   = PUTIH
--
-- RITME:
--
-- AWAL
-- FRONT ON
-- REAR ON
-- FRONT OFF
-- REAR OFF
--
-- BEAT 1
-- FRONT LEFT ON
-- FRONT RIGHT ON
-- REAR LEFT ON
-- ALL OFF
--
-- BEAT 2
-- FRONT LEFT ON
-- FRONT RIGHT ON
-- FLASH CEPAT
-- ALL OFF
--
-- BEAT 3
-- REAR LEFT ON
-- REAR RIGHT ON
-- FRONT ON
-- ALL OFF
--
-- BEAT 4
-- FRONT ON
-- REAR ON
-- FRONT OFF
-- REAR OFF
-- FRONT ON
-- REAR ON
-- ALL OFF
--
-- BEAT 5
-- FRONT LEFT ON
-- FRONT RIGHT ON
-- REAR LEFT + REAR RIGHT ON
-- FLASH
-- ALL OFF
--
-- LOOP
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================
-- SETTINGS
--========================================================

local ENABLED = false

-- Kecepatan utama ritme
local StrobeSpeed = 0.10

-- Flash cepat
local FlashSpeed = 0.035

-- Brightness
local FrontBrightness = 8
local RearBrightness = 8

-- Range
local FrontRange = 45
local RearRange = 35

-- Angle
local FrontAngle = 65
local RearAngle = 65

-- Posisi
local SideOffset = 2.8
local FrontOffset = 3.5
local RearOffset = 3.5
local HeightOffset = 1

-- Move
local FrontMove = 0
local RearMove = 0

local MoveStep = 0.5
local MoveTarget = "FRONT"

--========================================================
-- TRACKING
--========================================================

local PositionPrediction = 0.085
local RotationPrediction = 0.12
local VelocityInfluence = 1.0
local AngularSmoothing = 0.15

--========================================================
-- CLEAN OLD
--========================================================

local oldGui =
	playerGui:FindFirstChild(
		"CDT_RhythmStrobeLights"
	)

if oldGui then
	oldGui:Destroy()
end

local oldFolder =
	workspace:FindFirstChild(
		"CDT_RhythmStrobeLights"
	)

if oldFolder then
	oldFolder:Destroy()
end

--========================================================
-- GUI
--========================================================

local gui = Instance.new("ScreenGui")

gui.Name = "CDT_RhythmStrobeLights"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

gui.Parent = playerGui

--========================================================
-- DRAG
--========================================================

local function makeDraggable(frame, handle)

	local dragging = false
	local dragStart
	local startPosition

	handle.InputBegan:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = frame.Position

		end

	end)

	handle.InputEnded:Connect(function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = false

		end

	end)

	UIS.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType ==
			Enum.UserInputType.MouseMovement
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			local delta =
				input.Position - dragStart

			frame.Position =
				UDim2.new(
					startPosition.X.Scale,
					startPosition.X.Offset + delta.X,
					startPosition.Y.Scale,
					startPosition.Y.Offset + delta.Y
				)

		end

	end)

end

--========================================================
-- OPEN BUTTON
--========================================================

local openButton =
	Instance.new("TextButton")

openButton.Name = "OpenButton"

openButton.Size =
	UDim2.new(0,105,0,38)

openButton.Position =
	UDim2.new(1,-120,0.5,-19)

openButton.BackgroundColor3 =
	Color3.fromRGB(30,30,35)

openButton.BorderSizePixel = 0

openButton.Text = "STROBO"

openButton.TextColor3 =
	Color3.new(1,1,1)

openButton.TextSize = 14

openButton.Font =
	Enum.Font.GothamBold

openButton.Visible = false
openButton.Active = true

openButton.Parent = gui

local openCorner =
	Instance.new("UICorner")

openCorner.CornerRadius =
	UDim.new(0,8)

openCorner.Parent =
	openButton

makeDraggable(
	openButton,
	openButton
)

--========================================================
-- MAIN
--========================================================

local main =
	Instance.new("Frame")

main.Name = "Main"

main.Size =
	UDim2.new(0,280,0,470)

main.Position =
	UDim2.new(1,-300,0.5,-235)

main.BackgroundColor3 =
	Color3.fromRGB(30,30,35)

main.BorderSizePixel = 0

main.Active = true

main.Parent = gui

local mainCorner =
	Instance.new("UICorner")

mainCorner.CornerRadius =
	UDim.new(0,10)

mainCorner.Parent =
	main

--========================================================
-- TITLE
--========================================================

local title =
	Instance.new("TextLabel")

title.Size =
	UDim2.new(1,-55,0,40)

title.Position =
	UDim2.new(0,10,0,0)

title.BackgroundTransparency = 1

title.Text =
	"CDT RHYTHM STROBE"

title.TextColor3 =
	Color3.new(1,1,1)

title.TextSize = 16

title.Font =
	Enum.Font.GothamBold

title.TextXAlignment =
	Enum.TextXAlignment.Left

title.Active = true

title.Parent =
	main

makeDraggable(
	main,
	title
)

--========================================================
-- CLOSE
--========================================================

local closeButton =
	Instance.new("TextButton")

closeButton.Size =
	UDim2.new(0,32,0,32)

closeButton.Position =
	UDim2.new(1,-37,0,4)

closeButton.BackgroundColor3 =
	Color3.fromRGB(70,70,78)

closeButton.BorderSizePixel = 0

closeButton.Text = "×"

closeButton.TextColor3 =
	Color3.new(1,1,1)

closeButton.TextSize = 22

closeButton.Font =
	Enum.Font.GothamBold

closeButton.Parent =
	main

local closeCorner =
	Instance.new("UICorner")

closeCorner.CornerRadius =
	UDim.new(0,7)

closeCorner.Parent =
	closeButton

--========================================================
-- BUTTON CREATOR
--========================================================

local function createButton(text, y)

	local button =
		Instance.new("TextButton")

	button.Size =
		UDim2.new(1,-20,0,35)

	button.Position =
		UDim2.new(0,10,0,y)

	button.BackgroundColor3 =
		Color3.fromRGB(50,50,58)

	button.BorderSizePixel = 0

	button.Text = text

	button.TextColor3 =
		Color3.new(1,1,1)

	button.TextSize = 14

	button.Font =
		Enum.Font.Gotham

	button.Parent =
		main

	local corner =
		Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(0,7)

	corner.Parent =
		button

	return button

end

--========================================================
-- ON / OFF
--========================================================

local toggleButton =
	createButton(
		"STROBO : OFF",
		48
	)

toggleButton.MouseButton1Click:Connect(function()

	ENABLED =
		not ENABLED

	if ENABLED then

		toggleButton.Text =
			"STROBO : ON"

	else

		toggleButton.Text =
			"STROBO : OFF"

	end

end)

--========================================================
-- MOVE TARGET
--========================================================

local targetButton =
	createButton(
		"MOVE TARGET : FRONT",
		88
	)

targetButton.MouseButton1Click:Connect(function()

	if MoveTarget == "FRONT" then
		MoveTarget = "REAR"
	else
		MoveTarget = "FRONT"
	end

	targetButton.Text =
		"MOVE TARGET : "
		..MoveTarget

end)

--========================================================
-- MOVE LEFT
--========================================================

local leftButton =
	createButton(
		"← MOVE",
		128
	)

leftButton.TextSize = 18

--========================================================
-- MOVE RIGHT
--========================================================

local rightButton =
	createButton(
		"MOVE →",
		168
	)

rightButton.TextSize = 18

--========================================================
-- MOVE INFO
--========================================================

local moveLabel =
	Instance.new("TextLabel")

moveLabel.Size =
	UDim2.new(1,-20,0,25)

moveLabel.Position =
	UDim2.new(0,10,0,208)

moveLabel.BackgroundTransparency = 1

moveLabel.TextColor3 =
	Color3.fromRGB(190,190,190)

moveLabel.TextSize = 12

moveLabel.Font =
	Enum.Font.Gotham

moveLabel.TextXAlignment =
	Enum.TextXAlignment.Left

moveLabel.Parent =
	main

local function updateMoveText()

	moveLabel.Text =
		"FRONT: "
		..string.format(
			"%.1f",
			FrontMove
		)
		.."    REAR: "
		..string.format(
			"%.1f",
			RearMove
		)

end

leftButton.MouseButton1Click:Connect(function()

	if MoveTarget == "FRONT" then

		FrontMove -= MoveStep

	else

		RearMove -= MoveStep

	end

	updateMoveText()

end)

rightButton.MouseButton1Click:Connect(function()

	if MoveTarget == "FRONT" then

		FrontMove += MoveStep

	else

		RearMove += MoveStep

	end

	updateMoveText()

end)

updateMoveText()

--========================================================
-- SPEED
--========================================================

local speedLabel =
	Instance.new("TextLabel")

speedLabel.Size =
	UDim2.new(1,-20,0,25)

speedLabel.Position =
	UDim2.new(0,10,0,240)

speedLabel.BackgroundTransparency = 1

speedLabel.TextColor3 =
	Color3.new(1,1,1)

speedLabel.TextSize = 13

speedLabel.Font =
	Enum.Font.GothamBold

speedLabel.TextXAlignment =
	Enum.TextXAlignment.Left

speedLabel.Parent =
	main

local speedBar =
	Instance.new("Frame")

speedBar.Size =
	UDim2.new(1,-20,0,8)

speedBar.Position =
	UDim2.new(0,10,0,270)

speedBar.BackgroundColor3 =
	Color3.fromRGB(60,60,65)

speedBar.BorderSizePixel = 0

speedBar.Parent =
	main

local barCorner =
	Instance.new("UICorner")

barCorner.CornerRadius =
	UDim.new(1,0)

barCorner.Parent =
	speedBar

local speedFill =
	Instance.new("Frame")

speedFill.Size =
	UDim2.new(0.65,0,1,0)

speedFill.BackgroundColor3 =
	Color3.new(1,1,1)

speedFill.BorderSizePixel = 0

speedFill.Parent =
	speedBar

local fillCorner =
	Instance.new("UICorner")

fillCorner.CornerRadius =
	UDim.new(1,0)

fillCorner.Parent =
	speedFill

local speedKnob =
	Instance.new("TextButton")

speedKnob.Size =
	UDim2.new(0,18,0,18)

speedKnob.AnchorPoint =
	Vector2.new(0.5,0.5)

speedKnob.Position =
	UDim2.new(0.65,0,0.5,0)

speedKnob.BackgroundColor3 =
	Color3.new(1,1,1)

speedKnob.BorderSizePixel = 0

speedKnob.Text = ""

speedKnob.Parent =
	speedBar

local knobCorner =
	Instance.new("UICorner")

knobCorner.CornerRadius =
	UDim.new(1,0)

knobCorner.Parent =
	speedKnob

local MIN_SPEED = 0.025
local MAX_SPEED = 0.25

local function setSpeedFromX(x)

	local width =
		speedBar.AbsoluteSize.X

	if width <= 0 then
		return
	end

	local left =
		speedBar.AbsolutePosition.X

	local percent =
		math.clamp(
			(x-left)/width,
			0,
			1
		)

	StrobeSpeed =
		MAX_SPEED
		-
		(
			(MAX_SPEED-MIN_SPEED)
			*
			percent
		)

	-- Flash selalu lebih cepat
	FlashSpeed =
		math.max(
			0.012,
			StrobeSpeed * 0.35
		)

	speedFill.Size =
		UDim2.new(
			percent,
			0,
			1,
			0
		)

	speedKnob.Position =
		UDim2.new(
			percent,
			0,
			0.5,
			0
		)

	speedLabel.Text =
		string.format(
			"RHYTHM SPEED : %.3f",
			StrobeSpeed
		)

end

task.defer(function()

	setSpeedFromX(
		speedBar.AbsolutePosition.X
		+
		speedBar.AbsoluteSize.X
		*
		0.65
	)

end)

local speedDragging = false

speedKnob.MouseButton1Down:Connect(function()

	speedDragging = true

end)

speedBar.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		speedDragging = true

		setSpeedFromX(
			input.Position.X
		)

	end

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		speedDragging = false

	end

end)

UIS.InputChanged:Connect(function(input)

	if not speedDragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		setSpeedFromX(
			input.Position.X
		)

	end

end)

--========================================================
-- INFO
--========================================================

local info =
	Instance.new("TextLabel")

info.Size =
	UDim2.new(1,-20,0,135)

info.Position =
	UDim2.new(0,10,0,305)

info.BackgroundTransparency = 1

info.Text =
	"RHYTHM\n\n"
	.."AWAL\n"
	.."F → R → OFF\n\n"
	.."BEAT 1   FL + FR + RL\n"
	.."BEAT 2   FL + FR + FLASH\n"
	.."BEAT 3   RL + RR + FRONT\n"
	.."BEAT 4   F → R → F → R\n"
	.."BEAT 5   FL + FR + RL + RR + FLASH"

info.TextColor3 =
	Color3.fromRGB(150,150,150)

info.TextSize = 10

info.Font =
	Enum.Font.Gotham

info.TextXAlignment =
	Enum.TextXAlignment.Left

info.TextYAlignment =
	Enum.TextYAlignment.Top

info.Parent =
	main

--========================================================
-- OPEN / CLOSE
--========================================================

closeButton.MouseButton1Click:Connect(function()

	main.Visible = false
	openButton.Visible = true

end)

openButton.MouseButton1Click:Connect(function()

	main.Visible = true
	openButton.Visible = false

end)

--========================================================
-- LIGHT FOLDER
--========================================================

local lightFolder =
	Instance.new("Folder")

lightFolder.Name =
	"CDT_RhythmStrobeLights"

lightFolder.Parent =
	workspace

local lightParts = {}

local currentVehicle = nil
local currentRoot = nil

local lastAngularVelocity =
	Vector3.new(0,0,0)

--========================================================
-- CLEAR
--========================================================

local function clearLights()

	for _,data in ipairs(lightParts) do

		if data.Part then
			data.Part:Destroy()
		end

	end

	table.clear(lightParts)

	currentVehicle = nil
	currentRoot = nil

	lastAngularVelocity =
		Vector3.new(0,0,0)

end

--========================================================
-- GET VEHICLE SEAT
--========================================================

local function getVehicleSeat()

	local character =
		player.Character

	if not character then
		return nil
	end

	local humanoid =
		character:FindFirstChildOfClass(
			"Humanoid"
		)

	if not humanoid then
		return nil
	end

	local seat =
		humanoid.SeatPart

	if seat
		and (
			seat:IsA("VehicleSeat")
			or seat:IsA("Seat")
		) then

		return seat

	end

	return nil

end

--========================================================
-- GET VEHICLE MODEL
--========================================================

local function getVehicleModel(seat)

	return seat:FindFirstAncestorOfClass(
		"Model"
	)

end

--========================================================
-- GET ROOT
--========================================================

local function getRootPart(seat)

	local vehicle =
		getVehicleModel(seat)

	if not vehicle then
		return seat
	end

	if vehicle.PrimaryPart
		and vehicle.PrimaryPart:IsA("BasePart") then

		return vehicle.PrimaryPart

	end

	if seat.AssemblyRootPart
		and seat.AssemblyRootPart:IsA("BasePart") then

		return seat.AssemblyRootPart

	end

	local names = {

		"Chassis",
		"Main",
		"Body",
		"Base",
		"Frame",
		"VehicleBody",
		"DriveSeat"

	}

	for _,name in ipairs(names) do

		local part =
			vehicle:FindFirstChild(
				name,
				true
			)

		if part
			and part:IsA("BasePart") then

			return part

		end

	end

	return seat

end

--========================================================
-- CREATE LIGHT
--========================================================

local function createLight(
	root,
	name,
	offset,
	face,
	isFront,
	side
)

	local part =
		Instance.new("Part")

	part.Name =
		name.."_Visual"

	part.Size =
		Vector3.new(
			0.1,
			0.1,
			0.1
		)

	part.Transparency = 1

	part.Anchored = true

	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false

	part.CastShadow = false

	part.Parent =
		lightFolder

	--====================================================
	-- ATTACHMENT
	--====================================================

	local attachment =
		Instance.new("Attachment")

	attachment.Name =
		name.."_Attachment"

	attachment.Parent =
		part

	--====================================================
	-- SPOTLIGHT
	--====================================================

	local spot =
		Instance.new("SpotLight")

	spot.Name =
		name

	-- SEMUA PUTIH
	spot.Color =
		Color3.fromRGB(
			255,
			255,
			255
		)

	if isFront then

		spot.Brightness =
			FrontBrightness

		spot.Range =
			FrontRange

		spot.Angle =
			FrontAngle

	else

		spot.Brightness =
			RearBrightness

		spot.Range =
			RearRange

		spot.Angle =
			RearAngle

	end

	spot.Shadows = true

	spot.Face =
		face

	spot.Enabled = false

	spot.Parent =
		attachment

	table.insert(
		lightParts,
		{

			Part = part,

			Light = spot,

			Root = root,

			BaseOffset = offset,

			IsFront = isFront,

			Side = side,

			Name = name

		}
	)

end

--========================================================
-- SETUP VEHICLE
--========================================================

local function setupVehicle(seat)

	clearLights()

	local root =
		getRootPart(seat)

	if not root then
		return
	end

	currentRoot =
		root

	currentVehicle =
		getVehicleModel(seat)
		or seat

	--====================================================
	-- FRONT LEFT
	--====================================================

	createLight(

		root,

		"FrontWhiteLeft",

		Vector3.new(
			-SideOffset,
			HeightOffset,
			-FrontOffset
		),

		Enum.NormalId.Front,

		true,

		"LEFT"

	)

	--====================================================
	-- FRONT RIGHT
	--====================================================

	createLight(

		root,

		"FrontWhiteRight",

		Vector3.new(
			SideOffset,
			HeightOffset,
			-FrontOffset
		),

		Enum.NormalId.Front,

		true,

		"RIGHT"

	)

	--====================================================
	-- REAR LEFT
	--====================================================

	createLight(

		root,

		"RearWhiteLeft",

		Vector3.new(
			-SideOffset,
			HeightOffset,
			RearOffset
		),

		Enum.NormalId.Back,

		false,

		"LEFT"

	)

	--====================================================
	-- REAR RIGHT
	--====================================================

	createLight(

		root,

		"RearWhiteRight",

		Vector3.new(
			SideOffset,
			HeightOffset,
			RearOffset
		),

		Enum.NormalId.Back,

		false,

		"RIGHT"

	)

end

--========================================================
-- PREDICTED CFRAME
--========================================================

local function getPredictedRootCFrame(root)

	local currentCFrame =
		root.CFrame

	local velocity =
		root.AssemblyLinearVelocity

	local angularVelocity =
		root.AssemblyAngularVelocity

	local predictedPosition =
		root.Position
		+
		(
			velocity
			*
			PositionPrediction
			*
			VelocityInfluence
		)

	local predictedRotation =
		currentCFrame
		-
		currentCFrame.Position

	lastAngularVelocity =
		lastAngularVelocity:Lerp(
			angularVelocity,
			AngularSmoothing
		)

	local angularSpeed =
		lastAngularVelocity.Magnitude

	if angularSpeed > 0.0001 then

		local angle =
			angularSpeed
			*
			RotationPrediction

		local axis =
			lastAngularVelocity.Unit

		local rotationDelta =
			CFrame.fromAxisAngle(
				axis,
				angle
			)

		predictedRotation =
			rotationDelta
			*
			predictedRotation

	end

	return
		CFrame.new(
			predictedPosition
		)
		*
		predictedRotation

end

--========================================================
-- UPDATE LIGHT POSITION
--========================================================

local function updateLightPositions()

	if not currentRoot then
		return
	end

	if not currentRoot.Parent then
		clearLights()
		return
	end

	local predicted =
		getPredictedRootCFrame(
			currentRoot
		)

	for _,data in ipairs(lightParts) do

		local base =
			data.BaseOffset

		local move

		if data.IsFront then
			move = FrontMove
		else
			move = RearMove
		end

		local offset =
			Vector3.new(

				base.X + move,

				HeightOffset,

				base.Z

			)

		data.Part.CFrame =
			predicted
			*
			CFrame.new(
				offset
			)

	end

end

--========================================================
-- LIGHT CONTROL
--========================================================

local function allLightsOff()

	for _,data in ipairs(lightParts) do

		data.Light.Enabled = false

	end

end

local function setLights(names)

	allLightsOff()

	for _,wantedName in ipairs(names) do

		for _,data in ipairs(lightParts) do

			if data.Name == wantedName then

				data.Light.Enabled = true

			end

		end

	end

end

local function flashAll()

	for _,data in ipairs(lightParts) do
		data.Light.Enabled = true
	end

	task.wait(FlashSpeed)

	allLightsOff()

end

--========================================================
-- VEHICLE DETECTION
--========================================================

task.spawn(function()

	while true do

		local seat =
			getVehicleSeat()

		if seat then

			local vehicle =
				getVehicleModel(seat)
				or seat

			if vehicle ~= currentVehicle then

				setupVehicle(
					seat
				)

			else

				local root =
					getRootPart(seat)

				if root
					and root ~= currentRoot then

					setupVehicle(
						seat
					)

				end

			end

		end

		task.wait(0.15)

	end

end)

--========================================================
-- RHYTHM ENGINE
--========================================================
--
-- AWAL
-- F
-- R
-- OFF
--
-- BEAT 1
-- FL + FR
-- RL
-- OFF
--
-- BEAT 2
-- FL + FR
-- FLASH
-- OFF
--
-- BEAT 3
-- RL + RR
-- FRONT
-- OFF
--
-- BEAT 4
-- FRONT
-- REAR
-- FRONT
-- REAR
-- OFF
--
-- BEAT 5
-- FL + FR
-- RL + RR
-- FLASH
-- OFF
--========================================================

task.spawn(function()

	while true do

		if not ENABLED
			or not currentRoot
			or not currentRoot.Parent
			or #lightParts < 4 then

			allLightsOff()

			task.wait(0.05)

			continue

		end

		--================================================
		-- AWAL
		--================================================

		-- Lampu depan menyala
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Lampu belakang menyala
		-- Depan masih menyala
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight",
			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Lampu depan mati
		setLights({

			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Lampu belakang mati
		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- BEAT 1
		--================================================

		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight",
			"RearWhiteLeft"

		})

		task.wait(
			StrobeSpeed
		)

		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- BEAT 2
		--================================================

		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Flash cepat
		for i = 1,2 do

			for _,data in ipairs(lightParts) do
				data.Light.Enabled = true
			end

			task.wait(
				FlashSpeed
			)

			allLightsOff()

			task.wait(
				FlashSpeed
			)

		end

		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- BEAT 3
		--================================================

		setLights({

			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Lampu depan menyala
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight",
			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- BEAT 4
		--================================================

		-- Front
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		-- Rear
		setLights({

			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		-- Front mati
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		-- Rear
		setLights({

			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		-- Front lagi
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		-- Front + Rear
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight",
			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			FlashSpeed
		)

		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- BEAT 5
		--================================================

		-- Front kiri + kanan
		setLights({

			"FrontWhiteLeft",
			"FrontWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Belakang kiri + kanan
		setLights({

			"RearWhiteLeft",
			"RearWhiteRight"

		})

		task.wait(
			StrobeSpeed
		)

		-- Semua / flash
		for i = 1,2 do

			for _,data in ipairs(lightParts) do
				data.Light.Enabled = true
			end

			task.wait(
				FlashSpeed
			)

			allLightsOff()

			task.wait(
				FlashSpeed
			)

		end

		allLightsOff()

		task.wait(
			StrobeSpeed
		)

		--================================================
		-- KEMBALI KE AWAL
		--================================================

	end

end)

--========================================================
-- RENDER UPDATE
--========================================================

RunService.RenderStepped:Connect(function()

	if currentRoot
		and currentRoot.Parent then

		updateLightPositions()

	end

end)

--========================================================
-- CHARACTER RESPAWN
--========================================================

player.CharacterAdded:Connect(function()

	task.wait(1)

	-- Sengaja tidak clear light.
	-- Sistem akan mendeteksi kendaraan baru
	-- saat player masuk kembali.

end)

--========================================================
-- END
--========================================================
