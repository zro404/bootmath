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

  mov ax, 0x69
  call push_op

  mov si, hello_msg
  call print_string

get_inp:
  xor ax, ax
  mov ah, 0x0
  int 0x16
  cmp al, 0x08
  je get_inp
  mov ah, 0x0E ; Disp char
  int 0x10
  jmp get_inp

exit:
  cli
  hlt

hello_msg: db "Welcome to BootMath!", 0x0D, 0x0A, 0

print_string:
  lodsb ;Loads byte at ds:si to AL and increments SI
  cmp al,0 ; Check if end of msg
  jne ps_cont
  ret
ps_cont:
  mov ah, 0x0E ; Disp char
  int 0x10
  jmp print_string

%include "src/stack.asm"

times 510 - ($ - $$) db 0

dw 0xAA55 ; Set 511 and 512 byte to 0x55 and 0xAA (Little Endian)
