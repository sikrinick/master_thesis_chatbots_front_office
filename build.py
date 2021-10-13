#!/usr/bin/python3

from argparse import ArgumentParser

from os.path import dirname, realpath, join
from os import chdir, listdir, remove
from subprocess import run
from typing import Set

script_dir = dirname(realpath(__file__))
input_file = "master_thesis.tex"
output_root = "output"
        
def mandatory_files(folder: str) -> Set[str]:
    files=set(
        run(
            ["git", "ls-tree", "--name-only", "master"], capture_output=True, text=True,
            cwd=folder
        )
        .stdout
        .splitlines()
    )
    files.add(".git")
    files.add("build.py")
    return files

def clean(folder: str = "."):
    files = listdir(folder)
    for file in files:
        if file not in mandatory_files(folder):
            try: 
                remove(join(folder, file))
            except Exception as e:
                print(e)

def transform(output_format: str):
    
    chdir(script_dir)

    if output_format == "pdf":
        output_dir = join(output_root, "pdf")
        run([
            "latexmk",
            "-xelatex",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            f"-outdir={output_dir}",
            f'"{input_file}"'
        ])
    elif output_format == "html5":
        output_dir = join(output_root, "html5")
        run([
            "make4ht",
            "-x",
            "-f", "html5",
            "-d", output_dir,
            input_file
        ])
        clean()
        clean("images")
    elif output_format == "odt":
        output_dir = join(output_root, "odt")
        run([
            "make4ht",
            "-x",
            "-f", "odt",
            "-d", output_dir,
            input_file
        ])
        clean()
        clean("images")
    else:
        quit()


if __name__ == '__main__':
    parser = ArgumentParser(description='Build master_thesis.tex')
    parser.add_argument(
        "--pdf",
        help="Build PDF (default)",
        dest='format', action='store_const', const="pdf"
    )
    parser.add_argument(
        "--html5",
        help="Build HTML5",
        dest='format', action='store_const', const="html5"
    )
    parser.add_argument(
        "--odt",
        help="Build ODT",
        dest='format', action='store_const', const="odt"
    )
    parser.set_defaults(format="pdf")
    args = parser.parse_args()

    transform(output_format=args.format)