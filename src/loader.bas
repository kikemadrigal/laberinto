




80 screen 1,0,0:key off
1 ' inicializamos los sprites'
90 gosub 20870
1 ' Inicializamos los gráficos'
100 gosub 30000
1 ' Cragamos el main'
110 load "main.bas",r





1 ' Rutina cargar sprites con datas basic'
    20870 RESTORE
    1 ' vamos a meter 5 definiciones de sprites nuevos que serán 4 para el personaje y uno para la bola'
    20880 FOR I=0 TO 3:SP$=""
        20890 FOR J=1 TO 8:READ A$
            20900 SP$=SP$+CHR$(VAL("&H"+A$))
        20901 NEXT J
        20910 SPRITE$(I)=SP$
    20911 NEXT I
20920 return 
20930 DATA 18,18,66,5A,5A,24,24,66
20940 DATA 18,18,24,3C,3C,18,18,3C
20950 DATA 18,18,10,18,1C,18,18,1C
20960 DATA 18,18,08,18,38,18,18,38





1' Rutina cargar gráficos
    1' Definicición de tiles
    1 ' En el caracter 224*8=1792
    30000 FOR I=1792 TO 1799
       30010 READ A$
       30020 VPOKE I,VAL("&H"+A$)
    30030 NEXT I

    1 'En el 225'
    30040 FOR I=1800 TO 1807
       30050 READ A$
       30060 VPOKE I,VAL("&H"+A$)
    30070 NEXT I


    1' DFefinición de colores, en la dirección 8192 empieza la tabla de colores (base(6))
    1 ' 8192=transparente,8193=negro, 8194=verde, 8195=azul oscuro, 8196=lila, 8197=rojo osuro,8198= azul claro'
    1 ' 8199=rojo claro, 819a=naranja, 819b=amarillo, 819c=amarillo claro, 819d=verde, 8200=viloleta, 8201=gris, 8020=blanco
    1 ' Le dimos el color de nuestros tiles
    30210 VPOKE 8220,&Hc0

30270 return


1 'Definicion del caracter 224, ladrillo
30230 DATA E3,E3,E3,3E,3E,3E,F9,F9
1 'Definicion del caracter 225, picho'
30240 DATA 18,3C,66,42,C3,C3,C3,FF
