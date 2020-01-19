
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
    }
    else
    {
      UsageWrite();    
    }

    return 2;
}
