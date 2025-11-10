push_op:
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  mov [bx], ax
  inc bx
  mov [ecx], bx
  ret

push_val:
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  mov [bx], ax
  inc bx
  mov [ecx], bx
  ret

pop_op:
  mov bx, [op_ptr]
  lea cx, [op_ptr]
  dec bx
  mov ax, [bx]
  mov [ecx], bx

pop_val:
  mov bx, [val_ptr]
  lea cx, [val_ptr]
  dec bx
  mov ax, [bx]
  mov [ecx], bx

op_stack:
  times 20 db 0 
  db 0x1D ; Seperator

val_stack:
  times 20 db 0 
  db 0x1D ; Seperator

op_ptr: dw op_stack
val_ptr: dw val_stack
