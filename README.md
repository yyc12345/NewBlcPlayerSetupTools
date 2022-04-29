# BallanceSetupTools / Ballance 安装工具

Fully install any (custom) version of Ballance without using installers. / 脱离安装包完整安装任何 (自定义) 的 Ballance 版本。

## Usage Notes / 使用说明

### Installation / 安装

Run `install_ballance.bat` in Command Prompt (CMD) as administrator. / 以管理员身份在命令提示符 (CMD) 中运行 `install_ballance.bat`。

### Uninstallation / 卸载

Run `uninstall.bat` as administrator. / 以管理员身份运行 `uninstall.bat`。

## How it works

This batch file runs by automatically decompressing and copying all files in the `Ballance.zip` archive to the current directoruy, setting up required registry values, and finally creating shortcuts to both `Startup.exe` and `Player.exe` on the desktop.

## Creating your own custom version of Ballance

Just put all your Ballance files in the `Ballance_Files` directory and create a ZIP archive named `Ballance.zip` for the contents of this directory (don't include the directory itself though). Be sure to remove `INSTALL.log`, `UNWISE.exe`, `errorPlayer.csv`, `LogPlayer.csv` at first since they are not actually required by Ballance, but may in turn leak out your own settings. You may also want to replace `Database.tdb` with the default one (but do not delete it!).

For Simplified Chinese language switch support, put the necessary files under `Ballance_Files\Languages\cn\`.

The `switch_simplified_chinese.bat` file shall **not** be included if one does not wish to support switching languages.
