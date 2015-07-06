; Date and time functions

; The program prints the date and saves it to file when running from TURBO ASSEMBLER the path is:
; c:\Documents and Settings\MWASELAGeek\tasm\bin\>tasm digital clock.asm   
; c:\date.txt



.model small
.stack 
.data
.code
start:
mov ax,@data
mov ds,ax  

TAB EQU 9   ; ASCII CODE

mov ah, 2ch                  ; get time 
int 21h 
mov al, ch                   ; hour 
call deci 
mov w. hour, ax 
mov al, cl                   ; minute 
call deci 
mov w. minu, ax 
mov al, dh                   ; second 
call deci 
mov w. seco, ax 



mov ah, TAB 
mov dx, offset txt 
int 21h 


mov cx, 0                    ; file attribute
mov ax, 3c00h                ; create new file 
mov dx, offset fildat 
int 21h 
jb error                     ; error

mov w. handle, ax

mov ax, 4200h 
mov bx, w. handle 
xor cx, cx                   ; begin byte 0 
xor dx, dx                   ;  
int 21h 
jb error 


mov ah, 3eh                  ; close file.
mov bx, w. handle 
int 21h 



; wait for any key press:
mov ah, 0
int 16h

error:                       ; leave program (unconditionally). 
mov ax, 4c00h
int 21h


deci:                        ; calculate in decimal 
push cx
xor ah, ah 
mov cl, 10 
div cl 
add ax, 3030h
pop cx
ret 
     
mov ah,86h
mov cx,001Eh                  ;interrupt to give time interval of two seconds
mov dx,8480h  
               ;    

fildat db "c:\date.txt",0    ; where to save date and time.
handle db 0,0 


; here's data to display the date and time 

txt  db 0Dh, 0Ah, 0Ah, TAB, TAB          ; jump line and go two tabs right 

hour db 0, 0, ':'       
minu db 0, 0, ':' 
seco db 0, 0, ' '
      db 0Dh, 0Ah, 24h         ; line feed   return   and  stop symbol 24h=$ (ASCII).


mov ah,4ch
int 21h                        ;interrupt to return to operating system
                    
                    