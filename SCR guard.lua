local vim = game:GetService('VirtualInputManager')
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
while true do
    input.press(Enum.KeyCode.E)
    task.wait(0.1)
    input.press(Enum.KeyCode.T)
    task.wait(0.1)
    input.press(Enum.KeyCode.Y)
    task.wait(0.1)
    input.press(Enum.KeyCode.Q)
    task.wait(0.1)
    input.press(Enum.KeyCode.R)
    task.wait(0.1)
end