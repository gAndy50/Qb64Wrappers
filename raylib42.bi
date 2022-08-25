'Raylib 4.2 QB64 Wrapper
'Written by Andy P.
'Icy Viking Games
'Raylib Ver: 4.2
'QB64 Ver: 1.5
'Copyright (c) 2022

'Constants
CONST PI = 3.14159265358979323846
CONST DEG2RAD = PI / 180.0
CONST RAD2DEG = 180.0 / PI

'Structs converted to BASIC types
TYPE fVector2
    x AS _FLOAT
    y AS _FLOAT
END TYPE


TYPE fVector3
    x AS _FLOAT
    y AS _FLOAT
    z AS _FLOAT
END TYPE

TYPE fVector4
    x AS _FLOAT
    y AS _FLOAT
    z AS _FLOAT
    w AS _FLOAT
END TYPE

TYPE fMatrix
    m0 AS _FLOAT
    m4 AS _FLOAT
    m8 AS _FLOAT
    m12 AS _FLOAT
    m1 AS _FLOAT
    m5 AS _FLOAT
    m9 AS _FLOAT
    m13 AS _FLOAT
    m2 AS _FLOAT
    m6 AS _FLOAT
    m10 AS _FLOAT
    m14 AS _FLOAT
    m3 AS _FLOAT
    m7 AS _FLOAT
    m11 AS _FLOAT
    m15 AS _FLOAT
END TYPE

TYPE fColor
    r AS _UNSIGNED LONG
    g AS _UNSIGNED LONG
    b AS _UNSIGNED LONG
    a AS _UNSIGNED LONG
END TYPE

TYPE fRectangle
    x AS _FLOAT
    y AS _FLOAT
    xwidth AS _FLOAT
    height AS _FLOAT
END TYPE

TYPE fImage
    xdata AS _OFFSET
    xwidth AS INTEGER
    height AS INTEGER
    mipmaps AS INTEGER
    format AS INTEGER
END TYPE

TYPE fTexture
    id AS _UNSIGNED INTEGER
    xwidth AS INTEGER
    height AS INTEGER
    mipmaps AS INTEGER
    format AS INTEGER
END TYPE

TYPE fRenderTexture
    id AS _UNSIGNED INTEGER
    Tex AS fTexture
    Tex2 AS fTexture
END TYPE

TYPE fNPatchInfo
    source AS fRectangle
    left AS INTEGER
    top AS INTEGER
    right AS INTEGER
    bottom AS INTEGER
    layout AS INTEGER
END TYPE

TYPE fGlyphInfo
    value AS INTEGER
    offx AS INTEGER
    offy AS INTEGER
    advancex AS INTEGER
    img AS fImage
END TYPE

TYPE fFont
    baseSize AS INTEGER
    glyphCount AS INTEGER
    glyphPadding AS INTEGER
    Tex AS fTexture
    Recs AS fRectangle
    glyphs AS fGlyphInfo
END TYPE

TYPE fCamera3D
    position AS fVector3
    target AS fVector3
    up AS fVector3
    fovy AS _FLOAT
    projection AS INTEGER
END TYPE

TYPE fCamera2D
    offset AS fVector2
    target AS fVector2
    rotation AS _FLOAT
    zoom AS _FLOAT
END TYPE

TYPE fMesh
    vertexCount AS INTEGER
    triangleCount AS INTEGER

    vertices AS _FLOAT
    texcoords AS _FLOAT
    texcoords2 AS _FLOAT
    normals AS _FLOAT
    tangents AS _FLOAT
    colors AS _OFFSET
    indices AS _OFFSET

    animVertices AS _FLOAT
    animNormals AS _FLOAT
    boneId AS STRING * 255
    boneWeight AS _FLOAT

    vaoId AS _UNSIGNED INTEGER
    vboId AS _UNSIGNED INTEGER
END TYPE

TYPE fShader
    id AS _UNSIGNED INTEGER
    locs AS _OFFSET
END TYPE

TYPE fMaterialMap
    Tex AS fTexture
    col AS fColor
    value AS _FLOAT
END TYPE

TYPE fMaterial
    Shad AS fShader
    maps AS fMaterialMap
    params AS _FLOAT
END TYPE

TYPE fTransform
    translation AS fVector3
    rotation AS fVector4
    scale AS fVector3
END TYPE

TYPE fBoneInfo
    fName AS STRING * 32
    parent AS INTEGER
END TYPE

TYPE fModel
    transform AS fMatrix

    meshCount AS INTEGER
    materialCount AS INTEGER
    meshes AS fMesh
    materials AS fMaterial
    meshMaterial AS _OFFSET

    boneCount AS INTEGER
    bones AS fBoneInfo
    bindpose AS fTransform
END TYPE

TYPE fModelAnimation
    boneCount AS INTEGER
    frameCount AS INTEGER
    bones AS fBoneInfo
    frameposes AS fTransform
END TYPE

TYPE fRay
    position AS fVector3
    direction AS fVector3
END TYPE

TYPE fRayCollision
    hit AS INTEGER
    distance AS _FLOAT
    xpoint AS fVector3
    normal AS fVector3
END TYPE

TYPE fBoundingBox
    min AS fVector3
    max AS fVector3
END TYPE

TYPE fWave
    frameCount AS _UNSIGNED INTEGER
    sampleRate AS _UNSIGNED INTEGER
    sampleSize AS _UNSIGNED INTEGER
    channels AS _UNSIGNED INTEGER
    xdata AS _OFFSET
END TYPE

TYPE fAudioStream
    buffer AS _OFFSET
    processor AS _OFFSET

    sampleRate AS _UNSIGNED INTEGER
    sampleSize AS _UNSIGNED INTEGER
    channels AS _UNSIGNED INTEGER
END TYPE

TYPE fSound
    stream AS fAudioStream
    frameCount AS _UNSIGNED INTEGER
END TYPE

TYPE fMusic
    stream AS fAudioStream
    frameCount AS _UNSIGNED INTEGER
    looping AS INTEGER

    ctxType AS INTEGER
    ctxData AS _OFFSET
END TYPE

TYPE fVrDeviceInfo
    hResolution AS INTEGER
    vResolution AS INTEGER
    hScreenSize AS _FLOAT
    vScreenSize AS _FLOAT
    eyeToScreenDistance AS _FLOAT
    lensSeparationDistance AS _FLOAT
    interpupillaryDistance AS _FLOAT
    lensDistortionValues AS _FLOAT
    chromaAbCorrection AS _FLOAT
END TYPE

TYPE fVrStereoConfig
    projection AS fMatrix
    viewOffset AS fMatrix
    leftLensCenter AS _FLOAT
    rightLensCenter AS _FLOAT
    leftScreenCenter AS _FLOAT
    rightScreenCenter AS _FLOAT
    scale AS _FLOAT
    scaleIn AS _FLOAT
END TYPE

TYPE fFilePathList
    capacity AS _UNSIGNED INTEGER
    count AS _UNSIGNED INTEGER
    paths AS _OFFSET
END TYPE


'Config Flags
CONST FLAG_VSYNC_HINT = 64
CONST FLAG_FULLSCREEN_MODE = 2
CONST FLAG_WINDOW_RESIZABLE = 4
CONST FLAG_WINDOW_UNDECORATED = 8
CONST FLAG_WINDOW_HIDDEN = 128
CONST FLAG_WINDOW_MINIMIZED = 512
CONST FLAG_WINDOW_MAXIMIZED = 1024
CONST FLAG_WINDOW_UNFOCUSED = 2048
CONST FLAG_WINDOW_TOPMOST = 4096
CONST FLAG_WINDOW_ALWAYS_RUN = 256
CONST FLAG_WINDOW_TRANSPARENT = 16
CONST FLAG_WINDOW_HIGHDPI = 8192
CONST FLAG_WINDOW_MOUSE_PASSTHROUGH = 16348
CONST FLAG_MSAA_4X_HINT = 32
CONST FLAG_INTERLACED_HINT = 65536

'TraceLogLevel
CONST LOG_ALL = 0
CONST LOG_TRACE = 1
CONST LOG_DEBUG = 2
CONST LOG_INFO = 3
CONST LOG_WARNING = 4
CONST LOG_ERROR = 5
CONST LOG_FATAL = 6
CONST LOG_NONE = 7

'Keyboard Flags
CONST KEY_NULL = 0

CONST KEY_APOSTROPHE = 39
CONST KEY_COMMA = 44
CONST KEY_MINUS = 45
CONST KEY_PERIOD = 46
CONST KEY_SLASH = 47
CONST KEY_ZERO = 48
CONST KEY_ONE = 49
CONST KEY_TWO = 50
CONST KEY_THREE = 51
CONST KEY_FOUR = 52
CONST KEY_FIVE = 53
CONST KEY_SIX = 54
CONST KEY_SEVEN = 55
CONST KEY_EIGHT = 56
CONST KEY_NINE = 57
CONST KEY_SEMICOLON = 59
CONST KEY_EQUAL = 61
CONST KEY_A = 65
CONST KEY_B = 66
CONST KEY_C = 67
CONST KEY_D = 68
CONST KEY_E = 69
CONST KEY_F = 70
CONST KEY_G = 71
CONST KEY_H = 72
CONST KEY_I = 73
CONST KEY_J = 74
CONST KEY_K = 75
CONST KEY_L = 76
CONST KEY_M = 77
CONST KEY_N = 78
CONST KEY_O = 79
CONST KEY_P = 80
CONST KEY_Q = 81
CONST KEY_R = 82
CONST KEY_S = 83
CONST KEY_T = 84
CONST KEY_U = 85
CONST KEY_V = 86
CONST KEY_W = 87
CONST KEY_X = 88
CONST KEY_Y = 89
CONST KEY_Z = 90
CONST KEY_LEFT_BRACKET = 91
CONST KEY_BACKSLASH = 92
CONST KEY_RIGHT_BRACKET = 93
CONST KEY_GRAVE = 96

CONST KEY_SPACE = 32
CONST KEY_ESCAPE = 256
CONST KEY_ENTER = 257
CONST KEY_TAB = 258
CONST KEY_BACKSPACE = 259
CONST KEY_INSERT = 260
CONST KEY_DELETE = 261
CONST KEY_RIGHT = 262
CONST KEY_LEFT = 263
CONST KEY_DOWN = 264
CONST KEY_UP = 265
CONST KEY_PAGE_UP = 266
CONST KEY_PAGE_DOWN = 267
CONST KEY_HOME = 268
CONST KEY_END = 269
CONST KEY_CAPS_LOCK = 280
CONST KEY_SCROLL_LOCK = 281
CONST KEY_NUM_LOCK = 282
CONST KEY_PRINT_SCREEN = 283
CONST KEY_PAUSE = 284
CONST KEY_F1 = 290
CONST KEY_F2 = 291
CONST KEY_F3 = 292
CONST KEY_F4 = 293
CONST KEY_F5 = 294
CONST KEY_F6 = 295
CONST KEY_F7 = 296
CONST KEY_F8 = 297
CONST KEY_F9 = 298
CONST KEY_F10 = 299
CONST KEY_F11 = 300
CONST KEY_F12 = 301
CONST KEY_LEFT_SHIFT = 340
CONST KEY_LEFT_CONTROL = 341
CONST KEY_LEFT_ALT = 342
CONST KEY_LEFT_SUPER = 343
CONST KEY_RIGHT_SHIFT = 344
CONST KEY_RIGHT_CONTROL = 345
CONST KEY_RIGHT_ALT = 346
CONST KEY_RIGHT_SUPER = 347
CONST KEY_KB_MENU = 348

CONST KEY_KP_0 = 320
CONST KEY_KP_1 = 321
CONST KEY_KP_2 = 322
CONST KEY_KP_3 = 323
CONST KEY_KP_4 = 324
CONST KEY_KP_5 = 325
CONST KEY_KP_6 = 326
CONST KEY_KP_7 = 327
CONST KEY_KP_8 = 328
CONST KEY_KP_9 = 329
CONST KEY_KP_DECIMAL = 330
CONST KEY_KP_DIVIDE = 331
CONST KEY_KP_MULTIPLY = 332
CONST KEY_KP_SUBTRACT = 333
CONST KEY_KP_ADD = 334
CONST KEY_KP_ENTER = 335
CONST KEY_KP_EQUAL = 336

CONST KEY_BACK = 4
CONST KEY_MENU = 82
CONST KEY_VOLUME_UP = 24
CONST KEY_VOLUME_DOWN = 25

'Mouse Button Flags
CONST MOUSE_BUTTON_LEFT = 0
CONST MOUSE_BUTTON_RIGHT = 1
CONST MOUSE_BUTTON_MIDDLE = 2
CONST MOUSE_BUTTON_SIDE = 3
CONST MOUSE_BUTTON_EXTRA = 4
CONST MOUSE_BUTTON_FORWARD = 5
CONST MOUSE_BUTTON_BACK = 6

'Mouse Cursor
CONST MOUSE_CURSOR_DEFAULT = 0
CONST MOUSE_CURSOR_ARROW = 1
CONST MOUSE_CURSOR_IBEAM = 2
CONST MOUSE_CURSOR_CROSSHAIR = 3
CONST MOUSE_CURSOR_POINTING_HAND = 4
CONST MOUSE_CURSOR_RESIZE_EW = 5
CONST MOUSE_CURSOR_RESIZE_NS = 6
CONST MOUSE_CURSOR_RESIZE_NWSE = 7
CONST MOUSE_CURSOR_RESIZE_NESE = 8
CONST MOUSE_CURSOR_RESIZE_ALL = 9
CONST MOUSE_CURSOR_NOT_ALLOWED = 10

'Gamepad Buttons
CONST GAMEPAD_BUTTON_UNKNOWN = 0
CONST GAMEPAD_BUTTON_LEFT_FACE_UP = 1
CONST GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2
CONST GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3
CONST GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4
CONST GAMEPAD_BUTTON_RIGHT_FACE_UP = 5
CONST GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6
CONST GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7
CONST GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8
CONST GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9
CONST GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10
CONST GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11
CONST GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12
CONST GAMEPAD_BUTTON_MIDDLE_LEFT = 13
CONST GAMEPAD_BUTTON_MIDDLE = 14
CONST GAMEPAD_BUTTON_MIDDLE_RIGHT = 15
CONST GAMEPAD_BUTTON_LEFT_THUMB = 16
CONST GAMEPAD_BUTTON_RIGHT_THUMB = 17

'Gamepad Axis Flags
CONST GAMEPAD_AXIS_LEFT_X = 0
CONST GAMEPAD_AXIS_LEFT_Y = 1
CONST GAMEPAD_AXIS_RIGHT_X = 2
CONST GAMEPAD_AXIS_RIGHT_Y = 3
CONST GAMEPAD_AXIS_LEFT_TRIGGER = 4
CONST GAMEPAD_AXIS_RIGHT_TRIGGER = 5

'Material map index
CONST MATERIAL_MAP_ABLEDO = 0
CONST MATERIAL_MAP_METALNESS = 1
CONST MATERIAL_MAP_NORMAL = 2
CONST MATERIAL_MAP_ROUGHNESS = 3
CONST MATERIAL_MAP_OCCLUSION = 4
CONST MATERIAL_MAP_EMISSION = 5
CONST MATERIAL_MAP_HEIGHT = 6
CONST MATERIAL_MAP_CUBEMAP = 7
CONST MATERIAL_MAP_IRRADIANCE = 8
CONST MATERIAL_MAP_PREFILTER = 9
CONST MATERIAL_MAP_BRDF = 10

'Shader location index
CONST SHADER_LOC_VERTEX_POSITION = 0
CONST SHADER_LOC_VERTEX_TEXCOORD01 = 1
CONST SHADER_LOC_VERTEX_TEXCOORD02 = 2
CONST SHADER_LOC_VERTEX_NORMAL = 3
CONST SHADER_LOC_VERTEX_TANGENT = 4
CONST SHADER_LOC_VERTEX_COLOR = 5
CONST SHADER_LOC_MATRIX_MVP = 6
CONST SHADER_LOC_MATRIX_VIEW = 7
CONST SHADER_LOC_MATRIX_PROJECTION = 8
CONST SHADER_LOC_MATRIX_MODEL = 9
CONST SHADER_LOC_MATRIX_NORMAL = 10
CONST SHADER_LOC_VECTOR_VIEW = 11
CONST SHADER_LOC_COLOR_DIFFUSE = 12
CONST SHADER_LOC_COLOR_SPECULAR = 13
CONST SHADER_LOC_COLOR_AMBIENT = 14
CONST SHADER_LOC_MAP_ALBEDO = 15
CONST SHADER_LOC_MAP_METALNESS = 16
CONST SHADER_LOC_MAP_NORMAL = 17
CONST SHADER_LOC_MAP_ROUGHNESS = 18
CONST SHADER_LOC_MAP_OCCLUSION = 19
CONST SHADER_LOC_MAP_EMISSION = 20
CONST SHADER_LOC_MAP_HEIGHT = 21
CONST SHADER_LOC_MAP_CUBEMAP = 22
CONST SHADER_LOC_MAP_IRRADIANCE = 23
CONST SHADER_LOC_MAP_PREFILTER = 24
CONST SHADER_LOC_MAP_BRDF = 25

'Shader uniform data type
CONST SHADER_UNIFORM_FLOAT = 0
CONST SHADER_UNIFORM_VEC2 = 1
CONST SHADER_UNIFORM_VEC3 = 2
CONST SHADER_UNIFORM_VEC4 = 3
CONST SHADER_UNIFORM_INT = 4
CONST SHADER_UNIFORM_IVEC2 = 5
CONST SHADER_UNIFORM_IVEC3 = 6
CONST SHADER_UNIFORM_IVEC4 = 7
CONST SHADER_UNIFORM_SAMPLER2D = 8

'Shader attribute data types
CONST SHADER_ATTRIB_FLOAT = 0
CONST SHADER_ATTRIB_VEC2 = 1
CONST SHADER_ATTRIB_VEC3 = 2
CONST SHADER_ATTRIB_VEC4 = 3

'Pixel formats
CONST PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1
CONST PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2
CONST PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3
CONST PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4
CONST PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5
CONST PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6
CONST PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7
CONST PIXELFORMAT_UNCOMPRESSED_R32 = 8
CONST PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9
CONST PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10
CONST PIXELFORMAT_COMPRESSED_DXT1_RGB = 11
CONST PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12
CONST PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13
CONST PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14
CONST PIXELFORMAT_COMPRESSED_ETC1_RGB = 15
CONST PIXELFORMAT_COMPRESSED_ETC2_RGB = 16
CONST PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17
CONST PIXELFORMAT_COMPRESSED_PVRT_RGB = 18
CONST PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19
CONST PIXELFORMAT_COMPRESSED_ASTC_4X4_RGBA = 20
CONST PIXELFORMAT_COMPRESSED_ASTC_8X8_RGBA = 21

'Texture parameters
CONST TEXTURE_FILTER_POINT = 0
CONST TEXTURE_FILTER_BILINEAR = 1
CONST TEXTURE_FILTER_TRILINEAR = 2
CONST TEXTURE_FILTER_ANISOTROPIC_4X = 3
CONST TEXTURE_FILTER_ANISOTROPIC_8X = 4
CONST TEXTURE_FILTER_ANISOTROPIC_16X = 5

CONST TEXTURE_WRAP_REPEAT = 0
CONST TEXTURE_WRAP_CLAMP = 1
CONST TEXTURE_WRAP_MIRROR_REPEAT = 2
CONST TEXTURE_WRAP_MIRROR_CLAMP = 3

'Cubemap layouts
CONST CUBEMAP_LAYOUT_AUTO_DETECT = 0
CONST CUBEMAP_LAYOUT_LINE_VERTICAL = 1
CONST CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2
CONST CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3
CONST CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4

'Font type
CONST FONT_DEFAULT = 0
CONST FONT_BITMAP = 1
CONST FONT_SDF = 2

'Color blending modes
CONST BLEND_ALPHA = 0
CONST BLEND_ADDITIVE = 1
CONST BLEND_MULTIPLIED = 2
CONST BLEND_ADD_COLORS = 3
CONST BLEND_SUBTRACT_COLORS = 4
CONST BLEND_ALPHA_PREMULTIPLY = 5
CONST BLEND_CUSTOM = 6

'Gesture Flags
CONST GESTURE_NONE = 0
CONST GESTURE_TAP = 1
CONST GESTURE_DOUBLETAP = 2
CONST GESTURE_HOLD = 4
CONST GESTURE_DRAG = 8
CONST GESTURE_SWIPE_RIGHT = 16
CONST GESTURE_SWIPE_LEFT = 32
CONST GESTURE_SWIPE_UP = 64
CONST GESTURE_SWIPE_DOWN = 128
CONST GESTURE_SWIPE_IN = 256
CONST GESTURE_PINCH_IN = 256
CONST GESTURE_PINCH_OUT = 512

'CameraMode
CONST CAMERA_CUSTOM = 0
CONST CAMERA_FREE = 1
CONST CAMERA_ORBITAL = 2
CONST CAMERA_FIRST_PERSON = 3
CONST CAMERA_THIRD_PERSON = 4

'CameraProjection
CONST CAMERA_PERSPECTIVE = 0
CAMERA_ORTHOGRAPHIC = 1

'N-patch layout
CONST NPATCH_NINE_PATCH = 0
CONST NPATCH_THREE_PATCH_VERTICAL = 1
CONST NPATCH_THREE_PATCH_HORIZONTAL = 2

'Load the shared library
$IF WIN OR LIN THEN
    DECLARE DYNAMIC LIBRARY "raylib"

        'Window Functions

        SUB InitWindow (BYVAL xwidth AS INTEGER, BYVAL height AS INTEGER, title AS STRING)
        FUNCTION WindowShouldClose ()
        SUB CloseWindow ()
        FUNCTION IsWindowReady ()
        FUNCTION IsWindowFullscreen ()
        FUNCTION IsWindowHidden ()
        FUNCTION IsWindowMinimized ()
        FUNCTION IsWindowMaximized ()
        FUNCTION IsWindowFocused ()
        FUNCTION IsWindowResized ()
        FUNCTION IsWindowState (BYVAL flag AS _UNSIGNED INTEGER)
        SUB SetWindowState (BYVAL flags AS _UNSIGNED INTEGER)
        SUB ClearWindowState (BYVAL flags AS _UNSIGNED INTEGER)
        SUB ToggleFullscreen ()
        SUB MaximizeWindow ()
        SUB MinimizeWindow ()
        SUB RestoreWindow ()
        SUB SetWindowIcon (BYVAL fImage AS _OFFSET)
        SUB SetWindowTitle (title AS STRING)
        SUB SetWindowPosition (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
        SUB SetWindowMonitor (BYVAL mon AS INTEGER)
        SUB SetWindowMinSize (BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB SetWindowSize (BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB SetWindowOpacity (BYVAL op AS _FLOAT)
        FUNCTION GetWindowHandle ()
        FUNCTION GetScreenWidth ()
        FUNCTION GetScreenHeight ()
        FUNCTION GetRenderWidth ()
        FUNCTION GetRenderHeight ()
        FUNCTION GetMonitorCount ()
        FUNCTION GetCurrentMonitor ()
        FUNCTION GetMonitorPosition (BYVAL mon AS INTEGER)
        FUNCTION GetMonitorWidth (BYVAL mon AS INTEGER)
        FUNCTION GetMonitorHeight (BYVAL mon AS INTEGER)
        FUNCTION GetMonitorPhysicalWidth (BYVAL mon AS INTEGER)
        FUNCTION GetMonitorPhysicalHeight (BYVAL mon AS INTEGER)
        FUNCTION GetMonitorRefreshRate (BYVAL mon AS INTEGER)
        FUNCTION GetWindowPosition ()
        FUNCTION GetWindowScaleDPI ()
        FUNCTION GetMonitorName (BYVAL mon AS INTEGER)
        SUB SetClipboardText (text AS STRING)
        FUNCTION GetClipboardText ()
        SUB EnableEventWaiting ()
        SUB DisableEventWaiting ()

        'Custom frame controls
        SUB SwapScreenBuffer ()
        SUB PollInputEvents ()
        SUB WaitTime (BYVAL secs AS DOUBLE)

        'Cursor Functions
        SUB ShowCursor ()
        SUB HideCursor ()
        FUNCTION IsCursorHidden ()
        SUB EnableCursor ()
        SUB DisableCursor ()
        FUNCTION IsCursorOnScreen ()

        'Drawing Functions
        SUB ClearBackground (BYVAL fCol AS _UNSIGNED LONG)
        SUB BeginDrawing ()
        SUB EndDrawing ()
        SUB BeginMode2D (BYVAL fcamera2d AS _OFFSET)
        SUB EndMode2D ()
        SUB BeginMode3D (BYVAL fcamera3d AS _OFFSET)
        SUB EndMode3D ()
        SUB BeginTextureMode (BYVAL ftexture AS _OFFSET)
        SUB EndTextureMode ()
        SUB BeginShaderMode (BYVAL fshader AS _OFFSET)
        SUB EndShaderMode ()
        SUB BeginBlendMode (BYVAL bl AS INTEGER)
        SUB EndBlendMode ()
        SUB BeginScissorMode (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB EndScissorMode ()
        SUB BeginVrStereoMode (BYVAL fVrStereoConfig AS _OFFSET)
        SUB EndVrStereoMode ()

        FUNCTION LoadVrStereoConfig (BYVAL fVrDeviceInfo AS _OFFSET)
        SUB UnloadVrStereoConfig (BYVAL fVrStereoConfig AS _OFFSET)

        'Shader functions
        FUNCTION LoadShader (vsfileName AS STRING, fsFileName AS STRING)
        FUNCTION LoadShaderFromMemory (vscCode AS STRING, fsCode AS STRING)
        FUNCTION GetShaderLocation (BYVAL fShader AS _OFFSET, uniName AS STRING)
        FUNCTION GetShaderLocationAttrib (BYVAL fShader AS _OFFSET, attriName AS STRING)
        SUB SetShaderValue (BYVAL fShader AS _OFFSET, BYVAL locIndex AS INTEGER, BYVAL xval AS _OFFSET, BYVAL unitype AS INTEGER)
        SUB SetShaderValueV (BYVAL fShader AS _OFFSET, BYVAL locIndex AS INTEGER, BYVAL xval AS _OFFSET, BYVAL uniType AS INTEGER, BYVAL count AS INTEGER)
        SUB SetShaderValueMatrix (BYVAL fShader AS _OFFSET, BYVAL locIndex AS INTEGER, BYVAL fMatrix AS _FLOAT)
        SUB SetShaderValueTexture (BYVAL fShader AS _OFFSET, BYVAL locIndex AS INTEGER, BYVAL fTexture AS _OFFSET)
        SUB UnloadShader (BYVAL fShader AS _OFFSET)

        'Screen Space Functions
        FUNCTION GetMouseRay (BYVAL fVector2 AS _FLOAT, BYVAL fCamera2D AS _OFFSET)
        FUNCTION GetCameraMatrix (BYVAL fCamera2D AS _OFFSET)
        FUNCTION GetCameraMatrix2D (BYVAL fCamera2D AS _OFFSET)
        FUNCTION GetWorldToScreen (BYVAL fVector3 AS _FLOAT, BYVAL fCamera2D AS _OFFSET)
        FUNCTION GetScreenToWorld2D (BYVAL fVector2 AS _FLOAT, BYVAL fCamera2D AS _OFFSET)
        FUNCTION GetWorldToScreenEx (BYVAL fVector3 AS _FLOAT, BYVAL fCamera2D AS _OFFSET, BYVAL w AS INTEGER, BYVAL h AS INTEGER)

        'Timing Functions
        SUB SetTargetFPS (BYVAL fps AS INTEGER)
        FUNCTION GetFPS ()
        FUNCTION GetFrameTime ()
        FUNCTION GetTime ()

        'Misc Functions
        FUNCTION GetRandomValue (BYVAL min AS INTEGER, BYVAL max AS INTEGER)
        SUB SetRandomSeed (BYVAL seed AS _UNSIGNED INTEGER)
        SUB TakeScreenshot (fileName AS STRING)
        SUB SetConfigFlags (BYVAL flags AS _UNSIGNED INTEGER)

        SUB TraceLog (BYVAL logLevel AS INTEGER, text AS STRING)
        SUB SetTraceLogLevel (BYVAL logLevel AS INTEGER)
        SUB MemAlloc (BYVAL size AS INTEGER)
        SUB MemRealloc (BYVAL ptr AS _OFFSET, BYVAL size AS INTEGER)
        SUB MemFree (BYVAL ptr AS _OFFSET)

        SUB OpenURL (url AS STRING)

        'Custom Callbacks
        'SUB SetTraceLogCallback (BYVAL cb AS _OFFSET)
        'SUB SetLoadFileDataCallback (BYVAL cb AS _OFFSET)
        'SUB SetSaveFileDataCallback (BYVAL cb AS _OFFSET)
        'SUB SetLoadFileTextCallback (BYVAL cb AS _OFFSET)
        'SUB SetSaveFileTextCallback (BYVAL cb AS _OFFSET)

        'File management Functions
        FUNCTION LoadFileData (fName AS STRING, BYVAL bytesRead AS _OFFSET)
        SUB UnloadFileData (BYVAL dat AS _OFFSET)
        FUNCTION SaveFileData (fName AS STRING, BYVAL dat AS _OFFSET, BYVAL bytesToWrite AS _UNSIGNED INTEGER)
        FUNCTION ExportDataAsCode (dat AS STRING, BYVAL size AS _UNSIGNED INTEGER, fName AS STRING)
        FUNCTION LoadFileText (fName AS STRING)
        SUB UnloadFileText (text AS STRING)
        FUNCTION SaveFileText (fName AS STRING, text AS STRING)
        FUNCTION FileExists (fName AS STRING)
        FUNCTION DirectoryExists (path AS STRING)
        FUNCTION IsFileExtension (fname AS STRING, ext AS STRING)
        FUNCTION GetFileLength (fName AS STRING)
        FUNCTION GetFileExtension (fName AS STRING)
        FUNCTION GetFileName (path AS STRING)
        FUNCTION GetFileNameWithoutExt (path AS STRING)
        FUNCTION GetDirectoryPath (path AS STRING)
        FUNCTION GetPrevDirectoryPath (path AS STRING)
        FUNCTION GetWorkingDirectory ()
        FUNCTION GetApplicationDirectory ()
        FUNCTION ChangeDirectory (d AS STRING)
        FUNCTION IsPathFile (path AS STRING)
        FUNCTION LoadDirectoryFiles (path AS STRING)
        FUNCTION LoadDirectoryFilesEx (path AS STRING, filt AS STRING, BYVAL scan AS INTEGER)
        SUB UnloadDirectoryFiles (BYVAL f AS _OFFSET)
        FUNCTION IsFileDropped ()
        FUNCTION LoadDroppedFiles ()
        SUB UnloadDroppedFiles (BYVAL f AS _OFFSET)
        FUNCTION GetFileModTime (fName AS STRING)

        'Compression/Encoding Functions
        FUNCTION CompressData (BYVAL dat AS _OFFSET, BYVAL dataSize AS _OFFSET)
        FUNCTION DecompressData (BYVAL dat AS _OFFSET, BYVAL dsize AS INTEGER, BYVAL ddsize AS _OFFSET)
        FUNCTION EncodeDataBase64 (BYVAL dat AS _OFFSET, BYVAL ds AS INTEGER, BYVAL osize AS _OFFSET)
        FUNCTION DecodeDataBase64 (BYVAL dat AS _OFFSET, BYVAL osize AS _OFFSET)

        'Input Functions
        FUNCTION IsKeyPressed (BYVAL k AS INTEGER)
        FUNCTION IsKeyDown (BYVAL k AS INTEGER)
        FUNCTION IsKeyReleased (BYVAL k AS INTEGER)
        FUNCTION IsKeyUp (BYVAL k AS INTEGER)
        SUB SetExitKey (BYVAL k AS INTEGER)
        FUNCTION GetKeyPressed ()
        FUNCTION GetCharPressed ()

        'Gamepad Functions
        FUNCTION IsGamepadAvailable (BYVAL gp AS INTEGER)
        FUNCTION GetGamepadName (BYVAL gp AS INTEGER)
        FUNCTION IsGamepadButtonPressed (BYVAL gp AS INTEGER, BYVAL btn AS INTEGER)
        FUNCTION IsGamepadButtonDown (BYVAL gp AS INTEGER, BYVAL btn AS INTEGER)
        FUNCTION IsGamepadButtonReleased (BYVAL gp AS INTEGER, BYVAL btn AS INTEGER)
        FUNCTION IsGamepadButtonUp (BYVAL gp AS INTEGER, BYVAL btn AS INTEGER)
        FUNCTION GetGamepadButtonPressed ()
        FUNCTION GetGamepadAxisCount (BYVAL gp AS INTEGER)
        FUNCTION GetGamepadAxisMovement (BYVAL gp AS INTEGER, BYVAL ax AS INTEGER)
        FUNCTION SetGamepadMappings (mappings AS STRING)

        'Mouse Functions
        FUNCTION IsMouseButtonPressed (BYVAL btn AS INTEGER)
        FUNCTION IsMouseButtonDown (BYVAL btn AS INTEGER)
        FUNCTION IsMouseButtonReleased (BYVAL btn AS INTEGER)
        FUNCTION IsMouseButtonUp (BYVAL btn AS INTEGER)
        FUNCTION GetMouseX ()
        FUNCTION GetMouseY ()
        FUNCTION GetMousePosition ()
        FUNCTION GetMouseDelta ()
        SUB SetMousePosition (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
        SUB SetMouseOffset (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
        SUB SetMouseScale (BYVAL x AS _FLOAT, BYVAL y AS _FLOAT)
        FUNCTION GetMouseWheelMove ()
        FUNCTION GetMouseWheelMoveV ()
        SUB SetMouseCursor (BYVAL cur AS INTEGER)

        'Touch Functions
        FUNCTION GetTouchX ()
        FUNCTION GetTouchY ()
        FUNCTION GetTouchPosition (BYVAL idx AS INTEGER)
        FUNCTION GetTouchPointId (BYVAL idx AS INTEGER)
        FUNCTION GetTouchPointCount ()

        'Gesture Functions
        SUB SetGesturesEnabled (BYVAL flags AS _UNSIGNED INTEGER)
        FUNCTION IsGestureDetected (BYVAL ges AS INTEGER)
        FUNCTION GetGestureDetected ()
        FUNCTION GetGestureHoldDuration ()
        FUNCTION GetGestureDragVector ()
        FUNCTION GetGestureDragAngle ()
        FUNCTION GetGesturePinchVector ()
        FUNCTION GetGesturePinchAngle ()

        'Camera Functions
        SUB SetCameraMode (BYVAL fCamera2D AS _OFFSET, BYVAL mode AS INTEGER)
        SUB UpdateCamera (BYVAL fCamera2D AS _OFFSET)

        SUB SetCameraPanControl (BYVAL k AS INTEGER)
        SUB SetCameraAltControl (BYVAL k AS INTEGER)
        SUB SetCameraSmoothZoomControl (BYVAL s AS INTEGER)
        SUB SetCameraMoveControls (BYVAL keyFront AS INTEGER, BYVAL keyBack AS INTEGER, BYVAL keyRight AS INTEGER, BYVAL keyLeft AS INTEGER, BYVAL keyUp AS INTEGER, BYVAL keyDown AS INTEGER)

        'Shape Functions
        SUB SetShapesTexture (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT)

        SUB DrawPixel (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPixelV (BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLine (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL ex AS INTEGER, BYVAL ey AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineV (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineEx (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineBezier (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineBezierQuad (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineBezierCubic (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawLineStrip (BYVAL fVector2 AS _OFFSET, BYVAL count AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircle (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL rad AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircleSector (BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL sa AS _FLOAT, BYVAL ea AS _FLOAT, BYVAL segments AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircleSectorLines (BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL sa AS _FLOAT, BYVAL ea AS _FLOAT, BYVAL segments AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircleGradient (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL rad AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircleV (BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircleLines (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL rad AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawEllipse (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL radH AS _FLOAT, BYVAL radV AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawEllipseLines (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL radH AS _FLOAT, BYVAL radV AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRing (BYVAL fVector2 AS _FLOAT, BYVAL inRad AS _FLOAT, BYVAL outRad AS _FLOAT, BYVAL sa AS _FLOAT, BYVAL ea AS _FLOAT, BYVAL segments AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRingLines (BYVAL fVector2 AS _FLOAT, BYVAL inRad AS _FLOAT, BYVAL outRad AS _FLOAT, BYVAL sa AS _FLOAT, BYVAL ea AS _FLOAT, BYVAL segments AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangle (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB DrawRectangleV (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleRec (BYVAL fRectangle AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectanglePro (BYVAL fRectangle AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleGradientV (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleGradientH (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleGradientEx (BYVAL fRectangle AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleLines (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleLinesEx (BYVAL fRectangle AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleRounded (BYVAL fRectangle AS _FLOAT, BYVAL round AS _FLOAT, BYVAL segments AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRectangleRoundedLines (BYVAL fRectangle AS _FLOAT, BYVAL round AS _FLOAT, BYVAL segments AS INTEGER, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangle (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangleLines (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangleFan (BYVAL fVector2 AS _OFFSET, BYVAL count AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangleStrip (BYVAL fVector2 AS _OFFSET, BYVAL count AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPoly (BYVAL fVector2 AS _FLOAT, BYVAL sides AS INTEGER, BYVAL rad AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPolyLines (BYVAL fVector2 AS _FLOAT, BYVAL sides AS INTEGER, BYVAL rad AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPolyLinesEx (BYVAL fVector2 AS _FLOAT, BYVAL sides AS INTEGER, BYVAL rad AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)

        'Shape Collision Detection
        FUNCTION CheckCollisionRecs (BYVAL fRectangle AS _FLOAT, BYVAL fRectangle AS _FLOAT)
        FUNCTION CheckCollisionCircles (BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rad2 AS _FLOAT)
        FUNCTION CheckCollisionCircleRec (BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fRectangle AS _FLOAT)
        FUNCTION CheckCollisionPointRec (BYVAL fVector2 AS _FLOAT, BYVAL fRectangle AS _FLOAT)
        FUNCTION CheckCollisionPointCircle (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rad AS _FLOAT)
        FUNCTION CheckCollisionPointTriangle (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT)
        FUNCTION CheckCollisionLines (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _OFFSET)
        FUNCTION CheckCollisionPointLine (BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL thres AS INTEGER)
        FUNCTION GetCollisionRec (BYVAL fRectangle AS _FLOAT, BYVAL fRectangle AS _FLOAT)

        'Image Loading Functions
        FUNCTION LoadImage (fName AS STRING)
        FUNCTION LoadImageRaw (fName AS STRING, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL format AS INTEGER, BYVAL size AS INTEGER)
        FUNCTION LoadImageAnim (fName AS STRING, BYVAL frames AS _OFFSET)
        FUNCTION LoadImageFromMemory (fType AS STRING, BYVAL xdat AS _OFFSET, BYVAL size AS INTEGER)
        FUNCTION LoadImageFromTexture (BYVAL fTexture AS _OFFSET)
        FUNCTION LoadImageFromScreen ()
        SUB UnloadImage (BYVAL fImage AS _OFFSET)
        FUNCTION ExportImage (BYVAL fImage AS _OFFSET, fName AS STRING)
        FUNCTION ExportImageAsCode (BYVAL fImage AS _OFFSET, fName AS STRING)

        FUNCTION GenImageColor (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GenImageGradientV (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GenImageGradientH (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GenImageGradientRadial (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL dens AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GenImageChecked (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GenImageWhiteNoise (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fac AS _FLOAT)
        FUNCTION GenImageCellular (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL size AS INTEGER)

        FUNCTION ImageCopy (BYVAL fImage AS _OFFSET)
        FUNCTION ImageFromImage (BYVAL fImage AS _OFFSET, BYVAL fRectangle AS _FLOAT)
        FUNCTION ImageText (text AS STRING, BYVAL size AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION ImageTextEx (BYVAL fFont AS _OFFSET, text AS STRING, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageFormat (BYVAL fImage AS _OFFSET, BYVAL nf AS INTEGER)
        SUB ImageToPOT (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageCrop (BYVAL fImage AS _OFFSET, BYVAL fRectangle AS _FLOAT)
        SUB ImageAlphaCrop (BYVAL fImage AS _OFFSET, BYVAL thres AS _FLOAT)
        SUB ImageAlphaClear (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG, BYVAL thres AS _FLOAT)
        SUB ImageAlphaMask (BYVAL fImage AS _OFFSET, BYVAL fImage AS _OFFSET)
        SUB ImageAlphaPremultiply (BYVAL fImage AS _OFFSET)
        SUB ImageResize (BYVAL fImage AS _OFFSET, BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB ImageResizeNN (BYVAL fImage AS _OFFSET, BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB ImageResizeCanvas (BYVAL fImage AS _OFFSET, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageMipmaps (BYVAL fImage AS _OFFSET)
        SUB ImageDither (BYVAL fImage AS _OFFSET, BYVAL r AS INTEGER, BYVAL g AS INTEGER, BYVAL b AS INTEGER, BYVAL a AS INTEGER)
        SUB ImageFlipVertical (BYVAL fImage AS _OFFSET)
        SUB ImageFlipHorizontal (BYVAL fImage AS _OFFSET)
        SUB ImageRotateCW (BYVAL fImage AS _OFFSET)
        SUB ImageRotateCCW (BYVAL fImage AS _OFFSET)
        SUB ImageColorTint (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageColorInvert (BYVAL fImage AS _OFFSET)
        SUB ImageColorGrayscale (BYVAL fImage AS _OFFSET)
        SUB ImageColorContrast (BYVAL fImage AS _OFFSET, BYVAL con AS _FLOAT)
        SUB ImageColorBrightness (BYVAL fImage AS _OFFSET, BYVAL bright AS INTEGER)
        SUB ImageColorReplace (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION LoadImageColors (BYVAL fImage AS _OFFSET)
        FUNCTION LoadImagePalette (BYVAL fImage AS _OFFSET, BYVAL size AS INTEGER, BYVAL count AS _OFFSET)
        SUB UnloadImageColors (BYVAL fColor AS _UNSIGNED LONG)
        SUB UnloadImagePalette (BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GetImageAlphaBorder (BYVAL fImage AS _OFFSET, BYVAL thres AS _FLOAT)
        FUNCTION GetImageColor (BYVAL fImage AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER)

        'Image Drawing Functions
        SUB ImageClearBackground (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawPixel (BYVAL fImage AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawPixelV (BYVAL fImage AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawLine (BYVAL fImage AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL ex AS INTEGER, BYVAL ey AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawLineV (BYVAL fImage AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawCircle (BYVAL fImage AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL rad AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawCircleV (BYVAL fImage AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL rad AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawRectangle (BYVAL fImage AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawRectangleV (BYVAL fImage AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawRectangleRec (BYVAL fImage AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawRectangleLines (BYVAL fImage AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL thick AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDraw (BYVAL fImage AS _OFFSET, BYVAL fImage AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fRectangle AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawText (BYVAL fImage AS _OFFSET, text AS STRING, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL size AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB ImageDrawTextEx (BYVAL fImage AS _OFFSET, text AS STRING, BYVAL fVector2 AS _FLOAT, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)

        'Texture Loading Functions
        FUNCTION LoadTexture (fName AS STRING)
        FUNCTION LoadTextureFromImage (BYVAL fImage AS _OFFSET)
        FUNCTION LoadTextureCubemap (BYVAL fImage AS _OFFSET, BYVAL lo AS INTEGER)
        FUNCTION LoadRenderTexture (BYVAL w AS INTEGER, BYVAL h AS INTEGER)
        SUB UnloadTexture (BYVAL fTexture AS _OFFSET)
        SUB UnloadRenderTexture (BYVAL fTExture AS _OFFSET)
        SUB UpdateTexture (BYVAL fTexture AS _OFFSET, BYVAL pix AS _OFFSET)
        SUB UpdateTextureRec (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL pix AS _OFFSET)

        'Texture Config
        SUB GenTextureMipmaps (BYVAL fTexture AS _OFFSET)
        SUB SetTextureFilter (BYVAL fTexture AS _OFFSET, BYVAL filt AS INTEGER)
        SUB SetTextureWrap (BYVAL fTexture AS _OFFSET, BYVAL wp AS INTEGER)

        'Texture Drawing
        SUB DrawTexture (BYVAL fTexture AS _OFFSET, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureV (BYVAL fTexture AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureEx (BYVAL fTexture AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL scale AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureRec (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureQuad (BYVAL fTexture AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fRectangle AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureTiled (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fRectangle AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL scale AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTexturePro (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fRectangle AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextureNPatch (BYVAL fTExture AS _OFFSET, BYVAL fNPatchInfo AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTexturePoly (BYVAL fTexture AS _OFFSET, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _OFFSET, BYVAL fVector2 AS _OFFSET, BYVAL count AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)

        'Color Functions
        FUNCTION Fade (BYVAL fColor AS _UNSIGNED LONG, BYVAL al AS _FLOAT)
        FUNCTION ColorToInt (BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION ColorNormalize (BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION ColorFromNormalized (BYVAL fVector4 AS _FLOAT)
        FUNCTION ColorToHSV (BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION ColorFromHSV (BYVAL hue AS _FLOAT, BYVAL sat AS _FLOAT, BYVAL xval AS _FLOAT)
        FUNCTION ColorAlpha (BYVAL fColor AS _UNSIGNED LONG, BYVAL al AS _FLOAT)
        FUNCTION ColorAlphaBlend (BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG, BYVAL fColor AS _UNSIGNED LONG)
        FUNCTION GetColor (BYVAL hexv AS _UNSIGNED INTEGER)
        FUNCTION GetPixelColor (BYVAL ptr AS _OFFSET, BYVAL mat AS INTEGER)
        SUB SetPixelColor (BYVAL ptr AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG, BYVAL mat AS INTEGER)
        FUNCTION GetPixelDataSize (BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL mat AS INTEGER)

        FUNCTION GetFontDefault ()
        FUNCTION LoadFont (fName AS STRING)
        FUNCTION LoadFontEx (fName AS STRING, size AS INTEGER, BYVAL fchar AS _OFFSET, BYVAL count AS INTEGER)
        FUNCTION LoadFontFromImage (BYVAL fImage AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG, BYVAL fchar AS INTEGER)
        FUNCTION LoadFontFromMemory (fType AS STRING, BYVAL fd AS _OFFSET, BYVAL size AS INTEGER, BYVAL fsize AS INTEGER, BYVAL fchars AS _OFFSET, BYVAL count AS INTEGER)
        FUNCTION LoadFontData (BYVAL fd AS _OFFSET, BYVAL size AS INTEGER, BYVAL fsize AS INTEGER, BYVAL fchars AS _OFFSET, BYVAL count AS INTEGER, BYVAL ftype AS INTEGER)
        FUNCTION GenImageFontAtlas (BYVAL fGlyphInfo AS _OFFSET, BYVAL fRectangle AS _OFFSET, BYVAL count AS INTEGER, BYVAL fsize AS INTEGER, BYVAL pad AS INTEGER, BYVAL pm AS INTEGER)
        SUB UnloadFontData (BYVAL fGlyphInfo AS _OFFSET, BYVAL count AS INTEGER)
        SUB UnloadFont (BYVAL fFont AS _OFFSET)
        FUNCTION ExportFontAsCode (BYVAL fFont AS _OFFSET, fName AS STRING)

        'Text Drawing
        SUB DrawFPS (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
        SUB DrawText (text AS STRING, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL size AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextEx (BYVAL fFont AS _OFFSET, text AS STRING, BYVAL fVector2 AS _FLOAT, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextPro (BYVAL fFont AS _OFFSET, text AS STRING, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextCodepoint (BYVAL fFont AS _OFFSET, BYVAL cp AS INTEGER, BYVAL fVector2 AS _FLOAT, BYVAL size AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTextCodepoints (BYVAL fFont AS _OFFSET, BYVAL cp AS _OFFSET, BYVAL count AS INTEGER, BYVAL fVector2 AS _FLOAT, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)

        'Text Info
        FUNCTION MeasureText (text AS STRING, BYVAL size AS INTEGER)
        FUNCTION MeasureTextEx (BYVAL fFont AS _OFFSET, text AS STRING, BYVAL size AS _FLOAT, BYVAL space AS _FLOAT)
        FUNCTION GetGlyphIndex (BYVAL fFont AS _OFFSET, BYVAL cp AS INTEGER)
        FUNCTION GetGlyphInfo (BYVAL fFont AS _OFFSET, BYVAL cp AS INTEGER)
        FUNCTION GetGlyphAtlasRec (BYVAL fFont AS _OFFSET, BYVAL cp AS INTEGER)

        'Text codepoints
        FUNCTION LoadCodepoints (text AS STRING, BYVAL count AS _OFFSET)
        SUB UnloadCodepoints (BYVAL cp AS _OFFSET)
        FUNCTION GetCodepointCount (text AS STRING)
        FUNCTION GetCodepoint (text AS STRING, BYVAL bp AS _OFFSET)
        FUNCTION CodepointToUTF8 (BYVAL cp AS INTEGER, BYVAL bs AS _OFFSET)
        FUNCTION TextCodepointsToUTF8 (BYVAL cp AS _OFFSET, BYVAL xlen AS INTEGER)

        'Text strings
        FUNCTION TextCopy (dst AS STRING, src AS STRING)
        FUNCTION TextIsEqual (text AS STRING, text2 AS STRING)
        FUNCTION TextLength (text AS STRING)
        FUNCTION TextFormat (text AS STRING)
        FUNCTION TextSubtext (text AS STRING, BYVAL xpos AS INTEGER, BYVAL xlen AS INTEGER)
        FUNCTION TextReplace (text AS STRING, rep AS STRING, b AS STRING)
        FUNCTION TextInsert (text AS STRING, in AS STRING, BYVAL xpos AS INTEGER)
        FUNCTION TextJoin (text AS STRING, BYVAL count AS INTEGER, del AS STRING)
        FUNCTION TextSplit (text AS STRING, del AS STRING, BYVAL count AS _OFFSET)
        SUB TextAppend (text AS STRING, f AS STRING)
        FUNCTION TextFindIndex (text AS STRING, f AS STRING)
        FUNCTION TextToUpper (text AS STRING)
        FUNCTION TextToLower (text AS STRING)
        FUNCTION TextToPascal (text AS STRING)
        FUNCTION TextToInteger (text AS STRING)

        'Basic 3D shapes
        SUB DrawLine3D (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPoint3D (BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCircle3D (BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL rotAng AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangle3D (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawTriangleStrip3D (BYVAL fVector3 AS _OFFSET, BYVAL count AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCube (BYVAL fVector3 AS _FLOAT, BYVAL w AS INTEGER, BYVAL h AS INTEGER, BYVAL xlen AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCubeV (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCubeWires (BYVAL fVector3 AS _FLOAT, BYVAL w AS _FLOAT, BYVAL h AS _FLOAT, BYVAL xlen AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCubeWiresV (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCubeTexture (BYVAL fTexture AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL w AS _FLOAT, BYVAL h AS _FLOAT, BYVAL xlen AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCubeTextureRec (BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL w AS _FLOAT, BYVAL h AS _FLOAT, BYVAL xlen AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawSphere (BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawSphereEx (BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL rings AS INTEGER, BYVAL slices AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawSphereWires (BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL rings AS INTEGER, BYVAL slices AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCylinder (BYVAL fVector3 AS _FLOAT, BYVAL radTop AS _FLOAT, BYVAL radBot AS _FLOAT, BYVAL h AS _FLOAT, BYVAL slices AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCylinderEx (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL sr AS _FLOAT, BYVAL er AS _FLOAT, BYVAL sides AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCylinderWires (BYVAL fVector3 AS _FLOAT, BYVAL radTop AS _FLOAT, BYVAL radBot AS _FLOAT, byvalh AS _FLOAT, BYVAL slices AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawCylinderWiresEx (BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL sr AS _FLOAT, BYVAL er AS _FLOAT, BYVAL sides AS INTEGER, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawPlane (BYVAL fVector3 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawRay (BYVAL fRay AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawGrid (BYVAL slices AS INTEGER, BYVAL space AS _FLOAT)

        'Model management
        FUNCTION LoadModel (fName AS STRING)
        FUNCTION LoadModelFromMesh (BYVAL fMesh AS _OFFSET)
        SUB UnloadModel (BYVAL fModel AS _OFFSET)
        SUB UnloadModelKeepMeshes (BYVAL fModel AS _OFFSET)
        FUNCTION GetModelBoundingBox (BYVAL fModel AS _OFFSET)

        'Model Drawing
        SUB DrawModel (BYVAL fModel AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL scale AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawModelEx (BYVAL fModel AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL rotAngle AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawModelWires (BYVAL fModel AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL scale AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawModelWiresEx (BYVAL fModel AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL rotAngle AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawBoundingBox (BYVAL fBoundingBox AS _OFFSET, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawBillboard (BYVAL fCamera3D AS _OFFSET, BYVAL fTexture AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL size AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawBillboardRec (BYVAL fCamera3D AS _OFFSET, fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)
        SUB DrawBillboardPro (BYVAL fCamera3D AS _OFFSET, BYVAL fTexture AS _OFFSET, BYVAL fRectangle AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL fVector2 AS _FLOAT, BYVAL rot AS _FLOAT, BYVAL fColor AS _UNSIGNED LONG)

        'Mesh Functions
        SUB UploadMesh (BYVAL fMesh AS _OFFSET, BYVAL dyn AS INTEGER)
        SUB UpdateMeshBuffer (BYVAL fMesh AS _OFFSET, BYVAL idx AS INTEGER, BYVAL dat AS _OFFSET, BYVAL size AS INTEGER, BYVAL of AS INTEGER)
        SUB UnloadMesh (BYVAL fMesh AS _OFFSET)
        SUB DrawMesh (BYVAL fMesh AS _OFFSET, BYVAL fMaterial AS _OFFSET, BYVAL fMatrix AS _FLOAT)
        SUB DrawMeshInstanced (BYVAL fMesh AS _OFFSET, BYVAL fMaterial AS _OFFSET, BYVAL fMatrix AS _OFFSET, BYVAL inst AS INTEGER)
        FUNCTION ExportMesh (BYVAL fMesh AS _OFFSET, fName AS STRING)
        FUNCTION GetMeshBoundingBox (BYVAL fMesh AS _OFFSET)
        SUB GenMeshTangents (BYVAL fMesh AS _OFFSET)

        'Mesh Functions
        FUNCTION GenMeshPoly (BYVAL sides AS INTEGER, BYVAL rad AS _FLOAT)
        FUNCTION GenMeshPlane (BYVAL w AS _FLOAT, BYVAL l AS _FLOAT, BYVAL x AS INTEGER, BYVAL z AS INTEGER)
        FUNCTION GenMeshCube (BYVAL w AS _FLOAT, BYVAL h AS _FLOAT, BYVAL l AS _FLOAT)
        FUNCTION GenMeshSphere (BYVAL rad AS _FLOAT, BYVAL rings AS INTEGER, BYVAL slices AS INTEGER)
        FUNCTION GenMeshHemiSphere (BYVAL rad AS _FLOAT, BYVAL rings AS INTEGER, BYVAL slices AS INTEGER)
        FUNCTION GenMeshCylinder (BYVAL rad AS _FLOAT, BYVAL h AS _FLOAT, BYVAL slices AS INTEGER)
        FUNCTION GenMeshCone (BYVAL rad AS _FLOAT, BYVAL h AS _FLOAT, BYVAL slices AS INTEGER)
        FUNCTION GenMeshTorus (BYVAL rad AS _FLOAT, BYVAL size AS _FLOAT, BYVAL radSeg AS INTEGER, BYVAL sides AS INTEGER)
        FUNCTION GenMeshKnot (BYVAL rad AS _FLOAT, BYVAL size AS _FLOAT, BYVAL radSeg AS INTEGER, BYVAL sides AS INTEGER)
        FUNCTION GenMeshHeightmap (BYVAL fImage AS _OFFSET, BYVAL fVector3 AS _FLOAT)
        FUNCTION GenMeshCubicmap (BYVAL fImage AS _OFFSET, BYVAL fVector3 AS _FLOAT)

        'Material Loading
        FUNCTION LoadMaterials (fName AS STRING, BYVAL count AS _OFFSET)
        FUNCTION LoadMaterialDefault ()
        SUB UnloadMaterial (BYVAL fMaterial AS _OFFSET)
        SUB SetMaterialTexture (BYVAL fMaterial AS _OFFSET, BYVAL mt AS INTEGER, BYVAL fTexture AS _OFFSET)
        SUB SetModelMeshMaterial (BYVAL fModel AS _OFFSET, BYVAL id AS INTEGER, BYVAL mid AS INTEGER)

        'Model animations
        FUNCTION LoadModelAnimations (fName AS STRING, count AS _OFFSET)
        SUB UpdateModelAnimation (BYVAL fModel AS _OFFSET, BYVAL fModelAnimation AS _OFFSET, BYVAL frame AS INTEGER)
        SUB UnloadModelAnimation (BYVAL fModelAnimation AS _OFFSET)
        SUB UnloadModelAnimations (BYVAL fModelAnimation AS _OFFSET, BYVAL count AS _UNSIGNED INTEGER)
        FUNCTION IsModelAnimationValid (BYVAL fModel AS _OFFSET, BYVAL fModelAnimation AS _OFFSET)

        'Collision Detection
        FUNCTION CheckCollisionSpheres (BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL rad2 AS _FLOAT)
        FUNCTION CheckCollisionBoxes (BYVAL fBoundingBox AS _OFFSET, BYVAL fBoundingBox AS _OFFSET)
        FUNCTION CheckCollisionBoxSphere (BYVAL fBoundingBox AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT)
        FUNCTION GetRayCollisionSphere (BYVAL fRay AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL rad AS _FLOAT)
        FUNCTION GetRayCollisionBox (BYVAL fRay AS _OFFSET, BYVAL fBoundingBox AS _OFFSET)
        FUNCTION GetRayCollisionMesh (BYVAL fRay AS _OFFSET, BYVAL fMesh AS _OFFSET, BYVAL fMatrix AS _FLOAT)
        FUNCTION GetRayCollisionTriangle (BYVAL fRay AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT)
        FUNCTION GetRayCollisionQuad (BYVAL fRay AS _OFFSET, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT, BYVAL fVector3 AS _FLOAT)

        'Audio Functions
        SUB InitAudioDevice ()
        SUB CloseAudioDevice ()
        FUNCTION IsAudioDeviceReady ()
        SUB SetMasterVolume (BYVAL vol AS _FLOAT)

        'Wave Functions
        FUNCTION LoadWave (fName AS STRING)
        FUNCTION LoadWaveFromMemory (fType AS STRING, fd AS _OFFSET, BYVAL size AS INTEGER)
        FUNCTION LoadSound (fName AS STRING)
        FUNCTION LoadSoundFromWave (BYVAL fWave AS _OFFSET)
        SUB UpdateSound (BYVAL fSound AS _OFFSET, BYVAL d AS _OFFSET, BYVAL count AS INTEGER)
        SUB UnloadWave (BYVAL fWave AS _OFFSET)
        SUB UnloadSound (BYVAL fSound AS _OFFSET)
        FUNCTION ExportWave (BYVAL fWave AS _OFFSET, fName AS STRING)
        FUNCTION ExportWaveAsCode (BYVAL fWave AS _OFFSET, fName AS STRING)

        'Sound Play
        SUB PlaySound (BYVAL fSound AS _OFFSET)
        SUB StopSound (BYVAL fSound AS _OFFSET)
        SUB PauseSound (BYVAL fSound AS _OFFSET)
        SUB ResumeSound (BYVAL fSound AS _OFFSET)
        SUB PlaySoundMulti (BYVAL fSound AS _OFFSET)
        SUB StopSoundMulti ()
        FUNCTION GetSoundsPlaying ()
        FUNCTION IsSoundPlaying (BYVAL fSound AS _OFFSET)
        SUB SetSoundVolume (BYVAL fSound AS _OFFSET, BYVAL vol AS _FLOAT)
        SUB SetSoundPitch (BYVAL fSound AS _OFFSET, BYVAL pit AS _FLOAT)
        SUB SetSoundPan (BYVAL fSound AS _OFFSET, BYVAL pan AS _FLOAT)
        FUNCTION WaveCopy (BYVAL fWave AS _OFFSET)
        SUB WaveCrop (BYVAL fWave AS _OFFSET, BYVAL ins AS INTEGER, BYVAL fs AS INTEGER)
        SUB WaveFormat (BYVAL fWave AS _OFFSET, BYVAL sr AS INTEGER, BYVAL ss AS INTEGER, BYVAL chan AS INTEGER)
        FUNCTION LoadWaveSamples (BYVAL fWave AS _OFFSET)
        SUB UnloadWaveSamples (BYVAL samp AS _OFFSET)

        'Music
        FUNCTION LoadMusicStream (fName AS STRING)
        FUNCTION LoadMusicStreamFromMemory (fType AS STRING, d AS _OFFSET, BYVAL size AS INTEGER)
        SUB UnloadMusicStream (BYVAL fMusic AS _OFFSET)
        SUB PlayMusicStream (BYVAL fMusic AS _OFFSET)
        FUNCTION IsMusicStreamPlaying (BYVAL fMusic AS _OFFSET)
        SUB UpdateMusicStream (BYVAL fMusic AS _OFFSET)
        SUB StopMusicStream (BYVAL fMusic AS _OFFSET)
        SUB PauseMusicStream (BYVAL fMusic AS _OFFSET)
        SUB ResumeMusicStream (BYVAL fMusic AS _OFFSET)
        SUB SeekMusicStream (BYVAL fMusic AS _OFFSET, BYVAL po AS _FLOAT)
        SUB SetMusicVolume (BYVAL fMusic AS _OFFSET, BYVAL vol AS _FLOAT)
        SUB SetMusicPitch (BYVAL fMusic AS _OFFSET, BYVAL pit AS _FLOAT)
        SUB SetMusicPan (BYVAL fMusic AS _OFFSET, BYVAL pan AS _FLOAT)
        FUNCTION GetMusicTimeLength (BYVAL fMusic AS _OFFSET)
        FUNCTION GetMusicTimePlayed (BYVAL fMusic AS _OFFSET)

        'Audiostream
        FUNCTION LoadAudioStream (BYVAL sr AS _UNSIGNED INTEGER, BYVAL ss AS _UNSIGNED INTEGER, BYVAL chan AS _UNSIGNED INTEGER)
        SUB UnloadAudioStream (BYVAL fAudioStream AS _OFFSET)
        SUB UpdateAudioStream (BYVAL fAudioStream AS _OFFSET)
        FUNCTION IsAudioStreamProcessed (BYVAL fAudioStream AS _OFFSET)
        SUB PlayAudioStream (BYVAL fAudioStream AS _OFFSET)
        SUB PauseAudioStream (BYVAL fAudioStream AS _OFFSET)
        SUB ResumeAudioStream (BYVAL fAudioStream AS _OFFSET)
        FUNCTION IsAudioStreamPlaying (BYVAL fAudioStream AS _OFFSET)
        SUB StopAudioStream (BYVAL fAudioStream AS _OFFSET)
        SUB SetAudioStreamVolume (BYVAL fAudioStream AS _OFFSET, BYVAL vol AS _FLOAT)
        SUB SetAudioStreamPitch (BYVAL fAudioStream AS _OFFSET, BYVAL pit AS _FLOAT)
        SUB SetAudioStreamPan (BYVAL fAudioStream AS _OFFSET, BYVAL pan AS _FLOAT)
        SUB SetAudioStreamBufferSizeDefault (BYVAL size AS INTEGER)
        SUB SetAudioStreamCallback (BYVAL fAudioStream AS _OFFSET, BYVAL cb AS _OFFSET)

        SUB AttachAudioStreamProcessor (BYVAL fAudioStream AS _OFFSET, BYVAL cb AS _OFFSET)
        SUB DetachAudioStreamProcessor (BYVAL fAudioStream AS _OFFSET, BYVAL cb AS _OFFSET)

    $END IF
END DECLARE
