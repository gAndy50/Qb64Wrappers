REM $include: 'raylib42.bi'

LET w = 800
LET h = 600

CALL InitWindow(w, h, "Hello")

DIM SHARED Col AS fColor

'R and G are backwards?
Col.r = 255 'this is blue?
Col.g = 0
Col.b = 0 'this is red? (if value is 255)
Col.a = 255

SetTargetFPS (60)

DO

    BeginDrawing

    CALL ClearBackground(_RGBA32(Col.r, Col.g, Col.b, Col.a))

    CALL DrawFPS(1, 1)

    CALL DrawLine(10, 20, 50, 50, _RGBA32(0, 0, 255, 255))

    EndDrawing

LOOP UNTIL WindowShouldClose
