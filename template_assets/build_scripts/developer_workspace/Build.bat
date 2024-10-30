echo test 2
import sys
import os
from pathlib import Path

if getattr(sys, 'frozen', False):
    SCRIPT_DIR = os.path.dirname(os.path.abspath(sys.executable))
else:
    SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
os.chdir(SCRIPT_DIR)

src_dir = f'{os.path.dirname(os.path.dirname(SCRIPT_DIR))}/src/unreal_auto_mod'

base_path = Path(src_dir)
files_to_include = [
    base_path / "json/cli.json",
    base_path / "json/log_colors.json",
    base_path / "utilities.py"

pyinstaller_cmd = [
    'pyinstaller',
    '--collect-data grapheme',
    '--collect-submodules "psutil"',
    '--collect-submodules "win_man_py"',
    f"--icon={base_path.parent.parent / 'assets/images/UnrealAutoModIcon.ico'}"
]

for file_path in files_to_include:
    pyinstaller_cmd.append(f"--add-data={file_path};.")

command_string = " ".join(pyinstaller_cmd)

command = str(f'{src_dir}/__main__.py')

command_string = f'{command_string} "{command}"'

print(command_string)

os.system(command_string)
