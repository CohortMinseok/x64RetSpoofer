#include <iostream>
#include <stdio.h>
#include <intrin.h>

#include <Tools/RetSpoofInvoker.h>

uintptr_t jmp_rbx = 0x1234567;
uintptr_t some_address_function = 0x1234567;

int main(int argc, char *argv[])
{
    invoker.init(jmp_rbx); // Set your gadget address FF 23 -> jmp qwort ptr [rbx]

    invoker.invokeFastcall<long>(some_address_function, arg1, arg2); // return spoof call using the function's address and whatever args
}
