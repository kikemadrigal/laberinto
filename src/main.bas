10 rem ******************************
20 rem Program 
30 rem autor:   
40 rem ******************************
1 ' Inicilizamos el juego'
50 cls:defint a-z: open"grp:"as#1
1 ' Cuando se pulse el disparo ir a la subrutina de la línea 1530'
60 ON STRIG GOSUB 1530
1 ' Cuando haya colisión de sprites ir a la subrutina de la linea 1750'
70 ON SPRITE GOSUB 1760



1 ' Cargamos el mapa en el array'
80 gosub 8000
1 ' cargamos mapa en array'
90 gosub 8210
1 ' mostramos el mapa'
100 gosub 8110
1 ' inicilizamos el personaje'
120 gosub 5000



1 ' <<<<<< Main loop >>>>>'
    1 ' Actualizamos el input system'
    400 gosub 1260
    1 ' Comprobamos colisiones
    420 gosub 1760
    1 ' Actualizamos el player'
    430 gosub 1400
500 goto 400 


1 ' <<<<<< Final del Main loop >>>>>'



1260 '' <<<< INPUT SYSTEM >>>>
    1270 ST=STICK(0) OR STICK(1) OR STICK(2)
    1280 TG=STRIG(0) OR STRIG(1) OR STRIG(2)
    1290 I$=INKEY$
    1 ' Conservamos la posición previa para las colisiones'
    1300 xp=x: yp=y
    1310 IF ST=7 THEN x=x-8:pp=1
    1320 IF ST=3 THEN x=x+8:pp=2
    1330 IF ST=1 THEN y=y-8:pp=0
    1340 IF ST=5 THEN y=y+8:pp=3
    1350 if x<=0 then x=x
    1360 if y<=0 then y=y
    1370 if y+ph>192 then y=y
    1380 if x+pw>252 then x=x
1390 RETURN


1400 '' <<< update render system >>>>
    1420 PUT SPRITE 0,(x,y),6,pp
1430 return

1 ' Subrutina disparo'
1530 ' nada
1540 return

1 ' Nformación'
1 '1600 locate 0,0: print "x:"x", y:"y", cp:"cp", fp:"fp
1600 locate 0,0: print "cp:"cp", fp:"fp",ar:"m(fp,cp,ms)"                  "
1610 return

1' '' <<< update collision system >>>>
    1760 cp=x/8:fp=y/8
    1770 if cp <0 then cp=0
    1780 if fp <0 then fp=0
    1 ' Si hay una colision le dejamos la posicion que guardamos antes de cambiarla por pulsar una tecla'
    1810 if m(fp,cp,ms)>0 then x=xp: y=yp:beep: return
    1820 gosub 1600
1840 return




1 '---------------------------------------------------------'
1 '------------------------PLAYER---------------------------'
1 '---------------------------------------------------------'

1 ' Inicializando el personaje'
    1 ' xp=pisicon x previa'
    1 ' yp= posicion y previa'
    1 ' columna player identifica que columna está en el array el player para las colisiones'
    1 ' fp= fila player identifica en que columna está el player para comprobar colisioens'
    5000 x=0:y=192/2:xp=0:yp=0:pw=8:ph=8:cp=0:fp=0
    5010 gosub 1400
5020 return







1 '---------------------------------------------------------'
1 '------------------------MAPA---------------------------'
1 '---------------------------------------------------------'




1 ' inicializar_mapa
    1 '## ms=mapa seleccioando, lo hiremos cambiando    
    1 ' mm= maximo de mapas, como hemos creado 2 levels ponemos mm=mapa maximo 2
    1 'mc= mapa cambia, lo utilizaremos para cambiar los copys y así cambiar la pantalla
    8000 ms=0:mm=1:mc=0:tn=-1
    1 ' 22 serán la filas y 32 las columnas menos uno, porque así son los arrays'
    8010 dim m(21,31,mm-1)
8020 return

1 ' Rutina imprimir mapa
    8030 for f=0 to 21
        8040 for c=0 to 31
            8050 locate c, f:print chr$(224)
        8060 next c
    8070 next f
8080 return

1 'pintar o leer_valores_array
1 ' la pantalla en screen 1 son:
1 '      256px de ancho qu e/8=32 tiles de 8px 
1 '      192px de alto que /8= 24 tiles de 8px
    1 '8100 for i=0 to mm-1
        8110 for f=0 to 21
        1 ' ahora leemos las columnas c
            8120 for c=0 to 31
                8130 tn= m(f,c,ms)
                1' 8140 print tn
                8140 if tn> 0 then locate c, f:print chr$(224)
            8150 next c
            1 '8160 print #1,""
        8170 next f
        1 '8180 print #1,"mapa: "ms
    1' 8190 next i
8200 return


1 'guardar_mapa_en_array
    1 ' 1 leemos los levels
    1 '8210 for i=0 to mm-1
        1 ' ahora leemos las filas o la posición x
        8210 for f=0 to 21
        1 ' ahora leemos las columnas c o la posicion y
            8220 for c=0 to 31
                8230 read a$ 
                8240 m(f,c,i)=VAL(a$)
            8250 next c
        8260 next f
    1 '8210 next i
8270 return


10000 data -1,1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,-1,-1
10010 data -1,1,-1,-1,-1,1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1
10020 data -1,1,-1,-1,-1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1
10030 data -1,1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,-1
10040 data -1,1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1
10050 data -1,1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,1,1,1,-1,-1,-1,1,-1
10060 data -1,1,-1,-1,-1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1,-1,1,1,-1,-1,1,-1
10070 data -1,1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,1,-1,-1,1,-1
10080 data 1,1,1,-1,-1,-1,-1,-1,1,-1,-1,-1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,1,-1
10090 data -1,-1,1,-1,-1,-1,-1,-1,1,-1,-1,-1,1,-1,-1,-1,-1,1,1,1,1,1,-1,-1,-1,-1,-1,1,-1,-1,1,-1
10100 data -1,-1,1,1,1,-1,-1,-1,1,-1,-1,-1,1,-1,-1,-1,1,1,-1,-1,-1,1,1,1,1,1,-1,1,-1,-1,1,-1
10110 data -1,-1,-1,-1,1,-1,-1,-1,1,1,-1,-1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,1,-1,-1,1,-1
10120 data -1,-1,-1,1,1,1,-1,-1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,1,-1,-1,1,-1
10130 data 1,-1,-1,-1,-1,1,-1,-1,-1,-1,1,1,-1,-1,-1,-1,-1,1,1,1,1,-1,-1,-1,-1,1,-1,1,-1,-1,1,-1
10140 data 1,1,-1,-1,-1,1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,-1,-1,1,1,1,1,1,1,-1,1,-1,-1,1,-1
10150 data -1,1,1,-1,-1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,1,-1
10160 data -1,-1,1,1,-1,-1,-1,-1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,1,-1
10170 data -1,-1,-1,1,-1,-1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1,1,-1
10180 data -1,-1,-1,-1,1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,1,-1
10190 data -1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,-1
10200 data -1,-1,-1,-1,-1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,-1,-1
10210 data -1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1




 