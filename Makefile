all: bin_dir boot_asm
	
run: boot_asm
	qemu-system-x86_64 -drive file=bin/boot.bin,format=raw,index=0,media=disk


debug: boot_asm bin_dir
	qemu-system-i386 -hda bin/boot.bin -s -S & # Uses i386 for debugging
	gdb -ex "target remote localhost:1234" -ex "lay prev" -ex "set confirm off" -ex "set architecture i8086" -ex "break *0x7c00" bin/boot.bin

boot_asm: src/boot.asm bin_dir
	nasm -f bin src/boot.asm -o bin/boot.bin

.PHONY: bin_dir clean
bin_dir:
	mkdir -p bin

clean:
	rm -rf ./bin
