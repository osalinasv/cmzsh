# cmzsh

A Cmder/ConEmu addon that replicates OhMyZsh's robbyrussell theme

## Installation

Clone the repo:

```cmd
git clone https://github.com/osalinasv/cmzsh.git
```

Run the `install.ps1` script over your Cmder/ConEmu `config` directory:

```cmd
cd cmzsh
powershell .\install.ps1 C:\cmder\config
```

This will create symlinks between all `*.lua` files in the downloaded repo and the target `config` directory. i.e:

```
Directory: C:\cmder\config

Mode            LastWriteTime    Length Name
----            -------------    ------ ----
-a---l   06/01/2019   6:08 PM         0 cmzsh_0_config.lua
-a---l   06/01/2019   6:08 PM         0 cmzsh_1_colors.lua
-a---l   06/01/2019   6:08 PM         0 cmzsh_2_core.lua
-a---l   06/01/2019   6:08 PM         0 cmzsh_3_prompt.lua
-a---l   06/01/2019   6:08 PM         0 cmzsh_4_opt_git.lua
-a---l   06/01/2019   6:08 PM         0 cmzsh_5_opt_npm.lua
```

### Manual installation

You can always just copy and paste the files in the `config` directory. Or if you prefer, you can create the symlinks yourself, i.e:

```cmd
cd C:\cmder\config

mklink /H cmzsh_0_config.lua <path_to_repo>/cmzsh_0_config.lua
mklink /H cmzsh_1_colors.lua <path_to_repo>/cmzsh_1_colors.lua
mklink /H cmzsh_2_core.lua   <path_to_repo>/cmzsh_2_core.lua
mklink /H cmzsh_3_prompt.lua <path_to_repo>/cmzsh_3_prompt.lua
```

To create symlinks between different drives use PowerShell:

```ps
cd C:\cmder\config

New-Item -Path 'cmzsh_4_opt_git.lua' -ItemType SymbolicLink -Value '<path_to_repo>\cmzsh_4_opt_git.lua'
```

## To-do List

- [x] Add Git segment module
- [x] Add NPM segment module
- [ ] Add Virtualenv segment module
- [x] Create installation scripts
- [ ] Add preview images to this README

## Author

- **Omar Salinas** - [osalinasv](https://github.com/osalinasv)

See also the list of [contributors](https://github.com/osalinasv/cmzsh/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
