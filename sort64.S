
    .global main

/* variable mapping for insertion sort
   rsi : size of array
   rdi : array location
   r9  : Outer loop iterator ( i )
   r10 : Inner loop iterator ( j )
   ecx : Temporary ith value for swapping
   ebx : Temporary value to avoid excessive memory references 
   
*/

    .text
insertion_sort:
    enter $0 , $0
    push %r9
    push %r10
    push %r11
    push %rbx
    cmp $1 , %rsi
    jl .incorrectSizePassed
    mov $1 , %r9            /* Initialize outer loop iterator */
.OuterLoopEpilogue:
    cmp %rsi , %r9
    jl  .loopBodyInsSort
    jmp .endProgramInsSort
.loopBodyInsSort:
    mov %r9 , %r10         /* Initialize inner loop iterator */
.InnerloopBody:
   /* Compare the ith value with it's previous value*/
    mov -4(%rdi,%r10,4) , %ebx
    cmp %ebx , (%rdi,%r10,4)
    jl .swapAndExtendInnerLoop
    jmp .OuterLoopPrologue
.swapAndExtendInnerLoop:
    /* Swap ith value with previous value */
    mov -4(%rdi,%r10,4) , %ecx
    mov (%rdi,%r10,4) , %ebx   
    mov %ebx ,-4(%rdi,%r10,4)
    mov %ecx , (%rdi,%r10,4)
    dec %r10
    cmp $0 , %r10
    jne .InnerloopBody
.OuterLoopPrologue:
    inc %r9
    jmp .OuterLoopEpilogue

.incorrectSizePassed:
    /* Check for size of array passed if less than 1 , then
       sorting technique wont work  */
    mov $incorrect_size_text , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $incorrect_size_text , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
    
    /* perform an exit from the program */
    mov $0 , %rdi
    mov $60 , %rax
    syscall    

.endProgramInsSort:
    pop %rbx
    pop %r11
    pop %r10
    pop %r9
    leave
    ret

/* variable mapping
  rbx     : argc , Integer array 
  rdi     : argv[1]
  rcx     : Integer Array
  r9      : Input file descriptor as well as output file descriptor
  0(%rsp) : FileStat , Integer Array buffer
  48(%rsp): Filestat.size
  r15     : size of file in bytes
  r14     : Number of integers
*/


main:
    enter $256, $0       /* 256 bytes is for stat buffer */

    push %rbx
    push %rcx
    push %r9
    push %r12
    push %r10
    push %r11
    push %r13
    push %r14
    push %r15
    
    /* pushing 9 registers in above code leads to unaligned stack
       (p)adding 24 bytes aligns the same */
    add $24 , %rsp

    /* make a copy of argv[1] and argv[2] to be used later */
    mov 8(%rsi) , %rbx
    mov 16(%rsi) , %r13

    cmp $3 , %rdi
    jne .usageLabel
    mov 8(%rsi) , %rdi   /* Input file name argument */
    mov $0, %rsi         /* O_RDONLY flag is set */
    mov $0, %rdx         /* Dont care about permission bits */
    mov $2, %rax         /* syscall 2 is open */
    syscall

    /* r9 : fd of input file opening */
    mov %rax , %r9
    cmp $0 , %r9

    jle .badFileOpening

    /* Perform a stat syscall below that would populate the datastructure 
       with file properties like file size in bytes */
    mov %rsp , %rsi
    mov $4 , %rax
    syscall          /* Stat Syscall to return file size */

    cmp $0 , %rax   /* Check for validity of file properties in stat syscall */
    jne .incorrectFileProperties
    mov 48(%rsp) , %r15
    
    mov %r15 , %rax
    
    /* Input file is assmumed to be a .bin or .dat containing integers of 4bytes       each thus , file size by 4 would give number of integers */
    mov $4 , %rcx
    idiv %rcx
    mov %rax , %r14

    /* Allocate space for maximum number of integers
       and align the stack pointer */
    sub 48(%rsp), %rsp
    lea 0(%rsp), %r12     
    mov $15, %r10
    not %r10
    and %r10, %rsp

    /* Read the file into buffer at %rsp */
    mov %r11 , %rdx
    lea 0(%rsp) , %rsi
    mov %r9 , %rdi
    mov $0 , %rax   
    syscall
    
    /* Check for the file size read if it is negative
       then there was an error in reading */
    cmp $0 , %rax  
    jle .badFileReadLabel
    
    /* Closing the Input file post the preceding open call rightaway */
    mov %r9 , %rdi
    mov $3 , %rax
    syscall    

    /* %rbx : integer array */
    lea 0(%rsp) , %rbx

    /* Perform insertion sort on integer array obtained above */
    mov %r14 , %rsi
    mov %rbx , %rdi
    call insertion_sort   
   
    mov %r13 , %rdi   /* Output file name */
    mov $65, %rsi     /* Create a file in write only mode */
    mov $0644, %rdx   /* 644 : gives write permission in linux */   
    mov $2, %rax      /* syscall 2 is open */
    syscall

    mov %rax , %r9
    cmp $0 , %r9   /* Output file descriptor number is r9 */

    /* Check for any inconsistencies in output file opening */
    jle .badFileOpening
    
   
    /* Route the data from the buffer to output file */
    mov %r9  , %rdi
    mov %rbx , %rsi
    mov %r15 , %rdx
    mov $1 , %rax     /* Syscall 1 is write */
    syscall

    /* Close the file that was opened for writing in preceding call */
    mov %r9 , %rdi
    mov $3 , %rax
    syscall    
    jmp .endProgram

.usageLabel:
    /* Perform an usage text message to STDOUT */
    mov $usage_text , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $usage_text , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
   
    /* perform an exit from the program */
    mov $1 , %rdi
    mov $60 , %rax
    syscall    
     
.badFileReadLabel:
    /* Perform a bad file read message to STDOUT */
    mov $badfile_read , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $badfile_read , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
 
    /* perform an exit from the program */
    mov $1 , %rdi
    mov $60 , %rax
    syscall    

.incorrectFileProperties:
    /* Any failure in stat syscall message is routed to STDOUT */
    mov $stat_fail , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $stat_fail , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
 
    /* perform an exit from the program */
    mov $1 , %rdi
    mov $60 , %rax
    syscall    

.badFileOpening:
    /* Perform a bad file open message to STDOUT */
    mov $bad_file , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $bad_file , %rsi
    mov %rax , %rdx
    mov $1 , %rax
    syscall

    /* perform an exit from the program */
    mov $1 , %rdi
    mov $60 , %rax
    syscall    

.endProgram:  
    pop %r15
    pop %r14
    pop %r13
    pop %r11
    pop %r10
    pop %r12
    pop %r9
    pop %rcx
    pop %rbx
    mov $0 , %rax
    leave
    ret

 .data
usage_text          : .string "Usage: ./sort64 InputFile OutputFile\n"
bad_file            : .string "Incorrect File passed for open\n"
badfile_read        : .string "Incorrect File was passed to be read\n" 
stat_fail           : .string "Syscall stat fails to read properties\n"
incorrect_size_text : .string "Incorrect size of array for insertion sort\n"

