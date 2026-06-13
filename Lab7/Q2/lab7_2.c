#include<stdio.h>
extern int decrypt(); // forward declaration with arguments
extern char ans[]; // forward declaration
char* cipher_text = "kocvuzwyliuwslylkmlzvnclwylfbzlbok";
char substitution[] = {
'w', 't', 'z', 'f', 'v',
'i', 's', 'h', 'l', 'g',
'a', 'y', 'e', 'r', 'b',
'c', 'p', 'u', 'k', 'm',
'o', 'd', 'x', 'n', 'j',
'q'
};
int main(){
// call the decryption function from assembly
printf("recovered plain text: %s\n", ans);
}
