SECTION .data
message: db "CA BOUM ICI!", 10 ; input message with newline
len_msg: equ $-message ; length of input message

SECTION    .text    
  GLOBAL    _start


print:
    ;; PRINTING message
    mov       rax, 1                  ; system call for write
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, message            ; address of string to output
    mov       rdx, len_msg             ; number of bytes
    syscall              
    ret

decaleLettre:
    mov bl, 'Z' ; on stock le code ASCII de la lettre finale (Z)
    sub bl, [message + rax] ; on effectue : numero_lettre_codee = numero_lettre_finale − numero_lettre_initiale
    add bl, 'A' ; on ajoute le code ASCII de la lettre initiale (A) au code obtenu
    mov [message + rax], bl ; on modifie en place la string avec la lettre codée
    ret

_start:
    mov rax, 0 ; index de la lettre du message que l'on est en train de traiter

insideLoop:
    mov bl, [message + rax] ; on récupère le code ASCII de la lettre à traiter
    ;; on teste si la lettre est une lettre majuscule (A à Z), sinon, on ne fait pas le décalage
    cmp bl, 'A'
    jl afterDecalage
    cmp bl, 'Z'
    jg afterDecalage
    call decaleLettre ; on décale la lettre à l'index
afterDecalage:
    inc rax ; i++
    cmp rax, len_msg
    jl insideLoop ; if i < len_msg -> jump to insideLoop

endLoop:
    call print

exit:
  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
