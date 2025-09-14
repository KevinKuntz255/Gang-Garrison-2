// dealDamage( sourcePlayer, damagedObject, damageDealt )
with(argument1)
{
    if(variable_local_exists("deathmatch_invulnerable"))
    {
        if(argument1.deathmatch_invulnerable != 0)
            return 0;
    }
}
argument1.hp -= argument2;
if (object_is_ancestor(argument1.object_index, Character)) {
    if argument1.overhealed && argument1.overhealHp > 0 {
    		argument1.overhealHp -= argument2;
    		argument1.hp = min(argument1.maxHp, argument1.maxHp + argument1.overhealHp);
    }
}
// damn, alotta mods would mess wit the hp variable itself, hmm, todo: fix that after playtests
execute_string( global.dealDamageFunction, argument0, argument1, argument2 );

