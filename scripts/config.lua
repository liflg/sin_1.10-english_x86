Setup.Package
{
    vendor = "liflg.org",
    id = "sin",               -- unique identifier, will be proposed as installdirectory SAMPLE: "fakk2"
    description = "Sin",      -- full name of the game, will be used during setup SAMPLE: "Heavy Metal: FAKK2"
    version = "1.10-english",          -- version of the game SAMPLE: "1.02-english"
    splash = "splash.png", -- name of the splash file which has to be placed inside the meta directory
    superuser = false, 
    write_manifest = true, -- needs to be true if an uninstall-option should be provided
                           -- NOTE: atm installing serveral thousands files will slow down the installation process


    preuninstall = function(table)
       MojoSetup.platform.unlink(MojoSetup.destination .. "/ref_soft.so")
       MojoSetup.platform.unlink(MojoSetup.destination .. "/sin.exe")
       MojoSetup.platform.unlink(MojoSetup.destination .. "/base/game.so")
    end,

    postuninstall = function(table)
       MojoSetup.platform.unlink(MojoSetup.destination .. "/base/maps")
       MojoSetup.platform.unlink(MojoSetup.destination .. "/base/")
       MojoSetup.platform.unlink(MojoSetup.destination)
    end,
        
    postinstall = function(table)
        MojoSetup.msgbox("Serial number", "This game requires a serial number. Please fill in the following form or it will not run!")
        MojoSetup.platform.runscript("data/runit.sh", false, MojoSetup.destination .. "/registergui.sh")
    end,

    support_uninstall = true, 
    recommended_destinations =
    {
        "/usr/local/games",
        "/opt/",
        MojoSetup.info.homedir,
    }, 

    Setup.Readme
    {
        description = "README",
        source = "README.liflg"
    },

    Setup.Eula
    {
        description = "EULA",
        source = "licence",
    },

    Setup.Media
    {
        id = "sin-disc",          -- unique identifier for the cd/dvd-rom SAMPLE: "fakk2-cd"
        description = "Sin Linux Disc", -- this string will be shown to the end-user SAMPLE: "FAKK2-Loki CDROM"
        uniquefile = "bin/x86/sin.exe.gz"   -- unique file to decide if a disc is the right one SAMPLE: "fakk/pak0.pk3"
    },

    Setup.DesktopMenuItem
    {
        disabled = false,
        name = "Sin",           -- name of the menu-entry. SAMPLE: "Heavy Metal: FAKK2"
        genericname = "Ego-Shooter",    -- generic name. SAMPLE: "Ego-Shooter"
        tooltip = "Play Sin",        -- tooltip SAMPLE "play Heavy Metal: FAKK2"
        builtin_icon = false,
        icon = "icon.xpm",   -- path to icon file, realtive to the base-dir of the installation
        commandline = "%0/sin.exe.sh",    -- gamebinary or startscript, "%0/" stands for the base directory of the installation SAMPLE: "%0/fakk2.sh"
        category = "Game", 
    },

    Setup.Option
    {    
        value = true,
        required = true,
    	disabled = false,
    	bytes = 674830768,
    	description = "Required game data",
    	tooltip = "Needs the Sin-Linux-CDROM",

        Setup.File
	    {
		    source = "base:///libgtk1.2.tar.xz",
	    },

        Setup.File
	    {
		    source = "base:///libSDL-1.1.tar.xz",
	    },

        Setup.File
        {
            source = "base:///libsmpeg.tar.xz",
        },

        Setup.File
        {
            source = "base:///ref_gl.so.xz",
        },

    	Setup.File
    	{
	    	wildcards = { "sin.exe.sh", "registergui.sh" },
            permissions = "0755",
    	},

        Setup.File
        {
            wildcards = "README.liflg",
        },

    	Setup.File
    	{
    		source = "media://sin-disc/",
    		wildcards = { "help/*", "licence", "readme*", "Sin_Help.htm", "icon.xpm", "base/pak*", "base/movies/*" },
    	},
 
     	Setup.File
        {
            source = "media://sin-disc/bin/x86/",
            wildcards = { "registergui", "ref_soft.so.gz", "sin.exe.gz", "base/game.so.gz" },
            permissions = "0755",
        },

    	Setup.File
    	{
    		source = "media://sin-disc/ctf/ctf.tar.gz",
    	},

        Setup.File
        {
            source = "media://sin-disc/base/base.tar.gz",
        },
 
        Setup.File
        {
            source = "media://sin-disc/base/maps.tar.gz",
            destination = "base/",
        },
    },
}

