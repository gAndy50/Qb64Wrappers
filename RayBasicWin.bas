'Raylib Basic Simple Window
REM $include: 'raylib.bi'

LET w = 800
LET h = 600

CALL InitWindow(w, h, "Simple")

SetTargetFPS (60)

DIM SHARED Col AS rColor

Col.r = 0
Col.g = 255
Col.b = 0
Col.a = 255

DO

    BeginDrawing

    CALL ClearBackground(_RGBA32(Col.r, Col.g, Col.b, Col.a))

    CALL DrawText("Hello World" + CHR$(0), 10, 30, 20, _RGBA32(255, 0, 0, 255))

    IF IsKeyPressed(KEY_LEFT) THEN
        CALL DrawText("Left" + CHR$(0), 10, 60, 20, _RGBA32(255, 0, 0, 255))
    END IF

   CALL DrawFPS(10, 10)

    EndDrawing

LOOP UNTIL WindowShouldClose

CloseWindow

