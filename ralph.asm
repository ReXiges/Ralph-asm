 ; Nombre del estudiante: Sergie Salas Rojas
 ; Carnet: 2016138296
 ; Profesor: Kirstein Gätjens Soto
 ; Curso: Arquitectura de computadores
 ; Escuela de computación
 ; Fecha de entrega: 05/09/16
 ; Instituto tecnológico de Costa Rica
 ; Tarea: Ralph el compresor
 ; Tarea que se encarga de comprimir y descomprimir archivos
 
; Manual de Usuario
; este es un programa que se encarga de comprimir y descomprimir archivos
; para este programa se utilizo la maquina virtual DOS BOX, se recomienda tenerla para facilitar el empleo del programa
; para iniciar el programa se debe pasar el archivo a la carpeta en la que el DOS BOX esta montada
; se deben tener los TASM.EXE, TD.EXE y TLINK.EXE dentro de la carpeta del DOS BOX
; luego se debe digitar en la linea de comandos la instruccion: "tasm 16138296"
; esto genera el codigo objeto, luego se pone la instruccion: "tlink 16138296"
; por ultimo se debe digitar en la linea de comandos la intruccion: "16138296 Comando rutaDelArchivo"
; la ruta puede ser solo el nombre si esta en la mis  carpeta que el exe
; el comando puede ser -a para desplegar la ayuda, -c para comprimir y -d para descomprimir
; DEBE tener un comando o dejarse totalmete vacia la linea de comandos (esto desplegara la ayuda)
; NO se debe poner puntos en el nombre/ruta del archivo, amenos que se desee especificar una extension, solo para extensiones poner puntos 
; cuando se comprimen y descomprimen los archivos el archivo resultante estara en la misma carpeta en la que el original
; los formatos son .RLP para la salida de compresion y .TXT para la salida de descompresion
; Cuando se comprimen los archivos se imprimira una tabla con los asciis mas utilizados, si hay uno con un #, es es el numero ascii  de un caracter no imprimible
; Tambien se imprimira la tasa de compresion, si el archivo resultante es mas grande que el original se imprime un mensaje en lugar de eso


;Analisis de resultados:
;Obtener ruta del archivo de la linea de comandos: A
;Convertir a Ascii valores numericos: A
;Deteccion de extensiones:A
;Definir comando: A
;Validacion de errores con mensajes significativos: A
;Comprimir Archivos: A
;Crear tabla de mas utilizados: A
;Ordenar la tabla de mas utilizados: A
;Descomprimir Archivo: A
;Crear tasa de compresion con 2 puntos de presicion: A
;Desplegar ayuda: A
;Asignar Nuevas extensiones a arcchivos de salida: A

;Analisis adicional:
;Hacer multiples referencias a la pelicula Ralph el demoledor: S++


datos segment
   cajafuerte db ?
   msgayuda db "Bienvenido a la ayuda para Ralph el compresor y Felix el descompresor",10,13
   db "Para volver a llamar a esta ayuda digite -A en la linea de comandos",10,13
   db "Para llamar a Felix y descomprimir un archivo digite -D en la linea de comandos",10,13
   db "Para llamar a Ralph y comprimir un archivo digite -C en la linea de comandos",10,13
   db "Luego de digitar el comando, digite el nomnbre del archivo (con o sin ruta)",10,13
   db "Se usara RLP para descomprimir y txt para comprimir, si no se pone extension",10,13
   db "NO usar . en el nombre del archivo, solo para extension",10,13
   db "Al comprimir el archivo se mostraran los mas usados y la tasa de compresion",10,13
   db "Los resultados con un # son el ascii de los caracteres no imprimibles",10,13,'$'
   exitoRalph  db "He comprimido el archivo con exito-Ralph",'$'
   exitoFelix db "Su archivo ha sido descomprimido-Felix",'$'
   acercade1 db "Programa que comprime o descomprime por Sergie Salas",'$'
   acercade2 db "Clase de Arquitectura de computadores, grupo:01",'$'
   acercadeAdc db "Voy a comprimirlo!!!!-Ralph el compresor",'$'
   tablaAscii db "Tabla de repeticiones del archivo a comprimir (De mayor a menor)",10,13,'$'
   comando db 'A'
   errorMsgComando db "No puedo repararlo: comando invalido-Felix",'$';PD: Para el que lea esto, lo de no puedo repararlo es una referencia a la pelicula Ralph el demoledor, todos estos son los mensajes de error.
   errorMsgRuta db "No puedo repararlo: El archivo no existe en la ruta especificada-Felix",'$'
   errorVoid db "No puedo repararlo: No se ha digitado la ruta en la linea de comandos-Felix",'$'
   errorMsgLectura db "No puedo repararlo: Error de lectura-Felix",'$'
   errorMsgbytesLectura db "No puedo repararlo: Archivo demasiado grande-Felix",'$'
   bytesarchivoOri db "Bytes del archivo original: $" 
   bytesarchivNuv db "Bytes del archivo compreso: $"
   tasa db "Tasa de compresion: $"
   aumento db "Se aumento de tamano, No hay tasa de compresion$"
   porcentaje db "%$"
   rutarch db 128 dup (?)
   rutarchELregreso db 128 dup (?)
   hayExtension db 0
   variableParaImprimir db 8 dup (?)
   separador db " repeticiones: $"
	caracterActual db 0
	handle dw ?
	handleElregreso dw ?
	buffy db ?
	buffyExtendido db ?
	buffyAdicional db ?
	ascii dw 256 dup (0)
	repetidos1 dw 0
	repetidos2 dw 0
	repetidos3 dw 0
	repetidos4 dw 0
	repetidos5 dw 0
	repetidos6 dw 0
	repetidos7 dw 0
	repetidos8 dw 0
	repetidos9 dw 0
	repetidos10 dw 0
	repetidos11 dw 0
	repetidos12 dw 0
	repetidos13 dw 0
	repetidos14 dw 0
	repetidos15 dw 0
	iniciobuffytabla db "RLP"
	repetidosnum1 db ?
	repetidosnum2 db ?
	repetidosnum3 db ?
	repetidosnum4 db ?
	repetidosnum5 db ?
	repetidosnum6 db ?
	repetidosnum7 db ?
	repetidosnum8 db ?
	repetidosnum9 db ?
	repetidosnum10 db ?
	repetidosnum11 db ?
	repetidosnum12 db ?
	repetidosnum13 db ?
	repetidosnum14 db ?
	repetidosnum15 db ?
	bytesarchivo dw 0
	bytescompreso dw 20
   

datos ends; termina el segmento de datos

pila segment stack 'stack'

    dw 256 dup (?) ; se define la pila
    

pila ends

codigo segment; inicio del codigo

    assume  cs:codigo, ds:datos, ss:pila
	
	
	inicio:	
			
			mov ax, ds ; esta seccion mueve todos los datos que se necesitan y pone en cero los registros que se van a usar
			mov es, ax
			mov ax, datos
			mov ds, ax
			mov ax, pila
			mov ss, ax
			mov si, 82h ; se pone en el si el inicio de la linea de comandos
			mov cl, byte ptr es:[si] ; se pone en el cl el byte con el caracter actualmente en el puntero
			xor ch, ch
			call acercade
			xor ax,ax
			xor bx,bx
			xor dx,dx
			call IgnorarEspacios; se ignora la linea de comandos, ademas se revisa si esta vacia
			call definircomando; se define el comando
			call IgnorarEspacios; se vuelven a ignorar los espacios vacios
			call definirRuta; se  define la ruta del archivo
			jmp saltoinutil1; un salto inutil
			errorrutajmp:call errorruta; se llama al erro de la ruta
			saltoinutil1:
			mov ah,3dh; se abre el archivo con el que se trabajara
			mov al, 0
			lea dx, rutarch
			int 21h	
			jc errorrutajmp; se revisa si se pudo abrir
			mov handle, ax; se pone el handle donde pertenece
			cmp comando, 'C';se ve si se desea comprimir o descomprimir (la ayuda se valida en ignorar espacios)
			jne FelixEldescompresor
			
			call contarCaracteres; rutina para contar los caracteres ascii del archivo
			call ordenarMasUsados; se ordenan los caracteres en las tablas de mas usados
			call imprimirTablaMasUsados; rutina que imprime los caracteres de la tabla de mas usados
			call comprimirArchivo; rutina para comprimir el archivo en RLP
			call tasaCompresion; imprime la tasa de compresion del archivo
			call nuevalinea
			lea dx, exitoRalph; mensaje de exito
			mov ah,09h
			int 21h
			jmp terminarPrograma
			
			FelixEldescompresor:
			call descomprimirArchivo;se descomprime el archivo
			call nuevalinea
			lea dx, exitoFelix; mesaje de exito
			mov ah,09h
			int 21h


			terminarPrograma:
			mov ah, 3Eh; se cierran los archivos
			mov bx, handle
			int 21h
			mov ah, 3Eh
			mov bx, handleElregreso
			int 21h
			mov ax, 4C00h
			int 21h 
			

acercade Proc near; rutina para imprimir el acerca de
	call nuevalinea
	mov ah, 09h
	lea dx, acercade1
	int 21h
	call nuevalinea
	mov ah, 09h
	lea dx, acercade2
	int 21h
	call nuevalinea
	mov ah, 09h
	lea dx, acercadeAdc
	int 21h
	call nuevalinea
	call nuevalinea; llama a la rutina que crea una linea en blanco
	ret
	endp
	
nuevalinea PROC NEAR ; agrega lineas nuevas para espacios
	mov ah, 02h; crea lineas nuevas
	mov dl, 0Ah ; pone un enter
	int 21h
	mov dl, 0Dh;pone un retorno de carro
	int 21h
	ret; regresa a donde se llamo la rutina
	ENDP
	
IgnorarEspacios PROC NEAR; rutina que ignora espacios en blanco 
		Ignorar:
			mov al, byte ptr es:[si]
			cmp al, ' '
			je Ignorar2
			cmp al, 11
			je Ignorar2
			cmp al, 9
			je Ignorar2
			cmp al, 13
			je posibleError
			cmp al, 0
			je posibleError
			ret
		Ignorar2:;ciclo que ignora los espacios en blanco
			inc si
			jmp Ignorar
		posibleError:; entra si la linea termino, revisa si tiene que entrar en ayuda entonces
		cmp comando, 'A'
		jne noayudar
		call ayudar; llama ayuda si el comando es A (sirve tanto si no se puso nada como si solo se puso -a )
		noayudar: ;tira error
		call nuevalinea
		mov ah, 09h
		lea dx, errorVoid
		int 21h
		mov ax, 4C00h
		int 21h
		
	ENDP
	
definircomando PROC NEAR; rutina que define el comando del programa
			jmp defEmpezar
			ayuda:
			cmp byte ptr es:[si+1],' '; se valida que el comando solo sea un caracter (va despues de ver que es -a)
			je empAyudarComando
			cmp byte ptr es:[si+1],13; se valida que el comando solo sea un caracter (va despues de ver que es -a)
			je empAyudarComando
			cmp byte ptr es:[si+1],0; se valida que el comando solo sea un caracter (va despues de ver que es -a)
			je empAyudarComando
			jne  errorEncomando
			empAyudarComando:
			call ayudar
			defEmpezar:
			mov al, byte ptr es:[si]
			cmp al,'-'; se compara que se empieze con un comando
			jne errorComando
			inc si
			mov al, byte ptr es:[si]; se compara con los comandos disponibles y se ve si es uno valido
			cmp al, 'A'
			je ayuda
			cmp al, 'a'
			je ayuda
			cmp al, 'C'
			je comprimir
			cmp al, 'c'
			je comprimir
			cmp al, 'D'
			je descomprimir
			cmp al, 'd'
			je descomprimir
			errorEncomando:
			call errorComando; se descubbrio un comando invalido
			comprimir:
			cmp byte ptr es:[si+1],13; se valida que se haya puesto una ruta
			je errorNoRuta
			cmp byte ptr es:[si+1],0; se valida que se haya puesto una ruta
			je errorNoRuta
			cmp byte ptr es:[si+1],' '
			jne  errorEncomando
			mov comando, "C"; se pone que va a comprimir el archivo
			inc si
			jmp retornarComando
			descomprimir:
			cmp byte ptr es:[si+1],13; se valida que se haya puesto una ruta
			je errorNoRuta
			cmp byte ptr es:[si+1],0; se valida que se haya puesto una ruta
			je errorNoRuta
			cmp byte ptr es:[si+1],' '
			jne  errorEncomando
			mov comando, "D"; se pone que va a descomprimir el archivo
			inc si
			retornarComando: ret
			errorNoRuta:
			mov ah, 09h
		lea dx, errorVoid
		int 21h
		mov ax, 4C00h
		int 21h
			
	endp
	
ayudar Proc near; rutina que imprime la ayuda
			call nuevalinea
			mov ah, 09h
			lea dx, msgayuda
			int 21h
			mov ax, 4C00h
			int 21h 
	endp
	
errorComando PROC NEAR; rutina que imprime error de comando
			call nuevalinea
			mov ah, 09h
			lea dx, errorMsgComando
			int 21h
			mov ax, 4C00h
			int 21h 
	endp
errorRuta PROC NEAR; rutina que imprime error de ruta del archivo
			call nuevalinea
			mov ah, 09h
			lea dx, errorMsgRuta
			int 21h
			mov ax, 4C00h
			int 21h 
	endp

errorlectura PROC NEAR; rutina que imprime que hubo error en la lectura de un archivo
			call nuevalinea
			mov ah, 09h
			lea dx, errorMsgLectura
			int 21h
			mov ax, 4C00h
			int 21h 
	endp
	
tamarchORange PROC NEAR; rutina que imprime que un archivo es muy grande para comprimirse por el programa
			call nuevalinea
			mov ah, 09h
			lea dx, errorMsgbytesLectura
			int 21h
			mov ax, 4C00h
			int 21h 
	endp

definirRuta PROC NEAR; programa que define la ruta del archivo
	xor di, di	
	continuarRuta:
	mov al, byte ptr es:[si]
	cmp al, 13
	je retornoRuta
	mov byte ptr rutarch[di],al
	inc di
	inc si
	cmp al, '\'
	je extborrar
	cmp al, '/'
	je extborrar
	cmp al, '.'
	je extdetectada; se ve si existe extension
	jmp continuarRuta
	extborrar:
	mov hayExtension, 0; se usan 1 y 0 como valores booleanos
	jmp continuarRuta
	extdetectada:
	mov hayExtension, 1
	jmp continuarRuta
	retornoRuta:
	cmp hayExtension,1
	je regresoRuta
	cmp comando, 'C'; si no hay extension se pone la que se tiene por defecto
	jne archivoralph
	mov byte ptr rutarch[di],'.';txt si se esta comprimiendo
	inc di
	mov byte ptr rutarch[di],'t'
	inc di
	mov byte ptr rutarch[di],'x'
	inc di
	mov byte ptr rutarch[di],'t'
	inc di
	jmp regresoRuta
	archivoRalph:
	mov byte ptr rutarch[di],'.';RLP para descomprimir
	inc di
	mov byte ptr rutarch[di],'R'
	inc di
	mov byte ptr rutarch[di],'L'
	inc di
	mov byte ptr rutarch[di],'P'
	inc di
	regresoRuta: 
	mov byte ptr rutarch[di],0; se pone el cero al final
	ret
ENDP
	
contarCaracteres Proc near; rutina que cuenta la cantidad de caracterees
	jmp ignorarthis
	call errorlectura; se llama al mensaje de error de lectura
	ignorarthis:
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 0
	mov bx, handle
	int 21h; se abre el archivo
cicloCaracteres: 
	mov ah, 3Fh
	mov cx, 1
	mov bx, handle
	lea dx, buffy
	int 21h; se pone el caracter en buffy
	cmp ax, 0; se se termino el archivo
	je terminarContarCaracteres
	cmp bytesarchivo,65535; se ve si el archivo es demasiado grande
	je errorTamarch
	inc bytesarchivo; se incrementa el contador de los bytes del archivo
	xor ah,ah
	mov al, buffy
	xor dx,dx
	mov bx, 2; se multiplica el ascii por dos para usarlo de indice
	mul bx
	mov si, ax; se mueve el el ascii al si para usarlo de indice (ya implementado para usarse con words)
	inc ascii[si]; se incrementa la posicion del ascii que corresponde
	xor dx, dx
	xor cx, cx
	mov bx, handle
	mov ah, 42h
	mov al, 1
	int 21h; se incrementa el puntero
	jmp cicloCaracteres; se repite el ciclo hasta leer todo
	terminarContarCaracteres:
	ret
	errorTamarch:call tamarchORange; se imprime el error de tamano
ENDP

ordenarMasUsados proc near; rutina que imprime 
	xor di,di	
inicioOrdenamiento:
cmp caracterActual, 255; se compara el caracter actual con el maximo 255, si no es igual se continua
jne seguirOrdenando
jmp retornarOrdenamiento
seguirOrdenando:
	mov cx, 14;se pone al cx el maximo de repeticiones y se van decrementando dependiendo de cuales posiciones quedan intactas
	mov ax,ascii[di]
	cmp ax, repetidos1
	ja empBajar
	dec cx
	cmp ax, repetidos2
	ja empBajar
	dec cx
	cmp ax, repetidos3
	ja empBajar
	dec cx
	cmp ax, repetidos4
	ja empBajar
	dec cx
	cmp ax, repetidos5
	ja empBajar
	dec cx
	cmp ax, repetidos6
	ja empBajar
	dec cx
	cmp ax, repetidos7
	ja empBajar
	dec cx
	cmp ax, repetidos8
	ja empBajar
	dec cx
	cmp ax, repetidos9
	ja empBajar
	dec cx
	cmp ax, repetidos10
	ja empBajar
	dec cx
	cmp ax, repetidos11
	ja empBajar
	dec cx
	cmp ax, repetidos12
	ja empBajar
	dec cx
	cmp ax, repetidos13
	ja empBajar
	dec cx
	cmp ax, repetidos14
	ja empBajar
	cmp ax, repetidos15
	ja empBajar
	jmp noSirve; no entro a la tabla de resultados
	empbajar:
	mov dx, cx; mueve los caracteres de la tabal mas utilizados hacia a bajo desdes una posicion indicada por el cx
	lea si, repetidos15
	ciclomatico:; ciclo para la cantidad de repeticiones
	mov ax,word ptr ds:[si-2]
	mov word ptr ds:[si],ax
	dec si
	dec si
	cmp cx, 1
	je ciclomaticofin
	dec cx
	jmp ciclomatico
	ciclomaticofin:
	mov ax,ascii[di]
	mov word ptr ds:[si],ax; incerta el nuevo numero de repeticiones
	mov cx, dx
	lea si, repetidosnum15
	ciclomatico2:; ciclo para el ascii del caracter
	mov al,byte ptr ds:[si-1]
	mov byte ptr ds:[si],al
	dec si
	cmp cx, 1
	je ciclomaticofin2
	dec cx
	jmp ciclomatico2
	ciclomaticofin2:
	mov al,caracterActual
	mov byte ptr ds:[si],al; inserta el  nuevo caracter
	noSirve:; el caracter que se tiene actual mente es menor que cualquiera actualmente en la tabla
	inc di
	inc di
	inc caracterActual
	jmp inicioOrdenamiento
	retornarOrdenamiento:ret
endp

comprimirArchivo proc near; rutina que comprime el archivo
	xor si, si
	xor di, di
	nombreDestino:; se le pone nombre al nuevo archivo
	mov al, byte ptr rutarch[si]
	mov byte ptr rutarchELregreso[di],al
	inc di
	inc si
	cmp al, 0
	jne nombreDestino
	ciclorutarchN2:
	dec di
	mov al,byte ptr rutarchELregreso[di]
	cmp al, '.'
	jne ciclorutarchN2
	inc di
	mov byte ptr rutarchELregreso[di],'R'; se cambia la extension original por RLP
	inc di
	mov byte ptr rutarchELregreso[di],'L'
	inc di
	mov byte ptr rutarchELregreso[di],'P'
	inc di
	mov byte ptr rutarchELregreso[di],0
	mov ah, 3ch
	mov cx, 0
	lea dx, rutarchELregreso
	int 21h; se crea el archivo de salida
	mov handleElregreso, ax
	mov ah, 40h
	mov bx, handleElregreso
	mov cx, 20
	lea dx, iniciobuffytabla
	int 21h; se escriben en los primeros 20 byte, el TAG "RLP", la tabla de mas tilizados y el tamano original del archivo
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 0
	mov bx, handle
	int 21h;se pone el puntero
	comprimirmas:
	mov ah, 3Fh
	mov cx,1
	lea dx, buffyAdicional
	int 21h; se pone en el buffer el caracter actual
	cmp ax, 0
	je terminarcompresion; se ve si se termino el archivo
	mov bl, buffyAdicional
	call compararTabla; se ve si el caracter esta o no en la tabla
	cmp al, 1111b
	je noenTabla
	call enTabla; se llama si es de los mas utilizados
	jmp saltito
	noentabla:call entablano; se llama si no es de los mas utilizados
	saltito:
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h; se aumenta el puntero para leer el siguiente caracter
	jmp comprimirmas
	terminarcompresion:
	ret
	


endp

	
	
compararTabla proc near ; recibe el ascii en bl y retorna 1111 si no esta en la tabla su codigo correspondiente en al (inicio en cero)
	xor ax,ax; se pone en 0 ax y se incrementa al hasta encontrar un parecido en la tabla, si no lo hay se incrementa una vez mas y queda en 0000 1111
	cmp bl, repetidosnum1
	je retorno
	inc al
	cmp bl, repetidosnum2
	je retorno
	inc al
	cmp bl, repetidosnum3
	je retorno
	inc al
	cmp bl, repetidosnum4
	je retorno
	inc al
	cmp bl, repetidosnum5
	je retorno
	inc al
	cmp bl, repetidosnum6
	je retorno
	inc al
	cmp bl, repetidosnum7
	je retorno
	inc al
	cmp bl, repetidosnum8
	je retorno
	inc al
	cmp bl, repetidosnum9
	je retorno
	inc al
	cmp bl, repetidosnum10
	je retorno
	inc al
	cmp bl, repetidosnum11
	je retorno
	inc al
	cmp bl, repetidosnum12
	je retorno
	inc al
	cmp bl, repetidosnum13
	je retorno
	inc al
	cmp bl, repetidosnum14
	je retorno
	inc al
	cmp bl, repetidosnum15
	je retorno
	inc al
	retorno:ret
endp	

	
enTabla proc near; rutina que escribe en el compreso, su primera parte contiene un ascii que esta entre los mas usados
	mov cajafuerte,al; se mueve el codigo a una variable para no perderlo
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h; se aumenta el puntero
	xor dx, dx
	xor cx, cx
	mov bx, handle
	mov ah, 3Fh
	mov cx,1
	lea dx, buffyAdicional
	int 21h; se lee el siguiete byte
	mov bl, buffyAdicional
	call compararTabla
	mov ah,cajafuerte; se devuelve ,la variable
	shl ah,4;se ponen sus bits en la parte izq
	Or ah,al; se combinan ambos codigos
	cmp al,1111b; se ve si se necesita leer el siguiente byte o solo escribir ah
	je tablasintabla
	mov buffy, ah
	mov ah, 40h
	mov bx, handleElregreso
	mov cx, 1
	lea dx, buffy
	int 21h;se escribe solo ah, ya que ambos asciis estan en la tabla
	inc bytescompreso; se incrementan los bytes del compreso
	ret
	tablasintabla:; se lee el siguiente byte y se escribe tal y como esta ya que no esta en la tabla
	mov buffy, ah
	mov buffyExtendido,bl
	mov ah, 40h
	mov bx, handleElregreso
	mov cx, 2
	lea dx, buffy
	int 21h
	inc bytescompreso; se incrementa dos veces el tamano del compreso
	inc bytescompreso
	ret
endp 

	
enTablaNo proc near; rutina que escribe en el compreso, empueza con un caracter que no esta entre los mas usados
	mov ah,al
	xor al,al
	shl ah,4; se acomodan los bits para combinarlos
	shl bx,4
	or ax,bx
	mov buffy,ah
	mov buffyExtendido, al
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h; se incrementa el puntero
	xor dx, dx
	xor cx, cx
	mov bx, handle
	mov ah, 3Fh
	mov cx,1
	lea dx, buffyAdicional
	int 21h;se lee el caracter
	mov bl, buffyAdicional
	call compararTabla; se ve si el siguiente caracteer esta dentro o fuera de los mas usados
	cmp al, 1111b
	je sinTablasinTabla
	or buffyExtendido,al; si esta en los mas usados, se mezclan nadamas y se esciben
	mov ah, 40h
	mov bx, handleElregreso
	mov cx, 2
	lea dx, buffy
	int 21h
	inc bytescompreso
	inc bytescompreso
	ret
	sinTablasinTabla:; se le pone un 1111 al final y luego se escirbe el caracter nomalmente
	or buffyExtendido,al
	mov ah, 40h
	mov bx, handleElregreso
	mov cx, 3
	lea dx, buffy
	int 21h
	inc bytescompreso
	inc bytescompreso
	inc bytescompreso
	ret
endp
reglade3 proc near; rutina que realiza el calculo de porcentaje con dos puntos de precision
	xor dx,dx
	mov cx, 10000; se aumenta por 10 000 en vez de 100 para incluir los dos puntos de precision
	mul cx
	div bx;regla de 3
	xor si,si
	call convChar; se convierte a string
	 mov cx,3
	presicion2:; se pasa a la variable ademas de moverlo para luego insertar el .
	mov bl, byte ptr variableParaImprimir[si]
	inc si
	mov byte ptr variableParaImprimir[si],bl
	dec si
	dec si
	loop presicion2
	mov bl,'.'
	inc si
	mov byte ptr variableParaImprimir[si],bl; se inserta el . en la posicion que le corresponde
	ret
endp

ConvChar Proc near;el numero empieza en ax, esta rutina convierte el numero en ax en un strin, y lo mete a la variable para imprimir
	jmp ConvHexaProces
	vuelta:
	call charts
	mov byte ptr variableParaImprimir[si],bl
	inc si
	pop ax
	cmp ax,'+'
	jne vuelta
	mov byte ptr variableParaImprimir[si],'$'
	ret
	ConvHexaProces:
		mov bx,'+'
		push bx
		xor bx, bx
		xor cx, cx
		xor dx, dx
		mov bl, 10
		inicioHexadecer:
		xor dx, dx
		Idiv bx
		push dx
		cmp ax, bx
		jae inicioHexadecer
		jmp vuelta
	endp
	
charts proc near; rutina que dependiendo del numero que haya en ax, metera en bx su correpondiente ascii (del 0 a la F)
	cmp ax,0
	je hex0
	cmp ax,1
	je hex1
	cmp ax,2
	je hex2
	cmp ax,3
	je hex3
	cmp ax,4
	je hex4
	cmp ax,5
	je hex5
	cmp ax,6
	je hex6
	cmp ax,7
	je hex7
	cmp ax,8
	je hex8
	cmp ax,9
	je hex9
	cmp ax,10
	je hexaA
	cmp ax,11
	je hexB
	cmp ax,12
	je hexC
	cmp ax,13
	je hexD
	cmp ax,14
	je hexE
	jmp hexF
	hex0: mov bx,'0'
	ret
	hex1: mov bx,'1'
	ret
	hex2: mov bx,'2'
	ret
	hex3: mov bx,'3'
	ret
	hex4: mov bx,'4'
	ret
	hex5: mov bx,'5'
	ret
	hex6: mov bx,'6'
	ret
	hex7: mov bx,'7'
	ret
	hex8: mov bx,'8'
	ret
	hex9: mov bx,'9'
	ret
	hexaA: mov bx,'A'
	ret
	hexB: mov bx,'B'
	ret
	hexC: mov bx,'C'
	ret
	hexD: mov bx,'D'
	ret
	hexE: mov bx,'E'
	ret
	hexF: mov bx,'F'
	ret
	ENDP
	
	
imprimirTablaMasUsados proc near; rutina que imprime la tabla de mas utilizados a la hora de comprimir
	mov ah, 09h
	lea dx, tablaAscii
	int 21h
	xor di, di
	xor si,si
	mov cx,15
	inicioImpresion:
	mov ax,word ptr repetidos1[si]
	cmp ax, 0
	je terminarImpresion
	xor ax, ax
	mov al,byte ptr repetidosnum1[di]
	cmp al, 32
	jbe caracterNoImprimible
	mov byte ptr variableParaImprimir[0],al
	mov byte ptr variableParaImprimir[1],'$'
	jmp imprimirAscii
	caracterNoImprimible:; si no es imprimible pone el numero en ascii y un #
	push si
	push cx
	xor si,si
	inc si
	mov byte ptr variableParaImprimir[0],'#'
	call convChar
	pop cx
	pop si
	imprimirAscii:; imprime el caracter
	mov ah, 09h
	lea dx, variableParaImprimir
	int 21h
	mov ah, 09h
	lea dx, separador
	int 21h
	mov ax,word ptr repetidos1[si]; imprime sus repeticiones
	push si
	push cx
	xor si,si
	call convChar
	pop cx
	pop si
	mov ah, 09h
	lea dx, variableParaImprimir
	int 21h
	call nuevalinea
	inc si
	inc si
	inc di
	loop inicioImpresion
	terminarImpresion:ret
endp

tasaCompresion Proc near; rutina que saca la tasa de compresion del archivo
mov ah,09; primero imprime los tamanos de los archivos tanto el comprimido como el original
lea dx, bytesarchivoOri
int 21h
mov ax, bytesarchivo
xor si,si
call convChar
mov ah,09
lea dx, variableParaImprimir
int 21h
call nuevalinea
mov ah,09
lea dx, bytesarchivNuv
int 21h
mov ax, bytescompreso
xor si,si
call convChar
mov ah,09
lea dx, variableParaImprimir
int 21h
mov bx, bytesarchivo; pone la cantidad de bytes en registros de trabajo
mov ax, bytescompreso
cmp bx,ax; los compara para ver si hubo reduccion
ja noSeAumento
call nuevalinea; tira un mensaje en el caso de que se haya aumentado de tamano, esto mas que nada para evitar errores en la regla de 3
mov ah,09
lea dx, aumento
int 21h
ret
noSeAumento:
call reglade3; llama a la relga de 3 con los datos
call nuevalinea
mov ah,09; imprime el porcentaje de compresion
lea dx, tasa
int 21h
mov ah,09
lea dx, variableParaImprimir
int 21h
mov ah,09
lea dx, porcentaje
int 21h
ret
endp

descomprimirArchivo Proc near ;rutina que comprime el archivo 
	jmp iniciodescomprimir
	terminardescompresion2:ret
	iniciodescomprimir:
	xor si, si
	xor di, di
	nombreDestino2:; le pone nombre al nuevoarchivo
	mov al, byte ptr rutarch[si]
	mov byte ptr rutarchELregreso[di],al
	inc di
	inc si
	cmp al, 0
	jne nombreDestino2
	ciclorutarchN:
	dec di
	mov al,byte ptr rutarchELregreso[di]
	cmp al, '.'
	jne ciclorutarchN
	inc di
	mov byte ptr rutarchELregreso[di],'t'; cambia su extension a . txt
	inc di
	mov byte ptr rutarchELregreso[di],'x'
	inc di
	mov byte ptr rutarchELregreso[di],'t'
	inc di
	mov byte ptr rutarchELregreso[di],0
	mov ah, 3ch
	mov cx, 0
	lea dx, rutarchELregreso
	int 21h; crea el archivo
	mov handleElregreso, ax
	mov ah, 3fh
	mov bx, handle
	mov cx, 20
	lea dx,iniciobuffytabla
	int 21h; lee los datos necesario para trabajar y los carga a las variables
	pasarAlTxT:
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h
	mov ah, 3Fh
	mov cx,1
	lea dx, buffy
	int 21h; lee el byte al archivo
	cmp ax, 0
	je terminardescompresion2; ve si ya termino de leer el archivo 
	mov bl, buffy
	shr bl,4
	cmp bl, 1111b
	jne num1if
	jmp escribirSintabla ; empieza a escribir uno que no esta en la tabla
	num1if:
	xor bh,bh
	mov si, bx
	mov al, byte ptr repetidosnum1[si]; busca el ascii en la tabla de repetidos y lo mete al al
	mov buffyAdicional,al
	lea dx, buffyAdicional
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h; escibe el caracter
	dec bytesarchivo; decrementa los bytes restantes a escribir
	cmp bytesarchivo,0; revisa si hay que escribir mas
	jne num2if
	jmp terminardescompresion ; si ya no quedan bytes termina eliminado la basura
	num2if:
	mov bl, buffy
	shl bl, 4
	shr bl, 4;solo deja los ultimos 4 bits
	cmp bl, 1111b
	je vieneNotabla; los compara a ver si estan o no en la tabla de mas utilizados
	xor bh,bh
	mov si, bx
	mov al, byte ptr repetidosnum1[si]; repite el proceso de antes si este tambien esta dentro de los mas usados
	mov buffyAdicional,al
	lea dx, buffyAdicional
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h; lo escribe
	dec bytesarchivo; decrementa bytes a escribir restantes
	cmp bytesarchivo,0; vuelve a comparar si quedan cosas por escribir
	jne num3if
	jmp terminardescompresion; termina la descompresion si no tiene mas que escribir
	num3if:
	jmp retornoEscribir
	vieneNotabla:; viene un caracter que no esta en la tabla despues de uno que si estaba
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h
	mov bx, handle
	mov ah, 3Fh
	mov cx,1
	lea dx, buffy
	int 21h; lee es siguiente bye para obtener el resto del caracter
	lea dx, buffy
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h;lo escribe tal y como esta
	dec bytesarchivo; decrementa bytes a escribir restantes
	cmp bytesarchivo,0; vuelve a comparar si quedan cosas por escribir
	jne num4if 
	jmp terminardescompresion; termina la descompresion si no tiene mas que escribir
	num4if:
	retornoEscribir:
	jmp pasarAlTxT;se devuelve al incio del ciclo
	escribirSintabla:; aqui empezo a leer un caracter que no esta entre los mas usados
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h
	mov bx, handle
	mov ah, 3Fh
	mov cx,1
	lea dx, buffyAdicional
	int 21h
	mov bh, buffy
	mov bl, buffyAdicional
	shl bh,4
	shr bl,4
	or bh,bl; consigue el ascii del caracter que leyo al principio ya que ets separado en dos bytes diferentes
	mov buffyExtendido, bh
	lea dx, buffyExtendido
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h; lo escribe 
	dec bytesarchivo; decrementa los bytes restantes a escribir
	cmp bytesarchivo,0; ve si tiene que seguir escribiendo
	je terminardescompresion; termina la descompresion si no tiene mas que escribir
	mov bl, buffyAdicional
	shl bl,4
	shr bl,4
	cmp bl, 1111b; ve si el siguiente byte es un caracter o si lo que tiene es uno de los mas usados
	je leerSigbyte
	xor bh, bh
	mov si, bx
	mov al, byte ptr repetidosnum1[si]; busca el caracter y solo lo lee y escribe de la tabla de mas utilizados
	mov buffyAdicional,al
	lea dx, buffyAdicional
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h; lo escribe
	dec bytesarchivo; menos a los que le falta por escribir
	cmp bytesarchivo,0; ve si ya termino de escribir
	je terminardescompresion; termina de escribir
	jmp retornoEscribirNotabla
	leerSigbyte:; lee el siguiente byte y es el ascii normal solo lo escribe
	xor dx, dx
	xor cx, cx
	mov ah, 42h
	mov al, 1
	mov bx, handle
	int 21h
	mov bx, handle
	mov ah, 3Fh
	mov cx,1
	lea dx, buffy
	int 21h; lee el caracter
	lea dx, buffy
	mov bx,handleElregreso
	mov ah, 40h
	mov cx,1
	int 21h; escribe lo mismo
	dec bytesarchivo; menos a los que le falta por escribir
	cmp bytesarchivo,0; ve si ya termino de escribir
	je terminardescompresion; termina de escribir
	retornoEscribirNotabla:
	jmp pasarAlTxT; se devuelve al incio del ciclo
	terminardescompresion:; termina la descompresion
	ret
endp

codigo ends
 end inicio