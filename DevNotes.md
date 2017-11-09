# Just some Design and other random notes

> Start date: November 9th 2017

## Interesting stuff

- [GameOff Official site](https://itch.io/jam/game-off-2017)
- [Open Source Game dev resources](https://github.com/Calinou/awesome-gamedev)

- [Godot and Pixel Art Games](https://medium.com/@tumeowilliam/godot-engine-and-pixel-art-a-better-love-story-than-twilight-4c8155ba71cd)
- [Resolution Calculator](http://www.silisoftware.com/tools/screen_aspect_ratio_calculator)
- [Notes on Shovel Knight](https://www.gamasutra.com/blogs/DavidDAngelo/20140625/219383/Breaking_the_NES_for_Shovel_Knight.php)
- [Notes on Hyper Light Drifter](http://nightmargin.tumblr.com/post/102886823891/on-resolution)

## Brainstorming

### Game Mechanics

Blocking projectiles and storing them into satchel for future use (like *throwing back*).
Satchel works like a stack: first item in is last item out.

Thats it. Ha!


## Assets

List of assets being used. 

- VisualLogger: A plugin I made to log data into the screen.
- utilities/Resultion.gd: Based on code by [CowThing](https://github.com/godotengine/godot/issues/6506#issuecomment-247533233). Scales and makes the pixels look all blocky and juicy.
- utilities/Controller.gd: Based on code by [Andreas Esau](https://www.youtube.com/watch?v=BTX0DWDqnyA&t=45s)


## General Todo

### 9 - 15
- [x] Make bullets rigid bodies. Let them bounce around and add height and free fall to bullets before turning them into pickables. Let them bounce with each other too.
- [x] Make Teo charge the shot.
- [ ] Add aiming mechanic.
- [ ] Evaluate charging mechanic movement, should it move or not, and how?
- [ ] Make Teo and enemy bounce back when hit
- [ ] Implement simple enemy AI, make them move and choose when to throw. Limit the amount of throws to avoid farming bullets.

### 16-22
### 23-29
