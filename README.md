# Rank Quests
A Pet Simulator 99 macro for Windows.

## Functionality
This macro automates the completion of various quests, covering tasks such as resource collection, potion usage, item usage, breaking various objects, and making and hatching pets.

## 🛠️ Installation

### AutoHotKey
1. Get AutoHotKey 2.0 from https://www.autohotkey.com/ and install it.

### Macro
1. Download the macro's zip file.
2. Unzip the downloaded file.
3. Remove the zip file after extraction.

## 🖥️ System Requirements

### 1. Computer Configuration
| Setting | Requirement | How To Change |
| --- | --- | --- |
| Display Resolution | 1920x1080 | <kbd>Windows</kbd> + <kbd>I</kbd> > `Home` > `Display` |
| Scale | 100% | <kbd>Windows</kbd> + <kbd>I</kbd> > `Home` > `Display` |
|  |  |
|  |  |
|  |  |


1. Ensure Display Resolution is set to 1920x1080 - <kbd>Windows</kbd> + <kbd>I</kbd>, `Home`, `Display`
2. Set Scale to 100% - <kbd>Windows</kbd> + <kbd>I</kbd>, `Home`, `Display`
3. Ensure Windows Taskbar is visible (i.e., "Automatically hide the taskbar" must be disabled) - <kbd>Windows</kbd> + <kbd>I</kbd>, `Personalization`, `Taskbar`
4. Make sure you are using a QWERTY keyboard layout.
5. Ensure the Windows default language is English.

### 2. Roblox Configuration
1. Set Camera Mode to Classic - <kbd>Escape Key</kbd>, `Settings`
2. Set Movement Mode to Default - <kbd>Escape Key</kbd>, `Settings`
3. Set Action Mode to Priority - `Settings icon`, `Action Menu`
4. Set Vibrations to Off (prevents Massive Comet drops from disrupting the camera) - `Settings icon`, `Action Menu`

### 3. Pet Simulator 99 
1. Ensure all zones are unlocked.

## 🍎 Item Requirements

### 1. Items Required
The following items are essential for the macro to rank up your character.
| Item | Quest |
| --- | --- |
| Basic Coin Jars | Break Basic Coin Jars in the Best Area |
| Comets | Break Comets in the Best Area |
| Lucky Blocks | Break Lucky Blocks in the Best Area |
| Pinatas | Break Pinatas in the Best Area |
| Fruit | Use Fruits |
| Standard Best Pets | Make Golden Pets from the Best Egg |
| Golden Best Pets | Make Rainbow Pets from the Best Egg |
| Flags[^1] | Use Flags |
| Tier 3 Potions[^1] | Use Tier 3 Potions |
| Tier 4 Potions[^1] | Use Tier 4 Potions |
| Tier 5 Potions[^1] | Use Tier 5 Potions |
| Potions[^1] | Collect Potions |
| Enchants[^1] | Collect Enchants |

[^1]: This is a user choice defined in the `Settings.ini` file.

> [!IMPORTANT]
> If you run out of resources, quests may become stuck (e.g., transforming all pets into golden pets).

> [!WARNING]
> Due to latency or poor OCR performance, there is a risk of unintentionally upgrading all pets, potions, or enchants at once when crafting. It's advised to store any excess pets or items in a box as a precaution.

> [!TIP]
> If you have pets in your inventory that are stronger than the pets hatched from the best egg, put them in a box.

### 2. Items Recommended
The following items are recommended for the macro to rank up your character more efficiently.
| Item | Quest |
| --- | --- |
| Chest Mimic | Break Mini-Chests in the Best Area |
| Diamond Chest Mimic | Break Mini-Chests in the Best Area |
| Chest Spell Ultimate | Break Mini-Chests in the Best Area |
| Superior Chest Mimic | Break Superior Mini-Chests in Best Area |
| Fruity Enchant | Use Fruits |
| VIP Gamepass | Break Diamond Breakables |

## ▶️ Using the Macro

### Setting Up the Macro
1. Navigate to the folder where you extracted the zip file.
2. Open the `Settings` sub-folder.
3. Open the `Settings.ini` file in Notepad.
4. Update the `Settings.ini` file with your preferences.

### Loading the Macro
1. Navigate to the folder where you extracted the zip file.
2. Double-click the `Rank Quest.ahk` file. This will initiate the macro and display the user interface.

### First-time Use
1. Launch PS99.
2. Start the macro (this will alter your fonts, which will only take effect after restarting Roblox).
3. Close the Roblox client.
4. Restart Roblox/PS99.
5. Restart the macro.

> [!NOTE]  
> This macro changes your Roblox font to Times New Roman to improve OCR results. The new font will remain in your Roblox client until you click the `Default Font` button and restart Roblox.

### Regular Use
1. Launch Pet Simulator 99.
2. Navigate to the last world.
3. Load the macro.

> [!NOTE]  
> Do not rotate the camera. It can be zoomed in and out but any rotation will cause any movement to certain areas to fail.

## Hot Keys
- Press <kbd>F5</kbd> to exit the macro.
- Press <kbd>F8</kbd> to pause the macro.

> [!NOTE]  
>  These shortcuts are configurable in settings.

## 🗔 User Interface
| Control | Type | Description |
| --- | --- | --- |
| Pause | Button | Pauses the macro |
| Help | Button | Displays the README.txt file |
| Refresh | Button | Manually refreshes the quest list |
| Reconnect | Button | Initiates a reconnection |
| Default Font | Button | Reinstates the default Roblox font (requires changing worlds or restarting Roblox to take effect) |

## ⚙️ User Configuration

### 1. Basic Configuration
Basic configuration is completed in the `Settings\Settings.ini` file. Any changes made to this file take effect immediately.

### 2. Advanced Configuration
Advanced configuration is completed using the following `ahk` files. The macro must be restarted for any of these changes to take effect.
| File | Description |
| --- | --- |
| `Lib\Quests.ahk` | Contains individual quest priorities (a priority of 0 disables a quest). |
| `Lib\Movement.ahk` | Contains paths to different areas (e.g., VIP, best egg). |
| `Lib\Coords.ahk` | Contains coordinate locations for PS99 controls. |
| `Lib\Delays.ahk` | Contains delay times between different in-game actions (e.g., after closing the Inventory menu). |

## ⚠️ Known Issues

### Supercomputer!
> [!IMPORTANT]
> When performing automated conversions with calculated angles under 10°, the macro initiates at a 2.5° angle and increments as needed. However, there is an issue where 2.5° selections are occasionally misinterpreted as approximately 90°, resulting in significantly more pets being converted than required.
