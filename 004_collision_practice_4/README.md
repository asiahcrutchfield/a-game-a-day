# 004 - Collision Practice 4

### 🎯 Objective

- [x] Learning collision
- [x] Creating proper hitboxes to fit the visual shape of an object
- [x] Programmatically combining shapes into a composite shape

### 💡 Reflections

Understanding collision is becoming easier but consistently applying it is still a challenge for me.


### 📋 Process

1. I initialized variables for both the player and screen sizes in decimal.
2. I created the variables "old_x" and "old_y" to save previous x and y positions within the update function.
3. I mapped player movement to the arrow keys to get input from the player.
4. I used the input from the player to update the player's x and y positions.
5. I got the player's top, bottom, left and right measurments relative to their current position on the screen.
6. I created a screen collision function
7. I applied the collision function to the player. If the collision flag proved true, the player reverted to their previous x and y position before the collision
8. I created a create_obstacle function
9. I created a obstacle collision function. The function loops through all the shapes in an obstacle to apply custom collisions
10. I applied it to the shape I created in the _init function

### 🔨 Tools & Resources

- Pico-8 
- Language: Lua