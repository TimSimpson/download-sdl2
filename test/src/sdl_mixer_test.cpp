#define SDL_MAIN_HANDLED
#include <SDL.h>
#include <SDL_mixer.h>

int main(int argc, char* argv[]) {
    SDL_Init(SDL_INIT_VIDEO);
    Mix_Init(MIX_INIT_OGG);
    SDL_Quit();
    return 0;
}

