#include "game_manager.h"
// #include <godot_cpp/core/class_db.hpp>
// #include <godot_cpp/core/object.hpp>
#include <godot_cpp/classes/engine.hpp>
#include <godot_cpp/classes/scene_tree.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include <godot_cpp/godot.hpp>

#include <chrono>
#include <iostream>
#include <thread>

using namespace godot;

void uneFonction();

void GameManager::_bind_methods() {
  ClassDB::bind_method(D_METHOD("start_game"), &GameManager::start_game);

  ClassDB::bind_method(D_METHOD("get_map"), &GameManager::get_map);
  ClassDB::bind_method(D_METHOD("set_map", "name"), &GameManager::set_map);
  ClassDB::add_property("GameManager", PropertyInfo(Variant::STRING,"map"), "set_map", "get_map");
}

GameManager::GameManager() {
	restTime = 30;
  waveTime = 60;
  spawnTime = 100;
}

GameManager::~GameManager() {
}

// _physics_process est appelé précisément 60 fois par secondes (par défaut)
// void GDGame::_physics_process(double delta) {
// }


void GameManager::_process(double delta) { 
  if(!Engine::get_singleton()->is_editor_hint()) {
    // godot::UtilityFunctions::print("Allo godot");
    // godot::String texte = "Hello World!";
    // godot::UtilityFunctions::print(texte);

    SceneTree *scene_tree = get_tree();
    StringName node_name;

    Node *current_scene = scene_tree->get_current_scene();
    for(int i = 0; i < current_scene->get_child_count(); ++i) {
      node_name = current_scene->get_child(i)->get_name();
      godot::UtilityFunctions::print(node_name);
    }
  }
}

void GameManager::start_game() {
  godot::UtilityFunctions::print("C++ GameManager started");
  // std::thread t(uneFonction);

  // std::this_thread::sleep_for(std::chrono::milliseconds(5));

  // t.join();
}

void uneFonction() {
  // std::this_thread::sleep_for(std::chrono::seconds(1));
}

void GameManager::set_map(const godot::String mapName) {
  map = mapName;
  godot::UtilityFunctions::print("Map = " + mapName);
}
  
godot::String GameManager::get_map() {
  return map;
}
