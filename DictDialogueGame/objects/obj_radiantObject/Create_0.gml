xChange = 0;
yChange = 0;

alignment = random(1);
danger = random(1);

range = irandom_range(15, 60) + irandom_range(15, 40);

destroyable = false;

// functions for acting on these objects, to "help¨ them or to destroy them (null representing not possible) 
// the purpose of this would be to provide a standard format for npcs that are anti
// this object but also willing to act against them to "hurt" them (if it's fire that would be putting it out)
// or if it's a dark crystal they would attack it, or a good construct maybe they run to heal it
// these functions would need to take some general form like hurt->aiActionFight or help->aiActionFix or some
// kind of generic behavior relating to this, or just a good scripting language for npcs, that would probably be 
// better actually, the item being able to call the npc over, then send it a set of behavior instructions
// that would run on a framework like many things, I suppose this will be required anyway, hard to make npcs do
// anything without a way to communicate goals and behaviors to them... Anyway...