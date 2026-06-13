 
#define TTY (*(volatile unsigned char*)0xC000)

void _start()
{
    TTY = 'H';
    TTY = 'e';
    TTY = 'l';
    TTY = 'l';
    TTY = 'o';
    TTY = ' ';
    TTY = 'W';
    TTY = 'o';
    TTY = 'r';
    TTY = 'l';
    TTY = 'd';
    TTY = '\n';
}