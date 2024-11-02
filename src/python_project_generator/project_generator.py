import sys
import shutil
from pathlib import Path

import pyjson5


if getattr(sys, 'frozen', False):
    SCRIPT_DIR = Path(sys.executable).parent
else:
    SCRIPT_DIR = Path(__file__).resolve().parent


def get_project_info_json():
    project_info_json = Path(f'{SCRIPT_DIR}/python_project_generator.json')
    if not project_info_json.is_file():
        raise FileNotFoundError(f"project_info.json file not found: {project_info_json}")
    else:
        with open(project_info_json, 'r') as f:
            return pyjson5.load(f)


def get_project_name():
    project_name = get_project_info_json().get('project_name')
    if not project_name:
        raise ValueError("Missing 'project_name' in project info JSON.")
    return project_name


def get_project_dir():
    project_dir = Path(f'{SCRIPT_DIR}/{get_project_name()}')
    if not project_dir.is_dir():
        Path.mkdir(project_dir)
        if not project_dir.is_dir():
            raise NotADirectoryError(f"project_dir dir not found: {project_dir}")
    return project_dir


def copy_template_src_files_into_new_project():
    src_src_dir = Path(f'{SCRIPT_DIR}/template_assets/src')
    if not src_src_dir.is_dir():
        raise NotADirectoryError(f"src_src_dir dir not found: {src_src_dir}")
    dst_src_dir = Path(f'{get_project_dir()}/src/{get_project_name()}')
    shutil.copytree(src_src_dir, dst_src_dir)
    if not dst_src_dir.is_dir():
        raise NotADirectoryError(f"dst_src_dir dir not found: {dst_src_dir}")


def copy_template_build_scripts_into_new_project():
    src_build_scripts_dir = Path(f'{SCRIPT_DIR}/template_assets/build_scripts')
    if not src_build_scripts_dir.is_dir():
        raise NotADirectoryError(f'src_builds_dir dir is not found: {src_build_scripts_dir}')
    dst_build_scripts_dir = Path(f'{get_project_dir()}/build_scripts')
    shutil.copytree(src_build_scripts_dir, dst_build_scripts_dir)
    if not dst_build_scripts_dir.is_dir():
        raise NotADirectoryError(f'dst_build_scripts_dir dir is not found: {dst_build_scripts_dir}')


def copy_project_info_json_into_new_project():
    src_project_info_json = Path(f'{SCRIPT_DIR}/project_info.json')
    if not src_project_info_json.is_file():
        raise FileNotFoundError(f'project_info.json file not found: {get_project_info_json()}')
    dst_project_info_json = Path(f'{get_project_dir()}/src/{get_project_name()}/json/project_info.json')
    shutil.copyfile(src_project_info_json, dst_project_info_json)
    if not dst_project_info_json.is_file():
        raise FileNotFoundError(f'project_info.json file not found: {dst_project_info_json}')


def copy_images_folder_into_new_project():
    src_images_dir = Path(f'{SCRIPT_DIR}/template_assets/images')
    if not src_images_dir.is_dir():
        raise NotADirectoryError(f"src_images_dir dir not found: {src_images_dir}")
    dst_images_dir = Path(f'{get_project_dir()}/images')
    shutil.copytree(src_images_dir, dst_images_dir)
    if not dst_images_dir.is_dir():
        raise NotADirectoryError(f"dst_images_dir dir not found: {dst_images_dir}")


def copy_base_release_dir_into_new_project():
    src_base_release_dir = Path(f'{SCRIPT_DIR}/template_assets/base')
    if not src_base_release_dir.is_dir():
        raise NotADirectoryError(f"src_base_release_dir dir not found: {src_base_release_dir}")
    dst_base_release_dir = Path(f'{get_project_dir()}/base')
    shutil.copytree(src_base_release_dir, dst_base_release_dir)
    if not dst_base_release_dir.is_dir():
        raise NotADirectoryError(f"dst_base_release_dir dir not found: {dst_base_release_dir}")


def generate_project():
    copy_template_src_files_into_new_project()
    copy_template_build_scripts_into_new_project()
    copy_project_info_json_into_new_project()
    copy_images_folder_into_new_project()
    copy_base_release_dir_into_new_project()


generate_project()
