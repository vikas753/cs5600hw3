
    .global main

/* variable mapping
  rbx     : argc
  rdi     : argv[1]
  r9      : InputFD
  0(%rsp) : FileStat
  48(%rsp): Filestat.size
*/

    .text
main:
    enter $256, $0       /* 256 bytes is for stat buffer */
    push %rbx
    push %r9
    push %r12
    push %r10
    mov 8(%rsi) , %rbx
    cmp $3 , %rdi
    jne .usageLabel
    mov 16(%rsi) , %rdi   /* Input file name */
    push %rdi
    mov $0, %rsi    
    mov $0, %rdx      
    mov $2, %rax      /* syscall 2 is open */
    syscall
    pop %rdi         /*retain the file name */
    push %rdi
    mov %rax , %r9
    cmp $0 , %r9
    je .badFileOpening
    mov %rsp , %rsi
    mov $4 , %rax
    syscall          /* Stat Syscall to return file size */
    shll $2 , 48(%rsp)
    pop %rdi

    /* Allocate space for maximum number of integers */
    sub 48(%rsp), %rsp
    lea 0(%rsp), %r12     
    mov $15, %r10
    not %r10
    and %r10, %rsp

        

    jmp .endProgram
.usageLabel:
    mov $usage_text , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $usage_text , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
    jmp .endProgram
.badFileOpening:
    mov $bad_file , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $usage_text , %rsi
    mov %rax , %rdx
    mov $1 , %rax
    syscall
.endProgram: 
    pop %r9
    pop %rbx
    leave
    ret

 .data
usage_text : .string "./sort InputFile OutputFile \n"
bad_file   : .string " Incorrect File passed for open \n"
test_fmt   : .string " vikasv : %ld \n"

#if 0  /* C reference code below */
#include <unistd.h>
#include <stdio.h> // for perror
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>


int
length(char* text)
{
    char* z;
    for (z = text; *z; ++z);
    return z - text;
}

#define STD_OUT_CODE 1

int UsageWrite()
{
    char* usage = "Usage: ./sort input output \n";
    int rv = write(STD_OUT_CODE , usage, length(usage));
    if (rv < 0) {
        // Checking your syscall return values is a
        // really good idea.
        perror("write in main");
    }
    _exit(1);
   
}

int
main(int argc, char* argv[])
{
    if(argc < 3)
    {
      UsageWrite();	    
    }
    
    printf("argv1 : %s\n" , argv[1]);
    
    int InputFD = open(argv[1],O_RDONLY);
    

    if(InputFD)
    {
      struct stat FileStat;
      stat(argv[1] , &FileStat);
      int size = FileStat.st_size;
      printf("size : %ld \n" , size);
#endif
