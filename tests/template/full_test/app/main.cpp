#include <iostream>
#include "testproject.h"

int main() {
    std::cout << "TestProject Application" << std::endl;
    std::cout << "Version: " << testproject_get_version() << std::endl;
    std::cout << "Message: " << testproject_get_greeting() << std::endl;
    return 0;
} 