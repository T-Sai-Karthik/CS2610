#include <stdio.h>
#include <stdlib.h>

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

static void transpose(int n, double *a, double *b) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            b[j * n + i] = a[i * n + j];
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

    if (!a || !b) {
        fprintf(stderr, "allocation failed for N=%d\n", n);
        free(a);
        free(b);
        return 1;
    }

    init_matrix(n, a, 1.0);
    transpose(n, a, b);
    printf("checksum=%f\n", checksum(n, b));

    free(a);
    free(b);
    return 0;
}
