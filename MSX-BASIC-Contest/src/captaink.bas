200CLEAR300:DEFINTA-Z:SCREEN2,2,0:COLOR15,0,0
230_turboon
470DIMpt(5):DIMTL(4):DIMCL(8):DIMRE(6):DIMRY(10):DIMTK(3):DIMTR(6):DIMCF(6,2)
480vdp(4)=0:vdp(3)=159:R=RND(-TIME):GOSUB10000:pu=0:le=0
490IFPEEK(&H002B)>128THENde=3000ELSEde=3600
495SOUND7,184:CX=16:CY=0:pt(1)=12:pt(2)=24:pt(3)=36:pt(4)=30:nu=1:kn=4:rt=5:tc=10:wi=0:tp=0:ta=0:GOSUB10400:GOSUB11000:T$=STR$(pu):tx%=25:ty%=22:tq=7:GOSUB9990
4000'mloop
5200S=STICK(0):IFS=3THENPO=0:ur=ur+1:FA=0
5210IFS=7THENPO=1:ur=ur+1:FA=1
5220IFur>8ANDPO=0ANDsa=0ANDCL(2)=0THENCX=CX+3:it=it+3:it=itmod12:ur=0:GOSUB14000:GOSUB9600:GOSUB14900
5225IFur>8ANDPO=1ANDsa=0ANDCL(3)=0THENCX=CX-3:it=it+3:it=itmod12:ur=0:GOSUB14000:GOSUB9600:GOSUB14900
5230IFS=0THENPO=2:vr=vr+1
5235IFS=1THENPO=3:vr=vr+1
5239IFCL(0)=0THENGOSUB7800
5250IFvr>250AND(PO=2ORPO=3)THENpa=pa+3:pa=pamod6:vr=0:GOSUB9500
7500S1=STRIG(0):IFS1=-1ANDsa=0ANDCL(0)=1THENGOSUB8000ELSEIFsa=1THENGOSUB8117
7510IFTIME>2THEN:GOSUB14100
7520FORI=1TO30:NEXTI:GOTO4000
7799'GR
7800AR=AR+1:IFCL(4)=1ORCL(7)=1THENsp=1ELSEsp=3
7820IFAR>2ANDsa=0THENCY=CY+sp:AR=0:it=FA*3:PO=4:GOSUB9600:IFCL(0)=1THEN:si=1:su=5:fe=2:GOSUB14970
7825'
7830RETURN
8000'SA
8100IFfr=0THENsa=1:im=3
8110IF(S=2ORS=3)THENco=1
8115IF(S=7ORS=8)THENco=2
8117IFfr<=15GOTO8120
8118IFCL(4)=1ORCL(7)=1THENim=-1ELSEim=-3
8120sr=sr+1:IFsr>4THENfr=fr+1:CY=CY-im:CY=CYMOD192:sr=0ELSEGOTO8160
8130IFco=1ANDCL(2)=0THENCX=CX+2:GOSUB14000
8140IFco=2ANDCL(3)=0THENCX=CX-2:GOSUB14000
8150GOSUB9600
8160IFfr<3ANDCL(1)=0GOTO8200
8170IFfr>32ORCL(0)=1ORCL(1)=1ORCL(2)=1ORCL(3)=1THENfr=0:sr=0:fr=0:co=0:sa=0:su=5:si=1:fe=2:GOSUB14970
8200RETURN
9500PUTSPRITE0,(CX,CY),1,pa+pt(PO):PUTSPRITE1,(CX,CY),2,1+pa+pt(PO):PUTSPRITE2,(CX,CY),11,2+pa+pt(PO):GOSUB9700:RETURN
9600PUTSPRITE0,(CX,CY),1,it+pt(PO):PUTSPRITE1,(CX,CY),2,1+it+pt(PO):PUTSPRITE2,(CX,CY),11,2+it+pt(PO):GOSUB9700:RETURN
9700'col
9730T1=(CX+4)\8:T2=(CY+17)\8:GOSUB9840:C1=C0:T1=(CX+6)\8:T2=(CY)\8:GOSUB9840:C2=C0
9732T1=(CX+12)\8:T2=(CY+17)\8:GOSUB9840:C8=C0:T1=(CX+10)\8:T2=(CY)\8::GOSUB9840:C9=C0
9734T1=(CX+8+9)\8:T2=(CY+15)\8:GOSUB9840:C3=C0:T1=(CX+8+9)\8:T2=(CY+8)\8:GOSUB9840:C4=C0
9736T1=(CX-1)\8:T2=(CY+8)\8:GOSUB9840:C5=C0:T1=(CX-1)\8:T2=(CY+15)\8:GOSUB9840:C6=C0
9738T1=(CX-1)\8:T2=(CY+20)\8:GOSUB9840:C7=C0:T1=(CX+16)\8:T2=(CY+20)\8:GOSUB9840:W2=C0
9760IF(C1>kmANDC1<kn)OR(C8>kmANDC8<kn)THENCL(0)=1ELSECL(0)=0
9770IF(C2>kmANDC2<kn)OR(C9>kmANDC9<kn)THENCL(1)=1ELSECL(1)=0
9780IF(C3>kmANDC3<kn)OR(C4>kmANDC4<kn)THENCL(2)=1ELSECL(2)=0
9790IF(C5>kmANDC5<kn)OR(C6>kmANDC6<kn)THENCL(3)=1ELSECL(3)=0
9800IFC7>kmANDC7<knTHENCL(4)=1ELSECL(4)=0
9805IFW2>kmANDW2<knTHENCL(7)=1ELSECL(7)=0
9810IF(C6>3ANDC6<10)OR(C3>3ANDC3<10)THENCL(5)=1ELSECL(5)=0
9820IFC3=26ANDC6=27THENCL(6)=1ELSECL(6)=0
9230RETURN
9840C0=VPEEK(6144+T1+T2*32):RETURN
9990L=LEN(T$)-1:T$=RIGHT$(T$,L):OU$=STRING$(tq-L," ")+T$:FORI=1TOLEN(OU$):CT$=MID$(OU$,I,1):VPOKE&H1800+tx%+ty%*32+I-1,ASC(CT$)-32:NEXTI:RETURN
10000RESTORE18030:S=14336
10020READR$:IFR$="*"GOTO10030ELSEVPOKES,VAL("&H"+R$):S=S+1:GOTO10020
10030RESTORE17020:S=14720
10040READR$:IFR$="*"GOTO10200ELSEVPOKES,VAL("&H"+R$):S=S+1:GOTO10040
10200RESTORE20000:S=0
10210READR$:IFR$="*"GOTO10300ELSEVPOKES,VAL("&H"+R$):S=S+1:GOTO10210
10300RESTORE20250:S=8192
10310READR$:IFR$="*"THENRETURNELSEVPOKES,VAL("&H"+R$):S=S+1:GOTO10310
10400RESTORE30250:S=6144+32*21
10510READR$:IFR$="*"GOTO10520ELSEVPOKES,VAL("&H"+R$):S=S+1:GOTO10510
10520FORI=0TO20*32+31:VPOKE6144+I,13:NEXTI:ON(le+1)\1GOTO10530,10540,10550,10560
10530RESTORE40000:GOTO10600
10540RESTORE41000:GOTO10600
10550RESTORE42000:GOTO10600
10560RESTORE43000
10600FORI=1TO14:READn1,n2,n3:FORE=0TOn3-1:VPOKE6144+n1+1+E+32*n2,1:NEXTE:IFn3<>1THENVPOKE6144+n1+32*n2,3:VPOKE6144+n1+n3+1+32*n2,2
10610NEXTI
10620FORI=0TO8:READCL(I):NEXTI:FORI=1TO6:t=0:READn1,n2:FORE=0TO2:FORA=0TO2:VPOKE(6144+n1+A)+32*(n2+E),CL(t):t=t+1:NEXTA:NEXTE:NEXTI
10630FORI=0TO3:READCL(I):NEXTI:FORI=1TO4:t=0:READn1,n2:FORE=0TO1:FORA=0TO1:VPOKE(6144+n1+A)+32*(n2+E),CL(t):t=t+1:NEXTA:NEXTE:NEXTI
10640FORI=0TO7:VPOKE6144+12+32+I,73:NEXTI:FORI=0TO3:READn1,n2,n3:FORE=1TOn3:VPOKE6144+n1+32*n2+E-1,15:NEXTE:NEXTI
10800VPOKE6144+32*23+16,le+17:RETURN
11000FORI=0TO5:TR(I)=I:NEXTI:y0=0:y2=0:tj=0
11205FORI=0TO767
11206RY(y0)=0:IFVPEEK(6144+I)=73THENRY(y0)=I:y0=y0+1
11210IFVPEEK(6144+I)=27THENGOSUB14640:CF(tj,1)=tj+4:CF(tj,0)=I+6144:y2=y2+1
11220IFy0>9ANDy2>5THENI=767
11230NEXTI:FORI=0TO5:TR(I)=I+4:NEXTI:rt=5:RETURN
14000IFCX>240THENCX=240
14010IFCX<0THENCX=0
14020RETURN
14100TIME=0:nu=nu+1:ta=ta+1:de=de-1:IF(C3=tjORC6=tj)ANDCL(5)=1ANDtp=2THENVPOKE6144+23*32+8+tj-4,tj:tc=tj:ki=1:ku=10:si=1:su=10:GOSUB14960:GOSUB14780
14110IFnu>6THENnu=1
14120IFsi>0ANDsi<suTHENsi=si+1ELSEsi=0
14125IFki>0ANDki<kuTHENki=ki+1ELSEki=0
14130T$=STR$(de):tx%=25:ty%=23:tq=7:GOSUB9990:FORI=0TO5:IFCF(I,1)<10THENVPOKECF(I,0)+1-1*32,nu+16
14140NEXTI:tm=tm+1:IFtm>4THENVPOKE15*8+3,RND(1)*250:VPOKE15*8+4,RND(1)*250:VPOKE8192+15*8+3,RND(1)*250:VPOKE8192+15*8+4,RND(1)*250:tm=0
14190tn=tn+1:IFtn<2THENGOTO14600
14200FORI=0TO9:IFRY(I)>0THENVPOKE6144+RY(I),73+y1
14210NEXTI:tn=0:y1=y1+1:IFy1>3THENy1=0
14275'tarj
14285IFta<130GOTO14400
14289ON(tp+1)\1GOTO14290,14300,14720
14290IFtc=10THENtp=1:xt=RND(1)*32:yt=0:GOSUB14640:t0=VPEEK(6144+xt+(yt*32)):GOSUB15000ELSEta=0:GOTO14400
14300te=t0:t0=VPEEK(6144+xt+((yt+1)*32)):TK(0)=te:TK(1)=tj:TK(2)=6144+xt+(yt*32):SOUND2,yt+6
14310IF(t0>kmANDt0<kn)THENtp=2:ta=0:SOUND9,0:GOTO14600
14320yt=yt+1:VPOKE6144+xt+(yt*32),tj:VPOKE6144+xt+((yt-1)*32),te
14400'CTARJ
14410T1=(CX-1)\8:T2=(CY+9)\8:C0=6144+T1+T2*32:FORI=0TO5:IFPO=3ANDCL(6)=1ANDCF(I,0)=C0ANDTK(1)=CF(I,1)ANDtc=CF(I,1)THENmc=mc+1:cp=I:I=5
14420NEXTI:ifmc>0ANDPO=3thensound7,189:sound9,10:sound3,0:sound2,mc+RND(1)*200+30ELSEmc=0:IFtp=0thensound9,0
14425IFmc=0andCL(6)=1andPO=3thenGOSUB14950
14430IFmc=50THENmc=0:VPOKE6144+8+cp+22*32,59:VPOKECF(cp,0)+1-1*32,CF(cp,1):CF(cp,1)=10:tc=10:ta=0:cp=0:sound9,0:wi=wi+1
14440IFwi=6THENpu=pu+de:T$=STR$(pu):tx%=25:ty%=22:tq=7:GOSUB9990:T1$=" YOU"+" "+"WIN":GOTO15100
14450IFde=0THENT1$=" YOU"+" "+"LOSE":GOTO15100
14600RETURN
14640IFrt>=0THENtk=(INT(RND(TIME)*(rt+1))):tj=TR(tk):rt=rt-1:FORE=tkTO4:TR(E)=TR(E+1):NEXTE
14650RETURN
14720'BrTARJ
14730IFta<30THENRETURN
14740rt=rt+1:TR(rt)=tj
14780VPOKETK(2),TK(0):tp=0:ta=0:RETURN
14900IFfe>1ANDsi=0THENRESTORE15940:fe=0:GOSUB15890:RESTORE15910:GOTO15890ELSEfe=fe+1:RETURN
14950RESTORE15940:GOSUB15890:RESTORE15920:GOTO15890
14960RESTORE15950:GOSUB15890:RESTORE15930:GOTO15890
14970IFki=0THENRESTORE15940:GOSUB15890:RESTORE15925:GOTO15890ELSERETURN
15000RESTORE15900:GOTO15890
15100SOUND7,191:FORI=5TO27:FORE=7TO14:VPOKE6144+I+E*32,0:NEXTE:NEXTI:T$=T1$:tx%=9:ty%=10:tq=11:GOSUB9990:T$=" C"+" "+"CONTINUE":tx%=11:ty%=12:tq=11:GOSUB9990:CY=209:GOSUB9600
15110kb$=INKEY$:IFkb$<>"c"ANDkb$<>"C"GOTO15110
15120IFwi=6THENle=le+1:IFle>3THENle=0
15130GOTO490
15890FORI=1TO7:READn1,n2:SOUNDn1,n2:NEXTI:RETURN
15900DATA2,0,3,1,7,184,11,0,12,0,13,0,9,10
15910DATA4,65,5,1,7,184,11,70,12,2,13,0,10,16
15920DATA4,25,5,3,7,184,11,0,12,7,13,0,10,16
15925DATA4,25,5,6,7,184,11,70,12,2,13,0,10,16
15930DATA4,25,5,1,7,184,11,0,12,50,13,0,10,16
15940DATA4,0,5,0,7,184,11,0,12,0,13,0,10,0
15950DATA2,0,3,0,7,184,11,0,12,0,13,0,9,0
17020DATA7,18,20,38,46,59,2C,20,20,23,1E,8,2F,1F,C,0,E0,98,64,14,2,82,8E,F8,8C,2,E,32,C4,C8,10,0,0,7,1F,7,39,20,0,0,0,0,1,7,0,20,10,C,0,60,98,E8,FC,7C,70,0,70,FC,F0,CC,0,4,C,18
17030DATA0,0,0,0,0,6,13,1F,1F,1C,0,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,30,0,0,F,31,40,70,8C,B3,59,41,41,46,3C,10,1C,F,7,0,C0,30,C8,28,4,4,1C,F0,10,30,50,10,30,E0,0,0
17040DATA0,E,3F,F,73,40,0,0,0,1,3,C,0,0,0,7,0,C0,30,D0,F8,F8,E0,0,E0,C0,A0,60,C0,0,C0,80,0,0,0,0,0,C,26,3E,3E,38,0,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,80,0,0,0,0
17050DATA7,18,20,38,46,59,2C,20,20,23,1E,10,33,1F,C,4,E0,98,64,14,2,82,8E,F8,88,8,58,98,FC,F8,10,0,0,7,1F,7,39,20,0,0,0,0,1,1,0,20,10,8,0,60,98,E8,FC,7C,70,0,70,F0,A0,60,0,4,C,18
17060DATA0,0,0,0,0,6,13,1F,1F,1C,0,E,C,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,0,0,0,0,F,31,40,70,8C,B3,59,41,41,46,3C,10,1C,F,1,0,C0,30,C8,28,4,4,1C,F0,10,30,50,10,30,E0,C0,0
17070DATA0,E,3F,F,73,40,0,0,0,1,3,C,0,0,6,3,0,C0,30,D0,F8,F8,E0,0,E0,C0,A0,60,C0,0,0,C0,0,0,0,0,0,C,26,3E,3E,38,0,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,80,0,0,0,0
17080DATA7,1A,21,20,47,58,36,33,40,80,98,AC,F,F,E,0,E0,18,E4,4,E2,1A,6C,CC,2,1,19,35,F0,F0,70,0,0,5,1E,1F,38,20,0,0,30,7C,67,43,0,0,0,E,0,E0,18,F8,1C,4,0,0,C,3E,E6,C2,0,0,0,70
17090DATA0,0,0,0,0,7,9,C,F,3,0,0,E0,C0,0,0,0,0,0,0,0,E0,90,30,F0,C0,0,0,7,3,0,0,0,F,11,21,40,5F,70,36,43,80,98,8C,F,F,E,0,0,F0,8,C4,22,FA,E,6C,C2,1,19,31,F0,F0,70,0
17100DATA0,0,E,1E,3F,20,0,0,30,70,64,3,0,0,0,E,0,0,F0,38,DC,4,0,0,C,E,26,C0,0,0,0,70,0,0,0,0,0,0,F,9,C,F,3,70,60,0,0,0,0,0,0,0,0,0,F0,90,30,F0,C0,E,6,0,0,0
17120DATA7,19,26,28,40,41,71,1F,31,40,78,4,7,F,E,0,E0,18,4,1C,62,9A,34,84,4,C4,78,14,F4,F0,70,0,0,6,19,17,3F,3E,E,0,E,3F,7,3,0,0,0,E,0,E0,F8,E0,9C,4,0,0,0,0,80,E0,0,0,0,70
17130DATA0,0,0,0,0,0,0,0,0,0,0,38,18,0,0,0,0,0,0,0,0,60,C8,78,F8,38,0,8,8,0,0,0,7,18,20,38,46,59,2C,21,20,23,1E,28,2F,F,E,0,E0,98,64,14,2,82,8E,F8,8C,2,1E,20,E0,F0,70,0
17140DATA0,7,1F,7,39,20,0,0,0,0,1,7,0,0,0,E,0,60,98,E8,FC,7C,70,0,70,FC,E0,C0,0,0,0,70,0,0,0,0,0,6,13,1E,1F,1C,0,10,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1C,18,0,0,0
17150DATA7,1C,20,20,50,4C,23,3C,47,80,98,A8,F,F,E,0,E0,38,4,4,A,32,C4,3C,E2,1,19,15,F0,F0,70,0,0,3,1F,1F,2F,33,1C,3,38,7F,67,47,0,0,0,E,0,C0,F8,F8,F4,CC,38,C0,1C,FE,E6,E2,0,0,0,70
17160DATA0,0,0,0,0,0,0,0,0,0,0,0,E0,C0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,3,0,0,0,7,1C,20,20,50,4C,23,7C,87,98,88,F,F,E,0,0,E0,38,4,4,A,32,C4,3E,E1,19,11,F0,F0,70,0
17170DATA0,0,3,1F,1F,2F,33,1C,3,78,67,7,0,0,0,E,0,0,C0,F8,F8,F4,CC,38,C0,1E,E6,E0,0,0,0,70,0,0,0,0,0,0,0,0,0,0,0,70,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,E,6,0,0,0,*
18000'Cap
18030DATA7,19,26,28,40,41,71,1F,31,40,70,4C,23,13,8,0,E0,18,4,1C,62,9A,34,4,4,C4,78,10,F4,F8,30,0,0,6,19,17,3F,3E,E,0,E,3F,F,33,0,20,30,18,0,E0,F8,E0,9C,4,0,0,0,0,80,E0,0,4,8,30
18090DATA0,0,0,0,0,0,0,0,0,0,0,0,1C,C,0,0,0,0,0,0,0,60,C8,F8,F8,38,0,8,8,0,0,0,3,C,13,14,20,20,38,F,8,C,A,8,C,7,0,0,F0,8C,2,E,31,CD,9A,82,82,62,3C,8,38,F0,E0,0
18170DATA0,3,C,B,1F,1F,7,0,7,3,5,6,3,0,3,1,0,70,FC,F0,CE,2,0,0,0,80,C0,30,0,0,0,E0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,30,64,7C,7C,1C,0,C0,C0,0,0,0
18250DATA7,19,26,28,40,41,71,1F,11,10,1A,19,3F,1F,8,0,E0,18,4,1C,62,9A,34,4,4,C4,78,8,CC,F8,30,20,0,6,19,17,3F,3E,E,0,E,F,5,6,0,20,30,18,0,E0,F8,E0,9C,4,0,0,0,0,80,80,0,4,8,10
18310DATA0,0,0,0,0,0,0,0,0,0,20,20,0,0,0,0,0,0,0,0,0,60,C8,F8,F8,38,0,70,30,0,0,0,3,C,13,14,20,20,38,F,8,C,A,8,C,7,3,0,F0,8C,2,E,31,CD,9A,82,82,62,3C,8,38,F0,80,0
18390DATA0,3,C,B,1F,1F,7,0,7,3,5,6,3,0,0,3,0,70,FC,F0,CE,2,0,0,0,80,C0,30,0,0,60,C0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,30,64,7C,7C,1C,0,C0,C0,0,0,0
18440DATA*
20000'tlst
20050DATAFF,FF,FF,FF,FF,FF,FF,FF,FF,FF,DB,FF,FF,DB,FF,FF,FE,FF,DB,FD,FD,DB,FF,FE,7F,FF,DB,BF,BF,DB,FF,7F,C,3E,77,FF,FE,FC,78,30,C,3E,77,EF,FE,FC,78,30,C,3E,77,EF,DE,FC,78,30,C,3E,77,EB,DE,FC,78,30
20070DATAC,3E,77,EB,D6,FC,78,30,C,3E,77,EB,D6,EC,78,30,FF,F3,EB,DB,BB,7A,F9,FF,FF,FC,FA,F6,EE,5E,BE,FF,FF,9F,5E,DD,DB,D7,CF,FF,FF,00,EF,D7,BB,7D,00,FF,FF,0,FF,95,95,FF,0,FF,FF,0,FF,95,95,FF,0,FF
20090DATA1C,26,63,63,63,33,1E,FF,C,1C,C,C,C,C,3F,FF,3E,63,7,1E,3C,60,7F,FF,3F,6,C,1E,3,63,3E,FF,E,1E,36,66,7F,6,6,FF,7E,60,7E,3,3,63,3E,FF,1E,30,60,7E,63,63,3E,FF,7F,63,6,C,18,18,18,FF
20110DATA3E,63,63,3E,63,63,3E,FF,3E,63,63,3F,3,6,3C,FF,EB,EB,EB,B,FB,3,FE,FC,D7,D7,D7,D0,DF,C0,7F,3F,3F,7F,C0,DF,D0,D7,D7,D7,FC,FE,3,FB,B,EB,EB,EB,FF,FF,0,FB,0,FF,FF,0,0,FF,FF,0,FB,0,FF,FF
20130DATA0,0,0,0,0,0,0,0,1C,36,63,63,7F,63,63,63,7E,63,63,7E,63,63,7E,7E,1E,33,60,60,60,33,1E,1E,7C,66,63,63,63,66,7C,7C,7F,60,60,7C,60,60,7F,FF,7F,60,60,7C,60,60,60,FF,1F,30,60,67,63,33,1F,1F
20150DATA63,63,63,7F,63,63,63,63,3F,C,C,C,C,C,3F,3F,3,3,3,3,3,63,3E,3E,63,66,6C,78,6C,66,63,63,60,60,60,60,60,60,7F,7F,63,77,7F,6B,63,63,63,FF,63,73,7B,6F,67,63,63,63,3E,63,63,63,63,63,3E,3E
20170DATA7E,63,63,63,7E,60,60,60,3E,63,63,63,6D,66,3B,3B,7E,63,63,67,7C,6E,67,67,3C,66,60,3E,3,63,3E,3E,3F,C,C,C,C,C,C,C,63,63,63,63,63,63,3E,3E,63,63,63,63,36,1C,8,8,63,63,63,6B,7F,36,22,22
20190 DATA63,77,3E,1C,3E,77,63,63,33,33,33,1E,C,C,C,C,7F,7,E,1C,38,70,7F,FF,FF,81,BD,E7,A5,BD,81,FF,FF,20,10,8,4,2,FF,FF,7E,6,6,6,6,6,7E,FF,FF,FF,8,14,22,FF,FF,FF,FF,FF,FF,FF,FF,FF,7F,FF
20210DATAD6,D6,C6,D6,D6,D6,D6,D6,6B,6B,6B,6B,6B,63,6B,6B,29,3,25,3,21,B,1,2B,2F,17,2F,17,2F,17,2F,17,FF,0,B5,BD,BD,AD,0,FF,AF,BF,AF,BF,AA,BF,C0,FF,FD,FD,FD,FD,FD,FD,3,FF,FF,C0,BF,BF,BF,BF,BF,BF
20230 DATAFF,3,FD,55,FD,F5,FD,F5,FF,CF,AF,6E,ED,EB,E7,FF,FF,F3,EB,DB,BB,7A,F9,FF,FF,FC,FA,F6,EE,5E,BE,FF,FF,9F,5E,DD,DB,D7,CF,FF,*
20250'clr
20280 DATA0,0,0,0,0,0,0,0,81,E1,F1,F1,B1,E1,E1,71,81,E1,F1,F1,B1,E1,E1,71,81,E1,F1,F1,B1,E1,E1,71,F1,E1,71,71,71,51,51,51,F1,E1,E1,B1,A1,91,D1,D1,F1,31,21,21,21,C1,C1,C1,F1,E1,E1,B1,B1,B1,A1,A1
20300 DATAA1,91,81,81,81,61,61,61,F1,B1,E1,E1,71,31,31,C1,13,53,43,43,43,43,53,13,13,43,43,43,43,43,43,13,43,43,43,43,43,43,43,43,15,15,15,15,15,15,15,15,45,45,45,45,46,45,45,45,15,45,45,4B,45,45,45,15
20320 DATAE0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0
20340 DATAE0,F0,F0,F0,B0,E0,E0,0,E0,F0,F0,F0,B0,E0,E0,0,A0,A0,A0,A0,A0,A0,A8,A8,A0,A0,A0,A0,A0,A0,A8,A8,A8,A8,A0,A0,A0,A0,A0,A0,A8,A8,A0,A0,A0,A0,A0,A0,A1,A1,A0,A0,A0,A0,A0,A0,A0,A0,A0,A0,A0,A0,A1,A1
20360 DATAF4,F4,F4,F4,F4,F4,F4,F4,E1,F1,F1,F1,A1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1
20380 DATAE1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,E1,E1,E1,1,E0,F0,F0,F0,B0,E0,E0,0,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1
20400 DATAE1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1
20420 DATAE1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,E1,F1,F1,F1,B1,E1,E1,1,A1,A1,A1,A1,A1,A1,A1,A1,0,F0,F0,F0,F0,F0,0,0,F0,F0,F0,F0,F0,F0,F0,0,0,0,F0,F0,F0,0,0,0,0,0,0,0,0,0,F0,0
20440 DATAA1,A1,A0,A0,A0,A0,A0,A0,A1,A1,A0,A0,A0,A0,A0,A0,45,45,45,45,45,45,45,45,47,47,47,47,47,47,47,47,15,45,15,1B,15,5,45,15,47,47,47,47,47,47,47,17,47,47,47,47,47,47,47,17,17,47,47,47,47,47,47,47
20460DATA17,47,47,47,47,47,47,47,13,43,43,43,43,43,43,13,13,43,43,43,43,43,43,13,13,43,43,43,43,43,43,13,13,43,43,43,43,43,43,13,*
30000'mp
30250DATA3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,23,28,25,33,34,33,0,0,0,0,0,0,0,0,0,0,0,0,0,33,23,2F,32,25,0,0,0,0,0,0,0,0,23,21,32,24,33,0,0,0,0,0,0,0,0,0,0,2C,0,0,0,34,29,2D,25,0,0,0,0,0,0,0,0,0,*
40000DATA1,4,7,15,6,6,28,5,2,5,10,7,18,10,6,0,13,0,12,14,9,1,15,0,27,15,3,2,16,0,3,17,3,20,19,3,18,20,1,24,20,1,28,30,29,64,0,65,27,31,26,3,1,18,3,8,7,23,7,12,18,29,18,71,72,69,70,26,1,13,4,28,11,15,15,25,3,4,27,13,4,9,12,2,6,19,2
41000DATA0,3,3,6,6,6,24,6,6,4,10,6,16,10,4,8,14,5,16,14,9,0,15,0,1,16,0,2,17,0,3,18,0,4,19,0,5,20,0,29,17,0,28,30,29,64,0,65,27,31,26,1,0,9,3,26,3,20,11,12,18,23,18,71,72,69,70,1,6,18,4,27,9,18,16,17,6,4,26,11,4,10,12,2,6,16,2
42000DATA0,3,3,13,3,4,25,3,2,3,5,6,22,6,8,5,10,4,16,10,4,0,13,2,10,14,2,25,13,2,21,16,0,0,19,3,12,18,2,28,17,2,28,30,29,64,0,65,27,31,26,25,0,18,7,0,10,25,10,0,16,21,18,71,72,69,70,7,0,4,6,18,12,6,16,3,8,4,17,14,4,15,5,2,26,19,2
43000DATA0,3,2,28,3,2,11,5,2,17,5,2,2,7,2,26,7,2,6,10,5,19,10,5,8,14,5,17,14,5,0,17,3,27,17,3,9,20,1,22,20,1,28,30,29,64,0,65,27,31,26,0,0,29,0,11,2,18,2,0,18,29,18,71,72,69,70,15,7,15,16,2,12,28,12,14,9,4,14,18,4,1,14,4,27,14,4
