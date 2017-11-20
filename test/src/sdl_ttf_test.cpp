#define SDL_MAIN_HANDLED
#include <SDL.h>
#include <SDL_ttf.h>

int main(int argc, char* argv[]) {
    SDL_Init(SDL_INIT_VIDEO);
    TTF_Init();
    SDL_Quit();
    return 0;
}

