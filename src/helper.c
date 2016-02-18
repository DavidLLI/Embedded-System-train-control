#include "helper.h"

void myMemCpy(void *dest, void *src, int n) {
   // Typecast src and dest addresses to (char *)
   char *csrc = (char *) src;
   char *cdest = (char *) dest;
 
   // Copy contents of src[] to dest[]
   int i;
   for (i=0; i<n; i++)
       cdest[i] = csrc[i];
}


int myAtoi(char *str) {
    int res = 0; // Initialize result
    int sign = 0;
  
    // Iterate through all characters of input string and
    // update result
    if(str[0] == '-') {
    	sign = 1;
    }

    if(sign) {
    	int i;
		for (i = 1; str[i] != '\0'; ++i) {
	    	 res = res*10 + str[i] - '0';
	    }
	    res *= -1;	
    } else {
    	int i;
	    for (i = 0; str[i] != '\0'; ++i) {
	    	 res = res*10 + str[i] - '0';
	    }    	
    }
    // return result.
    return res;
}


int myStrcmp(const char* s1, const char* s2) {
    while(*s1 && (*s1==*s2))
        s1++,s2++;
    return *(const unsigned char*)s1-*(const unsigned char*)s2;
}


void reverse(char s[], int length) {
     int i, j;
     char c;
 
     for (i = 0, j = length-1; i<j; i++, j--) {
         c = s[i];
         s[i] = s[j];
         s[j] = c;
     }
}


void myItoa(int n, char s[]) {
     int i, sign;
 
     if ((sign = n) < 0)  /* record sign */
         n = -n;          /* make n positive */
     i = 0;
     do {       /* generate digits in reverse order */
         s[i++] = n % 10 + '0';   /* get next digit */
     } while ((n /= 10) > 0);     /* delete it */
     if (sign < 0)
         s[i++] = '-';
     s[i] = '\0';
     reverse(s, i);
}


void *memcpy(void* dst, void* src, int len) {
    int i;
    for (i = 0; i < len; i++)
       ((char *)dst)[i] = ((char *)src)[i];

   return dst;
}

