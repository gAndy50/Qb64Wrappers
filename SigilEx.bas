REM $include: 'sigil.bi'

CALL slWindow(640, 480, "Hello", slFALSE)

DO
    slRender
LOOP UNTIL slGetKey(SL_KEY_ESCAPE)

slClose
