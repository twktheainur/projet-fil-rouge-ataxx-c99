#include "agent.h"

Move agent_choose_move(const GameState *state, AgentContext *context)
{
  (void)context;
  return agent_random_choose_move(state);
}