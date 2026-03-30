# ── Toolchain ────────────────────────────────────────────────────────
CC      := gcc
CFLAGS  ?= -std=c99 -Wall -Wextra -Wpedantic -O2 -Iinclude
LDFLAGS ?=

# ── Platform detection ───────────────────────────────────────────────
ifeq ($(OS),Windows_NT)
  EXE     := .exe
  SHLIB   := .dll
  SHFLAGS := -shared
  DL_LIBS :=
  RM_F    := cmd /C del /Q /F
  SEP     := \\

else
  EXE     :=
  SHLIB   := .so
  SHFLAGS := -shared -fPIC
  DL_LIBS := -ldl
  RM_F    := rm -f
  SEP     := /
endif

# ── Plugins directory ─────────────────────────────────────────────────
PLUGINS_DIR := plugins
LEGACY_AGENT_OBJ := src$(SEP)agent_random.o src$(SEP)agent_student.o src$(SEP)agent_random_plugin.o

# ── Source sets ──────────────────────────────────────────────────────
CORE_SRC   := src/game.c src/avl.c
AGENT_SRC  := src/agents/agent_random.c src/agents/agent_student.c
CLI_SRC    := src/main.c $(CORE_SRC) $(AGENT_SRC) src/agent_loader.c
HARNESS_SRC:= src/main_harness.c $(CORE_SRC) $(AGENT_SRC) src/tui.c src/agent_loader.c

CLI_OBJ     := $(CLI_SRC:.c=.o)
HARNESS_OBJ := $(HARNESS_SRC:.c=.o)
TEST_AVL_OBJ:= tests/test_avl.o src/avl.o
TEST_TUI_OBJ:= tests/test_tui.o src/tui.o

# ── Default target ───────────────────────────────────────────────────
all: ataxx_cli$(EXE) ataxx_harness$(EXE) test_avl$(EXE)

# ── Original CLI binary (unchanged behaviour) ───────────────────────
ataxx_cli$(EXE): $(CLI_OBJ)
	$(CC) $(CFLAGS) -o $@ $(CLI_OBJ) $(LDFLAGS) $(DL_LIBS)

# ── Interactive TUI harness ──────────────────────────────────────────
ataxx_harness$(EXE): $(HARNESS_OBJ)
	$(CC) $(CFLAGS) -o $@ $(HARNESS_OBJ) $(LDFLAGS) $(DL_LIBS)

# ── Tests ────────────────────────────────────────────────────────────
test_avl$(EXE): $(TEST_AVL_OBJ)
	$(CC) $(CFLAGS) -o $@ $(TEST_AVL_OBJ) $(LDFLAGS)

test_tui$(EXE): $(TEST_TUI_OBJ)
	$(CC) $(CFLAGS) -o $@ $(TEST_TUI_OBJ) $(LDFLAGS)

# ── Example agent plugin (wraps the built-in random agent)
agent_plugin: src/agents/agent_random_plugin.c src/agents/agent_random.c $(CORE_SRC) | $(PLUGINS_DIR)
	$(CC) $(CFLAGS) $(SHFLAGS) -o $(PLUGINS_DIR)$(SEP)agent_random$(SHLIB) src/agents/agent_random_plugin.c src/agents/agent_random.c $(CORE_SRC) $(LDFLAGS)

# ── Student plugin  (usage: make student_plugin SRC=myagent.c NAME=myname)
SRC  ?= my_agent.c
NAME ?= custom
student_plugin: $(SRC) $(CORE_SRC) | $(PLUGINS_DIR)
	$(CC) $(CFLAGS) $(SHFLAGS) -o $(PLUGINS_DIR)$(SEP)agent_$(NAME)$(SHLIB) $(SRC) $(CORE_SRC) $(LDFLAGS)

baseline_plugin: baseline_agent.c $(CORE_SRC) | $(PLUGINS_DIR)
	$(CC) $(CFLAGS) $(SHFLAGS) -o $(PLUGINS_DIR)$(SEP)baseline_agent$(SHLIB) baseline_agent.c $(CORE_SRC) $(LDFLAGS)

# ── Create plugins directory ─────────────────────────────────────────
ifeq ($(OS),Windows_NT)
$(PLUGINS_DIR):
	if not exist $(PLUGINS_DIR) mkdir $(PLUGINS_DIR)
else
$(PLUGINS_DIR):
	mkdir -p $(PLUGINS_DIR)
endif

# ── Pattern rule ─────────────────────────────────────────────────────
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# ── Clean ────────────────────────────────────────────────────────────
clean:
	$(RM_F) $(subst /,$(SEP),$(CLI_OBJ) $(HARNESS_OBJ) $(TEST_AVL_OBJ) $(TEST_TUI_OBJ))
	-$(RM_F) $(LEGACY_AGENT_OBJ)
	$(RM_F) ataxx_cli$(EXE) ataxx_harness$(EXE) test_avl$(EXE) test_tui$(EXE)
	-$(RM_F) $(PLUGINS_DIR)$(SEP)*$(SHLIB)

.PHONY: all clean agent_plugin student_plugin baseline_plugin