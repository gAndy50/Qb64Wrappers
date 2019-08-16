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

