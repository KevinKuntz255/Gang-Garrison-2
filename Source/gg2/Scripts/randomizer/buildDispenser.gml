var player, xPos, yPos;

player = argument0;
xPos = argument1;
yPos = argument2;

if(!player.dispenser)
{
    player.dispenser = instance_create(xPos, yPos, player.object.buildObject[1]);
    player.dispenser.ownerPlayer = player;
    player.dispenser.team = player.team;
}
else
{
    player.dispenser.x = xPos;
    player.dispenser.y = yPos;
}

player.dispenser.startDirection = 1;
player.dispenser.image_xscale = 1;
player.object.nutsNBolts -= 50;
