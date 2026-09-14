pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
-- coordinates to draw obstacle --
 x=64
 y=64
-- player start coordinates --
	player_x=0
	player_y=0
	speed=3
-- player edges -- 
	player_l=0
	player_t=0
	player_btm=player_t + 7
	player_r=player_l + 7
	player_w=player_r-player_l
	player_h=player_btm-player_t
-- obstacle edges --
	obstacle_l=x
	obstacle_t=y
	obstacle_r=x + 7
	obstacle_btm=y + 7
-- screen edges --
	left_edge=0
	right_edge=127
	top_edge=0
	bottom_edge=127
-- collision flag --
	collision = false 
end

function _update()
	local old_x = player_x
	local old_y = player_y
-- player movement --
	if btn(0) then
		player_x-=speed
	end
	
	if btn(1) then
		player_x+=speed
	end
	
	if btn(2) then
		player_y-=speed
	end
	
	if btn(3) then
		player_y+=speed
	end
-- update player dimensions --
	player_l=player_x
	player_t=player_y
	player_btm=player_t + (8-1)
	player_r=player_l + (8-1)
	player_w=player_r-player_l
	player_h=player_btm-player_t
-- 4. obstacle detection --
	if is_colliding() then
		-- pushes the player back to where they were safely standing last frame
		player_x = old_x
		player_y = old_y
		
		-- force dimensions to update to the safe coordinates immediately
		player_l=player_x
		player_t=player_y
		player_btm=player_t + (8-1)
		player_r=player_l + (8-1)
	end
-- screen detection --
	if player_l<left_edge then
		player_x=left_edge
	end
	
	if player_t<top_edge then
		player_y=top_edge
	end
	
	if player_r>right_edge then
		player_x=right_edge-player_w
	end

	if player_btm>bottom_edge then
		player_y=bottom_edge-player_h
	end
end

function _draw()
	cls(1)
	spr(1,player_x,player_y)
	spr(2,x,y)
end

-- obstacle detection --
function is_colliding()
	-- if any of these are true, the boxes are completely separate!
	if player_r < obstacle_l then 
		return false 
	end -- player is too far left
	if player_l > obstacle_r then 
		return false 
	end -- player is too far right
	if player_btm < obstacle_t then
	 return false 
	end -- player is too far up
	if player_t > obstacle_btm then
	 return false 
	end -- player is too far down
	
	-- if none of the above are true, the rectangles must be overlapping!
	return true
end
__gfx__
00000000007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000a77a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007777000888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000770000888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000077777700888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077777700888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
