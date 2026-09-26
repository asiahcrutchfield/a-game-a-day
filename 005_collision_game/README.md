# 005 - Collision Game

### 🎯 Objective

- [x] Practice obstacle collisions
- [x] Learn primitive level creation
- [x] Practice using grids

### 💡 Reflections

I learned about the concept of using a grid to create shapes and obstacles. Turning the 128x128 screen into a 16x16 row was hard for me to visualize. And writing code to create a simple horizontal bar obstacle proved difficult. I used AI assistance to write and understand the hline and vline functions. However, I did study to try and understand what was being written.

I still need more practice with this concept so my next practice session will be a continuation of this concept.

### 📋 Process

1. **Define Grid & Entity Structures**
* Configured global pixel dimensions (8x8) to map the 128x128 screen into a 16x16 grid.
* Created entity tables for player state and obstacle piece templates (`hz_top`, `hz_mid`, `vt_left`, etc.) linked to sprite indices and alignment properties.


2. **Build Text-Based Grid Infrastructure**
* Implemented `create_empty_grid()` to generate a 16x16 string matrix initialized with `"0"` characters.
* Built helper functions (`set_tile`, `draw_hline`, `draw_vline`) to mutate grid characters into horizontal and vertical bar segments using string manipulation.


3. **Parse Map & Generate Hitboxes**
* Developed `build_grid_map()` to iterate through the grid matrix and convert column/row indexes into screen coordinates (`px`, `py`).
* Created `apply_collision_box()` to map character identifiers (`"1"` through `"6"`) to tile templates and generate tight bounding box edges (`left`, `right`, `top`, `btm`) offset by tile orientation.


4. **Implement Player Input & Movement Buffer**
* Cached previous player coordinates (`old_x`, `old_y`) at the start of `_update()`.
* Updated current player coordinates based on directional button inputs (`btn(0)` through `btn(3)`).
* Updated player bounding box coordinates (`top`, `left`, `right`, `btm`).


5. **Apply Collision Detection & Resolution**
* Implemented `screen_collision()` to verify the player stays within screen boundaries (0 to 127).
* Created `check_obstacle_collision()` to perform AABB (Axis-Aligned Bounding Box) overlap checks between player and level pieces.
* Restored player position to (`old_x`, `old_y`) whenever a collision check returned `true`.


6. **Render Game Scene**
* Cleared screen buffer using `cls()`.
* Iterated through `level.pieces` to render each obstacle sprite at its designated pixel coordinates.
* Rendered player sprite at active coordinates.

### 🔨 Tools & Resources

- Pico-8 
- Language: Lua