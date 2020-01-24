
#include <unistd.h>
#include <stdio.h> // for perror
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

// Api - code source : rewrote from the class notes of Nat tuck
int
length(char* text)
{
    char* z;
    for (z = text; *z; ++z);
    return z - text;
}

/* Swap the pointer values of two number */
void swap(int * a , int * b)
{
  int temp = *b;
  *b = *a;
  *a = temp;  
}

#define STD_OUT_CODE 1


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


// Usage Write - Api code source : rewrote the code from notes of nat tuck	   
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
    
    // read the file and obtain the size using stat syscall
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
      
      // Process the charachter text and convert into an integer array 
      // by striping newline charachters
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
      // Output buffer is sized as 5*number_of_integers to
      // have ample space to store the processed output data      
      int sizeArray = IntegerArrayIterator;
      char output_buffer[32*sizeArray];

      insertionSort(IntegerArray , sizeArray);
      int bufferIterator = 0;
      for(int i=0;i<sizeArray;i++)
      {
	int buffer_size = sprintf((char*)&output_buffer[bufferIterator] , "%ld\n" , IntegerArray[i]);
	bufferIterator=bufferIterator+buffer_size;
      }

      // Open and write the processed output to the file
      int OutputFD = open(argv[2] , O_WRONLY); 
       
      if(OutputFD)
      {
        int resultWrite = write(OutputFD , output_buffer , bufferIterator);
        if(resultWrite == -1)
        {
          close(InputFD);
          close(OutputFD);	  
          perror(" write result of OutputFD ");
          _exit(1);    
	  close(InputFD);
          close(OutputFD);	  
         
        }	
      }
      else
      {
        close(InputFD);
        close(OutputFD);	  
        UsageWrite();	      
      }     
    }
    else
    {   
      close(InputFD);
      UsageWrite();    
    }

    close(InputFD);
        
    return 2;
}
