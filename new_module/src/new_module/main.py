import sys

from log_py import log_py as log


def main_entry():
    log.log_message("Current Python version:", sys.version)
    log.log_message("Current Python version:", sys.version_info.major, sys.version_info.minor, sys.version_info.micro)

