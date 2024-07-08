# mouse

## license

**mouse.asm** is licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/). 

## overview

**mouse.asm** is a [Callisto module](https://github.com/Underrout/callisto).
it allows you to use a SNES mouse or equivalent hardware via controller port 2.

## requirements

(none)

## features

- polls SNES mouse.
- tracks up/down states (pushing/releasing buttons, changing speeds, un/plugging mouse).
- tracks consecutive clicks for buttons.
- cleans x/y speeds into signed numbers for convenience.
- can cycle original SNES mouse hardware speed.