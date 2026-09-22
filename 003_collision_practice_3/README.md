# 003 - Collision Practice 3

### 🎯 Objective
- [x] Create reusable piece blueprints for modular obstacle shapes

- [x] Programmatically construct multi-tile composite obstacles (L-shape) using a function

- [x] Implement pixel-accurate hitboxes for thin line graphics to allow precise cornering

- [x] Prevent the player from leaving screen boundaries or moving through custom obstacle tiles

### 💡 What I Learned
* Blueprint & Tiling Loop Logic: Using loops (for i = 0, bp.tw - 1) combined with step sizes (i * 8) lets you build continuous shapes out of repeating single-tile graphics without stretching sprites.

* Relative Offsets (ox/oy): Anchor points (x_start, y_start) define an obstacle's position on screen, while offsets shift individual sub-pieces relative to that anchor—making complex shapes reusable anywhere on the map.

* Tight Hitbox Alignment: Invisible collision boundaries must match the actual line thickness of the artwork (e.g., setting height or width to 1 pixel) so empty tile space doesn't block the player from entering open inner corners.

### 📋 Process
1. Initialize Engine & Player Settings: Set up _init() with core sprite dimensions, screen boundaries (128x128), player object properties (speed, x, y), and position tracking variables.

2. Define Piece Blueprints: Created table blueprints (h_piece and v_piece) specifying sprite IDs, repetition counts (tw/th), piece orientation, and local offsets (ox/oy).

3. Build Obstacle Factory (create_obstacle): Developed a function that reads blueprints and loops through tile dimensions, placing 8x8 tiled pieces with tight 2-pixel-thick hitboxes (w=7, h=1 for horizontal; w=1, h=7 for vertical).

4. Instantiate and Bound Obstacles: Generated an L-shape composite obstacle at position (30, 50) and calculated bounding edges (left, top, right, bottom) for each generated piece.

5. Handle Player Movement & Screen Bounds: Updated player positions in _update() based on arrow key inputs (btn(0) through btn(3)), caching previous coordinates (old_x, old_y) to handle collision resets, and clamped movement within screen bounds.

6. Execute AABB Collision Check: Iterated through all obstacle pieces using a custom is_colliding() function to revert player movement whenever hitboxes overlap.

7. Render Scene: Used _draw() to clear the screen with cls() and draw the player and individual obstacle tiles using spr().

### 🔨 Tools & Resources
- Pico-8 
- Language: Lua