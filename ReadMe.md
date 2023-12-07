<h1>Support</h1>

if you have any issues, you can come to my discord and throw a ticket in. I hope i can get it fixed ASAP Rocky
if you are going to ask why theres a folder saying dont open, with 4 copies of the readme, people snoop all around but dont just read it. hopefully thats not you
[My Community Discord Invite Link](https://discord.gg/TwBaVECdGM)



<h1>Credits</h1>
I want to give a huge Shoutout to Bostra over at Bostra Development https://discord.gg/K8gbPAgJ47 who helped me from quitting coding multiple times. 
Also A shout out to my beta testers! 

<h1>Dependencies</h1>

- [qb-core](https://github.com/qbcore-framework/qb-core)

- [LJ/PS](https://github.com/Project-Sloth/ps-inventory) or [qb inventory](https://github.com/qbcore-framework/qb-inventory) or [ox_inventory](https://github.com/overextended/ox_inventory)
  
  
- [ps-ui](https://github.com/Project-Sloth/ps-ui)
  
- [qb-target](https://github.com/qbcore-framework/qb-target) or [ox_target](https://github.com/overextended/ox_target)
</h1>
step 1 

add these
```
PlayerData.metadata['fishingrep'] = PlayerData.metadata['fishingrep'] or 0
PlayerData.metadata['magnetfishingrep'] = PlayerData.metadata['magnetfishingrep'] or 0
PlayerData.metadata['illegalfishing'] = PlayerData.metadata['illegalfishing'] or 0
```

underneath 
```
 PlayerData.metadata['dealerrep'] = PlayerData.metadata['dealerrep'] or 0
 ```
  in qb-core - > server - > player.lua
  
  
  step 2
  add these items 
  ```
["atlanticdolphin"] 		 = {["name"] = "atlanticdolphin", 			["label"] = "Atlantic Dolphin", 		['weight'] = 100, 		["type"] = "item", 		["image"] = "atlanticdolphin.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["belugawhale"] 			 = {["name"] = "belugawhale", 			    ["label"] = "Beluga Whale", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "belugawhale.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["bluefish"] 				 = {["name"] = "bluefish", 			    	["label"] = "Flounder", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "bluefish.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["bluewhale"] 				 = {["name"] = "bluewhale", 			    ["label"] = "Blue Whale", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "bluewhale.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["catfish"] 				 = {["name"] = "catfish", 			    	["label"] = "Catfish", 		    		['weight'] = 100, 		["type"] = "item", 		["image"] = "catfish.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["chileandolphin"] 			 = {["name"] = "chileandolphin", 			["label"] = "Chilean Dolphin", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "chileandolphin.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["chum"] 					 = {["name"] = "chum", 						["label"] = "Fish Chum", 		   		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "chum.png", 					["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["closedsafe"] 				 = {["name"] = "closedsafe", 			    ["label"] = "closed safe", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "closedsafe.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["copperpipe"] 				 = {["name"] = "copperpipe", 			    ["label"] = "copper pipe", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "copperpipe.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["fishingpole"] 			 = {["name"] = "fishingpole", 			    ["label"] = "Fishing Pole", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "fishingpole.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["flounder"] 				 = {["name"] = "flounder", 			    	["label"] = "Flounder", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "flounder.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["goblinshark"] 			 = {["name"] = "goblinshark", 			    ["label"] = "Goblin Shark", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "goblinshark.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["groundshark"] 			 = {["name"] = "groundshark", 			    ["label"] = "Ground Shark", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "groundshark.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["halibut"] 				 = {["name"] = "halibut", 			    	["label"] = "Halibut", 		     		['weight'] = 100, 		["type"] = "item", 		["image"] = "halibut.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["largemouthbass"] 			 = {["name"] = "largemouthbass", 			["label"] = "Large Mouth Bass", 		['weight'] = 100, 		["type"] = "item", 		["image"] = "largemouthbass.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["leatherheadturtle"] 		 = {["name"] = "leatherheadturtle", 		["label"] = "Leatherhead Turtle", 		['weight'] = 100, 		["type"] = "item", 		["image"] = "leatherheadturtle.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["magnet"] 					 = {["name"] = "magnet", 			    	["label"] = "magnet", 			        ["weight"] = 100, 		["type"] = "item", 		["image"] = "magnet.png", 			   		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["magnetpole"] 				 = {["name"] = "magnetpole", 			    ["label"] = "Magnet Pole", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "fishingpole.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},																																																																				    
["mdtreasurechest"] 		 = {["name"] = "mdtreasurechest", 			["label"] = "Treasure Chest", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "treasurechest.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["narwhal"] 				 = {["name"] = "narwhal", 			    	["label"] = "Narwhal", 		     		['weight'] = 100, 		["type"] = "item", 		["image"] = "narwhal.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["panfish"] 				 = {["name"] = "panfish", 			    	["label"] = "Panfish", 		    		['weight'] = 100, 		["type"] = "item", 		["image"] = "panfish.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["plugbait"] 				 = {["name"] = "plugbait", 			    	["label"] = "Plug Bait", 		     	['weight'] = 100, 		["type"] = "item", 		["image"] = "plugbait.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["reddrum"] 				 = {["name"] = "reddrum", 			    	["label"] = "Red Drum", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "reddrum.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyak"] 				 = {["name"] = "rustyak", 			    	["label"] = "rusty ak", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyak.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyantenna"] 			 = {["name"] = "rustyantenna", 			    ["label"] = "rusty antenna", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyantenna.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustybike"] 				 = {["name"] = "rustybike", 			    ["label"] = "rusty bike", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustybike.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustychain"] 				 = {["name"] = "rustychain", 			    ["label"] = "rusty chain", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustychain.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyelectronickit"] 		 = {["name"] = "rustyelectronickit", 		["label"] = "rusty electronickit", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyelectronickit.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustypistol"] 			 = {["name"] = "rustypistol", 			    ["label"] = "rusty pistol", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "rustypistol.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyraspberrypi"] 		 = {["name"] = "rustyraspberrypi", 			["label"] = "rusty raspberrypi", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyraspberrypi.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustysafe"] 				 = {["name"] = "rustysafe", 			    ["label"] = "rusty safe", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "closedsafe.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyscanner"] 			 = {["name"] = "rustyscanner", 			    ["label"] = "rusty scanner", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyscanner.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyscrapmetal"] 		 = {["name"] = "rustyscrapmetal", 			["label"] = "rusty scrapmetal", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyscrapmetal.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyshotgun"] 			 = {["name"] = "rustyshotgun", 			    ["label"] = "rusty shotgun", 			["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyshotgun.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustysign"] 				 = {["name"] = "rustysign", 			    ["label"] = "rusty sign", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustysign.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustytire"] 				 = {["name"] = "rustytire", 			    ["label"] = "rusty tire", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustytire.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustyusb"] 				 = {["name"] = "rustyusb", 			    	["label"] = "rusty usb", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "rustyusb.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["rustywheelchair"] 		 = {["name"] = "rustywheelchair", 			["label"] = "rusty wheelchair", 		["weight"] = 100, 		["type"] = "item", 		["image"] = "rustywheelchair.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["salmon"] 				     = {["name"] = "salmon", 			    	["label"] = "Salmon", 		     		['weight'] = 100, 		["type"] = "item", 		["image"] = "salmon.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["seaturtle"] 				 = {["name"] = "seaturtle", 			    ["label"] = "Sea Turtle", 		     	['weight'] = 100, 		["type"] = "item", 		["image"] = "seaturtle.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["sheetmetal"] 				 = {["name"] = "sheetmetal", 			    ["label"] = "sheet metal", 			    ["weight"] = 100, 		["type"] = "item", 		["image"] = "sheetmetal.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["softplasticbait"] 		 = {["name"] = "softplasticbait", 			["label"] = "Soft Plastic Bait", 		['weight'] = 100, 		["type"] = "item", 		["image"] = "softplasticbait.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["spermwhale"] 				 = {["name"] = "spermwhale", 			    ["label"] = "Sperm Whale", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "spermwhale.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["spinnerbait"] 		     = {["name"] = "spinnerbait", 			    ["label"] = "Spinner Bait", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "spinnerbait.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["steelhead"] 				 = {["name"] = "steelhead", 			    ["label"] = "Steelhead", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "steelhead.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["stripeddolphin"] 			 = {["name"] = "stripeddolphin", 			["label"] = "Striped Dolphin", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "stripeddolphin.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["tigershark"] 				 = {["name"] = "tigershark", 			    ["label"] = "Tiger Shark", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "tigershark.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["tortoise"] 				 = {["name"] = "tortoise", 			    	["label"] = "Tortoise", 		     	['weight'] = 100, 		["type"] = "item", 		["image"] = "tortoise.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["trout"] 				     = {["name"] = "trout", 			    	["label"] = "Trout", 		    		['weight'] = 100, 		["type"] = "item", 		["image"] = "trout.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["tunafish"] 				 = {["name"] = "tunafish", 			    	["label"] = "Tuna", 		     		['weight'] = 100, 		["type"] = "item", 		["image"] = "tuna.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["whitebass"] 				 = {["name"] = "whitebass", 			    ["label"] = "White Bass", 		     	['weight'] = 100, 		["type"] = "item", 		["image"] = "largemouthbass.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["worms"] 				     = {["name"] = "worms", 			    	["label"] = "worms", 		     		['weight'] = 100, 		["type"] = "item", 		["image"] = "worm.png", 			   		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},


```
step 3
add images to inventory script

step 4 fill out the config to match your city.

step 5 if you use ox inv add this 

```
FishingShop = {
		name = 'Fishing Shop',
		inventory = {
			{ name = 'fishingpole', price = 1000},
			{ name = 'magnetpole', price = 1000},
			{ name = 'worms', price = 25},
			{ name = 'spinnerbait', price = 25},
			{ name = 'plugbait', price = 25},
			{ name = 'softplasticbait', price = 25},
			{ name = 'magnet', price = 25},
		}, locations = {
			vector3(1314.75, 4281.75, 33.91)
		}, targets = {
			{ loc = vector3(1314.75, 4281.75, 33.91), length = 0.5, width = 3.0, heading = 270.0, minZ = 31.5, maxZ = 35.0, distance = 3 }
		}
	},
```

to your shops.lua 


step 6 add police exports inside the function PoliceCall() at the top of your client.lua

step 7 enjoy
	



