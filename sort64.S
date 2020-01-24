
    .global main

/* variable mapping for insertion sort
   rsi : size of array
   rdi : array location
   r9  : Outer loop iterator ( i )
   r10 : Inner loop iterator ( j )
   r11 : Temporary ith value for swapping
   rbx : Temporary value to avoid excessive memory references 
   
*/

    .text
insertion_sort:
    enter $0 , $0
    push %r9
    push %r10
    push %r11
    push %rbx
    cmp $1 , %rsi
    jle .incorrectSizePassed
    mov $1 , %r9            /* Initialize outer loop iterator */
.OuterLoopEpilogue:
    cmp %rsi , %r9
    jl  .loopBodyInsSort
    jmp .endProgramInsSort
.loopBodyInsSort:
    mov %r9 , %r10         /* Initialize inner loop iterator */
.InnerloopBody:
   /* Compare the ith value with it's previous value*/
    mov -8(%rdi,%r10,8) , %rbx
    cmp %rbx , (%rdi,%r10,8)
    jl .swapAndExtendInnerLoop
    jmp .OuterLoopPrologue
.swapAndExtendInnerLoop:
    /* Swap ith value with previous value */
    mov -8(%rdi,%r10,8) , %r11
    mov (%rdi,%r10,8) , %rbx   
    mov %rbx ,-8(%rdi,%r10,8)
    mov %r11 , (%rdi,%r10,8)
    dec %r10
    cmp $0 , %r10
    jne .InnerloopBody
.OuterLoopPrologue:
    inc %r9
    jmp .OuterLoopEpilogue

.incorrectSizePassed:
    mov $incorrect_size_text , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $incorrect_size_text , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
.endProgramInsSort:
    pop %rbx
    pop %r11
    pop %r10
    pop %r9
    leave
    ret

/* variable mapping
  rbx     : argc , Integer array , Output buffer
  rdi     : argv[1]
  rcx     : Integer Array
  r9      : InputFD
  0(%rsp) : FileStat
  48(%rsp): Filestat.size
  r11 : size of file
  r13 : File descriptor number
  r12 : read_buf_final array
  r14 : Integer Array Iterator
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

    mov 8(%rsi) , %rbx
    mov 16(%rsi) , %r13

    cmp $3 , %rdi
    jne .usageLabel
    mov 8(%rsi) , %rdi   /* Input file name */
    mov $0, %rsi    
    mov $0, %rdx      
    mov $2, %rax      /* syscall 2 is open */
    syscall

    /* r9 : fd of input file opening */
    mov %rax , %r9
    cmp $0 , %r9

    jle .badFileOpening

    mov %rsp , %rsi
    mov $4 , %rax
    syscall          /* Stat Syscall to return file size */

    cmp $0 , %rax   /* Check for validity of file properties in stat syscall */
    jne .incorrectFileProperties

    mov 48(%rsp) , %r11  /* retain or stash - size of file */
    mov %r11 , -20(%rbp)
    mov %r11 , %r12
    imul $6 , %r12
    mov %r12 , 48(%rsp)  /* 6 x size of file , would be sufficient to hold
                            file contents and integer array in future */
    
    /* Allocate space for maximum number of integers
       + contents of file
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
    
    mov %rax , %r11

    /* Closing the Input file post the preceding open call rightaway */
    mov %r9 , %rdi
    mov $3 , %rax
    syscall    

    /* %rbx : integer array */
    mov %r11 , %rbx
    add %rsp , %rbx

    mov $0 , %r10  /*Initiate start offset */
    mov %rsp , %r12 /* read_buf_final array */     
    mov $0 , %r14 /* Integer Array Iterator */    
    mov $0 , %r15 /* int i */

.loopCheck:
    cmp %r11 , %r15

/* for loop used for processing charachters to an 
   integer array */
    jl .loopBody
    jmp .loopExit
.loopBody:
    mov (%r12,%r15,1) , %al
    cmp $'\n' , %al
    je .makeAnIntegerEntry
    inc %r15
    jmp .loopCheck
.makeAnIntegerEntry:
    /* Feed atoi with charachter string till newline and
       processed output would be an integer to be made to array */
    lea  (%r12,%r10,1) , %rdi
    push %r10
    push %r11
    call atoi
    pop %r11
    pop %r10
    mov %rax , (%rbx,%r14,8)
    inc %r15
    mov %r15 , %r10
    inc %r14
    jmp .loopCheck

.loopExit:
    mov $0 , %r15
    
/* Perform insertion sort on integer array obtained above */
    mov %r14 , %rsi
    mov %rbx , %rdi
    push %rbx
    call insertion_sort   
    pop %rbx
    mov %rbx , %rcx
    mov %r14 , %r9
/* Size of output buffer which would be used to hold output file contents */
    imul $4 , %r14

/* Allocate the size as calculated above on stack and align the
stack pointer */ 
    sub %r14 , %rsp
    lea 0(%rsp), %r12     
    mov $15, %r10
    not %r10
    and %r10, %rsp

/* Move the stack pointer to r15 */
    mov %rsp , %r15

/* Initialize output buffer iterator */
    mov $0 , %r10

/* Initialize output buffer size variable */
    mov $0 , %r11   

.OutputBufferLoopPrologue:
    cmp %r9 , %r10
    jl .OutputBufferLoopBody
    jmp .OutputBufferLoopEnd
.OutputBufferLoopBody:
    /* Use sprintf to implement a string of integers 
       of integer array and route them to a charachter 
       buffer */
    mov (%rcx,%r10,8) , %rdx
    mov $output_buffer_fmt , %rsi
    lea (%r15,%r11,1) , %rdi
    
    /* There are many safe registers below , but we still
       save and restore them to avoid clobbering */
    push %rcx
    push %r11
    push %r10
    push %r15
    push %r9
    mov $0 , %al
    call sprintf
    pop %r9
    pop %r15
    pop %r10
    pop %r11
    pop %rcx

    add %rax , %r11      
    inc %r10
    jmp .OutputBufferLoopPrologue
.OutputBufferLoopEnd:
        
    mov %r13 , %rsi
    mov $output_buffer_test_fmt , %rdi
    mov $0 , %al
    call printf
   
    mov %r13 , %rdi   /* Output file name */
    mov $1, %rsi    
    mov $0, %rdx      
    mov $2, %rax      /* syscall 2 is open */
    syscall

    mov %rax , %r9
    cmp $0 , %r9   /* Output file descriptor number is r9 */

    /* Check for any inconsistencies in output file opening */
    jle .badFileOpening
    
    /* format the integer array data and pack them into a string */
    mov %r15 , %rdi
    mov $output_buffer_test_fmt , %rsi
    mov %r15 , %rdx
    mov $0 , %al
    push %r9
    call sprintf
    pop %r9

    mov %r15 , %rdi
    call strlen
   
  /* Route the data from the buffer to output file */
    mov %r9 , %rdi
    mov %r15 , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /* Syscall 1 is write */
    syscall

    mov %rax , %rsi
    mov $output_buffer_fmt , %rdi
    mov $0 , %al
    call printf

    /* Close the file that was opened for writing in preceding call */
    mov %r9 , %rdi
    mov $3 , %rax
    syscall    

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
.badFileReadLabel:
    mov $badfile_read , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $badfile_read , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
    jmp .endProgram
.incorrectFileProperties:
    mov $stat_fail , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $stat_fail , %rsi
    mov %rax , %rdx
    mov $1 , %rax     /*syscall 1 is write */
    syscall
    jmp .endProgram
.badFileOpening:
    mov $bad_file , %rdi
    call strlen
    
    mov $1 , %rdi
    mov $bad_file , %rsi
    mov %rax , %rdx
    mov $1 , %rax
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

    leave
    ret

 .data
usage_text : .string "./sort InputFile OutputFile \n"
bad_file   : .string " Incorrect File passed for open \n"
badfile_read : .string " Incorrect File was passed to be read \n " 
test_fmt   : .string " vikasv : %ld \n"
stat_fail  : .string " Syscall stat fails to read properties \n "
incorrect_size_text : .string " Incorrect size of array for insertion sort \n "
output_buffer_test_fmt : .string "%s \n"
output_buffer_fmt      : .string "%ld\n"

#if 0  /* C reference code below */
/* Program to perform an insertion sort on an array of 
   elements */
void insertionSort(int integer_array[] , int size)
{
  if(size > 1)
  {	  
    for(int j=1;j<size;j++)
    {
      int i=j;	  
      while(integer_array[i] < integer_array[i-1])
      {
        swap(&integer_array[i] , &integer_array[i-1]);
        i--;
        if(i == 0)
        {
	  break;
        }	
      }
    }    
  }
  else
  {
   // Api code source : rewrote the code from notes of nat tuck	  
    char* usage = "Invalid length of array  \n";
    int rv = write(STD_OUT_CODE , usage, length(usage));
    if (rv < 0) {
        // Checking your syscall return values is a
        // really good idea.
        perror("Insertion sort");
    }
    _exit(1);
     
  }  
}
#endif
