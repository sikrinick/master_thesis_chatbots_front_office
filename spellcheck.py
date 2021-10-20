#!/usr/bin/python3

from os import listdir, chdir, system, popen
from os.path import isdir, join, dirname, realpath
from dataclasses import dataclass
from typing import List



@dataclass
class Files:
    tex_files: List[str]
    dirs: List[str]
    pass

def list_tex_files(root: str) -> List[str]:
    files = []
    for file in listdir(root):
        file_path = join(root, file)
        if isdir(file_path):
            files = files + list_tex_files(file_path)
        elif file_path.endswith(".tex"):
            files.append(file_path)
    return files


chdir(dirname(realpath(__file__)))

tex_files = list_tex_files("content")
tex_files.append("master_thesis.tex")

for tex_file in tex_files:
    system(f"aspell -t -c {tex_file}")
    print(f"Spell checked: {tex_file}")

