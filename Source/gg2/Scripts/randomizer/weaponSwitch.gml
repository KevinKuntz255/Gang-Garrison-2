with(currentWeapon) instance_destroy();

currentWeapon = -1;

global.paramOwner = id;

currentWeapon = instance_create(x,y,global.weapons[argument0]);

global.paramOwner = noone;

if !cloak playsound(x,y,SwitchSnd);
