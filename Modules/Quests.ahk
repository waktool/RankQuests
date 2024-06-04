#Requires AutoHotkey v2.0

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST CONFIGURATION FILE
; ----------------------------------------------------------------------------------------
; This document encompasses comprehensive information for every quest. Each quest is
; defined by the following attributes:
;   • ID: Unique identifier for the quest.
;   • Name: The designated name of the quest.
;   • Regex: Regular expression utilized for quest identification.
;   • Status: Automation status categorized as either Auto or Manual.
;   • Zone: The specific zone where the quest must be accomplished.
;   • Priority: Level of importance determining the quest's actioning sequence.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

global QUEST_PRIORITY := Map()
QUEST_PRIORITY.Default := 0


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST PRIORITIES
; ----------------------------------------------------------------------------------------
; Modify the settings below to change how quests are prioritized and executed.  Quests are
; initially sorted and executed based on their priority. If multiple quests share the same
; priority, they are then sorted and executed according to their star level, with higher
; star levels being prioritized.
; * Note: Setting the priority to 0 will cause the macro to skip the quest.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

QUEST_PRIORITY["9"] := 20  ; "Break Diamond Breakables"
QUEST_PRIORITY["14"] := 25  ; "Collect Potions"
QUEST_PRIORITY["15"] := 25  ; "Collect Enchants"
QUEST_PRIORITY["20"] := 20  ; "Hatch Best Egg"
QUEST_PRIORITY["21"] := 5  ; "Break Breakables in Best Area"
QUEST_PRIORITY["31"] := 20  ; "Break Coin Jars"
QUEST_PRIORITY["33"] := 30  ; "Use Flags"
QUEST_PRIORITY["34-1"] := 30  ; "Use Tier 3 Potions"
QUEST_PRIORITY["34-2"] := 30  ; "Use Tier 4 Potions"
QUEST_PRIORITY["34-3"] := 30  ; "Use Tier 5 Potions"
QUEST_PRIORITY["35"] := 5  ; "Eat Fruits"
QUEST_PRIORITY["37"] := 20  ; "Break Coin Jars in Best Area"
QUEST_PRIORITY["38"] := 20  ; "Break Comets in Best Area"
QUEST_PRIORITY["39"] := 1  ; "Break Mini-Chests in Best Area"
QUEST_PRIORITY["40"] := 30  ; "Make Golden Pets from Best Egg"
QUEST_PRIORITY["41"] := 25  ; "Make Rainbow Pets from Best Egg"
QUEST_PRIORITY["42"] := 20  ; "Hatch Rare Pets"
QUEST_PRIORITY["43"] := 20  ; "Break Pinatas in the Best Area"
QUEST_PRIORITY["44"] := 20  ; "Break Lucky Blocks in the Best Area"
QUEST_PRIORITY["66"] := 1  ; "Break Superior Mini-Chests in Best Area"


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST PRIORITY OVERRIDES
; ----------------------------------------------------------------------------------------
; The quest overrides below are utilized by the macro and should not be altered by the
; user.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Update the priority if the player does not have VIP.
if (getSetting("HasGamepassVip") == "false")
    QUEST_PRIORITY["9"] := 0  ; "Break Diamond Breakables"

; Update the priority if the player has Super Drops.
if (getSetting("HasGamepassSuperDrops") == "true") {
    QUEST_PRIORITY["14"] := 0  ; "Collect Potions"
    QUEST_PRIORITY["15"] := 0  ; "Collect Enchants"
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST PROPERTIES
; ----------------------------------------------------------------------------------------
; The quest properties listed below are utilized by the macro and should not be altered by
; the user.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

global QUEST_DATA := Map()  ; Initialize a Map object to hold various quest properties.
QUEST_DATA.Default := Map("Name", "?", "Regex", "", "Status", "Manual", "Zone", "-") ; Set default values for a quest, used when no specific quest is defined.

QUEST_DATA["1"] := Map("Name", "Break Breakables", "Regex", "i)break(?!.*diamond).*breakable(?!.*best)", "Status", "Manual", "Zone", "-")
QUEST_DATA["2"] := Map("Name", "Hatch Pets", "Regex", "i)hatch(?!.*rare)(?!.*rainb)(?!.*gold)(?!.*ind)(?!.*fuse).*pet", "Status", "Manual", "Zone", "-")
QUEST_DATA["3"] := Map("Name", "Hatch Eggs", "Regex", "i)hatch(?!.*best).*egg", "Status", "Manual", "Zone", "Best")
QUEST_DATA["4"] := Map("Name", "Make Golden Pets", "Regex", "i)golden(?!.*best)", "Status", "Manual", "Zone", "Void")
QUEST_DATA["5"] := Map("Name", "Make Rainbow Pets", "Regex", "i)rainbow(?!.*best)", "Status", "Manual", "Zone", "Void")
QUEST_DATA["6"] := Map("Name", "Unlock Zones", "Regex", "i)unlock", "Status", "Manual", "Zone", "-")
QUEST_DATA["7"] := Map("Name", "Earn Diamonds", "Regex", "i)diamonds", "Status", "Auto", "Zone", "-")
QUEST_DATA["8"] := Map("Name", "Break Mini-Chests", "Regex", "i)mini.*chest(?!.*best)", "Status", "Manual", "Zone", "-")
QUEST_DATA["9"] := Map("Name", "Break Diamond Breakables", "Regex", "i)break.*diamond(?!.*best)", "Status", "Auto", "Zone", "VIP")
QUEST_DATA["10"] := Map("Name", "Buy Potions", "Regex", "i)buy.*pot", "Status", "Manual", "Zone", "-")
QUEST_DATA["11"] := Map("Name", "Buy Enchants", "Regex", "i)buy.*ench", "Status", "Manual", "Zone", "-")
QUEST_DATA["12"] := Map("Name", "Upgrade Potions", "Regex", "i)upg.*pot", "Status", "Manual", "Zone", "Void")
QUEST_DATA["13"] := Map("Name", "Upgrade Enchants", "Regex", "i)upg.*ench", "Status", "Manual", "Zone", "Void")
QUEST_DATA["14"] := Map("Name", "Collect Potions", "Regex", "i)col.*pot", "Status", "Auto", "Zone", "Void")
QUEST_DATA["15"] := Map("Name", "Collect Enchants", "Regex", "i)col.*ench", "Status", "Auto", "Zone", "Void")
QUEST_DATA["19"] := Map("Name", "Fuse Pets", "Regex", "i)fuse", "Status", "Manual", "Zone", "Void")
QUEST_DATA["20"] := Map("Name", "Hatch Best Egg", "Regex", "i)hatch.*your", "Status", "Auto", "Zone", "Void")
QUEST_DATA["21"] := Map("Name", "Break Breakables in Best Area", "Regex", "i)break.*breakable.*best", "Status", "Auto", "Zone", "Best")
QUEST_DATA["22"] := Map("Name", "Complete the Classic Obby", "Regex", "i)class", "Status", "Manual", "Zone", "5")
QUEST_DATA["23"] := Map("Name", "Complete the Minefield", "Regex", "i)minefield", "Status", "Manual", "Zone", "11")
QUEST_DATA["24"] := Map("Name", "Complete the Atlantis Minigame", "Regex", "i)altantis", "Status", "Manual", "Zone", "23")
QUEST_DATA["25"] := Map("Name", "Find Chests in the Digsite", "Regex", "i)chest.*dig", "Status", "Manual", "Zone", "30")
QUEST_DATA["26"] := Map("Name", "Catch Fish in the Fishing Minigame", "Regex", "i)fish", "Status", "Manual", "Zone", "27")
QUEST_DATA["27"] := Map("Name", "Complete the Ice Obby", "Regex", "i)ice.*ob", "Status", "Manual", "Zone", "38")
QUEST_DATA["28"] := Map("Name", "Complete the Pyramid Obby", "Regex", "i)pyr.*ob", "Status", "Manual", "Zone", "31")
QUEST_DATA["29"] := Map("Name", "Complete the Jungle Obby", "Regex", "i)jun.*ob", "Status", "Manual", "Zone", "18")
QUEST_DATA["30"] := Map("Name", "Complete the Chest Rush", "Regex", "i)ches.*rus", "Status", "Manual", "Zone", "45")
QUEST_DATA["31"] := Map("Name", "Break Coin Jars", "Regex", "i)coin.*jar(?!.*best)", "Status", "Auto", "Zone", "-")
QUEST_DATA["32"] := Map("Name", "Break Comets", "Regex", "i)comet(?!.*best)", "Status", "Manual", "Zone", "-")
QUEST_DATA["33"] := Map("Name", "Use Flags", "Regex", "i)use.*flag", "Status", "Auto", "Zone", "-")
QUEST_DATA["34-1"] := Map("Name", "Use Tier 3 Potions", "Regex", "i)use.*iii.*pot", "Status", "Auto", "Zone", "-")
QUEST_DATA["34-3"] := Map("Name", "Use Tier 5 Potions", "Regex", "i)use.*v.*pot", "Status", "Auto", "Zone", "-")
QUEST_DATA["34-2"] := Map("Name", "Use Tier 4 Potions", "Regex", "i)use.*pot", "Status", "Auto", "Zone", "-")
QUEST_DATA["35"] := Map("Name", "Eat Fruits", "Regex", "i)fruit", "Status", "Auto", "Zone", "-")
QUEST_DATA["36"] := Map("Name", "Complete the Sled Race", "Regex", "i)sled", "Status", "Manual", "Zone", "40")
QUEST_DATA["37"] := Map("Name", "Break Coin Jars in Best Area", "Regex", "i)coin.*jar.*best", "Status", "Auto", "Zone", "Best")
QUEST_DATA["38"] := Map("Name", "Break Comets in Best Area", "Regex", "i)comet.*best", "Status", "Auto", "Zone", "Best")
QUEST_DATA["39"] := Map("Name", "Break Mini-Chests in Best Area", "Regex", "^(?i)(?!.*sup).*mini-chest.*best area", "Status", "Auto", "Zone", "Best")
QUEST_DATA["40"] := Map("Name", "Make Golden Pets from Best Egg", "Regex", "i)golden.*best", "Status", "Auto", "Zone", "Void")
QUEST_DATA["41"] := Map("Name", "Make Rainbow Pets from Best Egg", "Regex", "i)rainbow.*best", "Status", "Auto", "Zone", "Void")
QUEST_DATA["42"] := Map("Name", "Hatch Rare Pets", "Regex", "rare.*pet", "Status", "Auto", "Zone", "Best")
QUEST_DATA["43"] := Map("Name", "Break Pinatas in the Best Area", "Regex", "i)pinata.*best", "Status", "Auto", "Zone", "Best")
QUEST_DATA["44"] := Map("Name", "Break Lucky Blocks in the Best Area", "Regex", "i)lucky.*event", "Status", "Auto", "Zone", "Best")
QUEST_DATA["45"] := Map("Name", "Find Chests in the Advanced Digsite", "Regex", "i)chest.*adv", "Status", "Manual", "Zone", "79")
QUEST_DATA["46"] := Map("Name", "Catch Fish in Advanced Fishing", "Regex", "i)fish.*adv", "Status", "Manual", "Zone", "92")
QUEST_DATA["47"] := Map("Name", "Index New Pets", "Regex", "i)ind.*pet", "Status", "Manual", "Zone", "Best")
QUEST_DATA["48"] := Map("Name", "Break a Black Lucky Block in the Lucky Block Minigame", "Regex", "i)black.*lucky", "Status", "Manual", "Zone", "87")
QUEST_DATA["49"] := Map("Name", "Collect Magic Shards in a Fishing Minigame", "Regex", "i)shard", "Status", "Manual", "Zone", "-")
QUEST_DATA["50"] := Map("Name", "Collect Magic Pools in a Digsite Minigame", "Regex", "i)pool", "Status", "Manual", "Zone", "-")
QUEST_DATA["51"] := Map("Name", "Sell Items at Your Booth", "Regex", "i)sell", "Status", "Manual", "Zone", "-")
QUEST_DATA["52"] := Map("Name", "Trade with Other Players", "Regex", "i)trade", "Status", "Manual", "Zone", "-")
QUEST_DATA["53"] := Map("Name", "Give Gifts to Other Players", "Regex", "i)tradin", "Status", "Manual", "Zone", "-")
QUEST_DATA["54"] := Map("Name", "Mail Gifts to Other Players", "Regex", "i)mail", "Status", "Manual", "Zone", "-")
QUEST_DATA["55"] := Map("Name", "Use Secret Keys", "Regex", "i)secret", "Status", "Manual", "Zone", "15")
QUEST_DATA["56"] := Map("Name", "Use Crystal Keys", "Regex", "i)crystal", "Status", "Manual", "Zone", "3")
QUEST_DATA["57"] := Map("Name", "Make Rainbow Fruit", "Regex", "i)rainbow", "Status", "Manual", "Zone", "52")
QUEST_DATA["58"] := Map("Name", "Plant Seeds in the Garden Minigame", "Regex", "i)seeds", "Status", "Manual", "Zone", "54")
QUEST_DATA["62"] := Map("Name", "Complete Item Creator Quests", "Regex", "i)creator", "Status", "Manual", "Zone", "120")
QUEST_DATA["63"] := Map("Name", "Get Critical Hits", "Regex", "i)crit", "Status", "Manual", "Zone", "-")
QUEST_DATA["64"] := Map("Name", "Collect Lootbags", "Regex", "i)loot", "Status", "Manual", "Zone", "-")
QUEST_DATA["65"] := Map("Name", "Collect Fruits", "Regex", "i)col.*fruit", "Status", "Manual", "Zone", "-")
QUEST_DATA["66"] := Map("Name", "Break Superior Mini-Chests in Best Area", "Regex", "i)sup", "Status", "Auto", "Zone", "Best")


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; QUEST PROPERTY OVERRIDES
; ----------------------------------------------------------------------------------------
; The quest property overrides listed below are utilized by the macro and should not be
; altered by the user.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Update the zone if the player does not have VIP.
if (getSetting("HasGamepassVip") == "false")
    QUEST_DATA["9"]["Zone"] := "-" ; "Break Diamond Breakables"

; Update the zone if the player has Super Drops.
if (getSetting("HasGamepassSuperDrops") == "true") {
    QUEST_DATA["14"]["Zone"] := "-"  ; "Collect Potions"
    QUEST_DATA["15"]["Zone"] := "-"  ; "Collect Enchants"
}