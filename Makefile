all: bin_dir boot_asm
	
run: boot_asm
	qemu-system-x86_64 -drive file=bin/boot.bin,format=raw,index=0,media=disk


debug: src/boot.asm bin_dir
	qemu-system-x86_64 -hda bin/boot.bin -s -S &
	gdb -ex "target remote localhost:1234" -ex "lay prev" -ex "break *0x7c00" bin/boot.bin

boot_asm: src/boot.asm bin_dir
	nasm -f bin src/boot.asm -o bin/boot.bin

.PHONY: bin_dir clean
bin_dir:
	mkdir -p bin

clean:
	rm -rf ./bin
