10 rem ******************************
20 rem Program 
30 rem autor:   
40 rem ******************************
1 'Inicilizamos el juego'
50 defint a-z
1 'Cuando se pulse el disparo ir a la subrutina de la línea 1530'
60 'ON STRIG GOSUB 1530
1 'Cuando haya colisión de sprites ir a la subrutina de la linea 1750'
70 'sprite on:ON SPRITE GOSUB 1900


75 print "Inicializando mapas"
1 ' Inicializamos el mapa'
80 gosub 8000
1 'Cargamos todos los mapas en array'
90 gosub 8100
95 print "Dibujando mapa"
1 ' mostramos el mapa'
100 gosub 8500
1 ' inicilizamos el personaje'
120 gosub 5000
1 ' inicilizamos los eneminos con el manager'
130 gosub 6000
1 ' Creamos el 1 enemigo, la ev y la el es para que se mueva hacia arriba o hacia abajo'
140 gosub 6100:ex(1)=8*12:ey(1)=6*20:ev(1)=8
150 gosub 6100:ex(2)=8*18:ey(2)=8*6:ev(2)=8
160 gosub 6100:ex(3)=8*14:ey(3)=8*8:ev(3)=8
170 gosub 6100:ex(4)=8*30:ey(4)=8*10:el(4)=8

1 ' <<<<<< Main loop >>>>>'
    1 ' Actualizamos el sistema de input'
    400 gosub 1260
    1 ' Esto es para mostrar datos para depurar'
    410 'gosub 4000
    1 ' Actualizamos el sistema de colisiones'
    430 gosub 1760
    1 ' Actualizamos sistema del render
    440 gosub 1400
500 goto 400 
1 ' <<<<<< Final del Main loop >>>>>'



1260 '' <<<< INPUT SYSTEM >>>>
    1265 '_turbo on(x,y,xp,yp,pw,ph,pv,pp)
    1270 ST=STICK(0) OR STICK(1) OR STICK(2)
    1280 'TG=STRIG(0) OR STRIG(1) OR STRIG(2)
    1290 'I$=INKEY$
    1 ' xp= posicion x previa player, yp=posición y previaplayer'
    1 ' Conservamos la posición previa para las colisiones'
    1300 xp=x:yp=y
    1 ' actualizamos la información del cartel despues de presionar las teclas '
    1 ' pv=player velocidad, pp=plano player, pc= layer columna y pf=player fila'
    1320 IF ST=7 THEN x=x-pv:pp=1
    1330 IF ST=3 THEN x=x+pv:pp=2
    1340 IF ST=1 THEN y=y-pv:pp=0
    1350 IF ST=5 THEN y=y+pv:pp=3
    1 ' Colisones con los extremos de la pantalla'
    1370 if x<=0 then x=xp
    1380 if y<=0 then y=yp
    1385 if y+ph>176 then y=yp
    1390 if x+pw>252 then x=xp
    1394 '_turbo off
1395 RETURN


1400 '' <<< RENDER SYSTEM >>>>
    1 ' Pintamos de nuevo el player con la posición, el color y el plano(dibujitos de izquierda, derecha..)'
    1420 PUT SPRITE 0,(x,y),1,pp
    1 ' dibujamos los enemigos'
    1430 'for i=0 to en=en-1
        1440 PUT SPRITE 5,(ex(1),ey(1)),10,5
        1450 PUT SPRITE 6,(ex(2),ey(2)),10,5
        1460 PUT SPRITE 7,(ex(3),ey(3)),10,5
        1470 PUT SPRITE 8,(ex(4),ey(4)),10,5
    1480 'next i
    1 'Si el mapa cambia volvemos a pintar el mapa 8100 y ponemos al player en su posición inicial'
    1490 if mc then gosub 8500:px=8:py=16
1495 return




1' '' <<< COLLISION SYSTEM >>>>
    1 'Colisiones del player con el mapa'
    1 ' Para detectar la colisión vemos el valor que hay en la tabla de nombres de la VRAM
    1 ' En la posición x e y de nuestro player con la formula: '
    1 ' Si hay una colision le dejamos la posicion que guardamos antes de cambiarla por pulsar una tecla'
    1760 hl=base(5)+(y/8)*32+(x/8):a=vpeek(hl)
    1 ' Si el valor es igual a 244 (nuestro ladrillo) ponemos los valores que tenía antes de pulsar el cursor'
    1770 if a=224 then x=xp: y=yp
    1 ' Si el valor es un 204 nuestro punto de fuga lo mandamos a otro sitio '
    1780 if a=204 then x=8*16: y=8*18:beep
    1 ' Si el valor el 215 (el tiled de la meta) cambiamos de mapa'
    1790 if a=215 then mc=1:ms=ms+1
    1 'Colisiones del player con sprites de los enemigos (mirar línea 70 y 1900)'
    1800 if pc=1 then pc=0:sprite on

    1 'Colisiones de ememigos con el mapa'
    1810 for i=0 to en-1
        1820 hl=base(5)+(ey(i)/8)*32+(ex(i)/8):a=vpeek(hl)
        1 'ev es la vlocidad eje x y el es la velocidad eje y'
        1830 if a=224 then ev(i)=-ev(i):el(i)=-el(i)
        1840 ex(i)=ex(i)+ev(i):ey(i)=ey(i)+el(i)
        1850 'ep(i)=ex(i):ei(i)=ey(i)
    1860 next i
1870 return


1 'Cuando 2 sprites colisionan...'
1 'Si no tiene vidas salimos del juego'
    1900 'if pe=0 then gosub 5000
    1 'La magia del basic nos obliga a desactivar las colisiones entre sprites'
    1 'Le quitamos una vida o energía
    1 'gosub 3300 actualizamos la informacion del juego'
    1 'Por ultimo volvemos a poner nuestro personaje en la posición del mapa inicial'
    1 'Actualizamos la variable player colision que nos ayuda a activar la colisiones (linea 1800)'
    1910 sprite off:pe=pe-1:gosub 3000:beep:gosub 5100:pc=1
1990 return

1 'informacion del juego que aparece en l aparte superior'
    3000 locate 0,0: print "Level "ms", Vidas:"pe" sp: "fre(0)
    3010 'locate 0,0: print "Array direccion: "hex$(VARPTR(m(0,0,0)))
3020 return

1 ' Debug'
1 'ponemos los valores que den -1 a 0 para que no de el array un error
    4000 'pc=x/8:pf=y/8
    4010 'if pc <0 then pc=0:if pf <0 then pf=0:if cp <0 then cp=0:if fp <0 then fp=0
    4020 'hl=base(5)+(y/8)*32+(x/8):a=vpeek(hl)
    4030  locate 0,21: print "en: "en", ex "ex(1)", ey: "ey(1)", ev"ev(1)
    4040 'locate 0,20: print "fp:"fp", cp:"cp",ar:"m(fp,cp,ms)"                  "
    4050 'locate 0,21: print "pf:"pf", pc:"pc",ar:"m(pf,pc,ms)"                  "
4060 return



1 '---------------------------------------------------------'
1 '------------------------PLAYER---------------------------'
1 '---------------------------------------------------------'

1 ' Inicializando el personaje'
    1 ' x=pisicon x previa, utilizada en el sistema de input'
    1 ' y= posicion y previa, utilizada en el sistema de input'
    1 ' pe=player energy o vida
    1 'Player colision, se utiliza para habilitar el sprite on cuando hay una colision'
    5000 x=8:y=16:xp=0:yp=0:pw=8:ph=8:pv=8:pe=10:pc=0
5020 return

1 'Punto inicio player'
    5100 if ms=0 then x=8:y=16
    5110 if ms=1 then x=21:y=16
5190 return

1 '---------------------------------------------------------'
1 '------------------------ENEMIES MANAGAER------------------'
1 '---------------------------------------------------------'

1 ' Definiendo la extructura de los enemigos'
1 ' em=numero maximo de enemigos'
1 ' et=turno de enemigo'
1 ' en=numero de enemigo'
1 ' Componente de posicion'
    1 ' ex=coordenada x, ey=coordenada y', ep=coordenada previa x, ei=coordenada previa y
1 ' Componente de fisica'
    1 ' ev=velocidad enemigo eje x, el=velocidad eje y'
1 ' Componente de render'
    1 ' ew=ancho enemigo, eh= alto enemigo, es=enemigo sprite'
1 ' Componente RPG'
    1 ' ea=enemigo ataque, ed=enemgo defnsa,ee=enemigo energia, ef=enemigo fuerza '

1 ' Init'
1 'con en=0 le decimos que queremos trabajar con el enemigo 0
1 'Pero vamos a rellenar la entidad 0 para que despues podamos copiar sus valores en la 1'
    6000 en=1
    6010 'Componente position
    6020 ex(0)=0:ey(0)=0:ep(0)=0:ei(0)=0
    1 'la velocidadas ponemos cuando creamos los enemigos'
    6030 ev(0)=0:el(0)=0
    6040 ew(0)=8:eh(0)=8:es(0)=5
    6050 ea(0)=30:ed(0)=15:ee(0)=100:ef(0)=0
6060 return

1 ' Crear enemigo'
    1 ' Como el espacio en la memoria lo creamos en el loader, ahora rellenamos, 
    1 ' el dibujado lo hacemos en el render '
    1 ' Aqui le asignamos el sprite que será el definido en el lodaer '
    1 ' En lugar de ponerles valores le copiamos los valores de la entidad creada en el init'
    1 'la siguiente vez que llamemos a crear enemigo se creará en la siguiente posición del array'
    6100 'en=en+1
    6110 ex(en)=ex(0):ey(en)=ey(0):ep(en)=ep(0):ei(0)=ei(0)
    6120 ev(en)=ev(0):el(en)=el(0)
    6130 ew(en)=ew(0):eh(en)=eh(0):es(en)=es(0)
    6140 ea(en)=ea(0):ed(en)=ed(0):ee(en)=ee(0):ef(en)=ef(0)
    6150 en=en+1
6160 return





1 '---------------------------------------------------------'
1 '------------------------MAPA---------------------------'
1 '---------------------------------------------------------'


1 ' inicializar_mapa
    1 '## ms=mapa seleccioando, lo hiremos cambiando    
    1 'mm= maximo de mapas, como hemos creado 2 levels ponemos mm=mapa maximo 2
    1 'mc= mapa cambia, lo utilizaremos para cambiar los copys y así cambiar la pantalla
    8000 ms=0:mm=5:mc=0:tn=0
    1 '22 serán la filas y 32 las columnas menos uno, porque así son los arrays'
    8010 dim m(23,31,mm-1)
8020 return

1 'Guardar_mapa_en_array
    1 '1 leemos los levels
    1 'Cada mapa ocupa 862 bytes'
    8100 for i=0 to mm-1
        1 'ahora leemos las filas o la posición x
        8110 for f=0 to 21: read a$
        1 'ahora leemos las columnas c o la posicion y
            8120 for c=0 to 31
                1 'Val convierte el string en un entero'
                8130 m(f,c,i)=val(mid$(a$,c+1,1))
            8140 next c
        8150 next f
    8160 next i
8170 return

1 'Render map, pintar mapa
    1 'la pantalla en screen 1 con width son:
    1 '256px de ancho qu e/8=32 tiles de 8px 
    1 '176px de alto que /8= 22 tiles de 8px
    8500 cls:mc=0
    8510 if ms>=mm then ms=0
    8520 _TURBO ON (tn,m(),ms,mm)
    8530 for i=0 to mm-1
        8540 for f=0 to 21
        1 ' ahora leemos las columnas c
            8550 for c=0 to 31
                8560 tn= m(f,c,ms)
                1 'Si lo que hay en el mapa es un ladrillo (un 1) pintamos el tiled 244'
                8570 if tn=1 then locate c, f:print chr$(224)
                1 'Si el tile es un 2 es un punto de fuga'
                8580 if tn=2 then locate c, f:print chr$(204)
                1 'Es un lugar para pasar al siguiente nivel,el 215 es un tiled prediseñado'
                8590 if tn=3 then locate c, f:print chr$(215)
            8600 next c
        8610 next f
    8620 next i
    8630 _TURBO off
    1 'Mostramos la informacion del juego'
    8640 gosub 3000
8650 return







1 'Level 1'
10010 data 00000000000000000000000000000331
10020 data 00001111111111111111111111111331
10030 data 10001000000000000000000000000001
10040 data 10011110011111111111111111111111
10050 data 10010010000000000000000000000001
10060 data 10010010011111111111111111000001
10070 data 10010010010000000000000001001001
10080 data 10010010011110000000000001001001
10090 data 10010010000010011111111001001001
10100 data 10010010000010000000221001001001
10110 data 10010011110010000000221001001001
10120 data 10000000010011111111111001001001
10130 data 10000000010000000000001001001001
10140 data 10011110011111111111111001001001
10150 data 10010010010000000000000001001001
10160 data 10010010010000000000000001001001
10170 data 11110010011100111111111111001001
10180 data 10000000010000122001000000001001
10190 data 10000000010000122001000000001001
10200 data 10011111110011111001111111111001
10210 data 10000000000010000000000000000001
10220 data 11111111111111111111111111111111

1 'Level 2'
10310 data 00000000000000000100000000000000
10320 data 00110000000100000100000000000000
10330 data 00011000000111111101111000000000
10340 data 00001110001110000000111000000100
10350 data 00000011011000000000001100011000
10360 data 00000000111111000000000011100000
10370 data 00000001100001111111111001100000
10380 data 00000000000000001000000000100000
10390 data 00011011000022001002200000011110
10400 data 00111110000000001000000000011110
10410 data 00111100111111001001111111101110
10420 data 00111000000010001000010000001110
10430 data 00111000000010011100010000001110
10440 data 00010000000010000000000000001100
10450 data 00010000000110000000010000001000
10460 data 00011000000011000000110000001000
10470 data 00001000000001111111100000011000
10480 data 00001100000000000000000000010000
10490 data 00000111000000011110000000110000
10500 data 00000001111000000010000011100000
10510 data 00000000001111111111111110003333
10520 data 00000000000000000000000000003333

1 'level 3'
10610 data 11000000000000111111111111111110
10620 data 01000000000000001000001000000010
10630 data 01000100001000101000001001000010
10640 data 01000100111000101000001001000010
10650 data 01000100000000100000000001000010
10660 data 01011111111111100000000001000010
10670 data 00000000010000100111111111100010
10680 data 11110111110000100100001000000010
10690 data 00000000001000100110000000100110
10700 data 00011111111101111110000000100100
10710 data 00000000101101111111001000100111
10720 data 11111110100001111111001111100000
10730 data 00001100000001001111100111000000
10740 data 00011111111101001111100110000000
10750 data 00010111000001001111100111000000
10760 data 00000100000010000000000111001000
10770 data 00111101000111111101111111111111
10780 data 11000001111100000100000000000000
10790 data 00011111000000000100000000000000
10800 data 00110000000000000100111111100000
10810 data 33111111111111111110100000111000
10820 data 33000000000111111110000000000000



1 'level 4'
10910 data 33000000000000000000000000000000
10920 data 11111111111111111111111111111000
10930 data 00010001000010010111111100001000
10940 data 00010001000010010000001000001000
10950 data 00010011000010010000001000001000
10960 data 01110000000000010000001000001000
10970 data 01000000000000010000001000001000
10980 data 01010000100010001000001111111110
10990 data 01010011100010001011100110001000
11200 data 01010110000010001110000110001000
11210 data 01011100000010001110000111111000
11220 data 01010110000010001011000110001000
11230 data 01010011000010001001100110000000
11240 data 01010001100010001000110110001110
11250 data 01010000100010001000010111110000
11260 data 00000000000000000000000000000000
11270 data 11111111111111111111111111111100
11280 data 00000111110000000000000000000000
11290 data 00011111111111111111111111111111
11300 data 00000010000000000000001000000000
11310 data 00000010000100000000001000000000
11320 data 00000000000100000000000000000000

1 'level 5'
11410 data 00000000000000000000000000000000
11420 data 01001111111111111111111111111100
11430 data 01001000000000000000000000000100
11440 data 01001000000000000000000000000100
11450 data 01001000111111111111111111100100
11460 data 01001000100000000000000000100100
11470 data 01001000100000000000000000100100
11480 data 01001000100001111111111000100100
11490 data 01001000100001330000001000100100
11500 data 01001000100001330000001000100100
11510 data 01001000100001111100001000100100
11520 data 01001000100000000000001000100100
11530 data 01001000100000000000001000100100
11540 data 01001000111111111111111000100100
11550 data 01001000000000000000000000100100
11560 data 01001000000000000000000000100100
11570 data 01001000000000000000000000100100
11580 data 01001000000000000000000000100100
11590 data 01001111111111111111111111100100
11600 data 01000000000000000000000000000100
11610 data 01111111111111111111111111111100
11620 data 00000000000000000000000000000000