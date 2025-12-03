-- Made by PlaceReporter99
-- https://github.com/PlaceReporter99

-- You may want to change these constants depending on your train.

-- The maximum speed of your train.
local MAXSPEED = 100

-- The speed the train should slow down to when getting close to the station.
local SAFESTOPSPEED = 40

-- The distance in miles from the station your train should reach before slowing down.
local SAFESTOPDISTANCE = 0.35















local cs = Instance.new("BindableEvent")
cs.Name = "ChangeSpeed"
status = {
    ["full"] = 2,
    ["slow"] = 1,
    ["stop"] = 0
}
signalv = {
    ["proceed"] = 0,
    ["precaution"] = 1,
    ["caution"] = 2,
    ["danger"] = 3,
    ["unknown"] = 4
}
cs.Event:Connect(function(a)
    if a == status.full then
        target(MAXSPEED)
    elseif a == status.slow then
        target(SAFESTOPSPEED)
    elseif a == status.stop then
        target(0)
    else
        target(a)
    end
end)

local fex = Instance.new("BindableEvent")
fex.Name = "ExecuteFunction"
fex.Event:Connect(function(f) f() end)
local vim = game:GetService('VirtualInputManager')
local vu = game:GetService('VirtualUser')
input = {
    hold = function(key, time)
        print("Holding key", key)
        vim:SendKeyEvent(true, key, false, nil)
        task.wait(time)
        vim:SendKeyEvent(false, key, false, nil)
        print("Finished holding key", key)
    end,
    press = function(key)
        print("Pressing key", key)
        vim:SendKeyEvent(true, key, false, nil)
	    task.wait(0.005)
        vim:SendKeyEvent(false, key, false, nil)
    end,
    start = function(key)
        print("starting key", key)
        vim:SendKeyEvent(true, key, false, nil)
    end,
    stop = function(key)
        print("stopping key", key)
        vim:SendKeyEvent(false, key, false, nil)
    end
}
function clickButton(button)
    button.Selected = true
    input.press(Enum.KeyCode.Return)
end
local drive = game.Players.LocalPlayer.PlayerGui.DriveGui
local left = drive.Additional.DetailsStack.AdvanceContainer.Main.ScheduleDetails.Counters
local cluster = drive.Cluster
local arm = cluster.Spedometer.TargetIndicator
local buttons = cluster.Actions
local d = left.Distance
local ti = left.DepartTime
local odm = cluster.Activity.ActivityMessage
local nl = drive.Summary.SummaryPage.Controls.NextLeg
local aws = cluster.AwsIndicatorMinimal
local signal = drive.Additional.DetailsStack.AdvanceContainer.Signal.Standard
local signald = drive.Additional.DetailsStack.AdvanceContainer.Signal.Distance

function getSignal()
    if signal.Danger.BackgroundTransparency == 0 then
        print("signal get danger")
        return signalv.danger
    end
    if signal.Precaution.BackgroundTransparency == 0 then
        print("signal get precaution")
        return signalv.precaution
    end
    if signal.Caution.BackgroundTransparency == 0 then
        print("signal get caution")
        return signalv.caution
    end
    if signal.Proceed.BackgroundTransparency == 0 then
        print("signal get proceed")
        return signalv.proceed
    end
    print("signal get unknown")
    return signalv.unknown
end

function getSignalDistance()
    return tonumber(signald.Text:sub(1, -4))
end

local mode = nil

speed_angle = function(speed) return speed*1.2 - 31 end

function target(speed)
    input.stop(Enum.KeyCode.W)
    input.stop(Enum.KeyCode.S)
    print("targeting speed", speed)
    print("rotation data this", speed_angle(speed), "that", arm.Rotation)
    if -0.5 <= speed_angle(speed) - arm.Rotation and speed_angle(speed) - arm.Rotation <= 0.5 then
        -- it's fine, do nothing 
        print("speed did not change", speed)
    elseif speed_angle(speed) < arm.Rotation then
        print("speed decrease to", speed)
        input.start(Enum.KeyCode.S)
        while speed_angle(speed) < arm.Rotation do
            task.wait(0.005)
        end
        input.stop(Enum.KeyCode.S)
    elseif speed_angle(speed) > arm.Rotation then
        print("speed increase to", speed)
        input.start(Enum.KeyCode.W)
        while speed_angle(speed) > arm.Rotation do
            task.wait(0.005)
        end
        input.stop(Enum.KeyCode.W)
    end
end
drive.Clock.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
input.press(Enum.KeyCode.T)
input.press(Enum.KeyCode.Q)
if arm.Rotation == speed_angle(0) and tonumber(d.Text:sub(1, -4)) ~= 0 and getSignal() ~= signalv.danger then
    task.wait(10)
    if arm.Rotation == speed_angle(0) and tonumber(d.Text:sub(1, -4)) ~= 0 and getSignal() ~= signalv.danger then
        mode = false
        cs:Fire(status.slow)
    end
end
--clickButton(nl)
end)
local c;
print(d.Text)
cs:Fire(status.full)
mode = true
function b()
    local num = tonumber(d.Text:sub(1, -4))
    print(num)
    if num == 0 or (getSignal() == signalv.danger and d >= getSignalDistance()) then
        cs:Fire(status.stop)
        if num == 0 then
            task.wait(15)
            if tonumber(d.Text:sub(1, -4)) == 0 then
                while not (odm.Text:match("Loading") or odm.Text:match("Awaiting")) and tonumber(d.Text:sub(1, -4)) == 0 do
                    cs:fire(5)
                    task.wait(3)
                    cs:fire(status.stop)
                    task.wait(6)
                end
            end
        end
    elseif (num <= SAFESTOPDISTANCE or getSignal() == signalv.caution) and mode then
        mode = false
        cs:Fire(status.slow)
    elseif not mode and (num > SAFESTOPDISTANCE and (getSignal() == signalv.precaution or getSignal() == signalv.proceed)) then
        mode = true
        cs:Fire(status.full)
    end
end
if (tonumber(d.Text:sub(1, -4)) <= SAFESTOPDISTANCE or getSignal() == signalv.caution) then
    cs:Fire(status.slow)
else
    cs:Fire(status.full)
end
d:GetPropertyChangedSignal("Text"):Connect(b)
signald:GetPropertyChangedSignal("Text"):Connect(b)
print(getSignal())