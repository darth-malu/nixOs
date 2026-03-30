''
  (

keybinds: (

global: {
  ":":       CommandMode,
  ",":       VolumeDown,
  "s":       Stop,
  ".":       VolumeUp,
  "<Tab>":   NextTab,
  "<S-Tab>": PreviousTab,
  "1":       SwitchToTab("Playing"),
  "4":       SwitchToTab("Dir"),
  "3":       SwitchToTab("Lists"),
  "2":       SwitchToTab("Find"),
  "q":       Quit,
  ">":       NextTrack,
  "p":       TogglePause,
  "<":       PreviousTrack,
  "f":       SeekForward,
  "z":       ToggleRepeat,
  "x":       ToggleRandom,
  "c":       ToggleConsume,
  "v":       ToggleSingle,
  "b":       SeekBack,
  "~":       ShowHelp,
  "I":       ShowCurrentSongInfo,
  "O":       ShowOutputs,
  "P":       ShowDecoders,
},

navigation: {
  "k":         Up,
  "j":         Down,
  "h":         Left,
  "l":         Right,
  "<Up>":      Up,
  "<Down>":    Down,
  "<Left>":    Left,
  "<Right>":   Right,
  "<C-k>":     PaneUp,
  "<C-j>":     PaneDown,
  "<C-h>":     PaneLeft,
  "<C-l>":     PaneRight,
  "<C-u>":     UpHalf,
  "N":         PreviousResult,
  "a":         Add,
  "A":         AddAll,
  "r":         Rename,
  "n":         NextResult,
  "g":         Top,
  "<Space>":   Select,
  "<C-Space>": InvertSelection,
  "G":         Bottom,
  "<CR>":      Confirm,
  "i":         FocusInput,
  "J":         MoveDown,
  "<C-d>":     DownHalf,
  "/":         EnterSearch,
  "<C-c>":     Close,
  "<Esc>":     Close,
  "K":         MoveUp,
  "D":         Delete,
},

queue: {
  "D":       DeleteAll,
  "<CR>":    Play,
  "<C-s>":   Save,
  "a":       AddToPlaylist,
  "d":       Delete,
  "i":       ShowInfo,
  "C":       JumpToCurrent,
},

),

  address: "127.0.0.1:6600",
  password: None,
  theme: None,
  cache_dir: "~/Music/rmpc/cache",
  lyrics_dir: "~/Music/rmpc/lyrics",
  on_song_change: "qs ipc call mpris songArt",
  volume_step: 5,
  scrolloff: 5,
  wrap_navigation: true,
  enable_mouse: true,
  enable_config_hot_reload: true,
  status_update_interval_ms: 1000,
  select_current_song_on_change: false,
  browser_song_sort: [Disc, Track, Artist, Title],

  progressbar_look: `["[", "─", "⊙", "┄", "]"],

  select_current_song_on_change: false,

  max_fps: 30,

cava: (
  framerate: 60, // default 60
    autosens: true, // default true
      sensitivity: 100, // default 100
        lower_cutoff_freq: 50, // not passed to cava if not provided
          higher_cutoff_freq: 10000, // not passed to cava if not provided
            input: (
              method: Fifo,
                source: "/tmp/mpd.fifo",
                sample_rate: 44100,
                channels: 2,
                sample_bits: 16,
            ),
            smoothing: (
              noise_reduction: 77, // default 77
                monstercat: false, // default false
                  waves: false, // default false
            ),
            // this is a list of floating point numbers thats directly passed to cava
            // they are passed in order that they are defined
            eq: []
),

layout: Split(
  direction: Vertical,
    panes: [
      (
        size: "8",
        pane: Split(
          direction: Horizontal,
            panes: [
              (
                size: "21",
                pane: Pane(AlbumArt),
              ),
              (
                size: "100%",
                pane: Split(
                  direction: Vertical,
                    panes: [
                      (
                        size: "5",
                        pane: Pane(Header),
                      ),
                      (
                        size: "1",
                        pane: Pane(ProgressBar),
                      ),
                      (
                        size: "2",
                        pane: Pane(Tabs),
                      ),
                    ]
                )
              ),
            ]
        ),
      ),
      (
        size: "100%",
        pane: Pane(TabContent),
      ),
    ],
),

)''
