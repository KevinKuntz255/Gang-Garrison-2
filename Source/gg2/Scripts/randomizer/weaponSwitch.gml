with(currentWeapon) instance_destroy();

currentWeapon = -1;

global.paramOwner = id;

currentWeapon = instance_create(x,y,global.weapons[argument0]);


// TODO: move to networking. this'll do
if (currentWeapon.ability != -1 and ability[currentWeapon.activeWeapon] == -1) {
    ability[currentWeapon.activeWeapon] = currentWeapon.ability;
    abilityBuffer[currentWeapon.activeWeapon] = currentWeapon.abilityBuffer;
    abilityName[currentWeapon.activeWeapon] = currentWeapon.abilityName;
    abilityVisual[currentWeapon.activeWeapon] = currentWeapon.abilityVisual;
    activateAbility[currentWeapon.activeWeapon] = currentWeapon.activateAbility;
    cancelAbility[currentWeapon.activeWeapon] = currentWeapon.cancelAbility;
    depleteAbiliy[currentWeapon.activeWeapon] = currentWeapon.depleteAbility;
    rechargeAbility[currentWeapon.activeWeapon] = currentWeapon.rechargeAbility;
    chargeWhileActive[currentWeapon.activeWeapon] = currentWeapon.chargeWhileActive;
    meter[currentWeapon.activeWeapon] = currentWeapon.meter;
    maxMeter[currentWeapon.activeWeapon] = currentWeapon.maxMeter;
    meterGain[currentWeapon.activeWeapon] = currentWeapon.meterGain;
    meterDrain[currentWeapon.activeWeapon] = currentWeapon.meterDrain;
}

global.paramOwner = noone;

if !cloak playsound(x,y,SwitchSnd);
