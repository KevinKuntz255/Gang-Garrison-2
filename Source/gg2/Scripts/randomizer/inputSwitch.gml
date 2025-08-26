if !global.myself.object.taunting
&& !global.myself.object.omnomnomnom
&& !global.myself.object.currentWeapon.ubering
{
    if (global.myself.object.zoomed) write_ubyte(global.serverSocket, TOGGLE_ZOOM);
    write_ubyte(global.serverSocket, WEAPON_SWAP);
}
/*&& !global.myself.object.buffing
&& !global.myself.object.currentWeapon.ubering
&& !global.myself.object.critting
&& !global.myself.object.megaHealed
&& !global.myself.object.stabbing
&& !global.myself.object.carrySentry
&& !global.myself.object.charge
&& !global.myself.object.stunned
&& !global.myself.object.zoomed
&& !global.myself.object.spinning*/
