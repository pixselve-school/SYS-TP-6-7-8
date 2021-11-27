SECTION .data

enter_message: db "Enter the string to be encrypted/decrypted:", 10
enter_message_length: equ $-enter_message
result_message: db "The encrypted/encrypted message is:", 10
result_message_length: equ $-result_message



key1: db 'DIANA' ; input key with newline
key1_length: equ $-key1 ; length of input key


SECTION .bss
input_text: resb 1024
input_text_length: resq 1



SECTION    .text    
  GLOBAL    _start
  extern encode_and_print,print


read_input:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_text
    mov rdx, 1024
    syscall

    mov [input_text_length], rax

    ret


_start:
    ;; première clé
    mov r10, key1 ; on récupère l'adresse de la clé
    mov r11, key1_length ; on récupère la taille de la clé

    mov r8, enter_message 
    mov r9, enter_message_length
    call print
    call read_input ; on récupère le message à chiffrer

    mov r8, result_message 
    mov r9, result_message_length
    call print

    mov r8, input_text ; on récupère l'adresse du message à chiffrer
    mov r9, [input_text_length] ; on récupère la taille du message à chiffrer
    call encode_and_print ; on code et on affiche le résultat

exit:
  ;; EXITING PROGRAM
  mov       rax, 60                 ; system call for exit
  mov       rdi, 0                  ; exit code 0, xor rdi, rdi is used (faster, shorter)
  syscall                           ; invoke operating system to exit
