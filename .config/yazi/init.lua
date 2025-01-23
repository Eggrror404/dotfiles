require("git"):setup()
require("starship"):setup()

-- bunny.yazi for bookmarks
local home = os.getenv("HOME")
require("bunny"):setup({
  hops = {
    { tag = "home", path = home, key = "h" },
    { tag = "config", path = home.."/.config", key = "c" },
    { tag = "app data", path = home.."/.local/share", key = "l" },
    { tag = "downloads", path = home.."/Downloads", key = "d" },
    { tag = "documents", path = home.."/Documents", key = "D" },
    { tag = "music", path = home.."/Music", key = "m" },
    { tag = "data drive", path = "/data", key = "t" },
  },
})
