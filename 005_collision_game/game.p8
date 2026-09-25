pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- 005 collision game --

function _init()
	-- define pixel dimensions (decimal) --
		p_w = 8
		p_h	= 8
	-- screen --
		screen = {
			-- standard screen dimensions (decimal) --
				w = 128,
				h = 128,
			-- screen dimensions --
				y = 0,
				x = 0				
		}
		screen.top = screen.y
		screen.left = screen.x
		screen.right = screen.left+screen.w-1
		screen.btm = screen.top+screen.h-1
	-- player --
		player = {
			spr_num = 7,
			-- start coordinates --
				x = 0,
				y = 0,
				speed = 2,
			-- player dimensions --
				w = p_w - 1,
				h = p_h - 1
		}
	-- obstacle pieces --
		-- horizontal pieces --
			hz_top = {
				spr_num = 1,
				h = p_h - 1,
				w = p_w - 1,
				vertical = false,
				orientation = "top"
			}
			hz_mid = {
				spr_num = 2,
				h = p_h - 1,
				w = p_w - 1,
				vertical = false,
				orientation = "mid"
			}
			hz_btm = {
				spr_num = 3,
				h = p_h - 1,
				w = p_w - 1,
				vertical = false,
				orientation = "btm"
			}
		-- vertical pieces --
			vt_left = {
				spr_num = 4,
				h = p_h - 1,
				w = p_w - 1,
				vertical = true,
				orientation = "left"
			}
			vt_mid = {
				spr_num = 5,
				h = p_h - 1,
				w = p_w - 1,
				vertical = true,
				orientation = "mid"
			}
			vt_right = {
				spr_num = 6,
				h = p_h - 1,
				w = p_w - 1,
				vertical = true,
				orientation = "right"
			}
	-- map grid --
		map_size = {
			col = screen.w/p_w,
			rows = screen.h/p_h
		}
		-- initialize empty grid --
			map_grid = create_empty_grid(
				map_size.col, map_size.rows)
		-- initialized grid --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
			-- 0000000000000000 --
		-- paint level layout --  
			draw_hline(map_grid, 6, 12, 6, "1")    -- top horizontal bar
			draw_hline(map_grid, 6, 12, 8, "1")    -- bottom horizontal bar
		-- generate level pieces --
			level = build_grid_map(0, 0, map_grid)
end

function _update()
	-- 1. capture player x and y --
		old_x = player.x
		old_y = player.y
	-- 2. get user input and update player position --
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
	-- 3. calculate player dimensions --
		player.top = player.y
		player.left = player.x
		player.right = player.left + player.w
		player.btm = player.top + player.h
	-- 4. create screen collision function --
	-- 5. apply screen collision --
		if screen_collision() or
			check_obstacle_collision(
			player, level) then
			player.x = old_x
			player.y = old_y
		end
	-- 6. create empty grid function --
	-- 7. initialize empty grid --
	-- 8. create collision box function --
	-- 9. create horizontal line function --
	-- 10. create vertical line function --
	-- 11. create map builder function --		
end

function _draw()
	cls()
	-- 1. draw all obstacle pieces --
		for pce in all(level.pieces) do
			spr(pce.spr_num, pce.x, pce.y)
		end
	-- 2. draw player --
		spr(player.spr_num, player.x, player.y)
end

function screen_collision()
	if player.top < screen.top or
		player.left < screen.left or
		player.right > screen.right or
		player.btm > screen.btm then
		return true
	end
	return false
end

function create_empty_grid(cols, rows)
	local grid = {}
	for r = 1, rows do
		local line = ""
		for c = 1, cols do
			line ..= "0"
		end
		add(grid, line)
	end
	return grid
end

function apply_collision_box(
	tile_type,px,py)
	-- 1. make collision map --
		tile_types = {
			["1"] = hz_top,
			["2"] = hz_mid,
			["3"] = hz_btm,
			["4"] = vt_left,
			["5"] = vt_mid,
			["6"] = vt_right
		}
		local template = tile_types[tile_type]
		
		-- return empty/nil if empty floor tile ("0")
			if not template then 
				return nil 
			end
	-- 2. create piece table --
		local piece = {
			spr_num = template.spr_num,
			x = px,
			y = py
		}
	-- 3. apply collision box --
		if template.vertical == false then
			piece.left = px
			piece.right = piece.left + template.w
			piece.top = py
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

function set_tile(grid, col, row, tile_char)
	local line = grid[row]
	grid[row] = sub(line, 1, col - 1) .. tile_char .. sub(line, col + 1)
end

function draw_hline(grid, start_col, end_col, row, tile_char)
	for c = start_col, end_col do
		set_tile(grid, c, row, tile_char)
	end
end

function draw_vline(grid, col, start_row, end_row, tile_char)
	for r = start_row, end_row do
		set_tile(grid, col, r, tile_char)
	end
end

-- grid map converter --
	function build_grid_map(x_start, y_start, map)
		local obstacle = {
			x = x_start,
			y = y_start,
			pieces = {}
		}
		
		for row = 1, #map do
			local line = map[row]
			for col = 1, #line do
				local char = sub(line, col, col)
				local px = x_start + (col - 1) * p_w
				local py = y_start + (row - 1) * p_h
				
				local piece = apply_collision_box(char, px, py)
				if piece then
					add(obstacle.pieces, piece)
				end
			end
		end
		
		return obstacle
	end

-- obstacle collision checker --
	function check_obstacle_collision(ply, obs)
		for pce in all(obs.pieces) do
			if ply.right >= pce.left and
			   ply.left <= pce.right and
			   ply.btm >= pce.top and
			   ply.top <= pce.btm then
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
