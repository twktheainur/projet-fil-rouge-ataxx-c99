#include "agent.h"
#include "avl.h"

static int evaluate_state(const GameState *state, Player player)
{
  int my_score = game_score(state, player);
  int opponent_score = game_score(state, player_opponent(player));
  return my_score - opponent_score;
}

Move agent_student_choose_move(const GameState *state, AgentContext *context)
{
  Move moves[ATAXX_MAX_MOVES];
  AvlTree cache;
  Move best_move;
  int best_value = -ATAXX_INF;
  int move_count;
  int index;

  (void)context;
  avl_init(&cache);
  best_move.is_pass = true;

  move_count = game_generate_moves(state, moves, ATAXX_MAX_MOVES);
  if (move_count <= 0)
  {
    avl_destroy(&cache);
    return best_move;
  }

  best_move = moves[0];
  for (index = 0; index < move_count && !moves[index].is_pass; ++index)
  {
    GameState next = *state;
    int value;
    game_apply_move(&next, moves[index]);
    value = evaluate_state(&next, state->current_player);
    avl_insert(&cache, game_hash(&next), value);
    if (value > best_value)
    {
      best_value = value;
      best_move = moves[index];
    }
  }

  avl_destroy(&cache);
  return best_move;
}