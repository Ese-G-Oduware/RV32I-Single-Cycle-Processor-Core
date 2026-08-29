//The code below was compiled and loaded into instruction memory.
//Credits to bit-spinner.com for providing the program. 

int fibonacci(int n) {
    
    if (n <= 0)
        return;

    int a = 0, b = 1, c, i;

    for (i = 1; i < n; i++) {
        c = a + b; // Calculate the next term
        a = b;     // Update a to the previous term
        b = c;     // Update b to the current term
    }

    return a;
}

int main(void) {

    int fib = fibonacci(5);
    return 0;        
}