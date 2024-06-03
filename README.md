# RankQuests
A Pet Simulator 99 macro for Windows.

## Functionality
This macro is specifically tailored for World 2 and assumes that all zones within World 2 are unlocked. It automates the completion of various quests, including:

- Use Fruits
- Use Flags
- Use Tier 3 Potions
- Use Tier 4 Potions
- Use Tier 5 Potions
- Break Breakables in the Best Area
- Break Comets in the Best Area
- Break Lucky Blocks in the Best Area
- Break Basic Coin Jars in the Best Area
- Break Mini-Chests in the Best Area
- Break Pinatas in the Best Area
- Break Diamond Breakables
- Earn Diamonds
- Hatch Rare Pets
- Hatch the Best Egg
- Make Golden Pets from the Best Egg
- Make Rainbow Pets from the Best Egg
- Collect Potions
- Collect Enchants

Please note: This macro modifies your Roblox font (please refer to the instructions for first-time use).

## Requirements

### AutoHotKey
1. Get AutoHotKey 2.0 from https://www.autohotkey.com/ and install it.

### Macro
1. Download the macro's zip file.
2. Unzip the downloaded file.
3. Remove the zip file after extraction.

### Computer Settings
1. Ensure Display Resolution is set to 1920x1080 (Windows Key + I, Home, Display).
2. Set Scale to 100% (Windows Key + I, Home, Display).
3. Ensure Windows Taskbar is visible (i.e., "Automatically hide the taskbar" must be disabled) (Windows Key + I, Personalization, Taskbar).
4. Make sure you are using a QWERTY keyboard layout.

### Roblox Configuration
1. Set Camera Mode to Classic (Escape Key, Settings).
2. Set Movement Mode to Default (Keyboard) (Escape Key, Settings).
3. Set Action Mode to Priority (Settings icon, Action Menu).
4. Set Vibrations to Off (Settings icon, Action Menu) - prevents Massive Comet drops from disrupting the camera.

### Pet Sim 99 Requirements
1. Ensure Zone 209 is unlocked.

### Quests (Essential Items)
- [ ] Basic Coin Jars                 - "Break Basic Coin Jars in the Best Area" quest.
- [ ] Comets                          - "Break Comets in the Best Area" quest.
- [ ] Lucky Blocks                    - "Break Lucky Blocks in the Best Area" quest.
- [ ] Pinatas                         - "Break Pinatas in the Best Area" quest.
- [ ] Fruit                           - "Use Fruits" quest.
- [ ] Standard Best Pets              - "Making Golden Pets from the Best Egg" quest.
- [ ] Golden Best Pets                - "Making Rainbow Pets from the Best Egg" quest.
- [ ] Flags (user choice)             - "Use Flags" quest (update QuestFlag in settings).
- [ ] Tier 3 Potions (user choice)    - "Use Tier 3 Potions" (Tier3Potion in settings).
- [ ] Tier 4 Potions (user choice)    - "Use Tier 4 Potions" (Tier4Potion in settings).
- [ ] Tier 5 Potions (user choice)    - "Use Tier 5 Potions" (Tier5Potion in settings).
- [ ] Potions (user choice)           - "Collect Potions" quest (PotionToUpgrade in settings).
- [ ] Enchants (user choice)          - "Collect Enchants" quest (EnchantToUpgrade in settings).

Notes:
- If you run out of resources, quests may become stuck (e.g., transforming all pets into golden pets).
- Due to latency or poor OCR performance, there is a risk of unintentionally upgrading all pets, potions, or enchants at once when crafting. It's advised to store any excess pets or items in a box as a precaution.
- If you have pets in your inventory that are stronger than the pets hatched from the best egg, put them in a box.

### Quests (Recommended Items)
- [ ] Chest Mimic                     - "Break Mini-Chests in the Best Area"
- [ ] Diamond Chest Mimic             - "Break Mini-Chests in the Best Area"
- [ ] Chest Spell Ultimate            - "Break Mini-Chests in the Best Area"
- [ ] Superior Chest Mimic            - "Break Superior Mini-Chests in Best Area"
- [ ] Fruity Enchant                  - "Use Fruits"
- [ ] VIP Gamepass                    - "Break Diamond Breakables"

## Using the Macro

### Set Up the Macro
1. Navigate to the folder where you extracted the zip file.
2. Open the Settings sub-folder.
3. Open the Settings.ini file in Notepad.
4. Update the Settings.ini file with your preferences.

### Load the Macro
1. Navigate to the folder where you extracted the zip file.
2. Double-click the AHK file. This will initiate the macro and automatically open the graphical user interface (GUI).

### First-time Use
1. Launch PS99.
2. Start the macro (this will alter your fonts, which will only take effect after restarting Roblox).
3. Close the Roblox client.
4. Restart Roblox/PS99.
5. Restart the macro.
Note: Your font will retain the new fonts until you click the "Default Font" button and restart Roblox.

### Regular Use
1. Launch PS99.
2. Navigate to World 2.
3. Activate the macro.
Note: Avoid adjusting the camera!
Note: Do not turn off your screen!

### Hot Keys
• Press F5 to exit the macro.
• Press F8 to pause the macro.
Note: These shortcuts are configurable in settings.

### Interface (GUI)
• Pause (Button): Pauses the macro.
• Help (Button): Displays this help file.
• Refresh (Button): Manually refreshes the quest list.
• Reconnect (Button): Initiates a reconnection.
• Default Font (Button): Reinstates the default Roblox font (requires changing worlds or restarting Roblox to take effect).

### User Configuration (Basic)
• Review the "Settings\Settings.ini" file and adjust it to match your game settings and preferences.

### User Configuration (Advanced)
• Review the "Lib\Quests.ahk" file to modify individual quest priorities (a priority of 0 disables a quest).
• Review the "Lib\Coords.ahk" file to adjust coordinate locations for PS99 controls.
• Review the "Lib\Movement.ahk" file to change movement to different areas (e.g., VIP, best egg).
• Review the "Lib\Delays.ahk" file to modify delay times between different in-game actions (e.g., after closing the Inventory menu).

## Known Issues

### Supercomputer!
Known Issue: When performing automated conversions with calculated angles under 10°, the macro initiates at a 2.5° angle and increments as needed. However, there is an issue where 2.5° selections are occasionally misinterpreted as approximately 90°, resulting in significantly more pets being converted than required.
