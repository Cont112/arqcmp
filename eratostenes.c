#include <stdio.h>
#include <stdlib.h>

#define MAX 30
void crivo(int n){

  int* prime;
  prime = (int *) malloc((n + 1) * sizeof(int));

  prime[1] = 0;
  prime[0] = 0;

  for(int i = 2; i <= n; i++){
      prime[i] = 1;
  }

  for(int i = 2; i <= n; i++){
    if(prime[i]){
        for(int j = i + i; j <= n; j += i){
          prime[j] = 0;
      }
    }
  }

  for(int i = 2; i <= n; i++){
    if(prime[i])printf("%d ", i);
  }

  free(prime);

}

int main (){
  int n = 32;

  crivo(n);
  return 0;
}
