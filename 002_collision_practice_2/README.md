# 002 - Collision Practice 2

### 🎯 Objective
- [x] Create core `_init`, `_update`, and `_draw` loops
- [x] Move a sprite using D-pad arrow inputs
- [x] Stop sprite from leaving screen
- [x] Extra practice with making collidable objects

### 💡 What I Learned
*  I think a good mental model is this: Imagine the object entering a collision area and create code that describes that. If trying to stop an object from leaving an area, write code for if it is outside that area.

### 📋 Process
1. I saved the old x & y positions before updating them in _update()
2. I defined the inputs for player movement through if-statments (up, left, right, and down arrow keys)
3. After defining the player movement, I updated the variables I defined in the beginning to use the updated x & y positions
4. I defined the edges of the screen for screen collision
5. I created a collision function at the bottom of the program to define obstacle collision
6. I applied the collision function to the 2 objects I created.

### 🔨 Tools & Resources
- Pico-8 
- Language: Lua