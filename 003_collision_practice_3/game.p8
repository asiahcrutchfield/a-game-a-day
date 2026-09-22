pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
	-- default sprite size in decimal --
		width = 8
		height = 8
	-- default screen size in decimal --
		scr_width = 128
		scr_height = 128
	-- player --
		player = {
			-- player start coordinates --
				x = 0,
				y = 0,
			-- player dimensions --
				w = 8,
				h = 8,
			-- player speed --
				speed = 2		
		}
	-- screen boundaries --
		upper_left = 0
		lower_right = scr_height-1
	-- piece definitions (blueprints) --
	-- 1. horizontal piece: starts at (0,0) offset, drawn 2 tiles wide (16px)
	h_piece = {
		spr_num = 2,
		ox = 0,
		oy = 0,
		h = height - 1,
		w = (width * 2) - 1, -- 15px bounding width
		tw = 2,              -- draws across 2 tile slots
		th = 1,
		horizontal = true
	}

	-- 2. vertical piece: starts at the same (0,0) origin to form the l corner
	v_piece = {
		spr_num = 3,
		ox = 0,              -- attached at origin (top-left corner)
		oy = 0,              -- attached at origin
		h = (height * 2) - 1,-- 15px bounding height
		w = width - 1,
		tw = 1,
		th = 2,              -- draws 2 tiles tall
		horizontal = false
	}

	-- obstacle table --
		obstacles = {}
		l_shape = create_obstacle(30, 50, {h_piece, v_piece})
		add(obstacles, l_shape)
	-- calculate obstacle boundaries --
		for obs in all(obstacles) do
			for pce in all(obs.pieces) do
						pce.left = pce.x
						pce.top = pce.y
						pce.right = pce.left + pce.w
						pce.bottom = pce.top + pce.h	
				end
		end
end

function _update()
	-- 1. get most recent player position --
		old_x = player.x
		old_y = player.y
	-- 2. player movement --
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
		player.top = player.y
		player.left = player.x
		player.right = player.left + (player.w-1)
		player.bottom = player.top + (player.h-1)
	-- 4. screen collision --
		if player.top < upper_left 
		or player.left < upper_left then
			player.y = old_y
			player.x = old_x
		end
		
		if player.right > lower_right 
		or player.bottom > lower_right then
			player.y = old_y
			player.x = old_x
		end
	-- 5. create obstacle table --
	-- 6. populate obstacle table in _init --
	-- 7. iterate through collision table --
		for obs in all(obstacles) do
			for pce in all(obs.pieces) do
				-- calculate collision --
					if is_colliding(pce.left,
					pce.right,pce.top,
					pce.bottom,player) then
							player.x = old_x
							player.y = old_y
					end	
				end			
		end
end

function _draw()
	cls()
	-- player --
	spr(1, player.x, player.y)

	-- obstacle --
	for combo in all(obstacles) do
		for obs in all(combo.pieces) do
			-- draws a solid white rectangle for each piece --
			spr(obs.spr_num, obs.x, obs.y, obs.tw, obs.th)
		end
	end
end

function is_colliding(left, right, top, bottom, player)
	if player.right >= left and
	   player.left <= right and
	   player.top <= bottom and
	   player.bottom >= top then
		return true
	end
	return false
end

function create_obstacle(x_start, y_start, blueprint)
	local new_obstacle = {
		x = x_start,
		y = y_start,
		pieces = {}
	}

	for bp in all(blueprint) do
		local off_x = bp.ox or 0
		local off_y = bp.oy or 0

		if bp.horizontal then
			-- loop through tile width and lay down sprite 2 side-by-side
			for i = 0, bp.tw - 1 do
				local piece = {
					spr_num = bp.spr_num,
					x = x_start + off_x + (i * 8),
					y = y_start + off_y,
					w = 7,
					h = 1,
					tw = 1,
					th = 1,
					horizontal = true
				}
				add(new_obstacle.pieces, piece)
			end
		else
			-- loop through tile height and lay down sprite 3 top-to-bottom
			for i = 0, bp.th - 1 do
				local piece = {
					spr_num = bp.spr_num,
					x = x_start + off_x,
					y = y_start + off_y + (i * 8),
					w = 1,
					h = 7,
					tw = 1,
					th = 1,
					horizontal = false
				}
				add(new_obstacle.pieces, piece)
			end
		end
	end

	return new_obstacle 	
end
__gfx__
00000000aaaaaaaa7777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a77aa77a7777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700a77aa77a0000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaa0000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007007aaaaaa70000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a777777a0000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aaaaaaaa0000000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
