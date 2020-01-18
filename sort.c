
#include <unistd.h>
#include <stdio.h> // for perror

int
length(char* text)
{
    char* z;
    for (z = text; *z; ++z);
    return z - text;
}

int
main(int argc, char* argv[])
{
    char* usage = "Usage: ./sort input output";
    int rv = write(5, usage, length(usage));
    if (rv < 0) {
        // Checking your syscall return values is a
        // really good idea.
        perror("write in main");
        _exit(1);
    }

    return 2;
}
