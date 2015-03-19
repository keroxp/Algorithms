#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>

void merge (int* arr, int s1, int e1, int s2, int e2)
{
  int max_len = e1-s1+1 + e2-s2+1;
  int merged[max_len];
  int i = s1;
  int j = s2;
  int k = 0;
  while (k < max_len) {
    if (i <= e1 && j <= e2) {
      if (arr[i] <= arr[j]) {
        merged[k] = arr[i];
        i++;
      } else if (arr[j] < arr[i]) {
        merged[k] = arr[j];
        j++;
      }
      k++;
    } else if (i > e1) {
      merged[k] = arr[j];
      if (j < e2) {
        merged[++k] = arr[++j];
      }
      j++;
      k++;
    } else if (j > e2) {
      merged[k] = arr[i];
      if (i < e1) {
        merged[++k] = arr[++i];
      }
      i++;
      k++;
    }
  }
  i = s1;
  j = s2;
  k = 0;
  while (i <= e1) {
    arr[i] = merged[k];
    k++;
    i++;
  }
  while (j <= e2) {
    arr[j] = merged[k];
    k++;
    j++;
  }
}

void _mergesort (int *arr, int left, int right)
{
  int w = right-left+1;
  if (w > 2) {
    int center = (int)(left+right)/2;
    _mergesort(arr, left, center);
    _mergesort(arr, center+1, right);
    merge(arr, left, center, center+1, right);
  } else if (w == 2) {
    if (arr[left] > arr[right]) {
      int tmp = arr[left];
      arr[left] = arr[right];
      arr[right] = tmp;
    }
  }
}

void print_array (int* arr, int len)
{
  int i;
  printf("[");
  for (i = 0; i < len; ++i) {
    printf("%i", arr[i]);
    if (i < len-1) {
      printf(",");
    }
  }
  printf("]\n");
}

void random_array (int *addr, int len)
{
  int i = 0;
  srand((unsigned)time(NULL));
  while(i < len) {
    addr[i] = rand()%100;
    i++;
  }
}

int main (int argc, char ** argv)
{
  int len = 100;
  int* arr = (int*)malloc(len*sizeof(int));
  random_array(arr, len);
  print_array(arr, len);
  _mergesort(arr, 0, len-1);
  print_array(arr, len);
}