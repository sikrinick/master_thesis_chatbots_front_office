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
latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error -outdir=output/pdf "master_thesis.tex"
```

### DOCX
`./build.py` supports PDF-to-DOCX conversion via GroupDocs Cloud 
However, you have to register in [GroupDocs Cloud](https://dashboard.groupdocs.cloud/applications/edit/55553).  
There you can create an application with internal storage and obtain `Client Id` and `Client Secret`.
Then, specify next environmental variables in your `~/.bashrc` or `~/.zshrc`
```zsh
export GROUPDOCS_CLIENT_ID="your client id"
export GROUPDOCS_CLIENT_SECRET="your client secret"
```

For manual convertion I strongly suggest to use [GroupDocs PDF to DOCX Converter](https://products.groupdocs.app/conversion/pdf-to-docx).
Another option is to use [Adobe PDF to Word Converter](https://www.adobe.com/acrobat/online/pdf-to-word.html).


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
```