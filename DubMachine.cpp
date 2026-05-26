#include "daisy_patch_sm.h"
#include "daisysp.h"
#include "dsp.h"
#include "dub_machine_hardware.h"
#include "constants.h"

using namespace daisy;
using namespace oam;
using namespace time_machine;
using namespace std;

#define N_TAPS 9
#define TIME_SECONDS 150
#define CALIBRATION_SAMPLES 128
#define BUFFER_WIGGLE_ROOM_SAMPLES 1000

// ---------------------- //
// GLITCH-O-MATIC: TODOs //
// ---------------------- //
// See IMPLEMENTATION_PLAN.md (in repo root) for the complete, detailed feature spec.
//
// Key next steps:
// 1. Hardware mapping: Update parameter/handler mapping to match new control map from IMPLEMENTATION_PLAN.md (sliders, pots, switches, clock, CV).
// 2. Implement advanced stutter division logic (see plan Table).
// 3. Add jitter/randomization new control and logic.
// 4. Add tape direction and FX bypass handling using switches.
// 5. Ensure CV inputs for all major pots are handled (speed, jitter, filter, FX, etc.).
// 6. Quantize all timing, playheads, and divisions to external clock CV if present.
// 7. Confirm pan (small pots) remain functional and mapped per division.
// 8. Polish: calibration, robust fallback to manual control, and test all new controls.
// 9. Keep GitHub Actions build working for this branch.
//
// Remove or update these lines as tasks are completed!

// [ Existing Dub-O-Matic code continues below ]

#include "daisy_patch_sm.h"
#include "daisysp.h"
#include "dsp.h"
#include "dub_machine_hardware.h"
#include "constants.h"
// ... rest of file unchanged ...
