// Write a message to the buffer-ish argument1 that informs the server
// that we want to switch to class argument0.

write_ubyte(argument1, PLAYER_CHANGECLASS);
if (argument0 < CLASS_SCOUT) newClass = checkClasslimits(global.myself, global.myself.team, CLASS_SCOUT); else
newClass = checkClasslimits(global.myself, global.myself.team, argument0);
//show_message(string(newClass));
write_ubyte(argument1, argument0);
write_ushort(argument1, global.loadout[newClass]);
