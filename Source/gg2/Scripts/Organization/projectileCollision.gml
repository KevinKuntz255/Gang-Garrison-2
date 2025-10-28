// projectileCollision( sourcePlayer, damagedCharacter, damageDealt, projectile, blood)
// note: meant only for Character interactions
var shootingPlayer,shotCharacter,damage,projectile,blood;
shootingPlayer = argument0;
shotCharacter = argument1;
damage = argument2;
projectile = argument3;
blood = argument4;

execute_string( global.projectileCollisionFunction, argument0, argument1, argument2, argument3, argument4); // place before everything so as to override INVIS exit
// be smart of you or me to add it back in case you still need it, eh fugg around n find out
for(i=0; i<2; i+=1) {
    /* todo: test this if statement, might need to pass the variables like this
        if (argument1.abilityActive[i])
        {
            if (argument1.ability[i] == INVULN)
            {
    
            }
        }
    */
    if (shotCharacter.abilityActive[i] and shotCharacter.ability[i] == INVULN)
    {
        var text;
        text=instance_create(argument3.x,argument3.y,Text);
        text.sprite_index=MissS;
        exit;
    }
    //with(shootingPlayer) {
    if(shootingPlayer.object != -1) {
        if (shootingPlayer.object.rechargeAbility[i] == DAMAGE)
        {
            shootingPlayer.object.meter[i] += damage;
        }
    }
    
}

/* crit randomization code, disabled/commented
todo: server-side option to enable crits
if random(100) < 15 && crit < 1.15 shot.crit = 1.35;
*/

if shotCharacter.tracker.alarm[SOAK_PISS] >= 1 and argument3.crit < 1.35
    argument3.crit = 1.15;

if (argument3.crit > 1) {
    with(Text)
    {
        if (variable_local_exists("owner")) {
            if (owner == other.shootingPlayer) {
                instance_destroy(); // cleaner, and closer to original tf2
            }    
        }
    }
}
if (argument3.crit == 1.15) {
    var text;
    text=instance_create(argument1.x,argument1.y,Text);
    text.sprite_index=MiniCritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}
if (argument3.crit >= 1.35) {
    var text;
    text=instance_create(argument1.x,argument1.y,Text);
    text.sprite_index=CritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}

switch(projectile.weapon)
{
    case DAMAGE_SOURCE_BLACKBOX:
        if (shootingPlayer.object != -1)  
            if (shotCharacter != shootingPlayer.object) shootingPlayer.object.hp += damage*0.3;
    break;
}


if shotCharacter.tracker.alarm[SOAK_MILK] >= 1
    if (shootingPlayer.object != -1) shootingPlayer.object.hp += damage*0.35;


damageCharacter(shootingPlayer, shotCharacter.id, damage*projectile.crit, projectile);

if (shotCharacter.lastDamageDealer != shootingPlayer and shotCharacter.lastDamageDealer != shotCharacter.player)
{
    shotCharacter.secondToLastDamageDealer = shotCharacter.lastDamageDealer;
    shotCharacter.alarm[4] = shotCharacter.alarm[3]
}
shotCharacter.alarm[3] = ASSIST_TIME / global.delta_factor;
shotCharacter.lastDamageDealer = shootingPlayer;
shotCharacter.lastDamageSource = projectile.weapon;
//shotCharacter.lastDamageCrit = projectile.crit;

if(global.gibLevel > 0 and blood > 0)
{
    repeat(blood)
    {
        blood = instance_create(x,y,Blood);
        blood.direction = direction-180;
    }
}
dealFlicker(shotCharacter.id);
