// damageCharacter( sourcePlayer, damagedCharacter, damageDealt, damageSource)
for(i=0; i<2; i+=1) {
    if (argument1.abilityActive[i] and argument1.ability[i] == INVULN)
    {
        var text;
        text=instance_create(argument3.x,argument3.y,Text);
        text.sprite_index=MissS;
        exit;
    }
    if (argument0.object.rechargeAbility[i] == DAMAGE)
    {
        meter[i] += argument2;
    }
}
// generate these on collision, easier that way
var canCreateText;
canCreateText = true;
with(Text)
{
    if (variable_local_exists("owner")) {
        if (owner == other.argument0) {
            other.canCreateText = false;
        }    
    }
}
if (argument3.crit == 1.15 and canCreateText) {
    var text;
    text=instance_create(argument3.x,argument3.y,Text);
    text.sprite_index=MiniCritS;
    text.owner = argument0;
}
if (argument3.crit >= 1.35 and canCreateText) {
    var text;
    text=instance_create(argument3.x,argument3.y,Text);
    text.sprite_index=CritS;
    text.owner = argument0;
}

switch(argument3.weapon)
{
    case DAMAGE_SOURCE_BLACKBOX:
        if (argument1 != argument0.object) argument0.object.hp += argument2*0.35;
    break;
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

