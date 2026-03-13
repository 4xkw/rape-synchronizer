# Synchronizer Channel Rape

A research tool for reading Synchronizer channel data in Steal a Brainrot without triggering server-side anticheat kicks.

Source: for research and educational purposes only.

## Features

- Reads AnimalList from all active plot channels via Synchronizer
- Bypasses debug.info source checks used by the anticheat
- Blocks the detection FireServer without triggering kick
- Compatible with executors that support standard UNC functions

## Anticheat Bypass Methods

### debug.info Source Spoofing
The synchronizer uses `debug.info(3, "s")` to check the call stack source. If the source returns `"[C]"` or a string without a dot, it flags the caller as an executor and schedules a delayed kick via `FireServer`. The bypass hooks `debug.info` and returns `"LocalScript"` for levels 2 and 3, making the anticheat believe the call originated from a legitimate game script.

### __namecall Interception via Raw Metatable
Instead of using `hookmetamethod` which is detected by the game, the bypass accesses the raw metatable of `game` directly via `getrawmetatable`, sets it writable with `setreadonly`, replaces `__namecall` using `rawset`, then restores readonly. This silently blocks the detection `FireServer` on `RE/InventoryService/Sort` without touching the remote itself or using any executor-specific hook APIs.

### unlockmodulescript
The Synchronizer module runs at a higher security context than executor scripts. `unlockmodulescript` aligns the context so `require` returns the real module table instead of an error or empty result.

## Usage

Run the script after joining. The `task.wait(3)` allows channels to populate before reading. Output is printed to console in the format:

```
plotName  slot  animalIndex  mutation
```

## Requirements

- Executor with support for: `getrawmetatable`, `setreadonly`, `rawset`, `hookfunction`, `newcclosure`, `clonefunction`, `unlockmodulescript`
- Game: Steal a Brainrot
