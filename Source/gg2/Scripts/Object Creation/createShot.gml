//createShot(x, y, projectile, damageSource, direction, projectileSpeed)

var _x, _y, projectile, damageSource, dir, projectileSpeed, shot;
_x = argument0;
_y = argument1;
projectile = argument2;
damageSource = argument3;
dir = argument4;
projectileSpeed = argument5;

shot = instance_create(_x,_y,projectile);
with(shot)
{
    direction = dir;
    image_angle = dir;
    speed = projectileSpeed;
    owner = other.owner;
    ownerPlayer = other.ownerPlayer;
    team = owner.team;
    weapon = damageSource;
    crit = owner.currentWeapon.crit;
    gun = owner.currentWeapon; // this is used in Blade and RocketLauncher, now its used in all shot creations
}

return shot;
