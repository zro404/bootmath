push_op:
  push bx
  push cx
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  inc bx
  cmp [bx], byte 0xFF
  jne cont_push
  mov si, oflow_error
  call print_string
  jmp exit

push_val:
  push bx
  push cx
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  inc bx
  cmp [bx], byte 0xFF
  jne cont_push
  mov si, oflow_error
  call print_string
  jmp exit

cont_push:
  mov [bx], al
  mov [ecx], bx
  pop cx
  pop bx
  ret

pop_op:
  push bx
  push cx
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  mov al, [bx]
  cmp al, 0xFF
  jne cont_pop
  mov si, uflow_error
  call print_string
  jmp exit

pop_val:
  push bx
  push cx
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  mov al, [bx]
  cmp al, 0xFF
  jne cont_pop
  mov si, uflow_error
  call print_string
  jmp exit

cont_pop:
  dec bx
  mov [ecx], bx
  pop cx
  pop bx
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
  db 0x0D, 0x0A, "Stack Underflow", 0
oflow_error:
  db 0x0D, 0x0A, "Stack Overflow", 0
