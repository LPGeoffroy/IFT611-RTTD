#include "high_res_timer.h"

#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>
#include <godot_cpp/godot.hpp>

using namespace godot;

void HighResTimer::_bind_methods() {
  ClassDB::bind_method(D_METHOD("start_timer"), &HighResTimer::start_timer);
  ClassDB::bind_method(D_METHOD("stop_timer"), &HighResTimer::stop_timer);
}

HighResTimer::HighResTimer() {}

HighResTimer::~HighResTimer() {}

// Retourne vrai si le timer a été lancé
void HighResTimer::start_timer(){
    pre = high_resolution_clock::now();
}

// Stop le timer et retourne le temps depuis 
double HighResTimer::stop_timer(){
  auto post = high_resolution_clock::now();
  return static_cast<double>(duration_cast<microseconds>(post - pre).count()) / 1000.0;
}
