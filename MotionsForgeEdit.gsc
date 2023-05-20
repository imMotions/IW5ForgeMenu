#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*

    Mod made by Santahunter
    Less modsize by Seann
	Don't remove my Credits!
	
	FOR MW3 few scipt errors but nothing game breaking just to help with map edits for zombieland
	FOR MW3 few scipt errors but nothing game breaking just to help with map edits for zombieland
	FOR MW3 few scipt errors but nothing game breaking just to help with map edits for zombieland

*/

myBunker() // add here the bunkercodes which u want to have on gamestart...
{
	/*Highrise Example
	CreateBlocks((-2723, 5162, 3030), (90, 0, 0));
	CreateBlocks((-2753, 5162, 3030), (90, 0, 0));
	CreateBlocks((-2723, 5132, 3030), (90, 0, 0));
	CreateDoors((-1550, 5875, 2967), (-1550, 5649, 2967), (0, 0, 0), 7, 1, 20, 100);
	CreateDoors((-1185, 5900, 2967), (-1185, 6117, 2967), (0, 0, 0), 7, 1, 20, 100);
	CreateDoors((-2672, 20020, 2058), (-2658, 20240, 2058), (0, 0, 0), 7, 1, 20, 100);
	CreateDoors((-3049, 19882, 2058), (-3035, 20340, 2058), (0, 0, 0), 7, 1, 20, 100);
	
	//CreateRamps((-2013.31, 20053.4, 1890),(-1405.79, 20013, 1890.24));
	//CreateElevator((-866.513, 20440.2, 2060.11),(-1401.66, 5944.93, 3116.87));
	//CreateElevator((-1629.84, 8475.9, 3237.32),(-2394.45, 19369.3, 1844.66));*/ 

CreateElevator((-1783.85, -397.403, 0.125001),(-2300.21, -490.623, 136.125));//in
CreateElevator((-3292.17, -25.9077, 136.125),(-1818.35, -34.9978, 0.125));//out
 
CreateWalls((-2741.74, -476.073, 155.671),(-2741.84, -645.754, 155.621));//door walls
CreateWalls((-2741.74, -476.073, 220.671),(-2741.84, -645.754, 220.621));//door walls
CreateDoors((-2742.84, -548.523, 178.098),(-2741.7, -726.329, 178.207), (90,0,0), 5, 1, 20, 90);

CreateWalls((-3337.28, -355.974, 241.561),(-3347.43, 48.6951, 232.26));//walls behind door
CreateWalls((-3151.13, 22.5003, 241.075),(-3310.02, 21.4295, 244.616));
CreateWalls((-3151.13, 23.1125, 172.196),(-3307.45, 22.2915, 177.938));
CreateWalls((-3337.54, 15.5849, 172.478),(-3337.71, -358.875, 165.058));
CreateBlocks((-3054.7, 15.8891, 136.125), (90, -90, 0));
CreateBlocks((-2801.91, 15.8933, 136.125), (90, -90, 0));
CreateBlocks((-2928.23, 00, 136.125), (90, -90, 0));


CreateElevator((-2313.95, 2638.09, 140.016),(-2650.87, 2303.66, 130.125));//in

CreateWalls((-2939.13, 2234.3, 167.167),(-3417.64, 2606.46, 167.073));
CreateWalls((-2929.9, 3540.81, 167.023),(-2389.12, 3554.66, 167.833));



}

Init()
{
    level thread onPlayerConnect();
	mapwait = 0;
	level.doorwait = 2;
	level.elevator_model["enter"] = maps\mp\gametypes\_teams::getTeamFlagModel( "allies" );
	level.elevator_model["exit"] = maps\mp\gametypes\_teams::getTeamFlagModel( "axis" );
	level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
	level.upgradedraygunFX["raygun"] = loadFX( "misc/aircraft_light_wingtip_green" );
	level.upgradedraygunFX["impact"] = loadFX( "misc/flare_ambient_green" );
	level.waittime = 0;
	level.flag_ref = 0;
	level.door_ref = 0;
	precacheModel( level.elevator_model["enter"] );
	precacheModel( level.elevator_model["exit"] );
	level.oi = maps\mp\gametypes\_teams::getTeamFlagIcon( "allies" );
	precacheShader(level.oi);
	setDvar("scr_war_timelimit", "0"); 
	setDvar("scr_war_scorelimit", "0");
	setDvar("Developer_script", "0");///hides script errors cba to fix them all nothing game breaking
	level thread myBunker();
	logprint("------------------------------\n");
	logprint("------------------------------\n");
	logprint("------------------------------\n");
	logprint("-------- " + getDvar("mapname") + " ---------\n");
	logprint("------------------------------\n");
	logprint("------------------------------\n");
	logprint("------------------------------\n");
    ents = getEntArray();
    for ( index = 0; index < ents.size; index++ ) // Disable Killtriggers of each map like in Highrise when u fall down or in Afghan, Wasteland...
    {
        if(isSubStr(ents[index].classname, "trigger_hurt"))
            ents[index].origin = (99999999, 999999, 9999999);
    }
}


onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );
        player thread onPlayerSpawned();	
		player thread spawnto();
		player thread Deletelast();
		player thread MyMod();
		player thread CheckSpeed();
		text1 = strTok("[^53^7] Ufo Mode;[^54^7] Teleport To Crosshair;[^55^7] Delete Edit;[^5F^7] Open Menu;[^5R^7] Spawn Edit;[^5Space^7] Select;[^5W,S^7] Scroll up/down; [^5Q^7] Change Speed",";");
		for(i=0;i<text1.size;i++)
			player.hud[i] = player createText2("default",1,"TOPLEFT","TOPLEFT",10,125+(i*10),500,1,text1[i]);
		player setClientDvar( "cg_objectiveText", "Make your own Mapedits");
		player setClientDvar("lowAmmoWarningNoAmmoColor2", 0, 0, 0, 0);
	    player setClientDvar("lowAmmoWarningNoAmmoColor1", 0, 0, 0, 0);
		logprint("------------------------------\n");
		logprint("GUID of " + player.name + ": " + player.guid + "\n");
		logprint("------------------------------\n");
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self thread UFO1();
		self thread Menu();
		self.maxhp = 9999;
	    self.maxhealth = self.maxhp;
	    self.health = self.maxhealth;
		self takeAllWeapons();
		self giveWeapon("iw5_deserteagle_mp");
		self freezecontrols(false);
		self maps\mp\gametypes\_menus::addToTeam( "allies" );
		wait .1;
		self switchToWeapon("iw5_deserteagle_mp");
		self setWeaponAmmoClip("iw5_deserteagle_mp", 0);
		self setWeaponAmmoStock("iw5_deserteagle_mp", 0);
		self thread CheckCorrectFile();
	}
}	

Menu()
{
    self endon("disconnect");
	self endon("death");
	self notify("remenu");
	self endon("remenu");
	//self endon("destroy");
	self.menu = 0;
	self notifyOnPlayerCommand("Menu", "+activate");
	text = strTok("Teleporter;Ramp;Floor;Wall;Door;FlyBlock;Block;Sentrygun;Special Pos;Weaponbox;Killtrigger;Forge Pick Up",";");
	for(;;)
	{
		self waittill("Menu");
		self.menu = 1;
		self.opt = 1;	
        self.moveSpeedScaler = 0;
	    self setMoveSpeedScale(0);  
        self freezecontrols (true);	
		self.shader = self createRectangle("CENTER","CENTER",0,-70,200,200,0,"black",20,.7); 
		self.optshader = self createRectangle("CENTER","CENTER",0,-150,200,16,0,"white",20,.7);
		for(i=0;i<text.size;i++)
		    self.option[i] = self createText("default",1,"CENTER","CENTER",0,-150+(i*15),150,1,text[i]);
		self thread ScrollUp();
		self thread ScrollDown();	
		self thread Functions();
		self waittill_any("Menu", "Spawn");	
		self thread oldSpeed();
		self.menu = 0;
	    self notify("destroy");
		self freezecontrols(false);
	}
}

ScrollDown()
{
    self endon("death");
	self endon("disconnect");
	self endon("destroy");
	self endon("remenu");
	self notifyOnPlayerCommand("W", "+forward");
	for(;;)
	{
	    self waittill("W");
		self.opt--;
		if(self.opt < 1)
		    self.opt = 12;
		self.optshader destroy();	
		if(self.opt == 1)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-150,200,20,0,"white",20,.7);
		if(self.opt == 2)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-135,200,20,0,"white",20,.7);	
		if(self.opt == 3)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-120,200,20,0,"white",20,.7);	
		if(self.opt == 4)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-105,200,20,0,"white",20,.7);	
        if(self.opt == 5)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-90,200,20,0,"white",20,.7);	
		if(self.opt == 6)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-75,200,20,0,"white",20,.7);
		if(self.opt == 7)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-60,200,20,0,"white",20,.7);
		if(self.opt == 8)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-45,200,20,0,"white",20,.7);
		if(self.opt == 9)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-30,200,20,0,"white",20,.7);	
		if(self.opt == 10)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-15,200,20,0,"white",20,.7);	
		if(self.opt == 11)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,0,200,20,0,"white",20,.7);

			if(self.opt == 12)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,15,200,20,0,"white",20,.7);			
	}
}

ScrollUp()
{
    self endon("death");
	self endon("disconnect");
	self endon("destroy");
	self endon("remenu");
	self notifyOnPlayerCommand("S", "+back");
	for(;;)
	{
	    self waittill("S");
		self.opt++;
		if(self.opt > 12)
		    self.opt = 1;
		self.optshader destroy();	
		if(self.opt == 1)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-150,200,20,0,"white",20,.7);
		if(self.opt == 2)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-135,200,20,0,"white",20,.7);	
		if(self.opt == 3)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-120,200,20,0,"white",20,.7);	
		if(self.opt == 4)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-105,200,20,0,"white",20,.7);	
        if(self.opt == 5)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-90,200,20,0,"white",20,.7);	
		if(self.opt == 6)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-75,200,20,0,"white",20,.7);
		if(self.opt == 7)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-60,200,20,0,"white",20,.7);
		if(self.opt == 8)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-45,200,20,0,"white",20,.7);
		if(self.opt == 9)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-30,200,20,0,"white",20,.7);	
		if(self.opt == 10)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,-15,200,20,0,"white",20,.7);	
		if(self.opt == 11)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,0,200,20,0,"white",20,.7);
			if(self.opt == 12)	
		    self.optshader = self createRectangle("CENTER","CENTER",0,15,200,20,0,"white",20,.7);
	}
}

UFO1()
{
    self endon("death");
	self endon("disconnect");
	self notifyOnPlayerCommand( "l", "+actionslot 3" );
	maps\mp\gametypes\_spectating::setSpectatePermissions();
	for(;;)
	{
	    self waittill("l");
		if(self.menu==0)
		{
		    self iprintln("^2UFO Mode Enabled");
			self allowSpectateTeam( "freelook", true );
			self.sessionstate = "spectator";
		}
		self waittill("l");
		if(self.menu==0)
		{
		    self iprintln("^1UFO Mode Disabled");
			self.sessionstate = "playing";
			self allowSpectateTeam( "freelook", false );
		}
	}
}
            
createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha)    
{
    HudElem = self createFontString( "objective", 1);
    HudElem.width = width;
    HudElem.height = height;
    HudElem.align = align;
    HudElem.relative = relative;
    HudElem.sort = sort;
    HudElem.alpha = alpha;
    HudElem setShader(shader, width, height);
    HudElem.hidden = false;
    HudElem.HideWhenInMenu = true;
    HudElem setPoint(align, relative, x, y);
    self thread destroyOnDeath(HudElem);
    return HudElem;
}
createText(font, fontScale, align, relative, x, y, sort, alpha, text)
{
    textElem = self createFontString(font, fontScale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem setText(text);
    textElem.HideWhenInMenu = true;
    self thread destroyOnDeath(textElem);
    return textElem;
}

createText2(font, fontScale, align, relative, x, y, sort, alpha, text)
{
    textElem = self createFontString(font, fontScale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem setText(text);
    textElem.HideWhenInMenu = true;
    self thread destroyOnDeath2(textElem);
    return textElem;
}

destroyOnDeath(elem)
{
	self waittill_any("disconnect", "death", "destroy");
   if(isDefined(elem.bar))
        elem destroy();
    else
        elem destroy();
    if(isDefined(elem.model))
        elem delete();
}			
	
destroyOnDeath2(elem)
{
    self waittill("disconnect");
    if(isDefined(elem.bar))
        elem destroy();
    else
        elem destroy();
    if(isDefined(elem.model))
        elem delete();
}	
	
getColor()
{
	return ((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
}

killme()
{
    self endon("disconnect");
	self notifyOnPlayerCommand("kill", "+actionslot 4");
	for(;;)
	{
	    self waittill("kill");
		self suicide();
	}
}

Functions()
{
    self endon("death");
	self endon("disconnect");
	self endon("destroy");
	self notifyOnPlayerCommand("Select", "+gostand");
	for(;;)
	{
	    self waittill("Select");
		self notify("Spawn");
		if(self.opt == 1)
		    self thread SpawnFlag();
		if(self.opt == 2)
		    self thread SpawnRamp();
		if(self.opt == 3)
		    self thread SpawnGrid();
		if(self.opt == 4)
		    self thread SpawnWall();
		if(self.opt == 5)
		    self thread SpawnDoor();
		if(self.opt == 6)
		    self thread SpawnAsc();		
		if(self.opt == 7)
		    self thread SpawnBlock();	
		if(self.opt == 8)
		    self thread SpawnSentry();		
		if(self.opt == 9)
		    self thread SpawnSpecial();	
		if(self.opt == 10)
		    self thread SpawnBox();	
		if(self.opt == 11)
		    self thread SpawnKill();
			if(self.opt == 12)
		    self thread ForgeON();
	}
	self notify("destroy");
}

SpawnFlag()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Flag", "+reload");
	self waittill("Flag");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Flag");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateElevator(" + pos1 + "," + pos2 + ");\n");
	self notify("nextblock");
	self CreateElevator(pos1, pos2);
	self iPrintlnbold("^5Flag spawned");
}

SpawnRamp()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Ramp", "+reload");
	self waittill("Ramp");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Ramp");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateRamps(" + pos1 + "," + pos2 + ");\n");
	self notify("nextblock");
	self CreateRamps(pos1, pos2);
	self iPrintlnbold("^5Ramp spawned");
}

SpawnGrid()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Grid", "+reload");
	self waittill("Grid");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Grid");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateGrids(" + pos1 + "," + pos2 + ");\n");
	self notify("nextblock");
	self CreateGrids(pos1, pos2);
	self iPrintlnbold("^5Grid spawned");
}
SpawnWall()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Wall", "+reload");
	self waittill("Wall");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Wall");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateWalls(" + pos1 + "," + pos2 + ");\n");
	self notify("nextblock");
	self CreateWalls(pos1, pos2);
	self iPrintlnbold("^5Wall spawned");
}

SpawnDoor()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Wall", "+reload");
	self waittill("Wall");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Wall");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateDoors(" + pos1 + "," + pos2 + ", (90,0,0), 3, 2, 20, 90);\n");
	self notify("nextblock");
	self CreateDoors(pos1, pos2, (90,0,0), 3, 2, 20, 90 );
	self iPrintlnbold("^5Door spawned, Edit Angles Yourself In Script!");
}


SpawnAsc()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Asc", "+reload");
	self waittill("Asc");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	self waittill("Asc");
	pos2 = self.origin;
	logprint("--------------------\n");
	logprint("CreateAsc(" + pos1 + "," + pos2 + ", (0,0,0), 3);\n");
	self notify("nextblock");
	self CreateAsc(pos1, pos2, (0,0,0), 3);
	self iPrintlnbold("^5Flyblock spawned");
}


SpawnBlock()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Block", "+reload");
	self waittill("Block");
	pos1 = self.origin;
	self iPrintlnbold("^5Position 1 set!, Select the 2nd Position");
	logprint("--------------------\n");
	logprint("CreateBlocks(" + pos1 + ", " + self.angles + ");\n");
	self notify("nextblock");
	self CreateBlocks(pos1, self.angles);
	self iPrintlnbold("^5Block spawned");
}

SpawnSentry()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Sentry", "+reload");
	self waittill("Sentry");
	pos1 = self.origin;
	logprint("--------------------\n");
	logprint("CreateSentry(" + pos1 + ");\n");
	self CreateSentry(pos1);
	self iPrintlnbold("^5Sentry spawned");
}

CreateSentry(pos1)
{
    mgTurret1 = spawnTurret( "misc_turret", pos1, "sentry_minigun_mp" ); 
	mgTurret1.angles = (0, 0, 0); 
    mgTurret1 setModel( "sentry_minigun" );
    mgTurret1 SetRightArc( 360 );		
}

SpawnSpecial()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Special", "+reload");
	self waittill("Special");
	pos1 = self.origin;
	logprint("--------------------\n");
	logprint("SpecialPos(" + pos1 + ");\n");
	self notify("nextblock");
	self SpecialPos(pos1);
	self iPrintlnbold("^5Tac spawned");
}

SpawnKill()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Kill", "+reload");
	self waittill("Kill");
	pos1 = self.origin;
	logprint("--------------------\n");
	logprint("CreateKill(" + pos1 + ");\n");
	self notify("nextblock");
	self thread CreateKill(pos1);
	self iPrintlnbold("^5Killtrigger spawned");
}

ForgeON()
{
	if(self.forgeOn==false)
	{
		self thread ForgeModeOn();
		self iPrintln("^7Forge Mode ^2Enabled ^1- ^7Hold [{+speed_throw}] to Move Objects");
		self.forgeOn=true;
	}
	else
	{
		self notify("stop_forge");
		self iPrintln("^7Forge Mode ^1Disabled");
		self.forgeOn=false;
	}
}

ForgeModeOn()
{
	self endon("death");
	self endon("stop_forge");
	for(;;)
	{
		while(self adsbuttonpressed())
		{
			trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
			while(self adsbuttonpressed())
			{
				trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
				trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
				wait 0.05;
			}
		}
		wait 0.05;
	}
}
CreateKill(pos)
{
    level endon("disconnect");
    for(;;)
	{
	    foreach(player in level.players)
		{
		    if(Distance(pos, player.origin) <= 200)
			{ 
			    if(player != self)
				{
			        player thread maps\mp\gametypes\_hud_message::hintMessage("^1Your In A Killtrigger!");
			        player suicide();
				}
				else
				{
				    player iPrintln("Modder can't die because of Killtrigger!");
				}				
			}
		}
		wait 1;
	}
}


SpecialPos(pos1)
{
    self.glow = spawnFX( level.upgradedraygunFX["impact"], self.origin );
	TriggerFX(self.glow);
    self thread deleteOnDestroy(self.glow);
}

SpawnBox()
{
    self endon("death");
	self endon("disconnect");
    self notifyOnPlayerCommand("Box", "+reload");
	self waittill("Box");
	pos1 = self.origin;
	logprint("--------------------\n");
	logprint("EliteWeaponBox(" + pos1 + ", " + self.team + ");\n");
	self notify("nextblock");
	self thread EliteWeaponBox(pos1, self.team);
	self iPrintln("^5Weaponbox spawned");
}

DeleteLast()
{
    self endon("disconnect");
	self notifyOnPlayerCommand("5", "+actionslot 2");
	for(;;)
	{
	    self waittill("5");
		self notify("deleteit");
	}
}

deleteOnDestroy(object)
{ 
    self endon("disconnect");
	self endon("nextblock");
    self waittill("deleteit");
	object delete();
	logprint("Object above is deleted!\n");
}

deleteOnDestroy2(object)
{ 
    self endon("disconnect");
	self endon("nextblock");
    self waittill("deleteit");
	object delete();
}

CreateWalls(start,end){D=Distance((start[0],start[1],0),(end[0],end[1],0));H=Distance((0,0,start[2]),(0,0,end[2]));blocks=roundUp(D/55);height=roundUp(H/30);CX=end[0] - start[0];CY=end[1] - start[1];CZ=end[2] - start[2];XA =(CX/blocks);YA =(CY/blocks);ZA =(CZ/height);TXA =(XA/4);TYA =(YA/4);Temp=VectorToAngles(end - start);Angle =(0,Temp[1],90);for(h=0;h < height;h++){block=spawn("script_model",(start +(TXA,TYA,10)+((0,0,ZA)* h)));self thread deleteOnDestroy(block);block setModel("com_plasticcase_friendly");block.angles=Angle;block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.001;for(i=1;i < blocks;i++){block=spawn("script_model",(start +((XA,YA,0)* i)+(0,0,10)+((0,0,ZA)* h)));self thread deleteOnDestroy2(block);block setModel("com_plasticcase_friendly");block.angles=Angle;block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.001;}block=spawn("script_model",((end[0],end[1],start[2])+(TXA * -1,TYA * -1,10)+((0,0,ZA)* h)));self thread deleteOnDestroy2(block);block setModel("com_plasticcase_friendly");block.angles=Angle;block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.001;}} 
CreateGrids(corner1,corner2,angle){W=Distance((corner1[0],0,0),(corner2[0],0,0));L=Distance((0,corner1[1],0),(0,corner2[1],0));H=Distance((0,0,corner1[2]),(0,0,corner2[2]));CX=corner2[0] - corner1[0];CY=corner2[1] - corner1[1];CZ=corner2[2] - corner1[2];ROWS=roundUp(W/55);COLUMNS=roundUp(L/30);HEIGHT=roundUp(H/20);XA=CX/ROWS;YA=CY/COLUMNS;ZA=CZ/HEIGHT;center=spawn("script_model",corner1);self thread deleteOnDestroy(center);for(r=0;r<=ROWS;r++){for(c=0;c<=COLUMNS;c++){for(h=0;h<=HEIGHT;h++){block=spawn("script_model",(corner1 +(XA * r,YA * c,ZA * h)));self thread deleteOnDestroy2(block);block setModel("com_plasticcase_friendly");block.angles =(0,0,0);block Solid();block LinkTo(center);block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.01;}}}center.angles=angle;}
CreateRamps(top,bottom){D=Distance(top,bottom);blocks=roundUp(D/30);CX=top[0] - bottom[0];CY=top[1] - bottom[1];CZ=top[2] - bottom[2];XA=CX/blocks;YA=CY/blocks;ZA=CZ/blocks;CXY=Distance((top[0],top[1],0),(bottom[0],bottom[1],0));Temp=VectorToAngles(top - bottom);BA =(Temp[2],Temp[1] + 90,Temp[0]);for(b=0;b < blocks;b++){block=spawn("script_model",(bottom +((XA,YA,ZA)* B)));self thread deleteOnDestroy(block);block setModel("com_plasticcase_friendly");block.angles=BA;block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.01;}block=spawn("script_model",(bottom +((XA,YA,ZA)* blocks)-(0,0,5)));self thread deleteOnDestroy2(block);block setModel("com_plasticcase_friendly");block.angles =(BA[0],BA[1],0);block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);wait 0.01;}
CreateElevator(enter,exit,angle){flag=spawn("script_model",enter);self thread deleteOnDestroy(flag);flag setModel(level.elevator_model["enter"]);wait 0.01;flag=spawn("script_model",exit);self thread deleteOnDestroy(flag);flag setModel(level.elevator_model["exit"]);wait 0.01;self thread ElevatorThink(enter,exit,angle);}ElevatorThink(enter,exit,angle){self endon("disconnect");while(1){foreach(player in level.players){if(Distance(enter,player.origin)<= 50){player SetOrigin(exit);player SetPlayerAngles(angle);}}wait .25;}}
CreatePlate(corner1,corner2,arivee,angle,time){W=Distance((corner1[0],0,0),(corner2[0],0,0));L=Distance((0,corner1[1],0),(0,corner2[1],0));H=Distance((0,0,corner1[2]),(0,0,corner2[2]));CX=corner2[0] - corner1[0];CY=corner2[1] - corner1[1];CZ=corner2[2] - corner1[2];ROWS=roundUp(W/55);COLUMNS=roundUp(L/30);HEIGHT=roundUp(H/20);XA=CX/ROWS;YA=CY/COLUMNS;ZA=CZ/HEIGHT;center=spawn("script_model",corner1);for(r=0;r<=ROWS;r++){for(c=0;c<=COLUMNS;c++){for(h=0;h<=HEIGHT;h++){block=spawn("script_model",(corner1 +(XA * r,YA * c,ZA * h)));self thread deleteOnDestroy(block);block setModel("com_plasticcase_friendly");block.angles =(0,0,0);block Solid();block CloneBrushmodelToScriptmodel(level.airDropCrateCollision);block thread Escalatore((corner1 +(XA * r,YA * c,ZA * h)),(arivee +(XA * r,YA * c,ZA * h)),time);wait 0.01;}}}center.angles=angle;center thread Escalatore(corner1,arivee,time);center CloneBrushmodelToScriptmodel(level.airDropCrateCollision);}Escalatore(depart,arivee,time){while(1){if(self.state=="open"){self MoveTo(depart,time);wait(time*2.5);self.state="close";continue;}if(self.state=="close"){self MoveTo(arivee,time);wait(time*2.5);self.state="open";continue;}}}/*CreateAsc(depart,arivee,angle,time){Asc=spawn("script_model",depart);self thread deleteOnDestroy(Asc);Asc setModel("com_plasticcase_friendly");Asc.angles=angle;Asc Solid();Asc CloneBrushmodelToScriptmodel(level.airDropCrateCollision);Asc thread Escalator(depart,arivee,time);}Escalator(depart,arivee,time){while(1){if(self.state=="open"){self MoveTo(depart,time);wait(time*1.5);self.state="close";continue;}if(self.state=="close"){self MoveTo(arivee,time);wait(time*1.5);self.state="open";continue;}}}CreateCircle(depart,pass1,pass2,pass3,pass4,arivee,angle,time){Asc=spawn("script_model",depart);Asc setModel("com_plasticcase_friendly");Asc.angles=angle;Asc Solid();Asc CloneBrushmodelToScriptmodel(level.airDropCrateCollision);Asc thread Circle(depart,arivee,pass1,pass2,pass3,pass4,time);}Circle(depart,pass1,pass2,pass3,pass4,arivee,time){while(1){if(self.state=="open"){self MoveTo(depart,time);wait(time*1.5);self.state="op";continue;}if(self.state=="op"){self MoveTo(pass1,time);wait(time);self.state="opi";continue;}if(self.state=="opi"){self MoveTo(pass2,time);wait(time);self.state="opa";continue;}if(self.state=="opa"){self MoveTo(pass3,time);wait(time);self.state="ope";continue;}if(self.state=="ope"){self MoveTo(pass4,time);wait(time);self.state="close";continue;}if(self.state=="close"){self MoveTo(arivee,time);wait(time);self.state="open";continue;}}}*/
SpawnWeapons(WFunc,Weapon,WeaponName,Location,TakeOnce,angle,gun){self endon("disconnect");gun delete();weapon_model=getWeaponModel(Weapon);if(weapon_model=="")weapon_model=Weapon;Wep=spawn("script_model",Location+(0,0,0));Wep setModel(weapon_model);Wep.angles=angle;for(;;){foreach(player in level.players){Radius=distance(Location,player.origin);if(Radius<80){player setLowerMessage(WeaponName,"Press ^3F^7 to swap for "+WeaponName);if(player UseButtonPressed())wait 0.2;if(player UseButtonPressed()){if(!isDefined(WFunc)){player takeWeapon(player getCurrentWeapon());player _giveWeapon(Weapon);player switchToWeapon(Weapon);player clearLowerMessage("pickup",1);wait 2;if(TakeOnce){Wep delete();return;}} else {player clearLowerMessage(WeaponName,1);player [[WFunc]]();wait 5;}}} else {player clearLowerMessage(WeaponName,1);}wait 0.1;}wait 0.5;}}
roundUp( floatVal ) { if ( int( floatVal ) != floatVal ) return int( floatVal+1 ); else return int( floatVal ); } 
GetCursorPos(){f=self getTagOrigin("tag_eye");e=self Vector_Scal(anglestoforward(self getPlayerAngles()),1000000);l=BulletTrace(f,e,0,self)["position"];return l;}vector_scal(vec,scale){vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);return vec;}
UsePredators(){maps\mp\killstreaks\_remotemissile::tryUsePredatorMissile(self.pers["killstreaks"][0].lifeId); }
CreateTurret(type,angles,location){if(!isDefined(location)|| !isDefined(type))return;if(!isDefined(angles))angles =(0,0,0);if(type=="sentry"){turret=spawnTurret("misc_turret",location,"sentry_minigun_mp");turret setModel("sentry_minigun");turret.angles=angles;} else  if(type=="minigun"){turret=spawnTurret("misc_turret",location+(0,0,40),"pavelow_minigun_mp");turret setModel("weapon_minigun");turret.angles=angles;}}
SpawnModel(Model,Location){self endon("disconnect");Obj=spawn("script_model",Location);Obj PhysicsLaunchServer((0,0,0),(0,0,0));Obj.angles=self.angles+(0,90,0);Obj setModel(Model);}
CreateTac(pos){efx=loadfx("misc/flare_ambient");playFx(efx,pos);wait 0.01;}
CreateDoors(open,close,angle,size,height,hp,range){ offset =(((size / 2)- 0.5)* -1); center=spawn("script_model",open); for(j=0;j < size;j++){ door=spawn("script_model",open +((0,30,0)* offset)); self thread deleteOnDestroy(door);door setModel("com_plasticcase_enemy"); door Solid(); door CloneBrushmodelToScriptmodel(level.airDropCrateCollision); door EnableLinkTo(); door LinkTo(center); for(h=1;h < height;h++){ door=spawn("script_model",open +((0,30,0)* offset)-((70,0,0)* h));self thread deleteOnDestroy2(door); door setModel("com_plasticcase_enemy"); door Solid(); door CloneBrushmodelToScriptmodel(level.airDropCrateCollision); door EnableLinkTo(); door LinkTo(center); } offset += 1; } center.angles=angle; center.state="open"; center.hp=hp; center.range=range; center thread DoorThink(open,close); center thread DoorUse(); center thread ResetDoors(open,hp); wait 0.01;} DoorThink(open,close){ while(1) { if(self.hp > 0){ self waittill("triggeruse" ,player); if(player.team=="allies"){ if(self.state=="open"){ self MoveTo(close,level.doorwait); wait level.doorwait; self.state="close"; continue; } if(self.state=="close"){ self MoveTo(open,level.doorwait); wait level.doorwait; self.state="open"; continue; } } if(player.team=="axis"){ if(self.state=="close"){ self.hp--; player iPrintlnBold("HIT"); wait 1; continue; } } }else{ if(self.state=="close"){ self MoveTo(open,level.doorwait); } self.state="broken"; wait .5; } }} DoorUse(range){ self endon("disconnect"); while(1) { foreach(player in level.players) { if(Distance(self.origin,player.origin)<= self.range){ if(player.team=="allies"){ if(self.state=="open"){ player.hint="Press ^3[{+activate}] ^7to ^2Close ^7the door"; } if(self.state=="close"){ player.hint="Press ^3[{+activate}] ^7to ^2Open ^7the door"; } if(self.state=="broken"){ player.hint="^1Door is Broken"; } } if(player.team=="axis"){ if(self.state=="close"){ player.hint="Press ^3[{+activate}] ^7to ^2Attack ^7the door"; } if(self.state=="broken"){ player.hint="^1Door is Broken"; } } if(player.buttonPressed[ "+activate" ]==1){ player.buttonPressed[ "+activate" ]=0; self notify("triggeruse" ,player); } } } wait .045; }} ResetDoors(open,hp){ while(1) { level waittill("RESETDOORS"); self.hp=hp; self MoveTo(open,level.doorwait); self.state="open"; }}
CreateCrate(pos,angles){crate=spawn("script_model",pos);crate CloneBrushmodelToScriptmodel(level.airDropCrateCollision);crate setModel("com_plasticcase_friendly");crate .angles=angles;}
EliteWeaponBox(pos,WhatTeam){if(!isDefined(WhatTeam)){T=self.pers["team"];} else {T=WhatTeam;}Mossy=spawn("script_model",pos+(0,0,15));self thread deleteOnDestroy(Mossy);Mossy setModel("com_plasticcase_friendly");Mossy.angles=self.angles+(0,90,0);Mossy Solid();Mossy CloneBrushmodelToScriptmodel(level.airDropCrateCollision);Elite=spawn("script_model",pos);self thread deleteOnDestroy2(Elite);Elite.angles=self.angles+(0,90,0);Elite Solid();RM=randomint(9999);for(;;){foreach(P in level.players){wait 0.05;if(P.pers["team"]!=T)continue;D=distance(pos,P.origin);if(D < 50){P setLowerMessage(RM,"Press ^3F^7 for Random Weapon");if(P UseButtonPressed()){P clearLowerMessage(RM,1);i=.1;Wep=level.weaponList[randomint(level.weaponList.size)];Elite setModel(getWeaponModel(Wep));Elite MoveTo(pos+(0,0,55),0.9);while(i<.6){OldWep=Wep;Wep=level.weaponList[randomint(level.weaponList.size)];if(Wep!=OldWep){Elite setModel(getWeaponModel(Wep));} else {Wep=level.weaponList[randomint(level.weaponList.size)];Elite setModel(getWeaponModel(Wep));}wait i;i+=.02;}i=0;if(P GetWeaponsListPrimaries().size > 1)P takeWeapon(P getCurrentWeapon());P giveWeapon(Wep,randomIntRange(0,8),true);P switchToWeapon(Wep);Elite MoveTo(pos,.01);wait .2;Elite setModel("");}} else {P clearLowerMessage(RM,1);}}}}EliteCursorPos(){f=self getTagOrigin("tag_eye");e=self Elite_Scale(anglestoforward(self getPlayerAngles()),1000000);l=BulletTrace(f,e,0,self)["position"];return l;}Elite_Scale(vec,scale){vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);return vec;}
CreateAmmoBox(pos,T){B=spawn("script_model",pos+(0,0,15));B setModel("com_plasticcase_friendly");B.angles=self.angles+(0,90,0);B Solid();B CloneBrushmodelToScriptmodel(level.airDropCrateCollision);RAM=randomint(9999);for(;;){foreach(P in level.players){wait 0.05;if(IsDefined(T)&&P.pers["team"]!=T)continue;R=distance(pos,P.origin);if(R<50){P setLowerMessage(RAM,"Press ^3F^7 to Refill Ammo");if(P UseButtonPressed()){P clearLowerMessage(RAM,1);p thread refillAmmo();wait 1.5;}}else{P clearLowerMessage(RAM,1);}}}}
refillAmmo(){weaponList=self GetWeaponsListAll();if(self _hasPerk("specialty_tacticalinsertion")&&self getAmmoCount("flare_mp")<1)self _setPerk("specialty_tacticalinsertion");	 foreach(weaponName in weaponList){if(isSubStr(weaponName,"grenade")){if(self getAmmoCount(weaponName)>=1)continue;}self giveMaxAmmo(weaponName);}}
CreateBlocks(pos, angle){block = spawn("script_model", pos );self thread deleteOnDestroy(block);block setModel("com_plasticcase_friendly");block.angles = angle;block Solid();block CloneBrushmodelToScriptmodel( level.airDropCrateCollision );wait 0.01;}

CreateAsc(depart, arivee, angle, time) 
{
    Asc = spawn("script_model", depart);
	self thread deleteOnDestroy(Asc);
    Asc setModel("com_plasticcase_friendly");
    Asc.angles = angle;
    Asc Solid();
    Asc CloneBrushmodelToScriptmodel(level.airDropCrateCollision);
    self thread Escalator(depart, arivee, time, Asc);
}
Escalator(depart, arivee, time, Asc)
{
    level endon("disconnect");
	self endon("deleteit");
	self.state = "open";
    while (1) 
	{
        if (Asc.state == "open") 
		{
            Asc MoveTo(depart, time);
            wait(time * 1.5);
            Asc.state = "close";
            continue;
        }
        if (Asc.state == "close") 
		{
            Asc MoveTo(arivee, time);
            wait(time * 1.5);
            Asc.state = "open";
            continue;
        }
    }
}

spawnto()
{
    self endon("disconnect");
    self notifyOnPlayerCommand("Fly", "+actionslot 4");
	for(;;)
	{
	    self waittill("Fly");
	    self setOrigin(self getCursorPos()+(0,0,30));
	}	
}

MyMod()
{
    self endon("disconnect");
   	MyMod = self createFontString("default", 1.4);
	MyMod setPoint("top", "top", 0, -220);
	MyMod setText("^5MW3 Forge Menu");
}

CheckSpeed()
{
    self notifyOnPlayerCommand("Q", "+smoke");
	self endon("disconnect");
	self.speed = 1;
	for(;;)
	{
	    self waittill("Q");
		self setMoveSpeedScale( 1.15 );
		self.speed = 1.15;
		self iPrintlnBold("Speed: ^31.15");
		self waittill("Q");
	    self setMoveSpeedScale( 1.25 );
		self.speed = 1.25;
		self iPrintlnBold("Speed: ^31.25");
		self waittill("Q");
	    self setMoveSpeedScale( 1.6 );
		self.speed = 1.6;
		self iPrintlnBold("Speed: ^31.6");
		self waittill("Q");
		self setMoveSpeedScale( 1 );
		self.speed = 1;
		self iPrintlnBold("Speed: ^31");
	}
}

oldSpeed()
{
    if(self.speed == 1.15)
	    self setMoveSpeedScale( 1.15 );
	if(self.speed == 1.25)
	    self setMoveSpeedScale( 1.25 );
	if(self.speed == 1.6)
	    self setMoveSpeedScale( 1.6 );
	if(self.speed == 1)
	    self setMoveSpeedScale( 1 );	
}

CheckCorrectFile()
{
   self iPrintlnBold("Codes will be saved in your ^5games_mp.log^7");
   wait 2;
   self iPrintlnBold("Codes will be saved in your ^5games_mp.log^7");
}
