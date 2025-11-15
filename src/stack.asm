push_op:
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  inc bx
  cmp [bx], byte 0xFF
  jne .cont
  mov si, oflow_error
  call print_string
  jmp exit
  .cont:
    mov [bx], al
    mov [ecx], bx
    ret

push_val:
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  inc bx
  cmp [bx], byte 0xFF
  jne .cont
  mov si, oflow_error
  call print_string
  jmp exit
  .cont:
    mov [bx], al
    mov [ecx], bx
    ret

pop_op:
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  mov al, [bx]
  cmp al, 0xFF
  jne .cont
  mov si, uflow_error
  call print_string
  jmp exit
  .cont:
    dec bx
    mov [ecx], bx
    ret

pop_val:
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  mov al, [bx]
  cmp al, 0xFF
  jne .cont
  mov si, uflow_error
  call print_string
  jmp exit
  .cont:
    dec bx
    mov [ecx], bx
    ret

op_stack:
  db 0xFF ; Seperator
  times 20 db 0
  db 0xFF

val_stack:
  db 0xFF
  times 20 db 0
  db 0xFF ; Seperator

op_ptr: dw op_stack
val_ptr: dw val_stack

uflow_error:
  db 0x0D, 0x0A, "Stack Underflow"
oflow_error:
  db 0x0D, 0x0A, "Stack Overflow"
