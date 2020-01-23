
    .global main

/* variable mapping
  rbx     : argc
  rcx     : Integer Array
  rdi     : argv[1]
  r9      : InputFD
  0(%rsp) : FileStat
  48(%rsp): Filestat.size
  r11 : size of file
  r13 : File descriptor number
  r12 : read_buf_final array
  r14 : Integer Array Iterator
*/

    .text
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
    cmp $3 , %rdi
    jne .usageLabel
    mov 8(%rsi) , %rdi   /* Input file name */
    mov $0, %rsi    
    mov $0, %rdx      
    mov $2, %rax      /* syscall 2 is open */
    syscall

    mov %rax , %r13  /* Input file descriptor number is r13 */
    mov %rax , %r9
    cmp $0 , %r9

    je .badFileOpening
    mov %rsp , %rsi
    mov $4 , %rax
    syscall          /* Stat Syscall to return file size */

    cmp $0 , %rax   /* Check for validity of file properties in stat syscall */
    jne .incorrectFileProperties

    mov 48(%rsp) , %r11  /* retain or stash - size of file */
    mov %r11 , %r12
    imul $5 , %r12
    mov %r12 , 48(%rsp)  /* 5 x size of file , would be sufficient to hold
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
    mov %r13 , %rdi
    mov $0 , %rax   
    syscall

    /* Check for the file size read if it is negative
       then there was an error in reading */
    cmp $0 , %rax  
    jle .badFileReadLabel
    
    mov %rax , %r11

    /* %rcx : integer array */
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

.PrintLoopCheck:
    cmp %r14 , %r15
    jl .printloopBody
    jmp .endProgram
.printloopBody:
    mov (%rbx,%r15,8) , %rsi
    mov $test_fmt , %rdi
    mov $0 , %al
    call printf
    inc %r15
    jmp .PrintLoopCheck
    

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
    mov $usage_text , %rsi
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
      char read_buf_final[size];
      size = read(InputFD , read_buf_final , size);

      if(size == -1)
      {
        close(InputFD);     
        printf(" InputFd : %ld\n " , InputFD);	
        perror(" read result of InputFD , inputfd ");
        _exit(1);      
      }

#define MAX_CHARS_LINE 255

      int start_offset = 0;
      int IntegerArray[size >> 1];
      int IntegerArrayIterator = 0;
      for(int i=0;i<size;i++)
      {      
        if(read_buf_final[i] == '\n')
	{
          read_buf_final[i] = '\0';		
          IntegerArray[IntegerArrayIterator] = atoi((char*)&read_buf_final[start_offset]); 		
	  start_offset = i+1;
	  IntegerArrayIterator++; 
	}
      }
      
      for(int i=0;i<IntegerArrayIterator;i++)
      {
        printf("%ld\n" , IntegerArray[i]);	      
      }    


      int OutputFD = open(argv[2] , O_WRONLY); 

      if(OutputFD)
      {
        int resultWrite = write(OutputFD , read_buf_final , size);
        if(resultWrite == -1)
        {
          close(InputFD);
          close(OutputFD);	  
          perror(" write result of OutputFD ");
          _exit(1);      
        }	
      }
      else
      {
        UsageWrite();	      
      }     
#endif
