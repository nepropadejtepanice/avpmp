CC = gcc
NASM = nasm

CFLAGS = -g -Wall -pipe -Dengine=1 -I. -Iinclude -Iwin95 -Iavp -Iavp/win95 -Iavp/support -Iavp/win95/frontend -Iavp/win95/gadgets
CXXFLAGS = $(CFLAGS)
LDLIBS = -lm # /home/relnev/ElectricFence-2.2.2/libefence.a

CFLAGS += `sdl-config --cflags`
LDLIBS += -L/usr/X11R6/lib -lX11 -lXext `sdl-config --libs`

AFLAGS = -g -Iinclude/ -w+macro-params -w+orphan-labels -w+number-overflow

ROOT = main.c stubs.c afont.c frustum.c kshape.c map.c maths.c md5.c mem3dc.c mem3dcpp.cpp module.c morph.c mslhand.c object.c shpanim.c sphere.c tables.c vdb.c version.c
AVP = ai_sight.c avpview.c bh_agun.c bh_ais.c bh_alien.c bh_binsw.c bh_cable.c bh_corpse.c bh_deathvol.c bh_debri.c bh_dummy.c bh_fan.c bh_far.c bh_fhug.c bh_gener.c bh_ldoor.c bh_lift.c bh_light.c bh_lnksw.c bh_ltfx.c bh_marin.c bh_mission.c bh_near.c bh_pargen.c bh_plachier.c bh_plift.c bh_pred.c bh_queen.c bh_rubberduck.c bh_selfdest.c bh_snds.c bh_spcl.c bh_swdor.c bh_track.c bh_types.c bh_videoscreen.c bh_waypt.c bh_weap.c bh_xeno.c bonusabilities.c cconvars.cpp cdtrackselection.cpp cheatmodes.c comp_map.c comp_shp.c consolelog.cpp davehook.cpp deaths.c decal.c detaillevels.c dynamics.c dynblock.c equipmnt.c equiputl.cpp extents.c game.c gamecmds.cpp gameflow.c gamevars.cpp hmodel.c hud.c inventry.c language.c lighting.c load_shp.c los.c maps.c mempool.c messagehistory.c missions.cpp movement.c paintball.c particle.c pfarlocs.c pheromon.c player.c pmove.c psnd.c psndproj.c pvisible.c savegame.c scream.cpp secstats.c sfx.c stratdef.c targeting.c track.c triggers.c weapons.c
SHAPES = cube.c
SUPPORT = consbind.cpp consbtch.cpp coordstr.cpp daemon.cpp r2base.cpp r2pos666.cpp reflist.cpp refobj.cpp scstring.cpp strtab.cpp strutil.c trig666.cpp wrapstr.cpp
AVPWIN95 = avpchunk.cpp cheat.c chtcodes.cpp d3d_hud.cpp ddplat.cpp endianio.c ffread.cpp ffstdio.cpp gflwplat.c hierplace.cpp iofocus.cpp jsndsup.cpp kzsort.c langplat.c modcmds.cpp npcsetup.cpp objsetup.cpp pathchnk.cpp platsup.c pldghost.c projload.cpp strachnk.cpp system.c vision.c
FRONTEND = avp_envinfo.c avp_intro.cpp 
GADGETS = ahudgadg.cpp conscmnd.cpp conssym.cpp consvar.cpp gadget.cpp hudgadg.cpp rootgadg.cpp t_ingadg.cpp teletype.cpp textexp.cpp textin.cpp trepgadg.cpp
WIN95 = animchnk.cpp animobs.cpp awbmpld.cpp awiffld.cpp awpnmld.cpp bmpnames.cpp chnkload.cpp chnktexi.cpp chnktype.cpp chunk.cpp chunkpal.cpp debuglog.cpp dummyobjectchunk.cpp enumchnk.cpp enumsch.cpp envchunk.cpp fail.c fragchnk.cpp gsprchnk.cpp hierchnk.cpp huffman.cpp iff.cpp iff_ilbm.cpp ilbm_ext.cpp io.c list_tem.cpp ltchunk.cpp media.cpp mishchnk.cpp obchunk.cpp oechunk.cpp our_mem.c plat_shp.c plspecfn.c shpchunk.cpp sndchunk.cpp sprchunk.cpp string.cpp texio.c toolchnk.cpp txioctrl.cpp wpchunk.cpp zsp.cpp

# the following should really be autogenerated...

SRCNAMES =	$(addprefix $(2)/,$(1))
OBJNAMES =	$(addprefix $(2)/,$(addsuffix .o,$(basename $(1))))
OBJNAMES1 =	$(addsuffix .o,$(basename $(1)))

ROOTSRC =	$(ROOT)
ROOTOBJ =	$(call OBJNAMES1,$(ROOT))
AVPSRC	=	$(call SRCNAMES,$(AVP),avp)
AVPOBJ	=	$(call OBJNAMES,$(AVP),avp)
SHAPESSRC =	$(call SRCNAMES,$(SHAPES),avp/shapes)
SHAPESOBJ =	$(call OBJNAMES,$(SHAPES),avp/shapes)
SUPPORTSRC =	$(call SRCNAMES,$(SUPPORT),avp/support)
SUPPORTOBJ =	$(call OBJNAMES,$(SUPPORT),avp/support)
AVPWIN95SRC =	$(call SRCNAMES,$(AVPWIN95),avp/win95)
AVPWIN95OBJ =	$(call OBJNAMES,$(AVPWIN95),avp/win95)
FRONTENDSRC =	$(call SRCNAMES,$(FRONTEND),avp/win95/frontend)
FRONTENDOBJ =	$(call OBJNAMES,$(FRONTEND),avp/win95/frontend)
GADGETSSRC =	$(call SRCNAMES,$(GADGETS),avp/win95/gadgets)
GADGETSOBJ =	$(call OBJNAMES,$(GADGETS),avp/win95/gadgets)
WIN95SRC =	$(call SRCNAMES,$(WIN95),win95)
WIN95OBJ =	$(call OBJNAMES,$(WIN95),win95)

SRC = $(ROOTSRC) $(AVPSRC) $(SHAPESSRC) $(SUPPORTSRC) $(AVPWIN95SRC) $(FRONTENDSRC) $(GADGETSSRC) $(WIN95SRC)
OBJ = $(ROOTOBJ) $(AVPOBJ) $(SHAPESOBJ) $(SUPPORTOBJ) $(AVPWIN95OBJ) $(FRONTENDOBJ) $(GADGETSOBJ) $(WIN95OBJ)

.SUFFIXES: .asm

all: AvP

AvP: depend $(OBJ)
	gcc -o AvP $(OBJ) $(LDLIBS)

compile: $(OBJ)

.asm.o:
	$(NASM) $(AFLAGS) -f elf -o $@ $<

tester:
	echo $(OBJ)

clean:
	-rm -rf depend $(OBJ)

distclean: clean
	-rm -rf `find . -name "*~"`

# I wish I knew how to do dependencies correctly...

#depend: Makefile $(SRC)
#	$(CC) $(CFLAGS) -MM $(SRC) > depend

# insert makefile dependencies here
# -include depend

depend: Makefile # $(SRC)
	touch depend
	makedepend -fdepend -- $(CFLAGS) -- $(SRC)

-include depend
# DO NOT DELETE THIS LINE -- make depend depends on it.
