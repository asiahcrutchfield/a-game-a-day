# 000 - Sprite Movement First Steps

### 🎯 Objective
- [x] Create core `_init`, `_update`, and `_draw` loops
- [x] Move a sprite using D-pad arrow inputs
- [x] Stop sprite from leaving screen
- [x] Learn very basic collision

### 💡 What I Learned
* PICO-8 coordinates start at (0,0) in the top-left corner. Increasing Y moves things down!
* `cls(1)` clears the canvas using the built-in color palette.
* To stop a sprite from leaving the right or bottom of the screen I need to subtract from how many pixels a sprite extends from its top left point.