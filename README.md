# Arjuna Browser

**A design experiment exploring what a power-user browser should feel like.**

Arjuna is a Firefox 149.0.2 fork built as a personal vision for browser UX — not a production browser. It was created to explore ideas around workspaces, dual sidebars, auto-hiding UI, and a distraction-free browsing experience. This is the final release.

![Arjuna](arjuna_logo.png)

## What's Different

Arjuna takes Firefox 149 and rethinks the interface:

- **Workspaces** — Built on top of Firefox containers. Each workspace is a container with its own tabs, tab groups, and state. Switch workspaces from the sidebar. New tabs auto-open in the active workspace.
- **Dual Sidebars** — Left sidebar for workspace switching. Right sidebar (inspired by Floorp) for bookmarks, history, downloads, synced tabs, extensions, and web panels with drag-and-drop reorder.
- **Auto-hide Overlay UI** — Toolbar and both sidebars collapse away when not in use. 6px trigger strips at window edges bring them back. The content area is always full-width.
- **Vertical Tabs Only** — Forced vertical tabs with no toggle. This is how it should be.
- **Zero Clutter** — Removed: Sponsored shortcuts, Firefox Labs, "More from Mozilla", Browser Layout settings, "Support Firefox" links, Recent Activity.
- **No Sponsored Content** — All sponsored content disabled at the branding level.
- **Full Extension Compatibility** — UA string reports as Firefox so AMO and all extensions work normally.
- **Custom Branding** — Arjuna logo, wordmark, About dialog, and application name throughout.

## This Is Not a Real Browser

Arjuna is a design statement, not a maintained project. It exists to show what a browser *could* be if designed for people who live in their browser. There are known bugs, no automatic updates, and no security patches beyond what Firefox 149.0.2 shipped with.

**Do not use this as your daily browser.**

If you like these ideas, advocate for them in Firefox, Floorp, Zen, or whatever browser you use.

## Install (AppImage)

Download the AppImage from the [Releases](https://github.com/ArjunKdaf/Arjuna/releases) page.

```bash
chmod +x Arjuna-149.0.2-x86_64.AppImage
./Arjuna-149.0.2-x86_64.AppImage
```

Works on any x86_64 Linux distribution.

## Build from Source

Arjuna is a set of patches applied to a clean Firefox 149.0.2 source tree.

### Requirements

- NixOS (or any Linux with the equivalent dependencies)
- ~16GB RAM, ~40GB disk space
- Patience (~77 minutes for a full build on 2 cores)

### Steps

```bash
# 1. Get Firefox 149.0.2 source
wget https://archive.mozilla.org/pub/firefox/releases/149.0.2/source/firefox-149.0.2.source.tar.xz
tar xf firefox-149.0.2.source.tar.xz
mv firefox-149.0.2 sources/firefox

# 2. Apply the patch
cd sources/firefox
patch -p1 < ../../patches/arjuna-full.patch

# 3. Copy the build config
cp ../../mozconfig .

# 4. Enter the build environment and build
cd ../..
nix-shell shell.nix
cd sources/firefox
./mach build

# 5. Run
./mach run
```

The `mozconfig` hardcodes a NixOS libclang path. If you're on a different distro, update the `--with-libclang-path` line to point to your system's `libclang.so` directory.

### Patch Breakdown

| Patch | What it does |
|-------|-------------|
| `01-branding.patch` | Logo, icons, app name, About dialog |
| `02-home-settings.patch` | Settings UI cleanup, sponsored content removal |
| `03-sidebar-secondary.patch` | Right sidebar with web panels, bookmarks, history |
| `04-toolbar-fixes.patch` | Auto-hide overlay system for all bars |
| `05-background-image.patch` | Custom background image |
| `arjuna-full.patch` | All of the above combined into one patch |
| `arjuna-nixos.patch` | NixOS-specific build fixes |

## Credits

Arjuna is built on the work of others:

- [Mozilla Firefox](https://www.mozilla.org/firefox/) — The foundation. MPL 2.0.
- [Floorp Browser](https://github.com/AkariNext/nicefox) — Right sidebar design inspiration. Code ported and rewritten.
- Built by [Arjun](https://github.com/ArjunKdaf) with [Claude Code](https://claude.ai/claude-code).

## License

MPL 2.0, same as Firefox.
