# 006 - Collision Game 2

### 🎯 Objective

- [x] Refactor and debug the grid-based map building pipeline (`init_grid`, `set_piece`, `draw_hline`, `draw_map`)
- [x] Deepen understanding of Lua string manipulation (`sub`) and array table structures
- [x] Integrate Axis-Aligned Bounding Box (AABB) collision detection with grid-generated tile pieces

### 💡 Reflections

I feel like I have a better understanding of how to use a grid based system to create and place objects. I'm also slowly beginning to understand tables and for loops better.

In my next session, I want to continue practicing these concepts as well as use them to create primitive levels.

### 📋 Process

1. **Refine Grid Data Structures & String Mutation**
   * Built `init_grid()` to dynamically construct a 16x16 row string matrix filled with `"0"` characters.
   * Mastered string slicing using `sub(line, 1, col - 1)` and `sub(line, col + 1)` inside `set_piece()` to mutate individual characters in immutable Lua strings.
   * Utilized `draw_hline()` and `draw_vline()` helper loops to set contiguous horizontal and vertical tile segments in the grid.

2. **Streamline Grid-to-Pixel Coordinate Math**
   * Converted 1-based grid positions `(col, row)` to 0-based pixel coordinates: `px = (col - 1) * spr_w` and `py = (row - 1) * spr_h`.
   * Identified and stripped redundant origin offset parameters (`x_start`, `y_start`) to simplify code readability for full-screen (128x128) maps.

3. **Generate Bounding Boxes (`apply_collision_box`)**
   * Linked string tile identifiers (`"1"` through `"6"`) to tile template objects (`hz_top`, `vt_left`, etc.).
   * Calculated precise hitbox edges (`left`, `right`, `top`, `btm`) accounting for tile orientation and custom offsets.
   * Ensured `nil` safety when parsing empty tiles (`"0"`) so only active obstacles were appended to the level table.

4. **Debug Code Flow & Resolve Runtime Errors**
   * Corrected `init_grid()` loop scoping so rows were added to the grid table only after completing column concatenation.
   * Resolved duplicate function name collisions by separating tile creation (`apply_collision_box`) from overlap checking (`check_obs_collision`).
   * Aligned parameter ordering across helper functions (`row` before `col` in `set_piece`).

5. **Execute Movement & Collision Resolution**
   * Tracked previous frame positions (`old_x`, `old_y`) and updated active player bounding boxes during input handling in `_update()`.
   * Evaluated screen boundaries (`scr_collision()`) and piece overlaps (`check_obs_collision()`).
   * Reset player coordinates to `old_x` and `old_y` whenever a collision was triggered.

6. **Render Game Scene**
   * Cleared the screen each frame using `cls()`.
   * Iterated through the `hz_bars` array to draw obstacle tile sprites (`spr`) at their calculated pixel locations.
   * Rendered the player sprite (`spr_num = 7`).

### 🔨 Tools & Resources

- Pico-8 
- Language: Lua