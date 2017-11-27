#include <iostream>

int main() {
    std::cout << "This dummy file just exists to trigger the CMake cache.\n";
    std::cerr << "sizeof(void *)=" << sizeof(void *) << "\n";
    if (sizeof(void *) != 8) {
        return 1;
    }
    return 0;
}
