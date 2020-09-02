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
1 ' Mostramos información juego'
130 gosub 1600


1 ' <<<<<< Main loop >>>>>'
    1 ' Actualizamos el input system'
    400 gosub 1260
    1 ' Comprobamos el player
    420 gosub  1400
    1 ' Actualizamos colisiones'
    430 gosub 1760
500 goto 400 


1 ' <<<<<< Final del Main loop >>>>>'



1260 '' <<<< INPUT SYSTEM >>>>
    1270 ST=STICK(0) OR STICK(1) OR STICK(2)
    1280 TG=STRIG(0) OR STRIG(1) OR STRIG(2)
    1290 I$=INKEY$
    1 ' Conservamos la posición previa para las colisiones'
    1300 cp=x/8: fp=y/8
    1 ' actualizamos la información del cartel despues de presionar las teclas '
    1310 IF ST=7 THEN x=x-pv:pp=1:pc=x/8:pf=y/8:gosub 1600
    1320 IF ST=3 THEN x=x+pv:pp=2:pc=x/8:pf=y/8:gosub 1600
    1330 IF ST=1 THEN y=y-pv:pp=0:pc=x/8:pf=y/8:gosub 1600
    1340 IF ST=5 THEN y=y+pv:pp=3:pc=x/8:pf=y/8:gosub 1600
    1350 if x<=0 then x=xp
    1360 if y<=0 then y=yp
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
1 'ponemos los valores que den -1 a 0 para que no de el array un error
    1600 pc=pc-2:cp=cp-2:pf=pf-2:fp=fp-2
    1610 gosub 1900
    1620 locate 0,20: print "fp:"fp+1", cp:"cp+1",ar:"m(fp,cp,ms)"                  "
    1630 locate 0,21: print "pf:"pf+1", pc:"pc+1",ar:"m(pf,pc,ms)"                  "
1640 return

1' '' <<< update collision system >>>>
    1760 'nada'
    1 ' Si hay una colision le dejamos la posicion que guardamos antes de cambiarla por pulsar una tecla'
    1810 if m(pf,pc,ms)>0 then x=(cp)*8: y=(fp)*8:beep: return
1840 return

1 ' rutina poner valores a 0 por si acaso'
    1900 if pc <0 then pc=0
    1910 if pf <0 then pf=0
    1920 if cp <0 then cp=0
    1930 if fp <0 then fp=0
1940 return




1 '---------------------------------------------------------'
1 '------------------------PLAYER---------------------------'
1 '---------------------------------------------------------'

1 ' Inicializando el personaje'
    1 ' xp=pisicon x previa'
    1 ' yp= posicion y previa'
    1 ' pc=columna player identifica que columna está en el array el player para las colisiones'
    1 ' pf= fila player identifica en que columna está el player para comprobar colisioens'
    5000 x=0:y=0:xp=0:yp=0:pw=8:ph=8:pc=0:pf=0:pv=8
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


10000 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
10010 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
10020 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,0,0
10030 data 0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,0,2,2,0,0
10040 data 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10050 data 0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10060 data 0,0,0,0,0,2,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,2,0,0
10070 data 0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10080 data 0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10090 data 0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,2,2,2,2,2,2,2,0,0,0,0,0,0,0,2,0,0
10100 data 0,0,0,0,0,2,0,0,0,2,0,0,0,2,2,0,0,0,0,0,0,2,2,2,2,2,0,0,0,2,2,0
10110 data 0,0,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,0
10120 data 0,0,0,0,0,2,0,0,0,2,0,0,0,2,2,2,2,2,2,0,0,0,0,0,0,2,0,0,0,0,2,0
10130 data 0,0,0,0,0,2,2,0,0,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,0
10140 data 0,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,0
10150 data 0,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0,0,2,2,0
10160 data 0,0,0,0,0,0,2,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,2,0,0
10170 data 0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10180 data 0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0
10190 data 0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0
10200 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
10210 data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


 