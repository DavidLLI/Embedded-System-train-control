#include "command.h"

int parse_digit1(char *cb, int *arg, int index1) {
    int x = cb[index1] - '0';
    if(x >= 0 && x <= 9) {
        *arg = x;
        return 1;
    } else {
        return 0;
    }
}

int parse_digit2(char *cb, int *arg, int index1, int index2) {
    int x1 = cb[index1] - '0';
    int x2 = cb[index2] - '0';
    if(x1 >= 0 && x1 <= 9 && x2 >= 0 && x2 <= 9) {
        *arg = x1 * 10 + x2;
        return 1;
    } else {
        return 0;
    }
}

int parse_digit3(char *cb, int *arg, int index1, int index2, int index3) {
    int x1 = cb[index1] - '0';
    int x2 = cb[index2] - '0';
    int x3 = cb[index3] - '0';
    if(x1 >= 0 && x1 <= 9 && x2 >= 0 && x2 <= 9 && x3 >= 0 && x3 <= 9) {
        *arg = x1 * 100 + x2 * 10 + x3;
        return 1;
    } else {
        return 0;
    }
}


// arg1:int
int parse_arg1(char *cb, int *arg1) {
    if(cb[2] == ' ') { // "cd "
        if(cb[4] == '\r') { // "cd x\r"
            int p_flag1 = parse_digit1(cb, arg1, 3);
            if(p_flag1) return 1;
        } else if(cb[5] == '\r') { // "cd xx\r"
            int p_flag1 = parse_digit2(cb, arg1, 3, 4);
            if(p_flag1) return 1;
        } else if(cb[6] == '\r') { // "cd xxx\r"
            int p_flag1 = parse_digit3(cb, arg1, 3, 4, 5);
            if(p_flag1) return 1;           
        }
    }
    return 0;
}

// arg1:int, arg2:int
int parse_arg2(char *cb, int *arg1, int *arg2) {
    if(cb[2] == ' ') { // "cd "
        if(cb[4] == ' ') { // "cd x "
            int p_flag1 = parse_digit1(cb, arg1, 3);
            if(p_flag1) {
                if(cb[6] == '\r') { // "cd x x\r"
                    int p_flag2 = parse_digit1(cb, arg2, 5);
                    if(p_flag2) return 1;
                } else if(cb[7] == '\r') { // "cd x xx\r"
                    int p_flag2 = parse_digit2(cb, arg2, 5, 6);
                    if(p_flag2) return 1;
                } else if(cb[8] == '\r') { // "cd x xxx\r"
                    int p_flag2 = parse_digit3(cb, arg2, 5, 6, 7);
                    if(p_flag2) return 1;
                }
            } 
        } else if(cb[5] == ' ') { // "cd xx "
            int p_flag1 = parse_digit2(cb, arg1, 3, 4);
            if(p_flag1) {
                if(cb[7] == '\r') { // "cd xx x\r"
                    int p_flag2 = parse_digit1(cb, arg2, 6);
                    if(p_flag2) return 1;
                } else if(cb[8] == '\r') { // "cd xx xx\r"
                    int p_flag2 = parse_digit2(cb, arg2, 6, 7);
                    if(p_flag2) return 1;
                } else if(cb[9] == '\r') { // "cd xx xxx\r"
                    int p_flag2 = parse_digit3(cb, arg2, 6, 7, 8);
                    if(p_flag2) return 1;
                }
            }
        } else if(cb[6] == ' ') { // "cd xxx"
            int p_flag1 = parse_digit3(cb, arg1, 3, 4, 5);
            if(p_flag1) {
                if(cb[8] == '\r') { // "cd xxx x\r"
                    int p_flag2 = parse_digit1(cb, arg2, 7);
                    if(p_flag2) return 1;
                } else if(cb[9] == '\r') { // "cd xxx xx\r"
                    int p_flag2 = parse_digit2(cb, arg2, 7, 8);
                    if(p_flag2) return 1;
                } else if(cb[10] == '\r') { // "cd xxx xxx\r"
                    int p_flag2 = parse_digit3(cb, arg2, 7, 8, 9);
                    if(p_flag2) return 1;
                }
            }            
        }
    }
    return 0;
}

// arg1:int, arg2:char
int parse_arg3(char *cb, int *arg1, int *arg2) {
    if(cb[2] == ' ') { // "cd "
        if(cb[4] == ' ') { // "cd x\r"
            int p_flag1 = parse_digit1(cb, arg1, 3);
            if(p_flag1) {
                if(cb[5] == 'C' || cb[5] == 'S' || cb[5] == 'c' || cb[5] == 's') {
                    if(cb[6] == '\r') {
                        *arg2 = cb[5];
                        return 1;
                    }
                }
            }
        } else if(cb[5] == ' ') { // "cd xx\r"
            int p_flag1 = parse_digit2(cb, arg1, 3, 4);
            if(p_flag1) {
                if(cb[6] == 'C' || cb[6] == 'S' || cb[6] == 'c' || cb[6] == 's') {
                    if(cb[7] == '\r') {
                        *arg2 = cb[6];
                        return 1;
                    }
                }
            }
        } else if(cb[6] == ' ') { // "cd xxx\r"
            int p_flag1 = parse_digit3(cb, arg1, 3, 4, 5);
            if(p_flag1) {
                if(cb[7] == 'C' || cb[7] == 'S' || cb[7] == 'c' || cb[7] == 's') {
                    if(cb[8] == '\r') {
                        *arg2 = cb[7];
                        return 1;
                    }
                }
            }         
        }
    }
    return 0;
}

// schar:char, sint:int, arg2:int
int parse_arg4(char *cb, char *schar, int *sint, int *arg2) {
    if(cb[2] == ' ') { // 'sp '
        if(cb[5] == ' ') { // 'sp A1'
            char c = cb[3];
            if(c - 'A' >= 0 && c - 'A' <= 26) {
                *schar = c;
                int p_flag1 = parse_digit1(cb, sint, 4);
                if(p_flag1) {
                    int p_flag2 = 0;
                    if(cb[7] == '\r') { // 'sp A1 1\r'
                        p_flag2 = parse_digit1(cb, arg2, 6);
                    } else if(cb[8] == '\r') { // 'sp A1 11\r'
                        p_flag2 = parse_digit2(cb, arg2, 6, 7);
                    } else if(cb[9] == '\r') { // 'sp A1 11\r'
                        p_flag2 = parse_digit3(cb, arg2, 6, 7, 8);
                    }
                    if(p_flag2) {
                        return 1;
                    }
                }
            } 
        } else if(cb[6] == ' ') { // 'sp A11'
            char c = cb[3];
            if(c - 'A' >= 0 && c - 'A' <= 26) {
                *schar = c;
                int p_flag1 = parse_digit2(cb, sint, 4, 5);
                if(p_flag1) {
                    int p_flag2 = 0;
                    if(cb[8] == '\r') { // 'sp A11 1\r'
                        p_flag2 = parse_digit1(cb, arg2, 7);
                    } else if(cb[9] == '\r') { // 'sp A11 11\r'
                        p_flag2 = parse_digit2(cb, arg2, 7, 8);
                    } else if(cb[10] == '\r') { // 'sp A11 11\r'
                        p_flag2 = parse_digit3(cb, arg2, 7, 8, 9);
                    }
                    if(p_flag2) {
                        return 1;
                    }
                }
            } 
        }
    }
    return 0; 
}


void parse_command(char *cb, int *type, int *arg1, int *arg2, char *schar, int *sint) {
    switch(cb[0]) {
        case 't':
            if(cb[1] == 'r') { // "tr"
                int flag = parse_arg2(cb, arg1, arg2);
                if(flag) {
                    *type = 1;
                    return;
                }
            }
            break;
        case 'T':
            if(cb[1] == 'R') { // "tr"
                int flag = parse_arg2(cb, arg1, arg2);
                if(flag) {
                    *type = 1;
                    return;
                }
            }
            break;
        case 'r':
            if(cb[1] == 'v') {
                int flag = parse_arg1(cb, arg1);
                if(flag) {
                    *type = 2;
                    return;
                }                
            }
            break;
        case 'R':
            if(cb[1] == 'V') {
                int flag = parse_arg1(cb, arg1);
                if(flag) {
                    *type = 2;
                    return;
                }                
            }
            break;            
        case 's':
            if(cb[1] == 't' 
                && cb[2] == 'o' 
                && cb[3] == 'p' 
                && cb[4] == '\r') {
                *type = 7;
                return;
            } else if(cb[1] == 'w') {
                int flag = parse_arg3(cb, arg1, arg2);
                if(flag) {
                    *type = 3;
                    return;
                }                 
            } else if(cb[1] == 'p') {
                int flag = parse_arg4(cb, schar, sint, arg2);
                if(flag) {
                    *type = 8;
                    return;
                }   
            }
            break;
        case 'S':
            if(cb[1] == 'T' 
                && cb[2] == 'O' 
                && cb[3] == 'P' 
                && cb[4] == '\r') {
                *type = 7;
                return;
            } else if(cb[1] == 'W') {
                int flag = parse_arg3(cb, arg1, arg2);
                if(flag) {
                    *type = 3;
                    return;
                }                 
            } else if(cb[1] == 'P') {
                int flag = parse_arg4(cb, schar, sint, arg2);
                if(flag) {
                    *type = 8;
                    return;
                }   
            }
            break;            
        case 'q':
            if(cb[1] == '\r') {
                *type = 4;
                return;
            }
            break;
        case 'Q':
            if(cb[1] == '\r') {
                *type = 4;
                return;
            }
            break;            
        case 'g':
            if(cb[1] == 'o' && cb[2] == '\r') {
                *type = 6;
                return;
            }
    }
    *type = 5;
    return;
}
