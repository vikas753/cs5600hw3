/*
  32 bit assembly code for performing sorting of input numbers
  It stores the local variables onto stack rather than registers
  as 32bit arch has very few registers and using them all
  could lead to spilling . 
*/

    .global main
    .data
usage_msg              :  .string "Usage: ./sort input output\n"
bad_file_open_msg      :  .string "File Open Failure !\n"
stat_syscall_msg       :  .string "Stat syscall failure to read properties\n"
readfile_fail_msg      :  .string "File read failure\n"
badfile_open_write_msg :  .string "Output file failed to open\n"
writefile_fail_msg     :  .string "File write failure\n"
incorrect_size_text    :  .string "Incorrect size passed for insertion sort\n"


/*
Returns the number of charachters in a string
variable mapping
   ebx : Counter of number of charachters or bytes
   eax : result
   edi : base address of string pointer
8(%ebp): First argument would be base address of string pointer
*/
strlen_prot:
    enter $0 , $0
    push %ebx
    mov 8(%ebp) , %edi
    mov $0 , %ebx
/* Iterates over each charachter of string 
   residing at %rdi and checks for termination
   i.e 0 value . 
*/
.loopStrlen:
    mov (%edi,%ebx,1) , %eax
    inc %ebx
    cmp $0 , %al
    /* Compare a byte and loop again if it aint terminating */
    jne .loopStrlen

    dec %ebx
    mov %ebx , %eax
    pop %ebx
    leave
    ret
 

/*
  8(%ebp)       : Number of integers
  4(%ebp)       : Integer array base ptr
  %ecx          : Integer array base ptr
  %ebx          : Outer loop iterator
  %edx          : Inner loop iterator
  %esi and %edi : used for swapping of variables
*/
    .text
insertion_sort:
    enter $0 , $0
    /* Push registers onto stack as part of caller save
       convention */
    push %ecx
    push %ebx
    push %edx
    push %esi
    push %edi
    
    mov 8(%ebp) , %ecx
    cmp $1 , 12(%ebp)
    jl .incorrectSizePassed
    mov $1 , %ebx              /* Initialize outer loop iterator */
.OuterLoopEpilogue:
    cmp 12(%ebp) , %ebx
    jl  .loopBodyInsSort
    jmp .endProgramInsSort
.loopBodyInsSort:
    mov %ebx , %edx         /* Initialize inner loop iterator */
.InnerloopBody:
   /* Compare the ith value with it's previous value*/
    mov -4(%ecx,%edx,4) , %esi
    cmp %esi , (%ecx,%edx,4)
    jl .swapAndExtendInnerLoop
    jmp .OuterLoopPrologue
.swapAndExtendInnerLoop:
    /* Swap ith value with previous value */
    mov -4(%ecx,%edx,4) , %esi
    mov (%ecx,%edx,4) , %edi
    mov %edi ,-4(%ecx,%edx,4)
    mov %esi , (%ecx,%edx,4)
    /* Update the inner loop iterator and check for any underflow */
    dec %edx
    cmp $0 , %edx
    jne .InnerloopBody
.OuterLoopPrologue:
    /* Update the outer loop iterator in epilog */
    inc %ebx
    jmp .OuterLoopEpilogue

.incorrectSizePassed:
    /* Check for size of array passed if less than 1 , then
       sorting technique wont work  */
    push $incorrect_size_text
    call strlen_prot
    
    mov %eax, %edx 
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $incorrect_size_text , %ecx
    int $0x80

    mov $1, %eax    // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80


.endProgramInsSort:
    pop %edi
    pop %esi
    pop %edx
    pop %ebx
    pop %ecx
    leave
    ret

/* variable mapping
   ecx : Input File Descriptor Number
   ebx : argv
  -16(%ebp) : file name
  -20(%ebp) : file descriptor number
  -24(%ebp) : file size in bytes
  -28(%ebp) : Number of integers in file  
  -32(%ebp) : Output file descriptor number
  -36(%ebp) : Integer Array Base Pointer Address
*/

    .text
main:
    /* We are allocating 256 bytes overhead on stack to store stat
       data structure and important local variables going forward */
    enter $288, $0
    /* Below registers are used throughout program hence are 
       push onto stack will be pop during exit */
    push %ebx
    push %ecx

    mov 8(%ebp) , %eax   # argc : %eax

    /* There should be 3 args exec file1 file2 */
    cmp $3 , %eax
    jne .usageLabel
    mov 12(%ebp) , %ebx
    
    /* Input file 1 is 4(%ebx) */
    mov 4(%ebx) , %eax   # argv[1] : %eax
    mov %eax , -16(%ebp)  /* backup the filename onto a location on stack */
    
    mov %eax , %ebx      /* Input file name argument */
    mov $0, %ecx         /* O_RDONLY flag is set */
    mov $0, %edx         /* Dont care about permission bits */
    mov $5, %eax         /* syscall 5 is open */
    push %ebx
    int $0x80
    pop %ebx
    
    cmp $0 , %eax
    jle .badFileOpening
    
    mov %eax ,-20(%ebp)      /* Make a backup of input file descriptor number at                                20(%ebp) */
    mov %esp , %ecx          /* Reroute the file stat properties to this data 
                           structure*/
    mov -16(%ebp) , %ebx     /* File name argument hasnt changed since last funct                               ion call */
    mov $106 , %eax
    int $0x80
 
    cmp $0 , %eax
    jne .syscallStatFails

    /* Stash the backup of file size onto 24(%ebp) location */
    mov 20(%esp) , %ecx
    mov %ecx , -24(%ebp) 

    /* Divide the file size by 4 to obtain the number of integers and stash 
       them onto 28(%ebp) */
    mov $0 , %edx
    mov %ecx , %eax
    mov $4 , %ebx
    idiv %ebx
    
    mov %eax , -28(%ebp)
    
    /* Allocate the buffer of same size as of Input data file 
       onto stack and align it at a 16 bit boundary as below */
    mov -24(%ebp) , %ecx
    sub %ecx , %esp

    mov $15 , %edx
    not %edx
    and %edx , %esp

    /* Perform the read of entire Input data file onto the locally 
       allocated stack buffer */
    mov -20(%ebp) , %ebx     /* File descriptor number     */
    mov %esp , %ecx          /* Integer array address      */
    mov %ecx , -36(%ebp)     /* backup of integer array base ptr onto stack */
    mov -24(%ebp) , %edx     /* Number of bytes to be read */
    mov $3 , %eax
    int $0x80
   
    /* A file read to be successfull would eventually
       return non-zero value */
    cmp $0 , %eax
    je .readFileFail

 
    /* Close the file that was open to be read in preceding call */
    mov -20(%ebp) , %ebx    /* File descriptor number */
    mov $6 , %eax           /* 6 : close syscall */
    int $0x80

    /* Perform insertion assuming 32-bit integers on the buffer 
       that was read */
    push -28(%ebp)
    push -36(%ebp)
    call insertion_sort

    /* 12(%ebp) : base pointer to argv array */
    mov 12(%ebp) , %ebx
    
    /* Output file -2- is 8(%ebx) */
    mov 8(%ebx) , %eax   # argv[2] : %eax
      
    mov %eax , %ebx       /* Output file name for routing data */
    mov $65, %ecx         /* O_WRONLY and O_CREATE flag is set */
    mov $0644, %edx       /* Dont care about permission bits */
    mov $5, %eax          /* syscall 5 is open */
    int $0x80
    
    cmp $0 , %eax        
    jle .badFileOpenWrite

    mov %eax , -32(%ebp)  /* Output file descriptor number */

    /* Perform the write of entire sorted Integer array data onto the output 
       file */
    mov %eax , %ebx           /* Output File descriptor number  */
    mov -36(%ebp) , %ecx      /* Integer array address          */
    mov -24(%ebp) , %edx      /* Number of bytes to be written  */
    mov $4 , %eax             /* Syscall 5 : write              */
    int $0x80
   
    /* A file write to be successfull would eventually
       return non-zero value */
    cmp $0 , %eax
    je .writeFileFail

  
    /* Close the file that was open to be written in preceding call */
    mov -32(%ebp) , %ebx    /* File descriptor number */
    mov $6 , %eax           /* 6 : close syscall */
    int $0x80
    
    jmp .endProgram

.usageLabel:    
    /* Write the usage message to STDOUT */
    push $usage_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 1: write
    mov $1, %ebx   // fd 1: stdout
    mov $usage_msg, %ecx
    int $0x80

    mov $1, %eax   // syscall 60: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80

.badFileOpening:    
    /* Write the open failure of an input file message to STDOUT */
    push $bad_file_open_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $bad_file_open_msg, %ecx
    int $0x80

    mov $1, %eax   // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80

.syscallStatFails:
    /* any failure in stat syscall for getting properties
       of a file would have a message to STDOUT */
    push $stat_syscall_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $stat_syscall_msg, %ecx
    int $0x80

    mov $1, %eax   // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80

.readFileFail:
    /* Failure in read of a file message to STDOUT */
    push $readfile_fail_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $readfile_fail_msg, %ecx
    int $0x80

    mov $1, %eax   // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80
.badFileOpenWrite:
    push $badfile_open_write_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $badfile_open_write_msg , %ecx
    int $0x80

    mov $1, %eax   // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80

.writeFileFail:
     /* Write the open failure of an output file message to STDOUT */
    push $writefile_fail_msg
    call strlen_prot    

    mov %eax, %edx  
   
    mov $4, %eax   // syscall 4: write
    mov $1, %ebx   // fd 1: stdout
    mov $writefile_fail_msg, %ecx
    int $0x80

    mov $1, %eax   // syscall 1: sys exit
    mov $1, %ebx    // error code 1 
    int $0x80

.endProgram:
    /* return 0 */
    mov $0 , %eax
    pop %ebx
    pop %ecx
    leave
    ret
