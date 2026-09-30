pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- 007 collision game 3 --

function _init()
	-- sprite dimensions (decimal) --
		spr_w = 8
		spr_h = 8
	-- screen dimensions (decimal) --
		scr_w = 128
		scr_h = 128
	-- player --		
		player = {
			spr_num = 7,
			-- dimensions --
				w = spr_w-1,
				h = spr_h-1,
			-- position --
				x = 0,
				y = 0,
				speed = 2
		}
	-- level pieces --
		-- vertical --
			hz_btm = {
				spr_num = 1,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
			hz_mid = {
				spr_num = 2,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
			hz_top = {
				spr_num = 3,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
		-- horizontal --
			vt_right = {
				spr_num = 4,
				w = spr_w-1,
				h = spr_h-1,
				vertical = true
			}
			vt_mid = {
				spr_num = 5,
				w = spr_w-1,
				h = spr_h-1,
				vertical = true
			}
			vt_left = {
				spr_num = 6,
				w = spr_w-1,
				h = spr_h-1,
				vertical = true
			}
	-- grid --
		grid_size = {
			cols = scr_w/spr_w,
			rows = scr_h/spr_h
		}
		-- empty grid --
			map_grid = init_grid(grid_size)
		-- create shapes --
			hz_bars = {
				["6"] = "0033333333333300",
				["8"] = "0011111111111100"
			}
		-- grid population --
			
end

function _update()
	-- 1. get old x/y positions --
		old_x = player.x
		old_y = player.y
	-- 2. update player positions --
		if btn(0) then
			player.x -= player.speed
		end		
		if btn(1) then
			player.x += player.speed
		end
		if btn(2) then
			player.y -= player.speed
		end
		if btn(3) then
			player.y += player.speed
		end
	-- 3. define player boundaries --
		player.top = player.y
		player.left = player.x
		player.right = player.left + player.w
		player.btm = player.top + player.h
	-- 4. create grid initialization fucntion --
	-- 5. create screen collision function --
	-- 6. apply screen collision --
		if screen_collision() then
			player.x = old_x
			player.y = old_y
		end
	-- 7. create lvl piece collision function --
	
end

function _draw()
	cls()
	-- player --
		spr(player.spr_num,player.x,
			player.y)
end


-->8
function init_grid(grid_size)
	-- 1. init empty grid --
		local grid = {}
	-- 2. loop through rows --
		for r = 1,grid_size.rows do
	-- 3. initialize empty line in row --
			local line = ""
	-- 4. loop through columns --
			for c = 1,grid_size.cols do
	-- 5.append empty space ("o") to line --
				line ..= "0"
			end
	-- 6. add line to grid --
			add(grid, line)
		end
		return grid
end

function screen_collision()
	-- 1. define screen boundaries --
		scr_left = scr_w - scr_w
		scr_top = scr_h - scr_h
		scr_right = scr_left + (scr_w-1)
		scr_btm = scr_top + (scr_h-1)
	-- 2. define collision conditions --
		if player.left < scr_left or
			player.right > scr_right or
			player.btm > scr_btm or
			player.top < scr_top then
				return true
		end
		return false
end

function lvl_piece_collision(
	lvl_piece,px,py)
	-- 1. define table of pieces --
		lvl_pieces = {
			["1"] = vt_btm,
			["2"] = vt_mid,
			["3"] = vt_top,
			["4"] = hz_right,
			["5"] = hz_mid,
			["6"] = hz_left
		}
	-- 2. define variable for selected piece --
		local template = lvl_pieces[lvl_piece] 
	-- 3. handle empty grid space --
		if not template then
			return nil
		end
	-- 4. define piece table for template --
	-- for return purposes --
		local piece = {
			spr_num = template.spr_num,
			x = px,
			y = py
		}
	-- 5. define default boundaries --
		if template.vertical == false then
			piece.left = piece.x
			piece.right = piece.left + template.w
			piece.top = piece.y
			piece.btm = piece.top + template.h
		else
			piece.left = px + 3
			piece.right = px + 3
			piece.top = py
			piece.btm = py + template.h                  
		end
	-- 6. define custom boundaries --		
		if lvl_piece == "1" then
			piece.top = py + 6
		elseif lvl_piece == "2" then
			piece.top = py + 3
			piece.btm = piece.top + 1
		elseif lvl_piece == "3" then
			piece.btm = py + 3
		elseif lvl_piece == "4" then
			piece.right = piece.left + 2
		elseif lvl_piece == "6" then
			piece.left = px
			piece.right = px + 3
		end
	
	return piece
end

function get_coordinates(shape)
	-- 1. create table --
		local coordinates = {}
	-- 2. loop through shape --
		for r=1,#shape do
			
		end
end
__gfx__
80000008000000000000000077777777000000770007700077000000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
08000080000000000000000077777777000000770007700077000000a77aa77a0000000000000000000000000000000000000000000000000000000000000000
00800800000000000000000000000000000000770007700077000000a77aa77a0000000000000000000000000000000000000000000000000000000000000000
00088000000000007777777700000000000000770007700077000000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
00088000000000007777777700000000000000770007700077000000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
008008000000000000000000000000000000007700077000770000007aaaaaa70000000000000000000000000000000000000000000000000000000000000000
08000080777777770000000000000000000000770007700077000000a777777a0000000000000000000000000000000000000000000000000000000000000000
80000008777777770000000000000000000000770007700077000000aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
