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
  extern encode_and_print


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
