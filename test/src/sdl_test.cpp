#include <iostream>

#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>

int main(int argc, char* argv[]) {
    SDL_Log("Greets Earth!");
    SDL_assert(false);
    return 0;
}
