#ifndef HIGH_RES_TIMER_H
#define HIGH_RES_TIMER_H

#include <godot_cpp/classes/ref_counted.hpp>

#include <functional>
#include <chrono>
#include <utility>

using namespace std;
using namespace std::chrono;

namespace godot {

class HighResTimer : public RefCounted {
  GDCLASS(HighResTimer, RefCounted)

  private:
    time_point<high_resolution_clock> pre;

  protected:
    static void _bind_methods();

  public:
    HighResTimer();
    ~HighResTimer();

    void start_timer();
    double stop_timer();
};

}

#endif // HIGH_RES_TIMER_H