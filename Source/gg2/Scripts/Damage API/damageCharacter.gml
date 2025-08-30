// damageCharacter( sourcePlayer, damagedCharacter, damageDealt, shot)
for(i=0; i<2; i+=1) {
    if (argument1.abilityActive[i] and argument1.ability[i] == INVINC)
    {
        var text;
        text=instance_create(argument3.x,argument3.y,Text);
        text.sprite_index=MissS;
        exit;
    }
    if (argument1.rechargeAbility[i] == DAMAGE)
    {
        meter[i] += argument2;
    }
}
// generate these on collision, easier that way
// todo: add a check for ownerPlayer to prevent so many distracting crit particles
if (!variable_local_exists("argument3.crit")) argument3.crit = 1; // huh
if (argument3.crit == 1.15) {
    var text;
    text=instance_create(argument3.x,argument3.y,Text);
    text.sprite_index=MiniCritS;
}
if (argument3.crit == 1.35) {
    var text;
    text=instance_create(argument3.x,argument3.y,Text);
    text.sprite_index=CritS;
}
/*
var object;
object = argument1.object_index;

if(object_is_ancestor(object, Character) or object == Character ) {
    if (argument3.weapon == DAMAGE_SOURCE_BLACKBOX) argument0.hp += argument2*0.35
}*/

dealDamage( argument0, argument1, argument2 );

if(argument1.omnomnomnom)
    argument1.omnomnomnomindex = min(argument1.omnomnomnomend, argument1.omnomnomnomindex+argument2/1.6*0.25);
argument1.timeUnscathed = 0;

