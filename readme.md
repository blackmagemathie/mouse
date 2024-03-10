# mouse

## license

**mouse** is licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/). 

## overview

**mouse** is a [Callisto module](https://github.com/Underrout/callisto). it allows one to read a SNES Mouse or equivalent hardware from Controller Port 2.

## requirements

(none)

## features

- Complete polling of the SNES mouse.
- Tracking of up-down states (buttons, hardware speed changes, mouse being plugged in or removed).
- Tracking of consecutive clicks for both buttons.
- Cleaning of X/Y speeds into signed numbers for easier use.
- Code to cycle hardware speed (for the original SNES Mouse).