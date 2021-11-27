SECTION .data

message1: db "HELLO WORLD!",10 ; input message with newline
message1_length: equ $-message1 ; length of input message

message2: db "THIS IS MEEEE!",10 ; input message with newline
message2_length: equ $-message2 ; length of input message

message3: db "LIFE SHOULD BE FUN FOR EVERYONE",10 ; input message with newline
message3_length: equ $-message3 ; length of input message

key1: db 'DIANA' ; input key with newline
key1_length: equ $-key1 ; length of input key

key2: db "HELLO" ; input key with newline
key2_length: equ $-key2 ; length of input key

key3: db "A" ; input key with newline
key3_length: equ $-key3 ; length of input key


SECTION    .text    
  GLOBAL    _start


;; fonction de print
;; @param : r8 = adresse du message
;; @param : r9 = taille du message
print:
    push rax
    push rdx
    ;; PRINTING message
    mov       rax, 1                  ; system call for write
    mov       rdi, 1                  ; file handle 1 is stdout
    mov       rsi, r8            ; address of string to output
    mov       rdx, r9             ; number of bytes
    syscall     
    pop rdx
    pop rax      
    ret

;; fonction de codage d'une lettre
;; @param : rax = adresse de la lettre
;; @param : rbx = adresse de la cle
code_letter:
    mov bl, [r10 + rcx] ; on récupère la lettre de la clé
    sub bl, [r8 + rax] ; numero_cle − numero_lettre_initiale
    cmp bl, 0 ; si numero_cle − numero_lettre_initiale < 0
    jge code_letter_next; sinon on passe à la suite
    add bl, 'Z' + 1 ; on ajoute 26 à la lettre
code_letter_next:
    cmp bl, 'A' ; on vérifie que la lettre codée est bien comprise entre A et Z
    jg code_letter_end ; sinon on passe à la suite
    add bl, 'A' ; on ajoute 'A' à la lettre
code_letter_end:
    mov [r8 + rax], bl ; on modifie en place la string avec la lettre codée
    ret


;; fonction de codage d'une chaine de caractères
;; @param : r8 = adresse de la chaine
;; @param : r9 = taille de la chaine
;; @param : r10 = adresse de la cle
;; @param : r11 = taille de la clé
;;
;; @return : r8 = adresse de la chaine codée

code_message:
    push rax
    push rbx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12

    mov rax, 0 ; index de la lettre du message que l'on est en train de traiter
    mov rcx, 0 ; index de la lettre de la clé

inside_loop:
    mov bl, [r8 + rax] ; on récupère le code ASCII de la lettre à traiter
    ;; on teste si la lettre est une lettre majuscule (A à Z), sinon, on ne fait pas le décalage
    cmp bl, 'A' ; on vérifie que le code ASCII de la lettre est bien plus grand que 'A'
    jl after_decalage ; sinon on passe à la suite
    cmp bl, 'Z' ; on vérifie que le code ASCII de la lettre à traiter est bien plus petit que le code ASCII de Z
    jg after_decalage ; sinon on passe à la suite
    call code_letter ; on décale la lettre à l'index

    inc rcx ; on incrémente l'index de la clé
    cmp rcx, r11 ; on teste si on a atteint la fin de la clé
    jl after_decalage ; sinon on passe à la suite
    mov rcx, 0 ; on remet le compteur à 0
after_decalage:
    inc rax ; i++
    cmp rax, r9 ; on teste si on a atteint la fin du message
    jl inside_loop ; sinon on passe à la suite
end_loop:
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rbx
    pop rax
    ret


;; fonction qui code une chaine de caractères et affiche le résultat
;; @param : r8 = adresse de la chaine
;; @param : r9 = taille de la chaine
;; @param : r10 = adresse de la cle
;; @param : r11 = taille de la clé

encode_and_print:
    push rax
    push rbx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12

    call code_message ; on code la chaine de caractères
    call print ; on affiche le résultat

    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rcx
    pop rbx
    pop rax
    ret

_start:
    ;; première clé
    mov r10, key1 ; on récupère l'adresse de la clé
    mov r11, key1_length ; on récupère la taille de la clé

    mov r8, message1 ; on récupère l'adresse du message à coder
    mov r9, message1_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    mov r8, message2 ; on récupère l'adresse du message à coder
    mov r9, message2_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    
    mov r8, message3 ; on récupère l'adresse du message à coder
    mov r9, message3_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    ;; seconde clé
    mov r10, key2 ; on récupère l'adresse de la clé
    mov r11, key2_length ; on récupère la taille de la clé

    mov r8, message1 ; on récupère l'adresse du message à coder
    mov r9, message1_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    mov r8, message2 ; on récupère l'adresse du message à coder
    mov r9, message2_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    
    mov r8, message3 ; on récupère l'adresse du message à coder
    mov r9, message3_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    ;; troisième clé
    mov r10, key3 ; on récupère l'adresse de la clé
    mov r11, key3_length ; on récupère la taille de la clé

    mov r8, message1 ; on récupère l'adresse du message à coder
    mov r9, message1_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    mov r8, message2 ; on récupère l'adresse du message à coder
    mov r9, message2_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat

    
    mov r8, message3 ; on récupère l'adresse du message à coder
    mov r9, message3_length ; on récupère la taille du message à coder
    call encode_and_print ; on code et on affiche le résultat



exit:
  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
