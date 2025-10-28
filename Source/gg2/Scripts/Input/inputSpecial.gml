// todo: add canBuild to weapon creation instances, secondaries specifically
//if(global.myself.object.canBuild)
if(global.myself.class == CLASS_ENGINEER)
{
    /*
        if !instance_exists(BuildMenu) instance_create(0,0,BuildMenu);
        else if instance_exists(BuildMenu) with (BuildMenu) done=true;
    */
    if(global.myself.sentry)
    {
        write_ubyte(global.serverSocket, DESTROY_SENTRY);
        socket_send(global.serverSocket);
    }
    else if(global.myself.object.nutsNBolts < 100)
    {
        with(NoticeO)
            instance_destroy();
        instance_create(0,0,NoticeO);
        NoticeO.notice = NOTICE_NUTSNBOLTS;
    }
    else if(collision_circle(global.myself.object.x,global.myself.object.y,50,Sentry,false,true)>=0)
    {
        with(NoticeO)
            instance_destroy();
        instance_create(0,0,NoticeO);
        NoticeO.notice = NOTICE_TOOCLOSE;
    }
    else if(collision_point(global.myself.object.x,global.myself.object.y,SpawnRoom,0,0) < 0)
    {
        write_ubyte(global.serverSocket, BUILD_SENTRY);
        socket_send(global.serverSocket);
    }
} else if global.myself.object.taunting==false && global.myself.object.omnomnomnom==false && global.myself.class==CLASS_HEAVY {
//} else if global.myself.object.taunting==false && global.myself.object.omnomnomnom==false && global.myself.object.weaponType[1] == CONSUMABLE {
    write_ubyte(global.serverSocket, OMNOMNOMNOM);
} else if global.myself.class == CLASS_SNIPER {
    if (global.myself.object.weaponType[global.myself.object.activeWeapon] == RIFLE) write_ubyte(global.serverSocket, TOGGLE_ZOOM); // todo: zoom scrunch anims on all characters
}/* else if (global.myself.object.currentWeapon.object_index == ScottishResistance)
{
    write_ubyte(global.serverSocket, DETONATION_POS);
    socket_send(global.serverSocket);
}
