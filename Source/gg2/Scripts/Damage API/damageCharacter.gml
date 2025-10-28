// damageCharacter( sourcePlayer, damagedCharacter, damageDealt )
argument1.timeUnscathed = 0;

if argument1.overhealed && argument1.overhealHp > 0 {
        argument1.overhealHp -= argument2;
        execute_string( global.dealOverhealDamageFunction, argument0, argument1, argument2 );
} else {
    dealDamage( argument0, argument1, argument2 );

    if(argument1.omnomnomnom)
        argument1.omnomnomnomindex = min(argument1.omnomnomnomend, argument1.omnomnomnomindex+argument2/1.6*0.25);
}


