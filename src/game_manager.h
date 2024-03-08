#ifndef GAME_MANAGER_H
#define GAME_MANAGER_H

#include <godot_cpp/classes/node.hpp>

namespace godot {

class GameManager : public Node {
  GDCLASS(GameManager, Node)

private:
	short restTime;
  short waveTime;
  int spawnTime;
  godot::String map;

protected:
	static void _bind_methods();

public:
	GameManager();
	~GameManager();

  // void _ready() override;
	void _process(double delta) override;
  // void _physics_process(double delta) override;

  void start_game();

  void set_map(const godot::String mapName);
  godot::String get_map();

};


}

#endif