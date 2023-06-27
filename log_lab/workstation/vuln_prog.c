#include <stdio.h>
#include <string.h>
#define DEBUG 0

void bufferSample(char* buf) {
  char smallbuf[BUFFER_SIZE];
#if DEBUG
printf("smallbuf @%p\n", smallbuf);
#endif
  strcpy(smallbuf, buf);
  printf("%s\n", smallbuf);
}

int main (int argc, char* argv[]){
  bufferSample(argv[1]);
  return 0;
}


