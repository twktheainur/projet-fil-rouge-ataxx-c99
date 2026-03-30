#ifndef AGENT_H
#define AGENT_H

#include "game.h"

typedef struct AgentContext {
    int depth_limit;
} AgentContext;

Move agent_random_choose_move(const GameState *state);
Move agent_student_choose_move(const GameState *state, AgentContext *context);

#endif