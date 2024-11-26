#include <iostream>
using namespace std;

namespace var1 {
    long int r10d=1121;
    long int r8d=1210;
    long int r9d=2121210;
    int ecx=1;
    int eax=21210;

    void check(bool condition) {
        if (condition) {
            puts("Access granted");
            return;
        }
        else {
            puts("Access denied");
            return;
        }
    }

    template <typename T>
    struct S {
        long int a = 1;
    };

    template <typename T>
    class C {
    public:
        int* rcx = &ecx;
        template <typename T>
        bool hard_check(S<T>* s)  {
            if (s == nullptr) {
                return false;
            }
            eax = s->a;
            int rbp_4 = 0;

            if (eax == rbp_4) {
                return false;
            }

            r10d = 0;
            r8d = 0;
        loc_4015C5:
            r9d = r8d;
            eax ^= r10d;
            r9d &= 3;

            int rbp_r9_4 = eax;
            eax = r8d + 1;
            r8d = eax;

            eax = ((s->a + eax) >> 8) & 0xFF;

            if (eax != 0) {
                r9d = r8d;
                r9d &= 3;
                r10d = (rbp_r9_4 >> 8) & 0xFF;
                goto loc_4015C5;
            }

            eax = rbp_r9_4;
            if (*rcx == eax) {
                return true;

            }
            return false;
        }
    };

    template <typename T>
    void access1( S<T> s, C<T> c) {
        if (&s == nullptr) {
            check(false);
        }
        check(c.hard_check(&s));
    }
};
