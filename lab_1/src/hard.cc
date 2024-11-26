#include <stdio.h>
#include <hard.h>

using namespace std;
using namespace var1;


int main() {
    var1::S<int> s;
    var1::C<int> c;
    var1::access1(s, c);
    return 0;
}
