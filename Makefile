nasm_options = -felf64
ld_options =

step_7_executable: step_7_message_and_key_from_stdin.o step_5_cipher_function_only.o
	ld $(ld_options) $^ -o $@

%.o: %.asm
	echo "🛠 Compiling" $^
	nasm $(nasm_options) $^

clean:
	rm ./*.o