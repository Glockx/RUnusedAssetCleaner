# RUnusedAssetClenaer

An Experimental Library To Clear Image Assets Used By R.Library 🛃

### Be aware: This is a experimental project yet, not fully tested. Using the library is your own responsibility.

## Features

- Find Unused Image Asset Recursively with [ripgrep](https://link-url-here.org)
  - ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files.
- Save Search Result As JSON File To The Desktop (Enabled By Default): -s
- Delete Unused Image Assets: -d
- Show Total Size Of The Unused Assets.

## Command Reference

#### Delete Unused Assets:

- `-d`: Delete Unused Image Assets From Project Permentantly.

#### Save Result:

- `-s`: Save Search Result As JSON File To The Desktop.
  (Enabled By Default)

## Run Locally

Clone the project

```bash
  git clone https://github.com/Glockx/RUnusedAssetCleaner
```

Go to the project directory

```bash
  cd RUnusedAssetCleaner
```

Install depedencies:
[Instruction (MacOS, Linux)](https://github.com/BurntSushi/ripgrep#installation)

```bash
  Install ripgrep
```

Open

```bash
  AssetCleaner.xcworkspace
```

Build Project

```bash
Run or Archive on Xcode
```

Execution

```bash
- Copy Executable to the Project Folder
- ./AssetCleaner -Arguments
```

## License

[GPL3](https://www.gnu.org/licenses/gpl-3.0.en.html)
