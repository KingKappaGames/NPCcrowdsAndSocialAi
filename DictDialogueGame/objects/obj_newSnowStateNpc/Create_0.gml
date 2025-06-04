moveSpd = 1;
directionFacing = 1;


fsm = new SnowState("idle");
fsm.add("idle", {
    enter: function() {
      sprite_index = spr_blibby;
    },
    step: function() {
      if (keyboard_check(vk_right) || keyboard_check(vk_left) || keyboard_check(vk_up) || keyboard_check(vk_down)) {
		  if(keyboard_check(vk_shift)) {
			 fsm.change("fly");
		  } else {
			  fsm.change("walk");
		  }
      }
    },
    draw: function() {
      draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * directionFacing, image_yscale, image_angle, image_blend, image_alpha);
    }
});

fsm.add("walk", {
    enter: function() {
		moveSpd = 1;
        sprite_index = spr_blibbyWalk;
    },
    step: function() {
	  var _moving = false;
      if (keyboard_check(vk_right)) {
			x += moveSpd;
			directionFacing = 1;
			_moving = true;
      }
	  if (keyboard_check(vk_left)) {
			x -= moveSpd;
			directionFacing = -1;
			_moving = true;
      }
	  if (keyboard_check(vk_down)) {
			y += moveSpd;
			_moving = true;
      }
	  if (keyboard_check(vk_up)) {
			y -= moveSpd;
			_moving = true;
      }
	  if(_moving == false) {
		  fsm.change("idle");
	  } else if(keyboard_check(vk_shift)) {
			fsm.change("fly");
	  }
    },
    draw: function() {
      draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * directionFacing, image_yscale, image_angle, image_blend, image_alpha);
    }
});

fsm.add_child("walk", "fly", {
    enter: function() {
      sprite_index = spr_blibbyFly;
	  moveSpd = 8;
    },
    step: function() {
		fsm.inherit();
		if(!keyboard_check(vk_shift)) {
			fsm.change("walk");
		}
    },
    draw: function() {
      draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * directionFacing, image_yscale, image_angle, image_blend, image_alpha);
    }
});