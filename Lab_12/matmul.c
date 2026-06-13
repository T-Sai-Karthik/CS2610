#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#if defined(__x86_64__) || defined(__i386__)
#include <x86intrin.h>
#endif

static void init_matrix(int n, double *m, double scale) {
    for (int i = 0; i < n * n; i++) {
        m[i] = scale * (double) ((i % 17) + 1);
    }
}

static double checksum(int n, const double *m) {
    double sum = 0.0;
    for (int i = 0; i < n * n; i++) {
        sum += m[i];
    }
    return sum;
}

static uint64_t read_tsc(void) {
#if defined(__x86_64__) || defined(__i386__)
    return __rdtsc();
#else
    return 0;
#endif
}

static void matmul(int n, double *a, double *b, double *c) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            double acc = 0.0;
            for (int k = 0; k < n; k++) {
                acc += a[i * n + k] * b[k * n + j];
            }
            c[i * n + j] = acc;
        }
    }
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s <N>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[1]);
    if (n <= 0) {
        fprintf(stderr, "N must be positive\n");
        return 1;
    }

    double *a = calloc((size_t) n * (size_t) n, sizeof(double));
    double *b = calloc((size_t) n * (size_t) n, sizeof(double));
    double *c = calloc((size_t) n * (size_t) n, sizeof(double));

    if (!a || !b || !c) {
        fprintf(stderr, "allocation failed for N=%d\n", n);
        free(a);
        free(b);
        free(c);
        return 1;
    }

    init_matrix(n, a, 1.0);
    init_matrix(n, b, 0.5);
    uint64_t start_cycles = read_tsc();
    matmul(n, a, b, c);
    uint64_t end_cycles = read_tsc();

    printf("checksum=%f\n", checksum(n, c));
    printf("cycles=%llu\n", (unsigned long long) (end_cycles - start_cycles));

    free(a);
    free(b);
    free(c);
    return 0;
}
