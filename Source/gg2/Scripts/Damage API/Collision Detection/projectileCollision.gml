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
for(i=0; i<2; i+=1) 
{
    /* todo: test this if statement with ACTIVE specific abilities, might need to pass the variables like this
        if (argument1.abilityActive[i])
        {
            if (argument1.ability[i] == ABILITY_INVULN)
            {
    
            }
        }
    */
    if (shotCharacter.abilityActive[i] and shotCharacter.ability[i] == ABILITY_INVULN)
    {
        var text;
        text=instance_create(argument3.x,argument3.y,Text);
        text.sprite_index=MissS;
        exit;
    }
    //with(shootingPlayer) {
    if(shootingPlayer.object != -1) {
        if (shootingPlayer.object.rechargeAbility[i] == ACHARGE_DAMAGE)
        {
            shootingPlayer.object.meter[i] += damage;
        }
    }   
}

/* crit randomization code, disabled/commented
todo: server-side option to enable random crits
if random(100) < 15 && crit < 1.15 shot.crit = 1.35;
*/

if shotCharacter.tracker.alarm[SOAK_PISS] >= 1 and argument3.crit < 1.35
    argument3.crit = 1.15;
    
if (shootingPlayer.object != -1) {
    switch(projectile.weapon)
    {
        case DAMAGE_SOURCE_BLACKBOX:
            if (shotCharacter != shootingPlayer.object) shootingPlayer.object.hp += damage*0.3;
        break;
        case DAMAGE_SOURCE_BLUTSAUGER:
            shootingPlayer.object.hp += 1;
            var text;
            text=instance_create(shootingPlayer.object.x,shootingPlayer.object.y - 8,Text);
            text.sprite_index=PlusOneS;
            if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
        break;
        case DAMAGE_SOURCE_RSHOOTER:
            if (!shotCharacter.onground and shotCharacter.moveStatus == 3 and projectile.crit < 1.15)
                projectile.crit = 1.15;
        break;
        case DAMAGE_SOURCE_AXE:
            if (shotCharacter.burnDuration > 0 and projectile.crit <= 1.35) 
                projectile.crit *= 1.43;
        break;
    }
    
    
    if shotCharacter.tracker.alarm[SOAK_MILK] >= 1
        shootingPlayer.object.hp += damage*0.35;
}

//if (argument3.crit > 1) {
    with(Text)
    {
        if (variable_local_exists("owner")) {
            if (owner == other.argument0) {
                instance_destroy(); // cleaner, and closer to original tf2
            }    
        }
    }
//}

// todo: two crit sprites? thats dumb
if (argument3.crit == 1.15) {
    var text;
    text=instance_create(shotCharacter.x,shotCharacter.y,Text);
    text.sprite_index=MiniCritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}
if (argument3.crit >= 1.35) {
    var text;
    text=instance_create(shotCharacter.x,shotCharacter.y,Text);
    text.sprite_index=CritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}

//(1*0.35) outdated and unused crit reduction. just modify the whole crit instead
damageCharacter(shootingPlayer, shotCharacter.id, damage*projectile.crit, projectile);

{
    if (projectile.object_index == Rocket)
    {
        if (shotCharacter.id == shootingPlayer.object and instance_exists(shotCharacter.lastDamageDealer) and shotCharacter.lastDamageDealer != shootingPlayer)
            shotCharacter.lastDamageSource = DAMAGE_SOURCE_FINISHED_OFF_GIB;
        else
        {
            if (shotCharacter.lastDamageDealer != shootingPlayer and 
                shotCharacter.lastDamageDealer != shotCharacter.player)
            {
                shotCharacter.secondToLastDamageDealer = shotCharacter.lastDamageDealer;
                shotCharacter.alarm[4] = shotCharacter.alarm[3]
            }
            shotCharacter.alarm[3] = ASSIST_TIME / global.delta_factor;
            shotCharacter.lastDamageDealer = shootingPlayer;
            shotCharacter.lastDamageSource = projectile.weapon;
        }  
    }
    else if (projectile.object_index == Mine)
    {
        if (shotCharacter.id == shootingPlayer.object and instance_exists(shotCharacter.lastDamageDealer) and shotCharacter.lastDamageDealer != shootingPlayer and !instance_exists(projectile.reflector))
            shotCharacter.lastDamageSource = DAMAGE_SOURCE_FINISHED_OFF_GIB;
        else
        {
            if (shotCharacter.lastDamageDealer != shootingPlayer and shotCharacter.lastDamageDealer != shotCharacter.player and projectile.reflector != shotCharacter.lastDamageDealer)
            {
                shotCharacter.secondToLastDamageDealer = shotCharacter.lastDamageDealer;
                shotCharacter.alarm[4] = alarm[3]
            }
            if (shootingPlayer != shotCharacter.id or (instance_exists(projectile.reflector) and shootingPlayer == shotCharacter.id))
                shotCharacter.alarm[3] = ASSIST_TIME / global.delta_factor;
            shotCharacter.lastDamageDealer = shootingPlayer;
            shotCharacter.lastDamageSource = projectile.weapon;
            if (shotCharacter.id==shootingPlayer.object and instance_exists(projectile.reflector))
            {
                shotCharacter.lastDamageDealer = projectile.reflector;
                shotCharacter.lastDamageSource = DAMAGE_SOURCE_REFLECTED_STICKY;
            }
        }           
    } 
    else 
    {
        if (shotCharacter.lastDamageDealer != shootingPlayer and shotCharacter.lastDamageDealer != shotCharacter.player)
        {
            shotCharacter.secondToLastDamageDealer = shotCharacter.lastDamageDealer;
            shotCharacter.alarm[4] = shotCharacter.alarm[3];
        }
        shotCharacter.alarm[3] = ASSIST_TIME / global.delta_factor;
        shotCharacter.lastDamageDealer = shootingPlayer;
        if (projectile.object_index == StabMask) 
        {
            if sign(shotCharacter.image_xscale) == sign(projectile.image_xscale)
                shotCharacter.lastDamageSource = DAMAGE_SOURCE_BACKSTAB;
            else
                shotCharacter.lastDamageSource = DAMAGE_SOURCE_KNIFE;
        } 
        else
        shotCharacter.lastDamageSource = projectile.weapon;
    }  
}

if(global.gibLevel > 0 and blood > 0)
{
    repeat(blood)
    {
        blood = instance_create(shotCharacter.x,shotCharacter.y,Blood);
        blood.direction = direction-180;
    }
}
dealFlicker(shotCharacter.id);
