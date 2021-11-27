SECTION .data
message: db HELLO WORLD",10 ; input message with newline
len_msg: equ $-message ; length of input message
key: db 'D' ; key encoding the shift of the symmetry

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

code_letter:
    mov bl, [key] ; on recupere la valeur de la cle
    sub bl, [message + rax] ; numero_cle − numero_lettre_initiale
    cmp bl, 0 ; si numero_cle − numero_lettre_initiale < 0
    jge code_letter_next ; sinon on passe a la suite
    add bl, 'Z' + 1 ; on ajoute 26 à la lettre
code_letter_next: 
    cmp bl, 'A'  ; on vérifie que la lettre codée est bien comprise entre A et Z
    jg code_letter_end ; sinon on passe à la suite
    add bl, 'A' ; on ajoute 'A' à la lettre
code_letter_end:
    mov [message + rax], bl ; on modifie en place la string avec la lettre codée
    ret

_start:
    mov rax, 0 ; index de la lettre du message que l'on est en train de traiter

insideLoop:
    mov bl, [message + rax] ; on récupère le code ASCII de la lettre à traiter
    ;; on teste si la lettre est une lettre majuscule (A à Z), sinon, on ne fait pas le décalage
    cmp bl, 'A' ; on vérifie que le code ASCII de la lettre est bien plus grand que 'A'
    jl after_decalage ; sinon on passe à la suite
    cmp bl, 'Z' ; on vérifie que le code ASCII de la lettre à traiter est bien plus petit que le code ASCII de Z
    jg after_decalage ; sinon on passe à la suite
    call code_letter ; on décale la lettre à l'index
afterDecalage:
    inc rax ; i++
    cmp rax, len_msg ; on teste si on a atteint la fin du message
    jl inside_loop ; sinon on passe à la suite

endLoop:
    call print

exit:
  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
