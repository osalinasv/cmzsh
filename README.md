# cmzsh

A Cmder/ConEmu addon that replicates OhMyZsh's robbyrussell theme

## Installation

Clone the repo:

```
git clone https://github.com/osalinasv/cmzsh.git <dirname>
```

Create a symlink between the .lua files in `<dirname>` and your Cmder/ConEmu `config` directory:

```
cd %CMDER_ROOT%/config

mklink /H cmzsh_0_config.lua <dirname>/cmzsh_0_config.lua
mklink /H cmzsh_1_colors.lua <dirname>/cmzsh_1_colors.lua
mklink /H cmzsh_2_core.lua   <dirname>/cmzsh_2_core.lua
mklink /H cmzsh_3_prompt.lua <dirname>/cmzsh_3_prompt.lua
```

The numbers in the filenames represent the load order of the addons.

Follow the same steps to intall any of the Optional segments for the prompt (i.e: git).
Optional segments are annotated with an `(op)` in the filename:

```
mklink /H cmzsh_4_git(op).lua <dirname>/cmzsh_4_git(op).lua
```

To create symlinks between different drives use PowerShell (remember to open as Admin if your Cmder/ConEmu directory is under `C:\`):

```
new-item -path 'cmzsh_4_git(op).lua' -itemtype symboliclink -value '<dirname>\cmzsh_4_git(op).lua'
```

## To-do List

- [x] Add Git segment module
- [x] Add NPM segment module
- [ ] Add Virtualenv segment module
- [ ] Create installation/updating scripts
- [ ] Add preview images to this README

## Author

- **Omar Salinas** - [osalinasv](https://github.com/osalinasv)

See also the list of [contributors](https://github.com/osalinasv/cmzsh/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
