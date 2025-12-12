// projectileCollision( sourcePlayer, damagedCharacter, damageDealt, projectile, blood)
// note: meant only for Character interactions
var shootingPlayer,shotCharacter,damage,projectile,blood;
shootingPlayer = argument0;
shotCharacter = argument1;
damage = argument2;
projectile = argument3;
blood = argument4;
/*
if (shootingPlayer.object == -1)
    todo: ease the if statement
*/
execute_string( global.projectileCollisionFunction, argument0, argument1, argument2, argument3, argument4); // place before everything so as to override INVIS exit
// be smart of you or me to add INVULN detection back in case you still need it, eh fugg around n find out
for(i=0; i<2; i+=1) 
{
    if (shotCharacter.abilityActive[i] and shotCharacter.ability[i] == ABILITY_INVULN)
    {
        var text;
        text=instance_create(argument3.x,argument3.y,Text);
        text.sprite_index=MissS;
        exit;
    }
    if (shotCharacter.cloak and shotCharacter.ability[i] == ABILITY_UBERCLOAK and shotCharacter.meter[i] > 0 and projectile.object_index != MeleeMask)
    {
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

with(Text) {
    if (variable_local_exists("owner")) {
        if (owner == other.argument0) {
            instance_destroy(); // cleaner, and closer to original tf2
        }    
    }
}


if shotCharacter.tracker.alarm[SOAK_PISS] > 0 and argument3.crit < CRIT_FACTOR
    argument3.crit = MINICRIT_FACTOR;
    
if (shootingPlayer.object != -1) {
    switch(argument3.weapon)
    {
        case DAMAGE_SOURCE_BLACKBOX:
            if (shotCharacter != shootingPlayer.object) shootingPlayer.object.hp += damage*0.3;
        break;
        case DAMAGE_SOURCE_RSHOOTER:
            if (!shotCharacter.onground and shotCharacter.moveStatus == 3 and projectile.crit < MINICRIT_FACTOR)
                projectile.crit = MINICRIT_FACTOR;
        break;
        case DAMAGE_SOURCE_AXE:
            if (shotCharacter.burnDuration > 0 and projectile.crit <= 1.35) 
                projectile.crit *= CRIT_FACTOR;
            with(shotCharacter)
            {
                if (burnDuration < maxDuration) {
                    burnDuration += 30*6; 
                    burnDuration = min(burnDuration, maxDuration);
                }
                if (burnIntensity < maxIntensity) {
                    burnIntensity += other.burnIncrease * 3;
                    burnIntensity = min(burnIntensity, maxIntensity);
                }
                burnedBy = other.ownerPlayer;
                afterburnSource = DAMAGE_SOURCE_AXE;
                alarm[0] = decayDelay / global.delta_factor;
            }
        break;
        case DAMAGE_SOURCE_BLUTSAUGER:
            if (shootingPlayer.object.hp < shootingPlayer.object.maxHp)
            {
                shootingPlayer.object.hp += 1;
                var text;
                text=instance_create(shootingPlayer.object.x,shootingPlayer.object.y - 8,Text);
                text.sprite_index=PlusOneS;
                text.owner = shootingPlayer;
            }
        break;
        case DAMAGE_SOURCE_UBERSAW:
            if (shootingPlayer.object.currentWeapon.weaponType == WTYPE_HEALBEAM)
                shootingPlayer.object.currentWeapon.uberCharge += 50;
            else
                shootingPlayer.object.uberChargeC += 50;
        break;
        case DAMAGE_SOURCE_WIDOWMAKER:
            shootingPlayer.object.nutsNBolts += damage*projectile.crit;
        case DAMAGE_SOURCE_ZAPPER:
            shotCharacter.player.humiliated = true;
            shotCharacter.wasStunned = true;
            shotCharacter.alarm[10] = 120 / global.delta_factor;
        break;
    }
    
    if shotCharacter.tracker.alarm[SOAK_MILK] > 0
        shootingPlayer.object.hp += damage*0.35;
}

// todo: two crit sprites? thats dumb
if (argument3.crit == MINICRIT_FACTOR) {
    var text;
    text=instance_create(shotCharacter.x,shotCharacter.y,Text);
    text.sprite_index=MiniCritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}
if (argument3.crit >= CRIT_FACTOR) {
    var text;
    text=instance_create(shotCharacter.x,shotCharacter.y,Text);
    text.sprite_index=CritS;
    if (instance_exists(shootingPlayer)) text.owner = shootingPlayer;
}

//(1*0.35) outdated and unused crit reduction. just modify the whole crit instead
damageCharacter(shootingPlayer, shotCharacter.id, argument2*projectile.crit, projectile);


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
    if (projectile.object_index == StabMask and projectile.weapon != Zapper) 
    {
        if sign(shotCharacter.image_xscale) == sign(projectile.image_xscale)
            shotCharacter.lastDamageSource = DAMAGE_SOURCE_BACKSTAB;
        else
            shotCharacter.lastDamageSource = DAMAGE_SOURCE_KNIFE;
    } 
    else
    shotCharacter.lastDamageSource = projectile.weapon;
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
