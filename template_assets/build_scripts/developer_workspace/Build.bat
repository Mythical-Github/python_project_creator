
cd %~dp0

set "SCRIPT_DIR=%CD%"

set "ProjectName=default_name"

set "SRC_DIR=%CD%\..\..\src\%ProjectName%"

@REM src_dir = f'{os.path.dirname(os.path.dirname(SCRIPT_DIR))}/src/unreal_auto_mod'

@REM base_path = Path(src_dir)
@REM files_to_include = [
@REM     base_path / "json/cli.json",
@REM     base_path / "json/log_colors.json",
@REM     base_path / "utilities.py"

@REM pyinstaller_cmd = [
@REM     'pyinstaller',
@REM     '--collect-data grapheme',
@REM     '--collect-submodules "psutil"',
@REM     '--collect-submodules "win_man_py"',
@REM     '--noconfirm',
@REM     '--onefile',
@REM     '--console',
@REM     f"--icon={base_path.parent.parent / 'assets/images/UnrealAutoModIcon.ico'}"
@REM ]

@REM for file_path in files_to_include:
@REM     pyinstaller_cmd.append(f"--add-data={file_path};.")

@REM command_string = " ".join(pyinstaller_cmd)

@REM command = str(f'{src_dir}/__main__.py')

@REM command_string = f'{command_string} "{command}"'

@REM print(command_string)

@REM os.system(command_string)
