# Qb64Wrappers
Wrappers for QB64!

# About
This repo will provide a wrappers for various libraries using the QB64 programming language. All wrappers written by Andy P. unless otherwise stated. 

NOTE: You will need the required DLLs inside of the folder where QB64.exe resides in order for these wrappers to work!

# License
This software is provided as-is. There is no warranty for this software. You use this software at your own risk. You may not hold me or the QB64 community responsible for any mis-happenings with this software. This software is provided in the event that it will be helpful. Licenses to the various libraries and QB64 can be found at their respected websites. 

# Wrappers Wrapped
* Sigil

# Examples
1. Sigil Example

```BASIC
REM $include: 'sigil.bi'

CALL slWindow(640, 480, "Hello - Press arrow keys to change Backdrop color!", slFALSE)

DO
    slRender
    IF slGetKey(SL_KEY_LEFT) = 1 THEN
        CALL slSetBackColor(255, 255, 255)
    ELSEIF slGetKey(SL_KEY_RIGHT) = 1 THEN
        CALL slSetBackColor(255, 255, 0)
    ELSEIF slGetKey(SL_KEY_DOWN) = 1 THEN
        CALL slSetBackColor(0, 0, 0)
    ELSEIF slGetKey(SL_KEY_UP) = 1 THEN
        CALL slSetBackColor(0, 0, 255)
    END IF

LOOP UNTIL slGetKey(SL_KEY_ESCAPE)

slClose
```
