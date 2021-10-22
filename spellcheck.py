#!/usr/bin/python3

from os import listdir, chdir, system
from subprocess import check_output, Popen, PIPE
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


en_aspell_dicts = [
    "technical/spelling/aspell.en.prepl",
    "technical/spelling/aspell.en.pws"
]

pl_aspell_dicts = [
    "technical/spelling/aspell.pl.prepl"
]

errors = []

print("Spell checking:\n" + "\n".join(tex_files))
print("\n")

all_errors = ""
for tex_file in tex_files:

    get_file_content = Popen([
        "cat",
        tex_file
    ], stdout=PIPE)

    first_check_english = Popen([
        "aspell",
        "list",
        "--mode=tex",
        "--lang=en",
        "--add-extra-dicts", "./technical/spelling/aspell.en.prepl",
        "--add-extra-dicts", "./technical/spelling/aspell.en.pws"
    ], stdout=PIPE, stdin=get_file_content.stdout)
    
    then_check_polish = Popen([
        "aspell",
        "list",
        "--mode=tex",
        "--lang=pl",
        "--add-extra-dicts", "./technical/spelling/special.pl.pws"
    ], stdin=first_check_english.stdout, stdout=PIPE)

    errors = then_check_polish.communicate()[0].decode()
    all_errors = all_errors + errors

    if len(errors) == 0: continue

    print(f"File: {tex_file}")
    print(errors)
    print("\n")

    system(" ".join([
        "aspell",
        "check",
        "--mode=tex",
        "--add-extra-dicts", "./technical/spelling/aspell.en.prepl",
        "--add-extra-dicts", "./technical/spelling/aspell.en.pws",
        "--add-extra-dicts", "./technical/spelling/special.enpl.pws",
        tex_file  
    ]))
        
if len(all_errors) == 0:
    print("Project spelling is correct. No mistakes found")