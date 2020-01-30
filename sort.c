/*
  C code for performing sorting technique . 
 */
#include <unistd.h>
#include <stdio.h> // for perror
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>


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
  if(size >= 1)
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
    int rv = write(STD_OUT_CODE , usage, strlen(usage));
    if (rv < 0) {
        perror(" Insertion sort fails with invalid array ");
    }
    _exit(1);
     
  }  
}


// Usage Write - Api code source : rewrote the code from notes of nat tuck	// Generic code to perform a usage text message write to STDOUT using 
// write syscall   
int UsageWrite()
{
    char* usage = "Usage: ./sort input output \n";
    int rv = write(STD_OUT_CODE , usage, strlen(usage));
    if (rv < 0) {
        // Checking your syscall return values is a
        // really good idea.
        perror("Write syscall for usage failure ");
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
      
    // Open the input file , check for any irregularities 
    int InputFD = open(argv[1],O_RDONLY);
    
    if(InputFD)
    {
     // read the file and obtain the size using stat syscall
      struct stat FileStat;
      stat(argv[1] , &FileStat);
      int size = FileStat.st_size;
      
      // read the dat file and populate the integer array as is
      int IntegerArray[size>>2];
      size = read(InputFD , (char*)&IntegerArray , size);

      // Only way to check whether read was fine is to see the size to be non-negative
      if(size == -1)
      {
        close(InputFD);     
        _exit(1);      
      }

      // Sort the Integer Array using insertion sorting technique
      int sizeArray = size >> 2;
      insertionSort(IntegerArray , sizeArray);

      // Program doesnt know whether file exists or not , so better
      // to create it and open it if it doesnt
      int flags = O_WRONLY | O_CREAT;
        
      // Open and write the unprocessed raw output to the file
      // 0644 : Suitable permission bits set for linux
      int OutputFD = open(argv[2] , flags , 0644); 
       
      if(OutputFD)
      {
	// Write the output binary data using write syscall as below
        int resultWrite = write(OutputFD , (char*)&IntegerArray , size);
        if(resultWrite == -1)
        {
          close(InputFD);
          close(OutputFD);	  
          _exit(1);    

         
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
        
    return 0;
}
