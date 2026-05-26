# Glitch-o-Matic Tape Looper Firmware – Implementation Plan

## 1. Hardware Control & CV Mapping

| Control         | Function                                         | CV Input Effect                                                    |
|-----------------|--------------------------------------------------|-------------------------------------------------------------------|
| Slider 1        | Tape Dry/Wet                                    | CV for master wet/dry                                             |
| Sliders 2–9     | Stutter divisions (1/32, 1/16T, 1/16, etc.) amplitude | CV for amplitude/division level; quantized to external clock if present |
| Small Pots      | Panning per stutter division                     | Manual only                                                       |
| Pot 1           | Tape Speed                                      | CV modulates varispeed/pitch                                      |
| Pot 2           | Jitter/Randomize                                | CV modulates jitter amount                                        |
| Pot 3           | Filter (Stereo LP/HP sweep)                     | CV sweeps filter cutoff/freq                                      |
| Pot 4           | Delay/Reverb Amount (wet)                       | CV morphs FX wetness                                              |
| Pot 5           | Delay/Reverb Time/Decay                         | CV modulates FX decay/tail                                        |
| Switch 1        | Tape Direction (Forward <-> Reverse)            | Manual switch only                                                |
| Switch 2        | FX Bypass (tap out all wet FX – 'tape dry run') | Manual switch only                                                |
| Clock CV        | External loop clock                             | Drives tape/stutter division timing                               |

---
## 2. Audio Signal Flow (Block Overview)

```
[Audio In] → [Tape Buffer + Varispeed/Direction (Clock-synced)]
             ↳ [Multi-head Stutter Engine (8 divisions: amplitude, pan, jitter, direction)]
                        ↳ [Head Mixer]
                        ↳ [Stereo Filter (CV/knob)]
                        ↳ [FX (Delay/Reverb: CV/knob)]
                        ↳ [Wet/Dry Blend (Slider/CV)]
                        ↳ [FX Bypass Switch]
                        ↳ [Audio Out]
```

## 3. Feature Details

### Tape Buffer & Playheads
- Circular buffer, sized for max loop; varispeed controlled via pot/CV
- 8 stutter playheads, each at a musically quantized buffer offset (division, syncs to clock CV if patched)
- Each playhead amplitude via slider+CV, pan via small pot
- Jitter offset (pot+CV) for individual randomization/glitch
- Tape direction switch toggles all heads' playback reverse

### Stutter Division Table
| Slider | Division | Description                |
|--------|----------|----------------------------|
| 2      | 1/32     | Micro cut, "granular"      |
| 3      | 1/16T    | Sixteenth triplet          |
| 4      | 1/16     | Classic syncopation        |
| 5      | 1/8T     | Eighth triplet             |
| 6      | 1/8      | Groove division            |
| 7      | 1/4T     | Quarter triplet            |
| 8      | 1/4      | Quarter note               |
| 9      | 1/2      | Tape half-loop             |

### Filter
- Stereo sweep, LP left, HP right (Pot 3 + CV)

### FX Engine
- Delay/reverb amount and decay time: Pot 4/5 plus CV on each, post-filter
- Dry/wet blend always available by slider1, CV
- FX bypass by switch2

### Clock CV Integration
- If patched: All loop/tap points and stutter divisions quantized to external clock pulses
- If not: Free-run from internal clock/tempo

### CV Behavior Notes
- CVs normalized/pots work as attenuators (Eurorack style)
- Smooth interpolation for all CV/knob/slider parameters
- Robust fallback to manual if unpatched

## 4. Firmware Dev Milestones

1. Hardware control scan (pots, sliders, CV, switches, clock input)
2. Tape engine core: buffer, varispeed, direction
3. Stutter engine: playhead quantizing, level/pan/jitter per head
4. FX + pan + filter; clock sync logic
5. Polish: CV interpolation, manual/CV fallback, robust clock logic, final integration
6. Testing: Audio, timing, controller response

## 5. Future Expansion
- Preset/pattern save
- MIDI integration
- Selectable FX engines
- Visual indicators (if available)

---

*This plan serves as the project’s technical reference for the Glitch-o-Matic firmware. Version control is via the `Glitch-o-Matic` branch.*
