<h1>md-fishing</h1>


<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://cdn.discordapp.com/attachments/1164709522691076120/1185676859363557457/Discord_logo.svg.png?ex=65907aa0&is=657e05a0&hm=dd2a8924c3a3d84507747ab2bac036e5fc219c697e084c9aa13ba468ff725bde&" width="100">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx">Mustache Scripts Discord</a><br>
</div>


<h1>Credits to</h1>

Big thanks to Bostra from [Bostra Development](https://discord.gg/K8gbPAgJ47) for preventing me from giving up multiple times. 
 
Special shoutout to my beta testers! Your feedback has been invaluable.

<h1>Dependencies</h1>

- [QBCore](https://github.com/qbcore-framework/qb-core)

- [ps inventory](https://github.com/Project-Sloth/ps-inventory) **or** [qb inventory](https://github.com/qbcore-framework/qb-inventory) **or** [ox inventory](https://github.com/overextended/ox_inventory)
   
- [ps-ui](https://github.com/Project-Sloth/ps-ui)
  
- [qb-target](https://github.com/qbcore-framework/qb-target) or [ox_target](https://github.com/overextended/ox_target)
</h1>


<h1>Setup : </h1>

**step 1**

- Add the following to `qb-core/server/player.lua` inside your existing playerdata

```lua
PlayerData.metadata['fishingrep'] 		= PlayerData.metadata['fishingrep'] 	  or 0
PlayerData.metadata['magnetfishingrep'] = PlayerData.metadata['magnetfishingrep'] or 0
PlayerData.metadata['illegalfishing'] 	= PlayerData.metadata['illegalfishing']   or 0
```
- **Preview**

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185687076381933668/image.png?ex=65908424&is=657e0f24&hm=027d7691e956b2b42e3a41e469d73635ecf491754f72563f4e88f7db8c7a30b1&)

**step 2**

- Add the following Items to `qb-core/shared/items.lua`

```lua
["atlanticdolphin"] 		 = {["name"] = "atlanticdolphin", 			["label"] = "Atlantic Dolphin", 		['weight'] = 100, 		["type"] = "item", 		["image"] = "atlanticdolphin.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["belugawhale"] 			 = {["name"] = "belugawhale", 			    ["label"] = "Beluga Whale", 		    ['weight'] = 100, 		["type"] = "item", 		["image"] = "belugawhale.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["bluefish"] 				 = {["name"] = "bluefish", 			    	["label"] = "Flounder", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "bluefish.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
["bluewhale"] 				 = {["name"] = "bluewhale", 			    ["label"] = "Blue Whale", 		    	['weight'] = 100, 		["type"] = "item", 		["image"] = "bluewhale.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	    ["description"] = ""},
["catfish"] 				 = {["name"] = "catfish", 			    	["label"] = "Catfish", 		    		['weight'] = 100, 		["type"] = "item", 		["image"] = "catfish.png", 			   		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,		["description"] = ""},
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

OR if you use ox_inv **credits to Avenge**
```
['atlanticdolphin'] = {
	label = 'Atlantic Dolphin',
	weight = 300,
	stack = true,
	close = false,
	description = "A beautiful atlantic dolphin!"
},

['belugawhale'] = {
	label = 'Beluga Whale',
	weight = 300,
	stack = true,
	close = false,
	description = "How did you catch this with only a rod?!"
},

['bluefish'] = {
	label = 'Blue Fish',
	weight = 300,
	stack = true,
	close = false,
	description = "A very blue fish"
},

['bluewhale'] = {
	label = 'Blue Whale',
	weight = 300,
	stack = true,
	close = false,
	description = "Okay, you're joking right?"
},

['catfish'] = {
	label = 'Cat Fish',
	weight = 300,
	stack = true,
	close = false,
	description = "A perrrrrrfect looking fish"
},

['chileandolphin'] = {
	label = 'Chileando Dolphin',
	weight = 300,
	stack = true,
	close = false,
	description = "A beautiful dolphin"
},

['chum'] = {
	label = 'Chum',
	weight = 300,
	stack = true,
	close = false,
	description = "A bucket of suspicous bait"
},

['closedsafe'] = {
	label = 'Rusted Safe',
	weight = 300,
	stack = true,
	close = false,
	description = "A water bogged, rusty safe"
},

['copperpipe'] = {
	label = 'Rusted Copper Pipe',
	weight = 300,
	stack = true,
	close = false,
	description = "A corroded, rusty copper pipe"
},

['fishingpole'] = {
	label = 'Fishing Pole',
	weight = 300,
	stack = true,
	close = false,
	description = "I can catch something with this!"
},

['flounder'] = {
	label = 'Flounder',
	weight = 300,
	stack = true,
	close = false,
	description = "A yellow-ish fish"
},

['goblinshark'] = {
	label = 'Goblin Shark',
	weight = 300,
	stack = true,
	close = false,
	description = "Fuck me, it's ugly!"
},

['groundshark'] = {
	label = 'Ground Shark',
	weight = 300,
	stack = true,
	close = false,
	description = "I'm sure I've seen this somewhere before"
},

['halibut'] = {
	label = 'Halibut',
	weight = 300,
	stack = true,
	close = false,
	description = "A fish when cooked correctly is delicous"
},

['largemouthbass'] = {
	label = 'Large Mouth Bass',
	weight = 300,
	stack = true,
	close = false,
	description = "A bass with a big mouth, I wounder?"
},

['leatherheadturtle'] = {
	label = 'Leather Head Turtle',
	weight = 300,
	stack = true,
	close = false,
	description = "A majestic turtle"
},

['magnet'] = {
	label = 'Magnet',
	weight = 300,
	stack = true,
	close = false,
	description = "A form of bait for certain fishing methods"
},

['narwhal'] = {
	label = 'Narwhal',
	weight = 300,
	stack = true,
	close = false,
	description = "A unicorn whale!"
},

['panfish'] = {
	label = 'Pan fish',
	weight = 300,
	stack = true,
	close = false,
	description = "A fresh-water fish"
},

['panfish'] = {
	label = 'Pan fish',
	weight = 300,
	stack = true,
	close = false,
	description = "A fresh-water fish"
},

['plugbait'] = {
	label = 'Plug Bait',
	weight = 300,
	stack = true,
	close = false,
	description = "A form of bait for certain fishing methods"
},

['reddrum'] = {
	label = 'Red Drum',
	weight = 300,
	stack = true,
	close = false,
	description = "A large, game fish"
},

['rustyak'] = {
	label = 'Rusty Assault Rifle',
	weight = 300,
	stack = true,
	close = false,
	description = "An unusable, rusty assault rifle"
},

['rustyantenna'] = {
	label = 'Rusty Antenna',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty antenna"
},

['rustybike'] = {
	label = 'Rusty Bike',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty push bike"
},

['rustychain'] = {
	label = 'Rusted Chain',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty, corroded chain"
},

['rustyelectronickit'] = {
	label = 'Rusty Electronic Kit',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty, corroded electronic kit"
},

['rustypistol'] = {
	label = 'Rusted Pistol',
	weight = 300,
	stack = true,
	close = false,
	description = "An unusable, rusty pistol"
},

['rustyraspberrypi'] = {
	label = 'Rusty Raspberry Pi',
	weight = 300,
	stack = true,
	close = false,
	description = "This was once useable, that time has passed"
},

['rustyscanner'] = {
	label = 'Rusty Scanner',
	weight = 300,
	stack = true,
	close = false,
	description = "This was once useable, that time has passed"
},

['rustyscrapmetal'] = {
	label = 'Rusty Scrap Metal',
	weight = 300,
	stack = true,
	close = false,
	description = "Rusty assortment of metals"
},

['rustyshotgun'] = {
	label = 'Rusty Shotgun',
	weight = 300,
	stack = true,
	close = false,
	description = "An unusable, rusty shotgun"
},

['rustysign'] = {
	label = 'Rusty Sign',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty sign post"
},

['rustytire'] = {
	label = 'Rusty Tire',
	weight = 300,
	stack = true,
	close = false,
	description = "A rusty rim and corroded tire"
},

['rustyusb'] = {
	label = 'Rusty USB',
	weight = 300,
	stack = true,
	close = false,
	description = "Whatever was on it is long gone"
},

['rustywheelchair'] = {
	label = 'Rusty Wheelchair',
	weight = 300,
	stack = true,
	close = false,
	description = "This would of been fun to use in a get-away"
},

['salmon'] = {
	label = 'Salmon',
	weight = 300,
	stack = true,
	close = false,
	description = "A delicous fish!"
},

['softplasticbait'] = {
	label = 'Soft Plastic Bait',
	weight = 300,
	stack = true,
	close = false,
	description = "A form of bait for certain fishing methods"
},

['spermwhale'] = {
	label = 'Sperm Whale',
	weight = 300,
	stack = true,
	close = false,
	description = "Did you have more than one person helping?"
},

['spinnerbait'] = {
	label = 'Spinner Bait',
	weight = 300,
	stack = true,
	close = false,
	description = "A form of bait for certain fishing methods"
},

['steelhead'] = {
	label = 'Steelhead Trout',
	weight = 300,
	stack = true,
	close = false,
	description = "A beautiful cold water, rainbow trout"
},

['stripeddolphin'] = {
	label = 'Striped Dolphin',
	weight = 300,
	stack = true,
	close = false,
	description = "Not sure you should be catching this!"
},

['tigershark'] = {
	label = 'Tiger Shark',
	weight = 300,
	stack = true,
	close = false,
	description = "Careful! They bite!"
},

['tortoise'] = {
	label = 'Hard Shell Tortoise',
	weight = 300,
	stack = true,
	close = false,
	description = "This creature might be 150 years old!"
},

['treasurechest'] = {
	label = 'Tresure Chest',
	weight = 300,
	stack = true,
	close = false,
	description = "Who knows what could be inside!?"
},

['trout'] = {
	label = 'Trout',
	weight = 300,
	stack = true,
	close = false,
	description = "A beautiful fish!"
},

['tuna'] = {
	label = 'Tuna',
	weight = 300,
	stack = true,
	close = false,
	description = "A large and delicous fish, this is worth alot!"
},

['whitebass'] = {
	label = 'White Bass',
	weight = 300,
	stack = true,
	close = false,
	description = "A very sought after fish!"
},

['worm'] = {
	label = 'Worm Bait',
	weight = 300,
	stack = true,
	close = false,
	description = "A form of bait for certain fishing methods"
},
```

- **Preview**

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185692986957385828/image.png?ex=659089a5&is=657e14a5&hm=9da0ddc074a0f4a402c29c2a827dadb57f027f222dc0e766b3dc7a6be4d4b9cf&)

**step 3**

- Add items images to `qb-inventory/html/images` **or** `ox_inventory/web/images`

**step 4**

- Modify `md-fishing/config.lua` to match your city.

**step 5 ( only for ox_inventory users )** 

- Add the following shop to `ox_inventory/data/plshops.lua` inside your existing playerdata


```lua
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
		vec3(1314.75, 4281.75, 33.91)
	}, targets = {
		{ loc = vec3(1314.75, 4281.75, 33.91), length = 0.5, width = 3.0, heading = 270.0, minZ = 31.5, maxZ = 35.0, distance = 3 }
	}
},
```

**step 6** 

- **To edit the following function**

	- head to `md-fishing/client/client.lua` and add what you use for police alert

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185691812397056020/image.png?ex=6590888d&is=657e138d&hm=e46d177f21023a7c88a25f34a4bc771136a4e47bd0ec25e49a8319bcb8762348&)
