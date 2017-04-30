/obj/item/weapon/gun/verb/toggle_firerate()
	set name = "Toggle Firerate"
	set category = "Object"

	firerate = !firerate

	if (firerate)
		loc << "You will now continue firing when your target moves."
	else
		loc << "You will now only fire once, then lower your aim, when your target moves."

/obj/item/weapon/gun/verb/lower_aim()
	set name = "Lower Aim"
	set category = "Object"
	if(target)
		stop_aim()
		usr.visible_message("\blue \The [usr] lowers \the [src]...")

/obj/item/weapon/gun/equipped(var/mob/user, var/slot)

	return ..()

//Removes lock fro mall targets
/obj/item/weapon/gun/proc/stop_aim()
	if(target)
		for(var/mob/living/M in target)
			if(M)
				M.NotTargeted(src) //Untargeting people.
		del(target)

//Compute how to fire.....
/obj/item/weapon/gun/proc/PreFire(atom/A as mob|obj|turf|area, mob/living/user as mob|obj, params)
	//Lets not spam it.
	if(lock_time > world.time - 2) return
	.
	if(ismob(A) && isliving(A) && !(A in target))
		Aim(A) 	//Clicked a mob, aim at them
	else  		//Didn't click someone, check if there is anyone along that guntrace
		var/mob/living/M = GunTrace(usr.x,usr.y,A.x,A.y,usr.z,usr)  //Find dat mob.
		if(M && isliving(M) && M in view(user) && !(M in target))
			Aim(M) //Aha!  Aim at them!
		else if(!ismob(M) || (ismob(M) && !(M in view(user)))) //Nope!  They weren't there!
			Fire(A,user,params)  //Fire like normal, then.
	usr.dir = get_cardinal_dir(src, A)

//Aiming at the target mob.
/obj/item/weapon/gun/proc/Aim(var/mob/living/M)
	if(!target || !(M in target))
		lock_time = world.time
		if(target && !automatic) //If they're targeting someone and they have a non automatic weapon.
			for(var/mob/living/L in target)
				if(L)
					L.NotTargeted(src)
			del(target)
			usr.visible_message("\red <b>[usr] turns \the [src] on [M]!</b>")
		else
			usr.visible_message("\red <b>[usr] aims \a [src] at [M]!</b>")
		M.Targeted(src)

//HE MOVED, SHOOT HIM!
/obj/item/weapon/gun/proc/TargetActed(var/mob/living/T)
	var/mob/living/M = loc
	if(M == T) return
	if(!istype(M)) return
	if(src != M.get_held_item())
		stop_aim()
		return
	M.last_move_intent = world.time
	if(src.in_chamber && T in view(5,M))
		Fire(T,usr,reflex = 1)
	else
		click_empty(M)

	usr.dir = get_cardinal_dir(src, T)

	if (!firerate) // If firerate is set to lower aim after one shot, untarget the target
		T.NotTargeted(src)

//Yay, math!

#define SIGN(X) ((X<0)?-1:1)

proc/GunTrace(X1,Y1,X2,Y2,Z=1,exc_obj,PX1=16,PY1=16,PX2=16,PY2=16)
	//bluh << "Tracin' [X1],[Y1] to [X2],[Y2] on floor [Z]."
	var/turf/T
	var/mob/living/M
	if(X1==X2)
		if(Y1==Y2) return 0 //Light cannot be blocked on same tile
		else
			var/s = SIGN(Y2-Y1)
			Y1+=s
			while(1)
				T = locate(X1,Y1,Z)
				if(!T) return 0
				M = locate() in T
				if(M) return M
				M = locate() in orange(1,T)-exc_obj
				if(M) return M
				Y1+=s
	else
		var
			m=(32*(Y2-Y1)+(PY2-PY1))/(32*(X2-X1)+(PX2-PX1))
			b=(Y1+PY1/32-0.015625)-m*(X1+PX1/32-0.015625) //In tiles
			signX = SIGN(X2-X1)
			signY = SIGN(Y2-Y1)
		if(X1<X2) b+=m
		while(1)
			var/xvert = round(m*X1+b-Y1)
			if(xvert) Y1+=signY //Line exits tile vertically
			else X1+=signX //Line exits tile horizontally
			T = locate(X1,Y1,Z)
			if(!T) return 0
			M = locate() in T
			if(M) return M
			M = locate() in orange(1,T)-exc_obj
			if(M) return M
	return 0


//Targeting management procs
mob/var
	list/targeted_by
	target_time = -100
	last_move_intent = -100
	last_target_click = -5
	target_locked = null

mob/living/proc/Targeted(var/obj/item/weapon/gun/I) //Self explanitory.
	if(!I.target)
		I.target = list(src)
	else if(I.automatic && I.target.len < 5) //Automatic weapon, they can hold down a room.
		I.target += src
	else if(I.target.len >= 5)
		if(ismob(I.loc))
			I.loc << "You can only target 5 people at once!"
		return
	else
		return
	for(var/mob/living/K in viewers(usr))
		K << 'sound/weapons/TargetOn.ogg'

	if(!targeted_by) targeted_by = list()
	targeted_by += I
	I.lock_time = world.time + 20 //Target has 2 second to realize they're targeted and stop (or target the opponent).
	src << "((\red <b>Your character is being targeted. They have 2 seconds to stop any click or move actions.</b> \black While targeted, they may \
	drag and drop items in or into the map, speak, and click on interface buttons. Clicking on the map objects (floors and walls are fine), their items \
	 (other than a weapon to de-target), or moving will result in being fired upon. \red The aggressor may also fire manually, \
	 so try not to get on their bad side.\black ))"

	if(targeted_by.len == 1)
		spawn(0)
			if(istype(I,/obj/item/weapon/gun/energy/plasma_caster))
				target_locked = image("icon" = 'icons/effects/Targeted.dmi', "icon_state" = "locking-y")
			else
				target_locked = image("icon" = 'icons/effects/Targeted.dmi', "icon_state" = "locking")
			update_targeted()
			spawn(0)
				sleep(20)
				if(target_locked)
					if(istype(I,/obj/item/weapon/gun/energy/plasma_caster))
						target_locked = image("icon" = 'icons/effects/Targeted.dmi', "icon_state" = "locked-y")
					else
						target_locked = image("icon" = 'icons/effects/Targeted.dmi', "icon_state" = "locked")
					update_targeted()

	//Adding the buttons to the controller person
	var/mob/living/T = I.loc
	if(T)
		if(T.client)
			T.client.add_gun_icons()
		else
			I.lower_aim()
			return
//		if(m_intent == "run" && T.client.target_can_move == 1 && T.client.target_can_run == 0)
//			src << "\red Your move intent is now set to walk, as your targeter permits it."  //Self explanitory.
//			set_m_intent("walk")

		//Processing the aiming. Should be probably in separate object with process() but lasy.
		while(targeted_by && T.client)
			if(last_move_intent > I.lock_time + 10 && !T.client.target_can_move) //If target moved when not allowed to
				I.TargetActed(src)
				if(I.last_moved_mob == src) //If they were the last ones to move, give them more of a grace period, so that an automatic weapon can hold down a room better.
					I.lock_time = world.time + 5
				I.lock_time = world.time + 5
				I.last_moved_mob = src
			else if(last_move_intent > I.lock_time + 10 && !T.client.target_can_run && m_intent == "run") //If the target ran while targeted
				I.TargetActed(src)
				if(I.last_moved_mob == src) //If they were the last ones to move, give them more of a grace period, so that an automatic weapon can hold down a room better.
					I.lock_time = world.time + 5
				I.lock_time = world.time + 5
				I.last_moved_mob = src
			if(last_target_click > I.lock_time + 10 && !T.client.target_can_click) //If the target clicked the map to pick something up/shoot/etc
				I.TargetActed(src)
				if(I.last_moved_mob == src) //If they were the last ones to move, give them more of a grace period, so that an automatic weapon can hold down a room better.
					I.lock_time = world.time + 5
				I.lock_time = world.time + 5
				I.last_moved_mob = src
			sleep(1)

mob/living/proc/NotTargeted(var/obj/item/weapon/gun/I)
	if( !(I.flags_gun_features & GUN_SILENCED) )
		for(var/mob/living/M in viewers(src))
			M << 'sound/weapons/TargetOff.ogg'
	if(!isnull(targeted_by))
		targeted_by -= I

	if(I.target)//To prevent runtimes. This whole thing is such an awful mess. Might come back to later, sigh. ~N
		I.target.Remove(src) //De-target them
		if(!I.target.len) del(I.target) //What the hell.

	var/mob/living/T = I.loc //Remove the targeting icons
	if(T && ismob(T) && !I.target)
		T.client.remove_gun_icons()
	if(!targeted_by.len)
		del target_locked //Remove the overlay
		del targeted_by
	spawn(1) update_targeted()

mob/living/Move()
	. = ..()
	for(var/obj/item/weapon/gun/G in targeted_by) //Handle moving out of the gunner's view.
		var/mob/living/M = G.loc
		if(!(M in view(src)))
			NotTargeted(G)
	for(var/obj/item/weapon/gun/G in src) //Handle the gunner loosing sight of their target/s
		if(G.target)
			for(var/mob/living/M in G.target)
				if(M && !(M in view(src)))
					M.NotTargeted(G)

//If you move out of range, it isn't going to still stay locked on you any more.
client/var
	target_can_move = 0
	target_can_run = 0
	target_can_click = 0
	gun_mode = 0

//These are called by the on-screen buttons, adjusting what the victim can and cannot do.
client/proc/add_gun_icons()
	screen += usr.item_use_icon
	screen += usr.gun_move_icon
	if (target_can_move)
		screen += usr.gun_run_icon



client/proc/remove_gun_icons()
	if(!usr) return 1 // Runtime prevention on N00k agents spawning with SMG
	screen -= usr.item_use_icon
	screen -= usr.gun_move_icon
	if (target_can_move)
		screen -= usr.gun_run_icon

client/verb/ToggleGunMode()
	set hidden = 1
	gun_mode = !gun_mode
	if(gun_mode)
		usr << "You will now take people captive."
	else
		usr << "You will now shoot where you target."
		for(var/obj/item/weapon/gun/G in usr)
			G.stop_aim()
		remove_gun_icons()
	if(usr.gun_setting_icon)
		usr.gun_setting_icon.icon_state = "gun[gun_mode]"


client/verb/AllowTargetMove()
	set hidden=1

	//Changing client's permissions
	target_can_move = !target_can_move
	if(target_can_move)
		usr << "Target may now walk."
		//usr.gun_run_icon = new /obj/screen/gun/run(null)	//adding icon for running permission
		screen += usr.gun_run_icon
	else
		usr << "Target may no longer move."
		target_can_run = 0
		screen -= usr.gun_run_icon
		//del(usr.gun_run_icon)	//no need for icon for running permission

	//Updating walking permission button
	if(usr.gun_move_icon)
		usr.gun_move_icon.icon_state = "no_walk[target_can_move]"
		usr.gun_move_icon.name = "[target_can_move ? "Disallow" : "Allow"] Walking"

	//Handling change for all the guns on client
	for(var/obj/item/weapon/gun/G in usr)
		G.lock_time = world.time + 5
		if(G.target)
			for(var/mob/living/M in G.target)
				if(target_can_move)
					M << "Your character may now <b>walk</b> at the discretion of their targeter."
					if(!target_can_run)
						M << "\red Your move intent is now set to walk, as your targeter permits it."
						M.set_m_intent("walk")
				else
					M << "\red <b>Your character will now be shot if they move.</b>"

mob/living/proc/set_m_intent(var/intent)
	if (intent != "walk" && intent != "run")
		return 0
	m_intent = intent
	if(hud_used)
		if (hud_used.move_intent)
			hud_used.move_intent.icon_state = intent == "walk" ? "walking" : "running"

client/verb/AllowTargetRun()
	set hidden=1

	//Changing client's permissions
	target_can_run = !target_can_run
	if(target_can_run)
		usr << "Target may now run."
	else
		usr << "Target may no longer run."

	//Updating running permission button
	if(usr.gun_run_icon)
		usr.gun_run_icon.icon_state = "no_run[target_can_run]"
		usr.gun_run_icon.name = "[target_can_run ? "Disallow" : "Allow"] Running"

	//Handling change for all the guns on client
	for(var/obj/item/weapon/gun/G in src)
		G.lock_time = world.time + 5
		if(G.target)
			for(var/mob/living/M in G.target)
				if(target_can_run)
					M << "Your character may now <b>run</b> at the discretion of their targeter."
				else
					M << "\red <b>Your character will now be shot if they run.</b>"

client/verb/AllowTargetClick()
	set hidden=1

	//Changing client's permissions
	target_can_click = !target_can_click
	if(target_can_click)
		usr << "Target may now use items."
	else
		usr << "Target may no longer use items."

	if(usr.item_use_icon)
		usr.item_use_icon.icon_state = "no_item[target_can_click]"
		usr.item_use_icon.name = "[target_can_click ? "Disallow" : "Allow"] Item Use"

	//Handling change for all the guns on client
	for(var/obj/item/weapon/gun/G in src)
		G.lock_time = world.time + 5
		if(G.target)
			for(var/mob/living/M in G.target)
				if(target_can_click)
					M << "Your character may now <b>use items</b> at the discretion of their targeter."
				else
					M << "\red <b>Your character will now be shot if they use items.</b>"
