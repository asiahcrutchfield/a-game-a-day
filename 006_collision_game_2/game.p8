pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- 006 collision game 2 --

function _init()
	-- define sprite dimensions (decimal) --
		spr_w = 8
		spr_h = 8
	-- define screen dimension (decimal) --
		scr_w = 128
		scr_h = 128
	-- player --
		player = {
			spr_num = 7,
			x = 0,
			y = 0,
			w = spr_w-1,
			h = spr_h-1,
			speed = 2
		}
	-- screen --
		screen = {
			left = 0,
			top = 0,
			right = scr_w-1,
			btm = scr_h-1
		}
	-- level pieces --
		-- horizontal pieces --
			hz_top = {
				spr_num = 1,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
			hz_mid = {
				spr_num = 1,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
			hz_btm = {
				spr_num = 1,
				w = spr_w-1,
				h = spr_h-1,
				vertical = false
			}
		-- vertical pieces --
			vt_left = {
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
			vt_right = {
				spr_num = 6,
				w = spr_w-1,
				h = spr_h-1,
				vertical = true
			}
	-- map grid --
		grid_size = {
			col = scr_w/spr_w,
			row = scr_h/spr_h
		}
		-- initialize grid --
			map_grid = init_grid(
				grid_size.row,grid_size.col)
		-- draw pieces --
			draw_hline(map_grid,
				4,12,5,"1")
				draw_hline(map_grid,
				4,12,7,"1")
		-- create grid out of modified grid --
			hz_bars = draw_map(map_grid)
end

function _update()
	-- 1. define old x and y positions --
		old_x = player.x
		old_y = player.y
	-- 2. update player position --
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
	-- 3. update player dimensions --
		player.left = player.x
		player.top = player.y
		player.right = player.left + player.w
		player.btm = player.top + player.h
	-- 4. create screen collision function --
	-- 5. apply screen collision --
		if scr_collision() or 
			check_obs_collision(hz_bars) then
    player.x = old_x
    player.y = old_y
		end
	-- 6. create grid initialization function --
	-- 7. initialize grid in _init --
	-- 8. create set piece function --
	-- 9. create draw horizontal function --
	-- 10. create draw vertical function --
	-- 11. create draw horizontal function --
	-- 12. create draw map function --
	-- 12. create obstacle collision function --
end

function _draw()
	cls()
	-- player --
		spr(player.spr_num,player.x,player.y)
	-- obstacle --
		for pce in all(hz_bars) do
			spr(pce.spr_num, pce.x, pce.y)
		end
end

function scr_collision()
	-- 1. compare screen and player boundaries --
		if player.left < screen.left or
			player.right > screen.right or
			player.btm > screen.btm or
			player.top < screen.top then
			return true
		end
		
		return false
end

function init_grid(rows,cols)
	-- 1. create grid table --
		local grid = {}
	-- 2. loop through rows --
		for r = 1, rows do
			local line = ""
			-- ex: {""} --
	-- 3. loop through columns --
			for c = 1, cols do
				line ..= "0"
				-- ex: {"0"} --
				-- ex: {"00"} --
				-- ex: {"000"} --
				-- ex: {"0000..."} --
			end
			add(grid,line)
		end
	-- 4. return the grid --
		return grid
end

function set_piece(grid,row,col,tile_char)
	-- 1. get row number and content --
		local line = grid[row]
	-- 2. cut line and replace concat	tile character -
		grid[row] = sub(line,1,col-1)
		 ..tile_char.. sub(line,col+1)
		-- ex: grid[row] = "00000" --
		-- sub(line,1,col-1(ex:col=4. col-1=3) --
		-- sub(line,1,col-1) = "000" --
		-- ..tile_char.. (ex: tile_char = "a") --
		-- "000" + "a" --
		--	sub(line,col+1) = "0" --
		-- "000" + "a" + "0" --
		-- "000a0" --			
end

function draw_hline(grid,
	start_col,end_col,row,
	tile_char)
	for c = start_col,end_col do
		set_piece(grid, row, c, tile_char)
	end
end

function draw_vline(grid, col, start_row, end_row, tile_char)
	for r = start_row, end_row do
		set_piece(grid, r, col, tile_char)
	end
end

function apply_collision_box(tile_type, px, py)
	tile_types = {
		["1"] = hz_top,
		["2"] = hz_mid,
		["3"] = hz_btm,
		["4"] = vt_left,
		["5"] = vt_mid,
		["6"] = vt_right
	}
	local template = tile_types[tile_type]
	
	if not template then 
		return nil 
	end

	local piece = {
		spr_num = template.spr_num,
		x = px,
		y = py
	}

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
	
	if tile_type == "1" then
		piece.btm = piece.top + 1
	elseif tile_type == "2" then
		piece.top = py + 3
		piece.btm = piece.top + 1
	elseif tile_type == "3" then
		piece.top = py + 6
	elseif tile_type == "4" then
		piece.right = piece.left + 2
	elseif tile_type == "6" then
		piece.left = px + 6
	end
	
	return piece
end

function draw_map(grid)
	local obstacle = {}
	
	for row = 1, #grid do
		local line = grid[row]
		for col = 1, #line do
			local char = sub(line, col, col)
			local px = (col - 1) * spr_w
			local py = (row - 1) * spr_h
			local piece = apply_collision_box(char, px, py)
			
			if piece then    
				add(obstacle, piece)
			end
		end
	end
	return obstacle
end

function check_obs_collision(obs)
	for pce in all(obs) do
		if player.right >= pce.left and
			player.left <= pce.right and
			player.top <= pce.btm and
			player.btm >= pce.top then
				return true
			end
	end
	return false
end
__gfx__
00000000777777770000000000000000770000000007700000000077aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
00000000777777770000000000000000770000000007700000000077a77aa77a0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000770000000007700000000077a77aa77a0000000000000000000000000000000000000000000000000000000000000000
00000000000000007777777700000000770000000007700000000077aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
00000000000000007777777700000000770000000007700000000077aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000007700000000077000000000777aaaaaa70000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000077777777770000000007700000000077a777777a0000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000077777777770000000007700000000077aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000
