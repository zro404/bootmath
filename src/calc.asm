calc:
  xor ax, ax
  call pop_val
  mov cx, ax
  call pop_val
  mov bx, ax
  call pop_op
  cmp al, 0x2B ; Addition
  jne .subtract
  add bl, cl
  cmp bx, 0x00FF
  jng .ret
  mov si, long_op_msg
  call print_string
  jmp exit

  .subtract:
    sub bl, cl

  .ret:
    mov ax, bx
    call push_val
    mov bx, [op_ptr]
    mov al, [bx]
    cmp al, 0xFF
    jne calc
    ret
