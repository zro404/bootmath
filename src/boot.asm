[BITS 16]
[ORG 0x7c00]


start:
  cli ;Clear Interrupts
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00
  sti ;Enable Interrupts

  mov si, hello_msg
  call print_string

  mov bx, 0x01

get_inp:
  xor ax, ax
  mov ah, 0x0
  int 0x16
  cmp al, 0x0D ; CR
  je .finish
  cmp al, 0x2B ; +
  je .accept_op
  cmp al, 0x2D ; -
  je .accept_op
  cmp al, 0x30 ; 0
  jl get_inp
  cmp al, 0x39 ; 9
  jg get_inp
  .accept_val:
    sub al, 0x30
    mov cl, al
    cmp bx, 0x00
    jne .first_digit
    call pop_val
    mov dl, 0x0A
    mul dl
    add ax, cx
    cmp ax, 0x00FF
    jng .first_digit
    mov si, long_op_msg
    call print_string
    jmp exit
    .first_digit:
      call push_val
      xor bx, bx
      mov al, cl
      add al, 0x30
      jmp .print_char
  .accept_op:
    call push_op
    mov bx, 0x01
  .print_char:
    mov ah, 0x0E ; Disp char
    int 0x10
    jmp get_inp
  .finish:
    mov ah, 0x0E 
    int 0x10
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10

call calc

xor bx, bx
xor cl, cl
call pop_val
convert_result:
  cmp al, 0x00
  je print_result
  mov dl, 0x0A
  div dl
  mov cl, al
  mov al, ah
  mov ah, 0x00
  call push_val
  mov al, cl
  jmp convert_result

print_result:
  call pop_val
  add al, 0x30
  mov ah, 0x0E 
  int 0x10
  mov bx, [val_ptr]
  mov al, [bx]
  cmp al, 0xFF
  jne print_result

exit:
  cli
  hlt

hello_msg: db 0x0A, "Welcome to BootMath!", 0x0D, 0x0A, "> ", 0
long_op_msg: db 0x0D, 0x0A, "Operation Exceeds 8bits!", 0

print_string:
  lodsb ;Loads byte at ds:si to AL and increments SI
  cmp al,0 ; Check if end of msg
  jne .cont
  ret
  .cont:
    mov ah, 0x0E ; Disp char
    int 0x10
    jmp print_string

%include "src/calc.asm"
%include "src/stack.asm"

times 510 - ($ - $$) db 0

dw 0xAA55 ; Set 511 and 512 byte to 0x55 and 0xAA (Little Endian)
