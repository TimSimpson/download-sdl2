#include <iostream>

#define SDL_MAIN_HANDLED
#include <SDL.h>

int main(int argc, char* argv[]) {
    SDL_assert(false);

    SDL_Log("Greets Earth!");

    return 0;
}
