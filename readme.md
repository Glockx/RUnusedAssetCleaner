# RUnusedAssetCleaner

An Experimental Library To Find Or Clear Unused Image Assets Used By [R.Swift](https://github.com/mac-cain13/R.swift) 🛃

### Be aware: This is a experimental project yet, not fully tested. Using the library is your own responsibility.

## Features

- Find Unused Image Asset Recursively with [ripgrep](https://github.com/BurntSushi/ripgrep)

- ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files,

- Save Search Result As JSON File To The Desktop (Enabled By Default),

- Delete Unused Image Assets,

- Show Total Size Of The Unused Assets.

## Command Reference

| Command                   | Description                                           |
| :------------------------ | :---------------------------------------------------- |
| `-d`                      | Delete Unused Image Assets From Project Permentantly. |
| `-s` (Enabled By Default) | Save Search Result As JSON File To The Desktop.       |

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

- ./AssetCleaner [Arguments...]

```

## License

[GPL3](https://www.gnu.org/licenses/gpl-3.0.en.html)
