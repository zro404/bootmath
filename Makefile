all: bin_dir boot_asm
	
run: boot_asm
	qemu-system-x86_64 -hda ./bin/boot.bin

boot_asm: bin_dir
	nasm -f bin src/boot.asm -o bin/boot.bin

.PHONY: bin_dir clean
bin_dir:
	mkdir -p bin

clean:
	rm -rf ./bin
