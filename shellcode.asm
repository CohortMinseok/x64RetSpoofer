BITS 64
DEFAULT REL

global NoStackShellcode

section .text

NoStackShellcode:
    mov [rsp + 8],  rcx     ; store shell_param in stack slot at rsp+8
    mov [rsp + 16], rdx     ; store real_arg0 in stack slot at rsp+16
    mov [rsp + 24], r8      ; store real_arg1 in stack slot at rsp+24
    mov [rsp + 32], r9      ; store real_arg2 in stack slot at rsp+32

    ; Modify shell_param members:
    mov rax, [rsp + 8]      ; rax = shell_param pointer
    mov r10, [rsp]          ; r10 = original return address from _spoofer_stub
    mov [rax + 24], r10     ; shell_param.shellcode_retaddr = _spoofer_stub return address
    mov [rax + 16], rdi     ; save original rdi (used for gadget chaining) into shell_param.rdi
    lea rdi, fixup
    mov [rax + 32], rdi     ; shell_param.shellcode_fixstack = address of fixup
    lea rdi, [rax + 32]     ; rdi = shell_param.shellcode_fixstack

    ; Write gadget address into stack return address:
    mov r10, [rax + 0]      ; r10 = shell_param.trampoline (e.g., jmp_rdi_0)
    mov [rsp + 8], r10      ; overwrite return address with gadget address

    ; Fix up the call stack and jump to the real function:
    add rsp, 8              ; adjust stack (skip extra parameter inserted by _spoofer_stub)
    mov rcx, [rsp + 8]      ; restore rcx parameter
    mov rdx, [rsp + 16]     ; restore rdx parameter
    mov r8,  [rsp + 24]     ; restore r8 parameter
    mov r9,  [rsp + 32]     ; restore r9 parameter
    mov r10, [rax + 8]      ; load real function pointer from shell_param.function
    jmp r10                 ; jump to real function

fixup:
    sub rsp, 8              ; restore stack offset (undo add rsp, 8)
    lea rcx, [rdi - 32]     ; rcx = shell_param pointer
    mov rdi, [rcx + 16]     ; rdi = shell_param.rdi (restore original rdi value)
    push qword [rcx + 24]   ; push shell_param.shellcode_retaddr (original _spoofer_stub return address)
    ret                     ; return using the fixed stack
