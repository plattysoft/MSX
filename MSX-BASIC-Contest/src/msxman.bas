5 rem Inicialización / initialization
10cls:color1,15,7:keyoff
20defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
30screen2,0,0
40definta-z
50open"grp:"as#1
60gosub5000
70gosub9000
90tm=40:tf=0
100gs=0
120stopon:onstopgosub140
140gosub900
150gs=0:goto200
160return
200 rem <<<<<<<<Bucle o máquina de estados / loop or state machine>>>>>>>>>>>>>
205ifgs=0thengoto300
210ifgs=1thengoto600
220ifgs=2thengoto500
300screen2:re=1:gosub4000
310draw("bm0,50c9r14d11r219u11r23d20l256u20c7u50r260d27l260")
320draw("bm20,40c4e10f10r20e10f10r20e10r40f10r20e10f10r20e10f10r5h12l210g12r230l10c11d20l210u19r210")
330a$="r5d5l5u5":draw("bm30,45xa$;"):draw("bm60,45xa$;"):draw("bm90,45xa$;"):draw("bm120,45xa$;"):draw("bm150,45xa$;"):draw("bm180,45xa$;"):draw("bm210,45xa$;")
340draw("bm120,50r5d10l5u10")
350paint(2,2),7,7:paint(2,65),9,9
360paint(100,35),4,4:paint(23,55),11,11
    370 preset (60,10):print #1,"MSX mansion"
    380 preset (60,20):print #1,"MSX Murcia 2022"
    390 preset (0,80):print #1,"Debes de ingeniar como salir de la mansion antes de que se te   acabe el tiempo"
    400 preset (0,110):print #1,"Utiliza las herramientas que    tienes a tu disposicion, pulsa  espacio para elegir una."
    440 preset (0,140):print #1,"Solo puedes utilizarlas una vez por mundo."
    450 preset (0,160):print #1,"Pulsa stop para terminar la     partida."
    460 preset (0,180):print #1,"Pulsa espacio para continuar"
465re=1:gosub4000
470co=co+1:ifco>600thenco=0:goto465elseifstrig(0)=-1thencls:gs=1:goto200elsegoto470
500screen2
510gosub900
    520 preset (60,10):print #1,"Has ganado"
    530 preset (60,20):print #1,"MSX Murcia 2022"
    540 preset (0,50):print #1,"Desarrolador: Kike Madrigal"
    550 preset (0,70):print #1,"Email: Kikemadrigal@hotmail.com"
    560 preset (0,90):print #1,"Muchas gracias por probar       nuestro juego     :)"
    570 preset (0,180):print #1,"Pulsa espacio para continuar"
580ifstrig(0)=-1thengs=0:goto200elsegoto580
600 rem inicio partida / start game
605a=usr3(0)
610pe=3
620gosub10000
630fori=0to19:vpoke(6144+20)+i*32,3:vpoke(6144+21)+i*32,3:vpoke(6144+22)+i*32,3:vpoke(6144+23)+i*32,3:nexti
640gosub11000
650gosub7000
660gosub3100
661gosub7100
680gosub8300
690intervalon:oninterval=100gosub3200
700strig(0)on:onstriggosub7100
710gosub3000
720time=0:ta=1
730a=usr4(0)
800 rem  <<<<<< Main loop >>>>>'
805ifpe<=0thengosub900:gs=0:goto200
810ifta<=0thentf=0:time=0:gosub5700
820'gosub1000
821st=stick(0)orstick(1)orstick(2)
822ifstick(0)>0thenxp=x:yp=y
823onstgoto825,826,827,828,829,830,831,832
824goto834
825y=y-pv:ps=p(0):swapp(0),p(1):pd=1:goto833
826y=y-pv:x=x+pv:ps=p(0):swapp(0),p(1):pd=1:goto833
827x=x+pv:ps=p(2):swapp(2),p(3):pd=3:goto833
828y=y+pv:x=x+pv:ps=p(4):swapp(4),p(5):pd=5:goto833
829y=y+pv:ps=p(4):swapp(4),p(5):pd=5:goto833
830x=x-pv:y=y+pv:ps=p(4):swapp(4),p(5):pd=5:goto833
831x=x-pv:ps=p(6):swapp(6),p(7):pd=7:goto833
832x=x-pv:y=y-pv:ps=p(0):swapp(0),p(1):pd=1:goto833
833re=10:gosub4000
834gosub1760
840ifmcthenms=ms+1:tf=ta:time=0:mc=0:ifmw=2andms=3thengs=2:goto200elsegosub11000:ifms=3thenmw=mw+1:ms=0:gosub7000:gosub3000:gosub3100:gosub8300elsegosub3000:gosub8300
890goto800
900restore10100:intervaloff:gosub6600:PUTSPRITE0,(0,212),1,0:PUTSPRITE20,(0,212),1,0:gosub7000:mw=0:ms=0
910return
1760 rem <<< PHYSICS, COLLISION SYSTEM & RENDER>>>>
1761ifx<=0thenx=xp:ify<=0theny=yp
1762ify+ph>160theny=yp
1763ifx+pw>160thenx=xp
1764md=6144+(y/8)*32+(x/8):a=vpeek(md)
1770ifa>3anda<17thenifos=3ando3=1thenvpokemd,0:o3=0:gosub3100:re=10:gosub4000elseifos=4ando4=1theno4=0:gosub3100:re=2:gosub3000elsex=xp:y=yp
1775ifa=22andos=5ando5=1theno5=0:gosub3100:re=8:gosub4000:vpokemd,0:ifpd=1thenvpoke6144+((y/8)-1)*32+(x/8),22elseifpd=3thenvpoke6144+((y/8)*32)+1+(x/8),22elseifpd=5thenvpoke6144+(((y/8)+1)*32)+(x/8),22elseifpd=7thenvpoke6144+((y/8)*32)+(x/8)-1,22
1780ifa=22thenx=xp:y=yp
1781ifa=21thenre=11:gosub4000:vpokemd,0:pp=pp+10:gosub3100:gosub3300
1785ifa=18ora=19thenre=2:gosub4000:mc=1
1790ifa=20thentf=ta:time=0:re=5:gosub4000:vpokemd,0
1795ifa=24thenbeep:gosub5700
1800putsprite0,(x,y),1,ps
1910ex=ex+ev
1920ifbt=0thenby=by+blelsebx=bx+bv
1930md=base(5)+(ey/8)*32+(ex/8):a=vpeek(md)
1940ifa>3anda<17ora=22thenev=-ev:ex=ea:ey=ei
1945ifex>160orex<=0orey>160orey<=0thengosub6600
1950ea=ex:ei=ey
1951md=base(5)+(by/8)*32+(bx/8):a=vpeek(md)
1952ifa>3anda<17ora=22thenbl=-bl:bv=-bv:bx=ba:by=bi
1953ifex>160orex<=0orey>160orey<=0thengosub6600
1954ba=bx:bi=by
1960ifx<ex+ewandx+pw>exandy<ey+ehandy+ph>eythenem=0:gosub2000:return
1961ifx<bx+bwandx+pw>bxandy<by+bhandy+ph>bythenbm=0:gosub2000:return
1965ec=ec+1:ifec>1thenec=0
1966bc=bc+1:ifbc>1thenbc=0
1970ifec=0thenes=8elsees=9
1980ifbc=0thenbs=10elsebs=11
1990ifem=1thenPUTSPRITEep,(ex,ey),eo,es
1995ifbm=1thenPUTSPRITEbp,(bx,by),bo,bs
1999return
2000ifos=2ando2=1thenre=6:gosub4000:o2=0:gosub3100:gosub6600:returnelsere=6:gosub4000:gosub5700:putsprite0,(x,y),1,ps
2090return
3000line(25*8,0)-(256,20*8),14,bf
3020preset(26*8,1*8):print#1,"World"
3030preset(27*8,3*8):print#1,mw
3040preset(26*8,5*8):print#1,"Level"
3050preset(27*8,7*8):print#1,ms
3060preset(26*8,9*8):print#1,"Live"
3070preset(26*8,11*8):print#1,pe
3075preset(26*8,13*8):print#1,"Score"
3080preset(26*8,15*8):print#1,pp
3085preset(26*8,17*8):print#1,"Time"
3099return
3100ifo1thenPUTSPRITE21,((22*8)-4,5*8),6,13elsePUTSPRITE21,((22*8)-4,5*8),15,13
3110ifo2thenPUTSPRITE22,((22*8)-4,7*8),6,14elsePUTSPRITE22,((22*8)-4,7*8),15,14
3120ifo3thenPUTSPRITE23,((22*8)-4,9*8),6,15elsePUTSPRITE23,((22*8)-4,9*8),15,15
3140ifo4thenPUTSPRITE24,((22*8)-4,11*8),6,16elsePUTSPRITE24,((22*8)-4,11*8),15,16
3150ifo5thenPUTSPRITE26,((22*8)-4,13*8),6,17elsePUTSPRITE26,((22*8)-4,13*8),15,17
3190return
3200line(26*8,18*8)-(30*8,20*8),14,bf
3210tu=time/100
3220ta=(tm+tf)-tu
3230preset(26*8,(19*8)-4):print#1,ta
3240iftamod2=0thenvpoke6144+(ty*32)+tx,0elsevpoke6144+(ty*32)+tx,24
3290return
3300line(27*8,15*8)-(31*8,16*8),14,bf
3310preset(26*8,15*8):print#1,pp
3390return
3400preset(0,23*8):print#1,en
3490return
4000a=usr2(0)
4010ifre=1thenPLAY"O5L8V4M8000CDCDCDCDCDEDEDEDEDCDCDCDCDEDEDEDED","o1v2o2CDR2CDR2o3CDR2r2o2cdr2"
4020ifre=2thenPLAY"O5L8V4M8000cder6cder2eedr12eedo6edccder6cder2eedr12eedo6edco3cder6cder2eedr2eedo6edc","o1v2o2r6CDr2cdr6CDr2cdr6CDr2cdr6CDr2cd"
4030ifre=5thenplay"l10o3v4gc"
4040ifre=6thenplay"t250o4v12dv9e"
4050ifre=7thenplay"O3L8V4M8000AADFG2AAAA"
4060ifre=8thensound1,2:sound8,16:sound12,5:sound13,9
4070ifre=9thenPLAY"o3l64t255v4m6500c"
4060ifre=10thensound1,2:sound6,25:sound8,16:sound12,1:sound13,9
4070ifre=11thensound1,0:sound6,25:sound8,16:sound12,4:sound13,9
4090return
5000x=0:y=0:xp=0:yp=0:pw=8:ph=8:pv=8:pe=3:pd=0:pp=0:pc=0
5010dimp(7):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5:p(6)=6:p(7)=7
5020return
5700pe=pe-1:pa=pa-pm:time=0
5740gosub8300
5750gosub3000
5790return
6100ew=8:eh=8:es=8:ep=10
6105ex=0:ey=0:ea=0:ei=0
6110ev=8
6160ec=0
6170eo=rnd(1)*(6-4)+4
6186em=1
6190return
6200bw=8:bh=8:bs=10:bp=11
6205bx=0:by=0:ba=0:bi=0
6210bv=8:bl=8
6260bc=0
6270bo=rnd(1)*(6-4)+4
6275bt=0
6281bm=1
6290return
6600ifem=0thenex=0:ey=212:putspriteep,(ex,ey),,es
6610ifbm=0thenbx=0:by=212:putspritebp,(bx,by),,bs
6640return
7000os=0:oy=3*8
7020o1=1:o2=1:o3=1:o4=1:o5=1
7090return
7100beep:os=os+1:ifos>5thenos=1
7105oy=oy+16:ifoy>13*8thenoy=5*8
7110line(0,20*8)-(256,24*8),15,bf
    7130 if os=2 and o2=1 then  preset (0,21*8):print #1,"Seleccionada la espada: ":preset (0,22*8):print #1,"Puedes matar enemigos"
    7140 if os=3 and o3=1 then  preset (0,21*8):print #1,"Seleccionada el rayo:":preset (0,22*8):print #1,"Puedes romper los muros"
    7160 if os=4 and o4=1 then  preset (0,21*8):print #1,"Seleccionada la escalera: ":preset (0,22*8):print #1,"Puedes pasar por encima de los muros"             
    7170 if os=5 and o5=1 then  preset (0,21*8):print #1,"Seleccionada la fuerza: " :preset (0,22*8):print #1,"Puedes mover los bloques rosas  pero solo 1 posicion."
7175ifgs=1thenPUTSPRITE20,((20*8),oy),1,12
7190return
8000mw=1:ms=0:mc=0:md=0:mp=0:tn=0
8020return
8300gosub6600
8305vpoke6144+(ty*32)+tx,0
8310ifmw=0andms=0thenx=5*8:y=10*8:tx=12:ty=13:gosub6100:ex=8*8:ey=2*8:gosub6200:bx=12*8:by=16*8:bt=0
8320ifmw=0andms=1thenx=1*8:y=18*8:tx=10:ty=15:gosub6100:ex=10*8:ey=15*8:gosub6200:bx=7*8:by=4*8:bt=1
8330ifmw=0andms=2thenx=1*8:y=14*8:tx=10:ty=7:gosub6100:ex=10*8:ey=1*8:gosub6200:bx=10*8:by=10*8:bt=0
8340ifmw=1andms=0thenx=14*8:y=7*8:tx=10:ty=4:gosub6100:ex=10*8:ey=4*8:gosub6200:bx=17*8:by=13*8:bt=1
8350ifmw=1andms=1thenx=4*8:y=13*8:tx=16:ty=11:gosub6100:ex=15*8:ey=12*8:gosub6200:bx=1*8:by=11*8:bt=0
8360ifmw=1andms=2thenx=1*8:y=1*8:tx=3:ty=12:gosub6100:ex=7*8:ey=15*8:gosub6200:bx=16*8:by=12*8:bt=0
8370ifmw=2andms=0thenx=12*8:y=6*8:tx=18:ty=7:gosub6100:ex=16*8:ey=12*8:gosub6200:bx=1*8:by=11*8:bt=0
8380ifmw=2andms=1thenx=1*8:y=1*8:tx=13:ty=11:gosub6100:ex=7*8:ey=15*8:gosub6200:bx=16*8:by=7*8:bt=1
8390ifmw=2andms=2thenx=5*8:y=1*8:tx=5:ty=11:gosub6100:ex=1*8:ey=10*8:gosub6200:bx=5*8:by=8*8:bt=0
8399return
9000FORI=0TO17:SP$=""
9020FORJ=1TO8:READA$
9030SP$=SP$+CHR$(VAL("&H"+A$))
9040NEXTJ
9050SPRITE$(I)=SP$
9060NEXTI
9110DATA03,C3,D8,3C,BD,DB,E7,7E
9120DATAC0,C3,1B,3C,BD,DB,E7,7E
9130DATA76,E6,D8,BC,BC,D8,E3,73
9140DATA73,E3,D8,BC,BC,D8,E6,76
9150DATA7E,E7,DB,BD,3C,1B,C3,C0
9160DATA7E,E7,DB,BD,3C,D8,C3,03
9170DATACE,C7,1B,3D,3D,1B,67,6E
9180DATA6E,67,1B,3D,3D,1B,C7,CE
9190DATA18,3C,66,C3,C3,66,3C,18
9200DATA3C,7E,FF,E7,E7,FF,7E,3C
9210DATA81,C3,24,3C,3C,24,42,C3
9220DATA00,42,66,3C,3C,24,66,00
9230DATA00,04,06,FF,FF,06,04,00
9240DATA81,42,24,18,18,24,42,81
9250DATA01,02,04,88,50,20,D0,C8
9260DATA07,0E,38,70,0E,1C,70,E0
9270DATA24,24,3C,24,24,3C,24,24
9280DATA00,23,33,FB,FB,33,23,00
9990return
10000FORI=0TO(26*8)-1
10020READA$
10030VPOKEI,VAL("&H"+A$)
10040VPOKE2048+I,VAL("&H"+A$)
10050VPOKE4096+I,VAL("&H"+A$)
10060NEXTI
10100DATAFF,66,66,00,00,66,66,00
10101DATAFF,66,66,00,00,66,66,00
10102DATAFF,99,99,FF,FF,99,99,FF
10103DATAFF,FF,FF,FF,FF,FF,FF,FF
10104DATA7E,7E,7E,7E,7E,7E,7E,7E
10105DATA00,7E,7E,7E,7E,7E,7E,7E
10106DATA7E,7E,7E,7E,7E,7E,7E,00
10107DATA00,FF,FF,FF,FF,FF,FF,00
10108DATA00,FE,FE,FE,FE,FE,FE,00
10109DATA00,7F,7F,7F,7F,7F,7F,00
10110DATA7F,7F,7F,7F,7F,7F,7F,00
10111DATAFE,FE,FE,FE,FE,FE,FE,00
10112DATA00,FE,FE,FE,FE,FE,FE,FE
10113DATA00,7F,7F,7F,7F,7F,7F,7F
10114DATA00,F7,F7,F7,00,7F,7F,7F
10115DATA00,F7,F7,F7,00,7F,7F,7F
10116DATA00,F7,F7,F7,00,7F,7F,7F
10117DATAFF,18,18,7E,7E,18,18,00
10118DATA00,7E,7E,7E,7E,7E,7E,7E
10119DATA5E,5E,7E,7E,7E,7E,7E,00
10120DATA18,3C,C3,81,1C,C3,3C,18
10121DATA14,3F,54,3E,15,15,7E,14
10122DATAFF,A5,FF,A5,A5,FF,A5,FF
10123DATAFF,5A,00,5A,5A,00,5A,00
10124DATAFF,C3,BD,5A,66,3C,81,D5
10125DATA7E,BD,DB,E7,E7,DB,BD,7E
10500FORI=0TO(26*8)-1
10520READA$
10530VPOKE8192+I,VAL("&H"+A$):'&h2000'
10540VPOKE10240+I,VAL("&H"+A$):'&h2800'
10550VPOKE12288+I,VAL("&H"+A$):'&h3000'
10560NEXTI
10600DATAE1,FE,FE,FE,FE,FE,FE,FE
10601DATAA1,EA,EA,EA,EA,EA,EA,EA
10602DATAF1,FE,FE,FE,FE,FE,FE,FE
10603DATAA1,A1,A1,A1,A1,A1,A1,A1
10604DATAA1,A1,A1,A1,A1,A1,A1,A1
10605DATAA1,E1,A1,A1,A1,A1,A1,A1
10606DATAA1,A1,A1,A1,A1,A1,E1,E1
10607DATAE1,E1,A1,A1,A1,A1,E1,E1
10608DATAE1,E1,A1,A1,A1,A1,E1,E1
10609DATAE1,E1,A1,A1,A1,A1,E1,E1
10610DATAA1,A1,A1,A1,A1,A1,E1,E1
10611DATAA1,A1,A1,A1,A1,A1,E1,E1
10612DATAE1,E1,A1,A1,A1,A1,A1,A1
10613DATAA1,E1,A1,A1,A1,A1,A1,A1
10614DATAA1,81,81,81,81,81,81,81
10615DATA81,51,51,51,51,51,51,51
10616DATA51,31,31,31,31,31,31,31
10617DATAF1,BF,BF,BF,BF,BF,BF,BF
10618DATA11,91,71,71,71,71,91,91
10619DATA91,91,91,91,91,91,91,91
10620DATA7F,7F,75,75,85,75,7F,7F
10621DATAA1,A1,A1,A1,A1,A1,A1,A1
10622DATAD1,D9,D9,D9,D9,D9,D9,D9
10623DATA61,D6,D6,D6,D6,D6,D6,D6
10624DATAA1,A6,A6,A6,A6,A6,A6,A6
10625DATAA6,A6,A6,A6,A6,A6,A6,A6
10690return
11000gosub6600
11010md=6144
11020forf=0to19
11030READmp$
11040forc=0to39step2
11050tn$=mid$(mp$,c+1,2)
11060tn=val("&h"+tn$)
11070VPOKEmd,tn:md=md+1
11160nextc
11170md=md+12
11180nextf
11190return
12000data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12010data0e1404000d07070708000000090307070707080e
12020data0e0004000415000000000016000400000000000e
12030data0e00040004000d0707030800000a0707070c000e
12040data0e0004000400040000040000000000120004000e
12050data0e000a070b000a0707030707070c00130004000e
12060data0e0000000000000000040000000400000004000e
12070data0e0707070707070c00040000000400000004000e
12080data0e00000000000004000a070707030707070b000e
12090data0e0015000016000400000000000000000000000e
12100data0e00000000000004000d0707070707070708000e
12110data0e000d070800000400040000000000000000000e
12120data0e00040000000004000a070707070c000907070e
12130data0e0004000d07070b00000000180004000000000e
12140data0e000400041400000009070c000004000000000e
12150data0e0004000a07070c0000000400000a07070c000e
12160data0e0004000000000400000004000000000004000e
12170data0e000a07070707030707070b001600000004000e
12180data0e0000000000000000000000000000000004140e
12190data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12200data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12210data0e0907070707070707070708000000000000000e
12220data0e140000000000000000150000000d070707160e
12230data0e090707070716070716070c000004000000000e
12240data0e0000000000000000000004000004000005000e
12250data0e00090307070707070c0006000004000004000e
12260data0e0000040000000000041500000004000004000e
12270data0e05000400001600000400000d070b000004000e
12280data0e0400040005000500040000041200000004000e
12290data0e0400040004000400040000041300000004000e
12300data0e04000400040004000400000a070716030b000e
12310data0e0400040004000400040000000000000400000e
12320data0e040004000400040004000d070708000400090e
12330data0e0400040004000400040004000000000400000e
12340data0e04000400060004000a0703070707070308000e
12350data0e0600041500000400000000000000000000000e
12360data0e0000060005000a07070707070707070c16000e
12370data0e0000000004000000000000000000000400000e
12380data0e000000000a070707070707070708140415140e
12390data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12400data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12410data0e0000000000000000000000000000000000000e
12420data0e000d07070707070708160009070707070c000e
12430data0e0004000000000000000000000000000004000e
12440data0e0004150000000000000000000000001404000e
12450data0e000307070707070707070707070707070b000e
12460data0e0004000000000000000000000000000000000e
12470data0e000415000000140516000e0e0e0e0e0e0e0e0e
12480data0e000a07070707070300000e0e0e0e0e0e0e0e0e
12490data0e000000000000000400000e0e1200000000000e
12500data0e000000000000150400000e0e1300000000000e
12510data0e000d07070707070300000e0e0e0e0e0e0e000e
12520data0e0004000000000006000016000000000005000e
12530data0e000400000000000000000e000000000004000e
12540data0e0003070707070707070707070707080004000e
12550data0e070b000000000000000000000000000004000e
12560data0e0000000000000005000005140000000004000e
12570data0e000907070707070b00000a07070707070b000e
12580data0e1500000000001600000000000000000000000e
12590data000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12600data0d0707070707070707070707070707070707070c
12610data04020202020202140f1502020202020202021504
12620data04020f0f0f0f020f0f0f020f0f020f020f0f0f04
12630data04020f020f0f0f0f0f0f0f0f0f0f0f020f020f04
12640data0402020202020202020202020202020202020204
12650data04020f0f0f0f0f0f0f0f0f0f0f0f0f0f0f020f04
12660data04020f020f020f020f020f150f020f020f020204
12670data0402020202020202020202020f02020202020204
12680data040f0f0f0f020f0f0f0f0f020f0f0f0f0f0f0f04
12690data04020f020202020202020f020f020f020f021504
12700data040202020f0f160f0f020f020f020f0202020204
12710data04020f0f0f020f150f020f02020202020f0f0f04
12720data04020f020f020f020f020f0f0f0f0f020f020f04
12730data0402020202020f020f02020202140f0202020204
12740data040f0f0f0f0f0f020f0f0f0f0f0f0f0f0f0f0204
12750data04020f020f020f020f020f020f020f020f021604
12760data0402020216020202020202020202020202020204
12770data04120202020f0f0f0f020f0f0f0f0f0f0f0f0f04
12780data0413020200150202020202020202020202021404
12790data0a0707070707070707070707070707070707070b
12800data0d0707070707070707070707070707070707070c
12810data040f02140f0f0202020f0f1402020202020f0f04
12820data040202020f0f1502020f0f02020f02020f0f0204
12830data0402020f0f0f020f020202020f02020f16020204
12840data040202150f0f02020f02020f02020f0202020204
12850data04020f0f0f0f0f020f0f0f0f0f0f0f0f0f0f1504
12860data04020f02020f0f0202020212020f0f02020f0204
12870data04020202020f0216020202130f0f0f0202020204
12880data040202020f0f02020f02020f0f140f0f02020204
12890data040f0f02020f0202020f0f0f02020f02020f0f04
12900data04020f0202160202020f0f0202020f02020f0204
12910data04020202020f02020f02020f02020f0f02020204
12920data04020f0f020f150f020202020f020f02020f0204
12930data04020f15020f0f020202020202020202020f0204
12940data04020f0f0f0f0f020f0f0f0f0f0f0f0f0f0f0204
12950data040202020f0f02020f02020f0202150f02020204
12960data040202020202020f020202020f0202020f020204
12970data04020f0f02160f02020f0f02020f0f02020f0204
12980data040f0f0202020202020f0f0202150f0202021504
12990data0a0707070707070707070707070707070707070b
13000data0d0707070707070707070707070707070707070c
13010data040202020f0f0f0f0f0f0202020f0f0202021404
13020data04150f020f021602020f020f020f0202160f1504
13030data040f0f020f020f02020f020f020f0202020f0f04
13040data040202020f0215020202150f020f020f020f0204
13050data040f0f020f020f0f0f0f0f0f020f020f020f0f04
13060data04020f020f020f1502020202020f020f020f0204
13070data040f0f0216020f0f0f0f0f0f0202020f020f0f04
13080data04020f020f0215020f02120f0f0f160f020f0204
13090data040f0f020f020f020f02130f150f020f020f0f04
13100data040202020f020f020f02020f020f020f020f0204
13110data040f0f020f020f020f02020f020f020f020f0204
13120data04020f020f020f02020202020202020f020f0204
13130data04150f020f0f0f0f0f0f0f0f0f0f0f0f020f1504
13140data040f0f02020f0f0f0f0f0f0f0f0f0f02020f0204
13150data0402020202020202020202020202020202020204
13160data0402160f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f04
13170data0402020202020202020202020202020202020f04
13180data040f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f021404
13190data0a0707070707070707070707070707070707070b
13200data0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f
13210data0f1010101010101010101010101010101010100f
13220data0f0000001500000000000000001600150000000f
13230data0f0010100510101010100010101000051010000f
13240data0f0000000415100000000000001000040000000f
13250data0f1010000400101000101010101000040010100f
13260data0f0000000400100000000000001000040000000f
13270data0f0000100400101610101010101000041010000f
13280data0f1000000400000000000000000000040000000f
13290data0f0000000400101010101010101000041510100f
13300data0f0000000400000500000000150500040000000f
13310data0f0010100416150400000010100400041010000f
13320data0f0000000400000400000000000400041400000f
13330data0f1010140600000410101010000416061010100f
13340data0f0000000000000400000000000400000000000f
13350data0f0016101010100400000000160410101010000f
13360data0f0000000000000600101010100412000000000f
13370data0f0000000000000000000000150613000000000f
13380data0f1010101010101010101010101010101010100f
13390data0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f
13400data1010101010101010101010101010101010101010
13410data1000000000000000001000001000000000000010
13420data1010151010101015101010101010151010101510
13430data1000000000001600000000000000001000000010
13440data1010101010151010101010151015101010151010
13450data1000000000000000000000001000001000000010
13460data1010171010151010171010101015101015101010
13470data1000001000000000001000000000001000000010
13480data1015101010101010151010151010101015101010
13490data1014000000000000001000001000000000160010
13500data1010151017101010101010151015101010101010
13510data1000000000000000000000001000001012000010
13520data1010101010101010171010101015101013000010
13530data1000000000000000001010101000141000000010
13540data1010151010151010151015101015101010101510
13550data1000001000001000000000000000001000000010
13560data1010151010101010151010101010101015101010
13570data1000000000001000160000000000001000000010
13580data1000001000001000001000001000000000000010
13590data1010101010101010101010101010101010101010
13600data1010101010101010101010101010101010101010
13610data1000000000001000000000001410000016000010
13620data1000101010101015101010101010101510100010
13630data1000100000001600160000100000000000100010
13640data1000100000001000000000101010101000100010
13650data1000100010101010101015100000001000100010
13660data1000100010000000000000160000001000160010
13670data1000100010001010101010101000001010101510
13680data1000100010001000000000001010101000000010
13690data1000171010001000001012001000001500101010
13700data1000150010001016001013001000161000101410
13710data1000100010001500001010001000001000100010
13720data1000100010101010150000001000001000100010
13730data1000100010000010101010101000001000100010
13740data1000100010000000000000000000001000100010
13750data1000100010101010101010101010101000150010
13760data1000100010000000000010000000000000100010
13770data1000101010101010101710101010101010100010
13780data1000000000000000000000000000000000000010
13790data1010101010101010101010101010101010101010