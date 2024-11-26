#include <stdio.h>
using namespace std;

namespace var1{
    template <typename T>
    struct s {
        T rcx = 0x53414249;
        T rcx4 = 0;
        T rcx8 = 0x00000000;
    };

    void check(bool condition) {
        if (condition) {
            printf("Access granted\n");
        }
        else {
            puts("Access denied");
            return;
        }
    }

    template <typename T>
    void access1(T a, T b, T c) {
        if (a == 0x53414249) {
            if (b == 0) {
                float value = *reinterpret_cast<float*>(&c);
                if (value == 0.0f) {
                    check(true);
                    return;
                }
            }
        }
        check(false);
    }  
};
