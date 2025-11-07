[BITS 16]
[ORG 0x7c00]


start:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00
  sti ;Enable Interrupts
  mov si, msg


print:
  lodsb ;Loads byte at ds:si to AL and increments SI
  cmp al,0 ; Check if end of msg
  je exit
  mov ah, 0x0E ; Disp char
  int 0x10
  jmp print


exit:
  cli
  hlt

msg: db "Hello, World!", 0

times 510 - ($ - $$) db 0

dw 0xAA55 ; Set 511 and 512 byte to 0x55 and 0xAA (Little Endian)
