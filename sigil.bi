'''''''''''''''''''''''''''''''''''''''''''''''''''''
'Sigil Basic                                       ''
'Written by Andy P. (Icy_Viking)                   ''
'QB64 Ver: 1.5                                     ''
'Sigil Ver: 0.9.0                                  ''
'Icy Viking Games                                  ''
'Contact/Paypal: g_andy <at> live.com              ''
'Patreon:https://www.patreon.com/CrazyVikingGamer '''
'''''''''''''''''''''''''''''''''''''''''''''''''''''

'Flags

CONST SL_ALIGN_CENTER = 0
CONST SL_ALIGN_RIGHT = 1
CONST SL_ALIGN_LEFT = 2

CONST SL_KEY_ESCAPE = 256
CONST SL_KEY_ENTER = 257
CONST SL_KEY_TAB = 258
CONST SL_KEY_BACKSPACE = 259
CONST SL_KEY_INSERT = 260
CONST SL_KEY_DELETE = 261
CONST SL_KEY_RIGHT = 262
CONST SL_KEY_LEFT = 263
CONST SL_KEY_DOWN = 264
CONST SL_KEY_UP = 265
CONST SL_KEY_PAGE_UP = 266
CONST SL_KEY_PAGE_DOWN = 267
CONST SL_KEY_HOME = 268
CONST SL_KEY_END = 269
CONST SL_KEY_CAPS_LOCK = 280
CONST SL_KEY_SCROLL_LOCK = 281
CONST SL_KEY_NUM_LOCK = 282
CONST SL_KEY_PRINT_SCREEN = 283
CONST SL_KEY_PAUSE = 284
CONST SL_KEY_F1 = 290
CONST SL_KEY_F2 = 291
CONST SL_KEY_F3 = 292
CONST SL_KEY_F4 = 293
CONST SL_KEY_F5 = 294
CONST SL_KEY_F6 = 295
CONST SL_KEY_F7 = 296
CONST SL_KEY_F8 = 297
CONST SL_KEY_F9 = 298
CONST SL_KEY_F10 = 299
CONST SL_KEY_F11 = 300
CONST SL_KEY_F12 = 301
CONST SL_KEY_F13 = 302
CONST SL_KEY_F14 = 303
CONST SL_KEY_F15 = 304
CONST SL_KEY_F16 = 305
CONST SL_KEY_F17 = 306
CONST SL_KEY_F18 = 307
CONST SL_KEY_F19 = 308
CONST SL_KEY_F20 = 309
CONST SL_KEY_F21 = 310
CONST SL_KEY_F22 = 311
CONST SL_KEY_F23 = 312
CONST SL_KEY_F24 = 313
CONST SL_KEY_F25 = 314
CONST SL_KEY_KEYPAD_0 = 320
CONST SL_KEY_KEYPAD_1 = 321
CONST SL_KEY_KEYPAD_2 = 322
CONST SL_KEY_KEYPAD_3 = 323
CONST SL_KEY_KEYPAD_4 = 324
CONST SL_KEY_KEYPAD_5 = 325
CONST SL_KEY_KEYPAD_6 = 326
CONST SL_KEY_KEYPAD_7 = 327
CONST SL_KEY_KEYPAD_8 = 328
CONST SL_KEY_KEYPAD_9 = 329
CONST SL_KEY_KEYPAD_DECIMAL = 330
CONST SL_KEY_KEYPAD_DIVIDE = 331
CONST SL_KEY_KEYPAD_MULTIPLY = 332
CONST SL_KEY_KEYPAD_SUBTRACT = 333
CONST SL_KEY_KEYPAD_ADD = 334
CONST SL_KEY_KEYPAD_ENTER = 335
CONST SL_KEY_KEYPAD_EQUAL = 336
CONST SL_KEY_LEFT_SHIFT = 340
CONST SL_KEY_LEFT_CONTROL = 341
CONST SL_KEY_LEFT_ALT = 342
CONST SL_KEY_LEFT_SUPER = 343
CONST SL_KEY_RIGHT_SHIFT = 344
CONST SL_KEY_RIGHT_CONTROL = 345
CONST SL_KEY_RIGHT_ALT = 346
CONST SL_KEY_RIGHT_SUPER = 347

CONST SL_MOUSE_BUTTON_1 = 0
CONST SL_MOUSE_BUTTON_2 = 1
CONST SL_MOUSE_BUTTON_3 = 2
CONST SL_MOUSE_BUTTON_4 = 3
CONST SL_MOUSE_BUTTON_5 = 4
CONST SL_MOUSE_BUTTON_6 = 5
CONST SL_MOUSE_BUTTON_7 = 6
CONST SL_MOUSE_BUTTON_8 = 7
CONST SL_MOUSE_BUTTON_LEFT = SL_MOUSE_BUTTON_1
CONST SL_MOUSE_BUTTON_RIGHT = SL_MOUSE_BUTTON_2
CONST SL_MOUSE_BUTTON_MIDDLE = SL_MOUSE_BUTTON_3

CONST SL_TRUE = 1
CONST SL_FALSE = 0

$IF WIN OR LIN THEN
    DECLARE DYNAMIC LIBRARY "sigil"
        'Init Commands
        SUB slWindow (BYVAL xwidth AS LONG, BYVAL xheight AS LONG, title AS STRING, BYVAL fullScr AS LONG)
        SUB slShowCursor (BYVAL show AS LONG)
        SUB slClose ()
        FUNCTION slShouldClose& ()
        'Input Commands
        FUNCTION slGetKey& (BYVAL xkey AS LONG)
        FUNCTION slGetMouseButton& (BYVAL btn AS LONG)
        FUNCTION slGetMouseX& ()
        FUNCTION slGetMouseY& ()
        'Simple Timing commands
        FUNCTION slGetDeltaTime& ()
        FUNCTION slGetTime& ()
        'Render Command
        SUB slRender ()
        'Color Control
        SUB slSetBackColor (BYVAL r AS DOUBLE, BYVAL g AS DOUBLE, BYVAL b AS DOUBLE)
        SUB slSetForeColor (BYVAL r AS DOUBLE, BYVAL g AS DOUBLE, BYVAL b AS DOUBLE)
        'Blending Command
        SUB slSetAdditiveBlend (BYVAL blend AS LONG)
        'Transformation Commands
        SUB slPush ()
        SUB slPop ()
        SUB slTranslate (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE)
        SUB slRotate (BYVAL deg AS DOUBLE)
        SUB slScale (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE)
        'Texture Load command
        FUNCTION slLoadTexture& (filename AS STRING)
        'Sound Loading/Playing Commands
        FUNCTION slLoadWAV& (filename AS STRING)
        FUNCTION slSoundPlay& (BYVAL snd AS LONG)
        FUNCTION slSoundLoop (BYVAL snd AS LONG)
        SUB slSoundPause (BYVAL snd AS LONG)
        SUB slSoundStop (BYVAL snd AS LONG)
        SUB slSoundPauseAll ()
        SUB slSoundResumeAll ()
        SUB slSoundStopAll ()
        FUNCTION slSoundPlaying& (BYVAL snd AS LONG)
        FUNCTION slSoundLooping& (BYVAL snd AS LONG)
        'Shape Commands
        SUB slTriangleFill (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL w AS DOUBLE, BYVAL h AS DOUBLE)
        SUB slTriangleOutline (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL w AS DOUBLE, BYVAL h AS DOUBLE)
        SUB slRectangleFill (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL w AS DOUBLE, BYVAL h AS DOUBLE)
        SUB slRectangleOutline (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL w AS DOUBLE, BYVAL h AS DOUBLE)
        SUB slCircleFill (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL rad AS DOUBLE, BYVAL vert AS LONG)
        SUB slCircleOutline (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL rad AS DOUBLE, BYVAL vert AS LONG)
        SUB slSemiCircleFill (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL rad AS DOUBLE, BYVAL num AS LONG, BYVAL deg AS DOUBLE)
        SUB slSemiCircleOutline (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL rad AS DOUBLE, BYVAL num AS LONG, BYVAL deg AS DOUBLE)
        SUB slPoint (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE)
        SUB slLine (BYVAL x1 AS DOUBLE, BYVAL y1 AS DOUBLE, BYVAL x2 AS DOUBLE, BYVAL y2 AS DOUBLE)
        SUB slSetSpriteTiling (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE)
        SUB slSetSpriteScroll (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE)
        SUB slSprite (BYVAL tex AS LONG, BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL w AS DOUBLE, BYVAL h AS DOUBLE)
        'Text Commands
        SUB slSetTextAlign (BYVAL align AS LONG)
        FUNCTION slGetTextWidth& (text AS STRING)
        FUNCTION slGetTextHeight& (text AS STRING)
        FUNCTION slLoadFont& (filename AS STRING)
        SUB slSetFont (BYVAL font AS LONG, BYVAL size AS LONG)
        SUB slSetFontSize (BYVAL size AS LONG)
        SUB slText (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, text AS STRING)

    END DECLARE
$END IF

