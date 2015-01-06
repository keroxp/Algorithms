#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>

/**
  Quick Sort in C
  by keroxp
**/

#define INT_MAX(a,b) (int)fmax((float)a,(float)b)

void print_array (int arr[], const int left, const int right) {
  int i = 0;
  int len = right-left+1;
  printf("{");
  while (i < len) {
    printf("%i,", arr[i]);
    i++;
  }
  printf("}\n");
}
int get_median (int a, int b, int c) {
  if (a >= b && a >= c) {
    return INT_MAX(b,c);
  } else if (b >= a && b >= c) {
    return INT_MAX(a,c);
  } else if (c >= a && c >= b) {
    return INT_MAX(a,b);
  }
  return -1;
}
void quick_sort (int arr[], int left, int right) {
  // return if given array has only a element.
  if (right - left < 1) return;
  int i = left;
  int j = right;
  // choose pivot, that is median of three elements.
  int k = (int)((i+j)/2);
  int piv = get_median(arr[left], arr[k], arr[right]);
  while (1) {
    // search element is identical or greater than the pivot.
    while (piv > arr[i]) {
      i++;
    }
    // .. is identical or lesser than the pivot.
    while (piv < arr[j]) {
      j--;
    }
    // break if axises crossed
    if (j <= i) {
      break;
    }
    // switch elements
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
    i++;
    j--;
  }
  // divied the array into subarrays at location axises crossed
  quick_sort(arr, left, i-1);
  quick_sort(arr, j+1, right);
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
int main (int argc, char** argv)
{
  // array to be sorted
  int len = 10;
  int *arr = (int*)malloc(len*sizeof(int));
  random_array(arr, len);
  print_array(arr, 0, 9);
  quick_sort(arr, 0, 9);
  print_array(arr, 0, 9);
  free(arr);
}