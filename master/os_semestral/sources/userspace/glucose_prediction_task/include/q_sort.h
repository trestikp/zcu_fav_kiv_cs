#pragma once

// source: https://forgetcode.com/cpp/852-generic-quick-sort

template<class T>
inline void swap(T& v1,T& v2)
{
  T temp=v2;
  v2=v1;
  v1=temp;
}
template<class T>
void quicksort(T *array,int hi,int lo=0)
{
  while(hi>lo)
  {
    int i=lo;
    int j=hi;
    do
    {
      while(array[i]<array[lo]&&i<j)
         i++;
      while(array[--j]>array[lo])
                 ;
      if(i<j)
         swap(array[i],array[j]);
    }while(i<j);
    swap(array[lo],array[j]);
 
    if(j-lo>hi-(j+1)) {
       quicksort(array,j-1,lo);
       lo=j+1;
    }else{
       quicksort(array,hi,j+1);
       hi=j-1;
    }
  }
}