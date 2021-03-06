# Just some Design and other random notes

> Start date: November 9th 2017

## Interesting stuff

- [GameOff Official site](https://itch.io/jam/game-off-2017)
- [Open Source Game dev resources](https://github.com/Calinou/awesome-gamedev)

- [Godot and Pixel Art Games](https://medium.com/@tumeowilliam/godot-engine-and-pixel-art-a-better-love-story-than-twilight-4c8155ba71cd)
- [Resolution Calculator](http://www.silisoftware.com/tools/screen_aspect_ratio_calculator)
- [Notes on Shovel Knight](https://www.gamasutra.com/blogs/DavidDAngelo/20140625/219383/Breaking_the_NES_for_Shovel_Knight.php)
- [Notes on Hyper Light Drifter](http://nightmargin.tumblr.com/post/102886823891/on-resolution)
- [Git Branching](https://github.com/Kunena/Kunena-Forum/wiki/Create-a-new-branch-with-git-and-manage-branches)
- [Game Design Gif](https://twitter.com/WaywardMira/status/929025607480041473)
- [56 PixelArt Tips](http://blog.studiominiboss.com/pixelart)

## Brainstorming

### Game Mechanics

- Blocking projectiles and storing them into satchel for future use (like *throwing back*).
- Satchel works like a stack: first item in is last item out.
- Stone Abilities:
    - Regular Stone: Hurts!
    - Bounce Stone: Bounce! a lot!
    - Explosive Stones: Explode!
    - Warp Stone: Warp! (Can help to tranverse map)
- Only way to open doors, breaking them throwing stuff (Let's reinforce the main mechanic).
- You can throw with different strengths by charging. Charging limits your movement. 
- Enemies: Are ghosts. Because they are ghosts, they cannot be damaged directly, instead they need to have something to "bring it to the physic world", like a t-shirt, or paint them... HENCE the mechanic, paint balls to allow ghost hurting? (This is getting too complicated...)

Thats it. Ha!

### Random ideas

#### Tutorial

- Tutorial is a floating island. Teo awakes  an that's it. After a while, stones will start to fall. There the player can pick them up and throw them. There will be an interesting floating object that (when hit) opens a path to the rest of the level. There you learn, you can move, throw stuff and open paths.

#### Mechanics

- Other important mechanics, warp stone and blocking. 
- Other important mechanic, there are alarmclock seeds. They spawn an alarmclock plant. Everytime you die, the alarmclock plant will "wake teo up" on that spot, serving as a checkpoint. 
- Teo has very little life count. The only way to make him whitstand more damage is by gathering "shield stones" and keeping them in the pack. You can have infinite shield stones.
- Teo has a limited amount of items on the satchel.
- The satchel has to compartmens: 1 for rocks and the other for support items, like the seeds. (This means, you can throw the shield stones as weapons if needed be, alsom you are limited in the amount of rocks you can carry, so must think properly which ones to carry and stuff).
- Must think other ways to solve puzzles, so if player is out of rocks he can device a way to go through.

#### Animations
- Add air sparks to throwing around Teo (like a delayed loop effect).
- Add air sparks to rocks to add strength to the movement (when launched with more power).

#### Character Design
- Enemies are black ghosts with interesting throwback elements like:
    - A Metool helmet.
    - A big Mario shell with a ghost inside.
    - more references to come

#### Music

- First tutorial music should be a marimba magic misterious big adventure theme.

## Assets

List of assets, how they were made and credit where needed.

- utilities/Resultion.gd: Based on code by [CowThing](https://github.com/godotengine/godot/issues/6506#issuecomment-247533233). Scales and makes the pixels look all blocky and juicy.
- utilities/Controller.gd: Based on code by [Andreas Esau](https://www.youtube.com/watch?v=BTX0DWDqnyA&t=45s)
- Fonts: *Qpix* was created by me using [bitfontmaker2](http://www.pentacom.jp/pentacom/bitfontmaker2/)
- Aseprite Importer: Plugin to import Aseprite export files to Godot made by [eska014](https://github.com/eska014/aseprite-import). Did minor modifications to allow preprocessing scripts.


## General Todo

### 9 - 15
- [x] Make bullets rigid bodies. Let them bounce around and add height and free fall to bullets before turning them into pickables. Let them bounce with each other too.
- [x] Make Teo charge the shot.
- [x] Move camera man to direction vector when charging a shot.
- [x] Add aiming mechanic.
- [x] Evaluate charging mechanic movement, should it move or not, and how?
- [x] Make Teo bounce back when hit
- [x] Bullet bouncing looks weird, Godot physics has some trouble with collisions on high speeds. [Possible solutions](https://godotengine.org/qa/1250/how-to-properly-handle-high-speed-collisions):
    - Increase the fixed fps value in Project settings.
    - (This solution rocks!) Implement Bullet as kinematic body with reflect on normal of collision.
- [x] Implement simple enemy AI, make them move and choose when to throw. Limit the amount of throws to avoid farming bullets.
- [x] Make Teos running speed match the animations steps. 
- [x] Add shadows to enemies and Teo
- [x] Improve height and shadow handling for bullets. (Work with offset)
    - [x] Implement sprite_handler for bullets
    - [x] Create stone animations.
    - [x] Tweak stone to make shadow work well.
- [x] Fix shadows for Ghost's and Teo's pixel art sprites (top down shadow!)
    - [x] Fix Teo's shadows
    - [x] Fix Ghost's shadows 
- [x] Rocks are too big, evaluate making them smaller
- [x] Fix Rocks positioning when changing size
- [x] Make Rock size relative to throw length (faster-bigger)

- [x] Evaluate *tealm*'s critique: "looks better! But I would slow him down just a bit more, and just use a simple blob shadow shape beneath him - the one you have now might be  distracting."
    - [x] Tweak Teo's movement to make animation and movement feel tighter.
    - [x] Evaluate blob shadow.

- [x] Aseprite importe: When a structural change is made to the aseprite file and the spritesheet is reimported to godot, old data lingers in sprite scene screwing the animations. Must find way to bypass autoupdate and create a fresh import.

- [x] Teo's throw and move animation
    - [x] Create pixel art for preparing throw 8 directions
    - [x] Create pixel art for moving while preparing throw 8 directions
        - [x] Create leg movements
        - [x] Fixed and improved 8 direction aproximations from target vector
        - [x] Fix Leg movements
        - [x] Synchronize movement and animations
        - [x] Fix Camera to new aiming mechanic 
        - [x] Add motion details (Hair and tie)
        - [x] Add coded animation details (move up on certain frames if necesary)
        - [x] Fix leg shadows
        - [x] Finetune speed, animation and gameplay

- [x] Create pixel art for throwing with 8 directions
    - [x] Down Anim
    - [x] DownLeft Anim
    - [x] Left Anim
    - [x] UpLeft Anim
    - [x] Up Anim
    - [x] UpRight Anim
    - [x] Right Anim
    - [x] DownRight Anim
    - [x] Finetune speed, animation and gameplay
    - [x] Implement rock spawning points


### 16-22



- [x] Warp Stone
    - [x] Aim Contorls
        - [x] Test dual keyboard arrows
        - [x] Test move / mouse combo
        - [x] Implement best aiming mechanic
    - [x] Implement stone types
    
- [x] Create island system
    - [x] Create background parallax
        - [x] Create images 
    - [x] Create island tiles
        - [x] Create boundaries
            - [x] Current way of handling falling doens't work well, fix it or find a better one.
        - [x] Add obstacles functionality

    - [x] **Bug:** When rocks is spawn outside of island `outside` flag doesn't work.
    - [x] **Bug:** When rock's parent node is changed, animation is restarted breaking the flow of the rocks fall.
    - [x] **Bug:** Fix Stone free falling (some directions feels like is moving up rather than falling)
    - [x] Change ground logic to ray casts. (Raycast don't work when completely inside of collision shape)
    - [x] **Create shader for background**
        - [x] Transform big background to small sprites for new layer
        - [x] Improve shader for different and nicer bkg effect
    - [x] Implement falling mechanic
    
    - [x] Make sprites
        - [x] Grass Tiles
            - [x] Create animated grass tiles functionality
            - [x] **Animate grass**
            - [x] Remove 2 layers of grass and transform to 1
                - [x] Change all front grass tiles to be a 1 pixel line
        - [x] Dirt Tiles

- [x] Shield Stone
    - [x] Rock sprites
- [x] Regular Stone
    - [x] Rock sprites

- [x] Create tilemap assets
    - [x] Dirt
    - [x] Grass



### 23-29

    - [ ] Make stone collide with islands when free falling
    - [ ] Improve camera handling when throwing and warping
    - [x] Test warp mechanic
    - [ ] Make parallax configure itself to the current resolution (because of the `Resolution.gd` class, the resolution changes)
    - [ ] Improve Particle effect.

    - [x] Implement Teo falling and respawn
        - [x] Implement restart effect

- [x] Define how switching between rock works
    - [x] Implement satchel system
        - [x] Satchel logic
        - [x] Satchel Sprites
        - [x] Satchel GUI nodes

- [ ] **Implement respawning when throwing warp stone to abyss**

- [ ] Create Tutorial level
    - [ ] Implement alarm clock system
        - [ ] Create clock sprites
        - [ ] Implement clock mechanic
    - [ ] Add "Button blocks"
        - [ ] Create button blocks
    - [ ] Implement level flow

- [ ] Pixeling
    - [ ] Create background assets
        - [ ] First parallax level
        - [ ] Big clouds
        - [ ] Smaller clouds
        - [ ] Floating stuff
    - [ ] Create obstacle assets
    - [ ] Create other assets, like sparks and dust, etc..

- [ ] Create Enemies ?
- [ ] Sounds ?
- [ ] Boss ?


- [ ] Make transition from throwing to idle Teo's animations
    - [ ] Add interesting details on that transition, like bag moving on Up direction.


## Fonts

### Qpix

Data export to use with http://www.pentacom.jp/pentacom/bitfontmaker2/
```
{"33":[0,0,16,16,16,16,16,16,16,0,0,16,0,0,0,0],"34":[0,144,72,216,0,0,0,0,0,0,0,0,0,0,0,0],"35":[0,0,0,0,288,144,504,144,144,504,144,72,0,0,0,0],"36":[0,32,32,112,168,40,40,112,160,160,168,112,32,32,0,0],"37":[0,0,272,296,168,144,64,64,288,672,656,272,0,0,0,0],"38":[0,0,0,0,112,136,80,32,592,648,264,752,0,0,0,0],"39":[0,0,8,8,0,0,0,0,0,0,0,0,0,0,0,0],"40":[0,64,32,16,16,8,8,8,16,16,32,64,0,0,0,0],"41":[0,8,16,32,32,64,64,64,32,32,16,8,0,0,0,0],"42":[0,0,32,112,32,80,0,0,0,0,0,0,0,0,0,0],"43":[0,0,0,0,32,32,248,32,32,0,0,0,0,0,0,0],"44":[0,0,0,0,0,0,0,0,0,0,0,24,16,8,0,0],"45":[0,0,0,0,0,0,0,120,0,0,0,0,0,0,0,0],"46":[0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0],"47":[0,0,128,64,64,32,32,16,16,8,8,4,0,0,0,0],"48":[0,0,0,120,132,132,132,132,132,132,132,120,0,0,0,0],"49":[0,0,0,16,28,16,16,16,16,16,16,124,0,0,0,0],"50":[0,0,0,120,132,128,128,64,32,16,8,252,0,0,0,0],"51":[0,0,0,120,132,128,128,112,128,128,132,120,0,0,0,0],"52":[0,0,0,64,96,80,72,68,68,508,64,64,0,0,0,0],"53":[0,0,0,252,4,4,4,124,128,128,128,124,0,0,0,0],"54":[0,0,0,120,132,4,4,124,132,132,132,120,0,0,0,0],"55":[0,0,0,252,128,64,32,32,16,16,16,16,0,0,0,0],"56":[0,0,0,120,132,132,120,132,132,132,132,120,0,0,0,0],"57":[0,0,0,120,132,132,132,248,128,128,132,120,0,0,0,0],"58":[0,0,0,0,0,0,8,0,0,0,0,8,0,0,0,0],"59":[0,0,0,0,0,0,8,0,0,0,0,24,16,8,0,0],"60":[0,0,0,0,384,96,24,4,24,96,384,0,0,0,0,0],"61":[0,0,0,0,0,248,0,0,248,0,0,0,0,0,0,0],"62":[0,0,0,0,12,48,192,256,192,48,12,0,0,0,0,0],"63":[0,112,136,260,260,128,64,32,32,0,0,32,0,0,0,0],"65":[0,0,96,144,264,264,516,516,1020,516,516,516,0,0,0,0],"66":[0,0,60,68,132,132,124,132,260,260,132,124,0,0,0,0],"67":[0,0,240,264,516,516,4,4,516,516,264,240,0,0,0,0],"68":[0,0,252,260,516,516,516,516,516,516,260,252,0,0,0,0],"69":[0,0,1020,4,4,4,124,4,4,4,4,1020,0,0,0,0],"70":[0,0,1020,4,4,4,124,4,4,4,4,4,0,0,0,0],"71":[0,0,240,264,516,516,4,4,900,516,264,240,0,0,0,0],"72":[0,0,516,516,516,516,1020,516,516,516,516,516,0,0,0,0],"73":[0,0,4,4,4,4,4,4,4,4,4,4,0,0,0,0],"74":[0,0,64,64,64,64,64,64,64,68,68,56,0,0,0,0],"75":[0,0,4,132,68,36,20,12,20,36,68,132,0,0,0,0],"76":[0,0,4,4,4,4,4,4,4,4,4,508,0,0,0,0],"77":[0,0,1548,1300,1188,1092,1028,1028,1028,1028,1028,1028,0,0,0,0],"78":[0,0,1028,1036,1044,1060,1092,1156,1284,1540,1028,1028,0,0,0,0],"79":[0,0,496,520,1028,1028,1028,1028,1028,1028,520,496,0,0,0,0],"80":[0,0,252,260,516,516,260,252,4,4,4,4,0,0,0,0],"81":[0,0,496,520,1028,1028,1028,1028,1028,1412,520,1520,0,0,0,0],"82":[0,0,252,260,516,516,260,252,260,516,516,516,0,0,0,0],"83":[0,0,496,520,1028,4,8,496,512,1028,520,496,0,0,0,0],"84":[0,0,2044,64,64,64,64,64,64,64,64,64,0,0,0,0],"85":[0,0,516,516,516,516,516,516,516,516,264,240,0,0,0,0],"86":[0,0,260,260,260,260,260,260,136,136,80,32,0,0,0,0],"87":[0,0,4100,4100,4100,4228,4228,4228,2184,2376,2376,1584,0,0,0,0],"88":[0,0,260,260,136,80,32,32,80,136,260,260,0,0,0,0],"89":[0,0,260,260,136,136,80,32,32,32,32,32,0,0,0,0],"90":[0,0,1020,512,256,128,64,32,16,8,4,1020,0,0,0,0],"91":[0,0,56,8,8,8,8,8,8,8,8,8,8,56,0,0],"92":[0,0,4,8,8,16,16,32,32,64,64,128,0,0,0,0],"93":[0,0,56,32,32,32,32,32,32,32,32,32,32,56,0,0],"94":[0,32,80,80,136,0,0,0,0,0,0,0,0,0,0,0],"95":[0,0,0,0,0,0,0,0,0,0,0,0,0,2040,0,0],"96":[0,24,32,0,0,0,0,0,0,0,0,0,0,0,0,0],"97":[0,0,0,0,0,0,240,136,132,132,132,376,0,0,0,0],"98":[0,0,0,4,4,4,116,140,132,132,132,124,0,0,0,0],"99":[0,0,0,0,0,0,120,132,4,4,132,120,0,0,0,0],"100":[0,0,0,128,128,128,184,196,132,132,132,248,0,0,0,0],"101":[0,0,0,0,0,0,120,132,252,4,132,120,0,0,0,0],"102":[0,0,0,24,36,4,4,28,4,4,4,4,0,0,0,0],"103":[0,0,0,0,0,0,184,196,132,132,248,128,132,120,0,0],"104":[0,0,0,4,4,4,52,76,68,68,68,68,0,0,0,0],"105":[0,0,0,4,0,0,4,4,4,4,4,4,0,0,0,0],"106":[0,0,0,8,0,0,8,8,8,8,8,8,8,6,0,0],"107":[0,0,0,4,4,68,68,36,28,36,68,68,0,0,0,0],"108":[0,0,0,4,4,4,4,4,4,4,4,4,0,0,0,0],"109":[0,0,0,0,0,0,436,588,580,580,580,580,0,0,0,0],"110":[0,0,0,0,0,0,116,140,132,132,132,132,0,0,0,0],"111":[0,0,0,0,0,0,120,132,132,132,132,120,0,0,0,0],"112":[0,0,0,0,0,0,116,140,132,132,132,124,4,4,4,0],"113":[0,0,0,0,0,0,184,196,132,132,132,248,128,128,128,0],"114":[0,0,0,0,0,0,52,12,4,4,4,4,0,0,0,0],"115":[0,0,0,0,0,0,120,4,4,120,128,120,0,0,0,0],"116":[0,0,0,0,0,8,28,8,8,8,8,16,0,0,0,0],"117":[0,0,0,0,0,0,132,132,132,132,196,184,0,0,0,0],"118":[0,0,0,0,0,0,132,132,132,72,72,48,0,0,0,0],"119":[0,0,0,0,0,0,1028,1092,1092,584,680,272,0,0,0,0],"120":[0,0,0,0,0,0,196,40,16,32,80,140,0,0,0,0],"121":[0,0,0,0,0,0,132,132,72,72,48,32,16,16,0,0],"122":[0,0,0,0,0,0,252,64,32,16,8,252,0,0,0,0],"123":[0,0,48,8,8,8,8,4,8,8,8,8,8,48,0,0],"124":[0,0,0,8,8,8,8,8,8,8,8,8,8,0,0,0],"125":[0,0,12,16,16,16,16,32,16,16,16,16,16,12,0,0],"126":[0,0,0,0,0,48,584,384,0,0,0,0,0,0,0,0],"161":[0,0,0,0,16,0,0,16,16,16,16,16,16,16,0,0],"168":[0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0],"180":[0,0,48,16,0,0,0,0,0,0,0,0,0,0,0,0],"183":[0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0],"184":[0,0,0,0,0,0,0,0,0,0,0,0,16,32,0,0],"185":[0,32,32,32,0,0,0,0,0,0,0,0,0,0,0,0],"186":[0,48,72,72,48,0,0,0,0,0,0,0,0,0,0,0],"191":[0,0,0,0,32,0,0,32,32,16,8,260,260,136,112,0],"192":[16,32,96,144,264,264,516,516,1020,516,516,516,0,0,0,0],"193":[256,128,96,144,264,264,516,516,1020,516,516,516,0,0,0,0],"194":[96,144,96,144,264,264,516,516,1020,516,516,516,0,0,0,0],"195":[288,208,96,144,264,264,516,516,1020,516,516,516,0,0,0,0],"200":[16,32,1020,4,4,4,124,4,4,4,4,1020,0,0,0,0],"201":[128,64,1020,4,4,4,124,4,4,4,4,1020,0,0,0,0],"204":[1,2,4,4,4,4,4,4,4,4,4,4,0,0,0,0],"205":[16,8,4,4,4,4,4,4,4,4,4,4,0,0,0,0],"209":[288,208,1028,1036,1044,1060,1092,1156,1284,1540,1028,1028,0,0,0,0],"210":[16,32,496,520,1028,1028,1028,1028,1028,1028,520,496,0,0,0,0],"211":[256,128,496,520,1028,1028,1028,1028,1028,1028,520,496,0,0,0,0],"215":[0,0,0,0,144,96,96,144,0,0,0,0,0,0,0,0],"217":[16,32,516,516,516,516,516,516,516,516,264,240,0,0,0,0],"218":[256,128,516,516,516,516,516,516,516,516,264,240,0,0,0,0],"224":[0,0,0,16,32,0,240,136,132,132,132,376,0,0,0,0],"225":[0,0,0,256,128,0,240,136,132,132,132,376,0,0,0,0],"232":[0,0,0,8,16,0,120,132,252,4,132,120,0,0,0,0],"233":[0,0,0,128,64,0,120,132,252,4,132,120,0,0,0,0],"236":[0,0,2,4,0,0,4,4,4,4,4,4,0,0,0,0],"237":[0,0,8,4,0,0,4,4,4,4,4,4,0,0,0,0],"241":[0,0,0,144,104,0,116,140,132,132,132,132,0,0,0,0],"242":[0,0,0,8,16,0,120,132,132,132,132,120,0,0,0,0],"243":[0,0,0,128,64,0,120,132,132,132,132,120,0,0,0,0],"247":[0,0,0,0,0,32,0,248,0,32,0,0,0,0,0,0],"249":[0,0,0,8,16,0,132,132,132,132,196,184,0,0,0,0],"250":[0,0,0,128,64,0,132,132,132,132,196,184,0,0,0,0],"name":"kijipixel","copy":"ErickQuijivix","letterspace":"64","basefont_size":"512","basefont_left":"62","basefont_top":"0","basefont":"Arial","basefont2":""}
```