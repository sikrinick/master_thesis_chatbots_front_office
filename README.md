# Master Thesis

## Requirements:
- [Latexmk](https://mg.readthedocs.io/latexmk.html)  
You probably have it already installed on your computer, because it is part of MacTeX and MikTeX and is bundled with many Linux Distributions.
For macOS with brew I suggest 
```
brew install --cask mactex
```
- [Python 3](https://www.python.org/downloads/)  
Required to run build.py script

## Compilation

### PDF
```zsh
./build.py
# or
python3 build.py --pdf
# or
latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=output/pdf "master thesis.tex"
```

### DOCX
I strongly suggest to use [Adobe PDF to Word Converter](https://www.adobe.com/acrobat/online/pdf-to-word.html)


## Editor
As an editor I strongly suggest Visual Studio Code.  
List of required extensions are in `.vscode/extensions.json`.


## Spell checker
I used `aspell` for spell checks in terminal.
```zsh
# install aspell
brew install aspell 

# run spellcheck script
./spellcheck.py

# or you can check every file separately
aspell -t -c master_thesis.tex 
aspell -t -c content/introduction.tex 
cd content/chapter_1 && aspell -t -c 1_banking_system_overview.tex
... 
```