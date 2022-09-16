# RUnusedAssetClenaer

An Experimental Library To Clear Image Assets Used By R.Library 🛃

## Features

- Find Unused Image Asset Recursively with [ripgrep](https://link-url-here.org)
  - ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files.
- Save Search Result As JSON File To The Desktop (Enabled By Default): -s
- Delete Unused Image Assets: -d
- Show Total Size Of The Unused Assets.

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
