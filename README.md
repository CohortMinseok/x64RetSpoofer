# x64RetSpoofer
x64 Return Spoofing

Similar return spoofing method for x64 with similar invoke function.

x86RetSpoofer: [https://github.com/danielkrupinski](https://github.com/danielkrupinski/x86RetSpoof)

Found from Github User: https://github.com/zxcvbnm3057

Simply add all 3 file in whatever directory.
Make sure to set your Build Dependencies -> Build Customizations.
I personaly use NASM, so make adjustments if you choose to use MASM.

NASM Installation for VS: https://github.com/ShiftMediaProject/VSNASM

3/15/2025 - Update
* I made changes to the shellcode.asm cause I found that RBX, although it worked majority of the time, is a very volatile register.
* Calling certain functions would cause a crash, and my current project has several function calls that I utilize
* RDI is a bit safer, but you can also opt for r12, r13+0x0, r14, r15...
* https://www.unknowncheats.me/forum/anti-cheat-bypass/268039-x64-return-address-spoofing-source-explanation.html
