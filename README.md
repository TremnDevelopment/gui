# CustomGUI

A lightweight, dependency-free Roblox Lua GUI library for building settings-style menus with toggles, sliders, dropdowns, buttons, sections, and toast notifications.

![type](https://img.shields.io/badge/type-Roblox%20Lua-blue) ![status](https://img.shields.io/badge/status-stable-brightgreen)

---

## Features

- 🪟 Draggable window with minimize / close buttons
- 📂 Collapsible sections to organize related controls
- 🔘 Toggles (on/off switches)
- 🎚️ Sliders with live value display
- 🔽 Dropdown menus
- 🖱️ Buttons
- 🔔 Toast notifications (Info / Success / Warning / Error)
- ⌨️ `RightShift` hotkey to show/hide the whole GUI
- 🎨 Single `Theme` table to reskin colors in one place
- 📦 No external dependencies — pure Lua/Roblox API

---

## Installation

1. Copy `CustomGUI.lua` into a **ModuleScript** in `ReplicatedStorage`, and name it `CustomGUI`.
2. In a **LocalScript** (e.g. under `StarterPlayerScripts`), require it:

```lua
local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("CustomGUI"))
```

3. Build your window (see [Quick Start](#quick-start) below).

> You can also just paste the whole library directly at the top of a single LocalScript if you don't want to use a separate ModuleScript — it works either way since it just `return`s a table.

---

## Quick Start

```lua
local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("CustomGUI"))

local Window = Library:CreateWindow({
    Title = "My Script Hub",
    Subtitle = "v1.0 — press RightShift to hide/show",
})

local Section = Window:CreateSection("Features")

Section:AddToggle("Feature One", false, function(state)
    print("Feature One:", state)
end)

Section:AddButton("Run Action", function()
    Window:Notify({
        Title = "Done",
        Text = "Action ran successfully.",
        Type = "Success",
    })
end)
```

See `Example_Usage.lua` for a full working example with every element type.

---

## API Reference

### `Library:CreateWindow(config)`

Creates the main window and returns a `Window` object.

| Field      | Type   | Default | Description                       |
|------------|--------|---------|------------------------------------|
| `Title`    | string | `"Settings"` | Text shown in the top bar     |
| `Subtitle` | string | `""`    | Optional smaller text under the title |

```lua
local Window = Library:CreateWindow({
    Title = "My Script Hub",
    Subtitle = "v1.0",
})
```

---

### `Window:CreateSection(name)`

Creates a labeled section (a rounded panel) inside the window and returns a `Section` object that you add controls to.

```lua
local Section = Window:CreateSection("Features")
```

You can create as many sections as you like — the window scrolls automatically if content overflows.

---

### `Section:AddToggle(text, default, callback)`

Adds an on/off switch.

| Param      | Type     | Description                              |
|------------|----------|-------------------------------------------|
| `text`     | string   | Label shown next to the toggle           |
| `default`  | boolean  | Initial state                            |
| `callback` | function | `function(state: boolean) ... end`       |

Returns a handle: `{ Set(value), Get() }`.

```lua
local myToggle = Section:AddToggle("Feature One", false, function(state)
    print("Feature One:", state)
end)

myToggle:Set(true)   -- programmatically turn it on
print(myToggle:Get()) -- read current state
```

> ⚠️ If `default` is `true`, the callback fires once immediately when the toggle is created.

---

### `Section:AddSlider(text, min, max, default, callback)`

Adds a draggable slider with a live numeric readout.

| Param      | Type     | Description                         |
|------------|----------|---------------------------------------|
| `text`     | string   | Label shown above the slider         |
| `min`      | number   | Minimum value                        |
| `max`      | number   | Maximum value                        |
| `default`  | number   | Initial value                        |
| `callback` | function | `function(value: number) ... end`    |

Returns a handle: `{ Set(value), Get() }`.

```lua
Section:AddSlider("Speed", 0, 100, 20, function(value)
    print("Speed:", value)
end)
```

---

### `Section:AddDropdown(text, options, default, callback)`

Adds a click-to-expand dropdown list.

| Param      | Type     | Description                                |
|------------|----------|----------------------------------------------|
| `text`     | string   | Label shown above the dropdown              |
| `options`  | table    | Array of strings, e.g. `{"A", "B", "C"}`    |
| `default`  | string   | Initially selected option                   |
| `callback` | function | `function(selected: string) ... end`        |

Returns a handle: `{ Set(value), Get() }`.

```lua
Section:AddDropdown("Mode", { "Option A", "Option B" }, "Option A", function(selected)
    print("Mode:", selected)
end)
```

---

### `Section:AddButton(text, callback)`

Adds a clickable button.

```lua
Section:AddButton("Run Action", function()
    print("Button pressed!")
end)
```

---

### `Window:Notify(options)`

Shows a toast notification in the top-right corner that auto-dismisses.

**Table form:**

```lua
Window:Notify({
    Title = "Saved",
    Text = "Your settings have been saved.",
    Duration = 4,      -- seconds, default 4
    Type = "Success",  -- "Info" | "Success" | "Warning" | "Error", default "Info"
})
```

**Shorthand form:**

```lua
Window:Notify("Saved", "Your settings have been saved.", 4)
```

Notification types are color-coded:

| Type      | Color            |
|-----------|------------------|
| `Info`    | Blue (accent)    |
| `Success` | Green            |
| `Warning` | Yellow           |
| `Error`   | Red              |

Multiple notifications stack vertically and dismiss independently.

---

## Hotkeys

| Key          | Action                        |
|--------------|--------------------------------|
| `RightShift` | Show / hide the entire window |

To change the hotkey, edit this block near the bottom of `CreateWindow`:

```lua
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
```

---

## Theming

All colors live in one `Theme` table near the top of `CustomGUI.lua`:

```lua
local Theme = {
    Background   = Color3.fromRGB(24, 24, 28),
    Section      = Color3.fromRGB(32, 32, 38),
    Accent       = Color3.fromRGB(90, 120, 255),
    Text         = Color3.fromRGB(235, 235, 240),
    SubText      = Color3.fromRGB(160, 160, 170),
    ToggleOff    = Color3.fromRGB(55, 55, 62),
    Stroke       = Color3.fromRGB(50, 50, 58),
}
```

Change any value here to reskin every element in the library at once.

---

## File Structure

```
CustomGUI.lua        -- the library (ModuleScript)
Example_Usage.lua     -- example LocalScript showing every feature
README.md             -- this file
```

---

## Notes

- Re-running the script (e.g. during testing) automatically destroys any previous instance of the GUI, so you won't get duplicates.
- All elements return `Set`/`Get` handles so you can control the UI from your own code (e.g. loading saved settings on startup).
- This library only builds the **UI shell** — you're expected to plug your own logic into each callback function.
