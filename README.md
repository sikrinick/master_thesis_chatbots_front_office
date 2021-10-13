# Master Thesis

## Requirements:
- [Latexmk](https://mg.readthedocs.io/latexmk.html)  
You probably have it already installed on your computer, because it is part of MacTeX and MikTeX and is bundled with many Linux Distributions.
- [Python 3](https://www.python.org/downloads/)  
Required to run build.py script

## Compilation

### PDF
```zsh
python3 build.py
# or
python3 build.py --pdf
# or
latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=output/pdf "master thesis.tex"
```

### DOCX
I strongly suggest to use [Adobe PDF to Word Converter](https://www.adobe.com/acrobat/online/pdf-to-word.html)

### HTML5
```zsh
python3 build.py --html5
# or
make4ht -x -f html5 -d output/html5 master_thesis.tex
```

### ODT (OpenOffice, LibreOffice, Microsoft Word)
```zsh
python3 build.py --odt
# or
make4ht -x -f odt -d output/odt master_thesis.tex
```
