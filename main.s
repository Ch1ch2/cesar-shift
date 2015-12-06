        AREA |.text|, CODE, READONLY

A       EQU 0
KEY     EQU 8           ; KEY = 8
MEM     EQU 0x20000000  ; SRAM memory base address

        ENTRY
        EXPORT __main

__main
        LDR     R0,=x_rw    ; R0=0x20000000 initialise memory index
        LDR     R1,=Tab1    ; R1=Start addr. location of Tab1
        MOV     R3,#0       ; i=0
top
        CMP     R3,#100     ; while i < 101 ;TODO get string size
        BGT     done
        LDRB    R2,[R1],#1  ; R1=RAM[R1]
        STRB    R2,[R0],#1  ; RAM[R0=0x20000000]=0x00000008, R0=0x20000001
        ADD     R3,#1       ; i++
        B       top
done    ; Tab1 is stored at 0x20000000 up to 0x20000009

begin
        LDR R1, =MEM        ; load start memory pointer into R1
        LDR R2, =KEY        ; load KEY into register R3
        LDR R8, =0          ; load R8 = 1


    ; crypt function with string pointer in R1 and Key in R2
crypt   LDR R4, =0          ; R4=i=0
        ADD R8, #1          ; iSdone++
        CMP R8, #3          ; isDone == 3 ??
        BEQ donef           ; if not equal, goto end
strLop  LDRB R5,[R1]        ; load char at position i
        CMP R5, #0x00       ; compare char in R4 with NULL (0x00)
        BEQ endCrypt
        ; if not equal, branch to endCrypt
        SUB R5,#32          ; R5 = R5 - 32
        ADD R5,R2           ; R5 = R5 + KEY
        CMP R5, #0          ; (R8 = R5 - 32 +KEY) < 0 ???
        BGE sup0
        ; Crypting ... R5 = (R5-32+KEY +94) MOD 94 + 32
        ADD R5,#94          ; R5 = R5 +94 )
        B mod
        ; Crypting ... R5 = (R5-32+KEY) MOD 94 + 32
sup0
        ; R5 mod 94 = R5 - R6*integerPart( R5 /94)
mod     LDR R7,=94          ; load r7 with 94 for the SDIV
        SDIV R6,R5,R7       ; R6 = integerPart(R5 / 94)
        MUL R6, R7          ; R6=R6*95
        SUB R5,R6           ; R5=R5-R6
        ; end Mod
        ADD R5, #32
        STRB R5,[R1],#1     ; Store char in R5, i.e. RAM[R1]=R5, and increment memory pointer
        B   strLop          ; loop to char compares

endCrypt

decrypt

        LDR R1, =MEM        ; load string pointer
        LDR R2, =-KEY       ; load R2= - KEY to decrypt
        B crypt

donef   nop

        AREA mytab, DATA, READONLY
;Tab1   DCB 'H', 'e', 'l', 'o', ' ', 'b', 'o', 'b', '\0'
Tab1    DCB "0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [  ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z"
;Tab2   DCD 0x02,0x07

        AREA variables, DATA, READWRITE
x_rw    space 1
y_rw    space 2

    END