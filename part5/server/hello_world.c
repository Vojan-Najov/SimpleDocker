#include <stdlib.h>
#include <stdio.h>
#include <fcgiapp.h>

int main(void) {
  int socket_fd = 0;
  int request_ret;
  FCGX_Request request;

  FCGX_Init();

  // socket_fd = FCGX_OpenSocket("127.0.0.1:8080", 16);
  // if (socket_fd < 0) {
  //   perror("OpenSocket error");
  //   exit(EXIT_FAILURE);
  // }

  if (FCGX_InitRequest(&request, socket_fd, 0) != 0) {
    perror("InitRequest error");
    exit(EXIT_FAILURE);
  }

  while (42) {
    request_ret = FCGX_Accept_r(&request);
    if (request_ret < 0) {
      perror("Accept request error");
      exit(EXIT_FAILURE);
    }
    
    FCGX_FPrintF(request.out, "Content-Type: text/html\n\n");
    FCGX_FPrintF(request.out, "Hello world!\n");
    FCGX_Finish_r(&request);
  }

  return EXIT_SUCCESS;
}
