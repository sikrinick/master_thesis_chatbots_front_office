\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{master_thesis}[2021/10/03 v1.0.0 Master Thesis UW WNE EN]

\newcommand{\@baseclass}{report}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}}
\PassOptionsToClass{a4paper, oneside, 12pt}{\@baseclass}
\ProcessOptions

\LoadClass{\@baseclass}


% Dependencies
\RequirePackage{tocloft}
\RequirePackage{titlesec}
\RequirePackage{etoolbox}
\RequirePackage{setspace}
\RequirePackage[within=none]{caption}

\ifdefined\HCode % detect tex4ht
  \RequirePackage{inputenc}
  \PassOptionsToPackage{utf8}{inputenc}
  \RequirePackage{fontenc}
  \PassOptionsToPackage{T1}{fontenc}
\else
  \RequirePackage{fontspec}
  \setmainfont{Times New Roman}
\fi
\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\RequirePackage{lscape}
\RequirePackage{rotating}
\RequirePackage{longtable}  
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage[
  style=verbose,
  sorting=nty,
  dashed=false,
  backend=biber,
]{biblatex}
\RequirePackage{xurl}
\RequirePackage[hidelinks]{hyperref}


% Debugging
\iffalse
  \RequirePackage{showframe}
\fi

\pgfplotsset{compat=1.16}
\usetikzlibrary{shapes,arrows,positioning,fit,calc}
  
\tikzstyle{input} = [coordinate]
\tikzstyle{output} = [coordinate]
\tikzstyle{block} = [draw, rectangle, minimum height=3em, minimum width=6em]
\tikzstyle{sum} = [draw, circle, node distance=1cm]

\setcounter{footnote}{0}  

\linespread{1.425}

% Reset margins
\textwidth=\paperwidth
\textheight=\paperheight
\oddsidemargin = -1in
\evensidemargin = -1in
\topmargin = -1in
\marginparwidth = 0mm
\marginparsep = 0mm
\headsep = 0mm
\headheight = 0mm

% Set margins
\addtolength{\oddsidemargin}{2.5cm}
\addtolength{\evensidemargin}{2.5cm}
\addtolength{\textwidth}{-5cm}
\addtolength{\topmargin}{2.5cm}
\addtolength{\textheight}{-5cm}

% Title page
\renewcommand{\maketitle}{
  \begin{spacing}{1.0}
  \begin{center}
    {\fontsize{18pt}{21.6pt}\selectfont
      University of Warsaw\\
      Faculty of Economic Sciences
      \par
    }

    \vspace{1cm plus 1fill} 

    \begin{spacing}{1.425}
    {\fontsize{14pt}{16.8pt}\selectfont
      \@author
      \par
    }
    {
      Album N°: \@studentbooknumber
      \par
    }
    \end{spacing}

    \vspace{8mm plus .1fill}
    
    {\fontsize{20pt}{24pt}\selectfont
      \textbf{\@title}
      \par
    }
    
    \vspace{8mm plus .1fill}
    
    \begin{spacing}{1.425}
    {\fontsize{14pt}{16.8pt}\selectfont
      Master degree thesis\\
      Field of study: \@course
    }
    \end{spacing}

    \vspace{2cm plus 1.5fill}
    
    \begin{flushright}
      \begin{tabular}{r}
        The thesis written under the supervision of\\
        \@supervisor\\
        \@supervisorunit\\
        WNE UW
      \end{tabular}
    \end{flushright}
    
    \vspace{1cm plus 1fill}
    
    \@city , \@date
    \par
    
    \vspace{1.2cm}
  \end{center}
  \end{spacing}
  \pagebreak

  % Supervisor statement
  \vspace*{1cm}
  \noindent
  \textit{Declaration of the supervisor}
  \bigskip

  \noindent
  I declare that the following thesis was written under my supervision and I state that it meets all criteria to be submitted for the procedure of academic degree award.

  \vspace{15mm}

  \noindent
  Date \hfill Signature of the Supervisor \hspace*{4cm}

  \vspace{3cm}
  \noindent
  \textit{Declaration of the author of the thesis}
  \bigskip

  \noindent
  Aware of the legal responsibility, I declare that I am the sole author of the following thesis and that the thesis is free from any content that constitutes copyright infringement or has been acquired contrary to applicable laws and regulations.
  
  \noindent
  I also declare that the thesis has never been a subject of degree-awarding procedures in any higher education institution.
  
  \noindent
  Moreover I declare that the attached version of the thesis is identical with the enclosed electronic version.
  
  \vspace{15mm}

  \noindent
  Date \hfill Signature of the Author \hspace*{4cm}

  \pagebreak

  \global\renewcommand{\maketitle}{\relax}
  
  \global\renewcommand{\title}{\relax}
  \global\renewcommand{\@title}{\@empty}
  
  \global\renewcommand{\thanks}{\relax}
  \global\renewcommand{\@thanks}{\@empty}

  \global\renewcommand{\author}{\relax}
  \global\renewcommand{\@author}{\@empty}

  \global\renewcommand{\date}{\relax}
  \global\renewcommand{\@date}{\@empty}

  \global\renewcommand{\and}{\relax}
}

\newcommand{\studentbooknumber}[1]{\gdef\@studentbooknumber{#1}}
\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\supervisorunit}[1]{\gdef\@supervisorunit{#1}}
\newcommand{\city}[1]{\gdef\@city{#1}}
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\studycode}[1]{\gdef\@studycode{#1}}
\newcommand{\classification}[1]{\gdef\@classification{#1}}
\newcommand{\titlepl}[1]{\gdef\@titlepl{#1}}
\newcommand{\summary}[1]{\gdef\@summary{#1}}
\newcommand{\summarypl}[1]{\gdef\@summarypl{#1}}

% Summary
\newcommand{\makesummary}{
  \begin{spacing}{1.0}
  \begin{center}
    \textbf{Summary}
    \@endparpenalty\@M
  \end{center}
  \@summary
  
  \medskip
  
  \begin{center}
    \textbf{Streszczenie}
    \@endparpenalty\@M
  \end{center}
  \@summarypl

  \bigskip
  
  \begin{center}
    \textbf{Key words}
    \@endparpenalty\@M
  \end{center}
  \begin{center}
    \@keywords
  \end{center}

  \bigskip

  \begin{center}%
    \textbf{Field of the thesis (codes according to the Erasmus program)}
    \@endparpenalty\@M
  \end{center}
  \begin{center}
    \@studycode\par
  \end{center}

  \bigskip

  \begin{center}%
    \textbf{Thematic classification}
    \@endparpenalty\@M
    \@classification\par
  \end{center}

  \bigskip

  \begin{center}%
    \textbf{The title of the thesis in Polish}
    \@endparpenalty\@M
  \end{center}
  \begin{center}
  \@titlepl\par
  \end{center}
  \end{spacing}
  \vfil
  \pagebreak
}

% Table of contents
\AtBeginDocument{
  \let\oldtoc\tableofcontents
  \renewcommand{\tableofcontents}{
    \begin{singlespace}
    \oldtoc
    \end{singlespace}
  }
}
\renewcommand{\contentsname}{\uppercase{Table of contents}}
\renewcommand{\cfttoctitlefont}{\hfill\large\bfseries}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
\renewcommand{\cftbeforetoctitleskip}{-0.5cm}
\renewcommand{\cftaftertoctitleskip}{1em}

%% Chapters
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\cftchappresnum}{CHAPTER\space}
\renewcommand{\cftchapaftersnum}{.}
\newlength{\cftchappresnum@width}
\setlength{\cftchapnumwidth}{1.5em}
\settowidth{\cftchappresnum@width}{\cftchappresnum}
\addtolength{\cftchapnumwidth}{\cftchappresnum@width}
\AtBeginDocument{
  \titleformat{name=\chapter}[block]
    {\begin{center}\normalfont\bfseries}
    {CHAPTER\space\thechapter}{0em}
    {\end{center}\vspace{-0.3cm}\normalfont\bfseries\begin{center}}
    [\end{center}]
  \titlespacing*{name=\chapter}{0cm}{-2em}{18pt}
}

%% Unnumbered chapters
\newcommand{\unnumberedchapter}[1]{
  \chapter*{\uppercase{#1}}
  \addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{#1}}{#1}}
}
\AtBeginDocument{
  \titleformat{name=\chapter, numberless}[block]{\normalfont\bfseries}{}{0em}{\normalfont\bfseries}
  \titlespacing*{name=\chapter, numberless}{0cm}{-1em}{18pt}
}


%% Sections
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\enspace}
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}.}
\setlength{\cftsecindent}{0em}
\renewcommand{\cftbeforesecskip}{4mm}
\setlength{\cftsecnumwidth}{2em}
\AtBeginDocument{
  \titleformat{\section}[block]{\normalfont\bfseries}{\thesection}{1em}{\normalfont\bfseries}
  \titlespacing*{name=\section}{0cm}{28pt}{18pt}
}

%% Subsections
\setlength{\cftsubsecindent}{1.5em}
\renewcommand{\thesubsection}{\thesection\arabic{subsection}.}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftsubsecnumwidth}{3em}
\AtBeginDocument{
  \titleformat{\subsection}[block]{\normalfont\bfseries}{\thesubsection}{1em}{\normalfont\bfseries}
  \titlespacing*{name=\subsection}{0cm}{28pt}{18pt}
}

%% Paragraph
\setlength{\parindent}{1.0cm}

%% Bullet lists and numbered lists
\AtBeginDocument{
  \setlist{nosep, ,after=\vspace{18pt}}
}


%% Caption
\DeclareCaptionLabelFormat{myformat}{#1~#2}
\captionsetup{labelformat=myformat, labelsep=period}

%% Figure caption
\captionsetup[figure]{singlelinecheck=off}

%% Table caption
\captionsetup[table]{singlelinecheck=off}

%% Figure and table source
\newcommand{\source}[1]{
  \par\noindent\footnotesize
  \begin{enumerate}[label=\textit{Source:}, wide=0pt, leftmargin=*]
    \item #1
  \end{enumerate}
}

%% Citations
\AtBeginDocument{
  %% Disabling citation boxes
  \renewcommand{\cite}[2][]{}
  \nocite{*}
}

%% Bibliography
\AtBeginDocument{
  \renewcommand\bibname{BIBLIOGRAPHY}
  \renewcommand\UrlFont{\normalfont}
  \DeclareFieldFormat{title}{#1}
  \DeclareFieldFormat{chapter}{#1}
  \DeclareFieldFormat{url}{
    \newline\hspace*{-\bibhang}\url{#1}\nopunct
  }
  \setlength{\bibitemsep}{1em}
}

%% List of shorts
\newenvironment{listofshorts}
{
  \vspace{1em}
  \section*{List of shorts}
  \setlength\LTleft{-5pt}
  \setlength\LTright{0pt}
  \begin{longtable}{l @{\hspace{2em}-\hspace{1em}} l @{\extracolsep{\fill}}}  
}
{
  \end{longtable}
}
\newcommand{\short}[2]{
  #1 & #2 \\
}


%% Table
\newcommand{\mttable}[3]{
  \begin{table}
    \caption{#1}
    \bgroup
    \setlength{\topsep}{0pt}
    \begin{center}
      #3
    \end{center}
    \egroup
    \medskip
    \source{#2}
  \end{table}
}

%% List of tables
\renewcommand{\listtablename}{List of tables}
\setlength{\cfttabindent}{0em}
\renewcommand{\cfttabpresnum}{\tablename~}
\renewcommand{\cfttabaftersnum}{.}
\setlength{\cfttabnumwidth}{5em}
\AtBeginDocument{
  \makeatletter
  \renewcommand\listoftables{
    \section*{\listtablename}
    \@starttoc{lot}
  }
  \makeatother
}


%% Figure
\newcommand{\mtfigure}[4][tbp]{
  \begin{figure}[#1]
    \caption{#2}
    \bgroup
    \setlength{\topsep}{0pt}
    \begin{center}
      #4
    \end{center}
    \egroup
    \medskip
    \source{#3}
  \end{figure}
}

%% List of figures
\renewcommand{\listfigurename}{List of figures}
\setlength{\cftfigindent}{0em}
\renewcommand{\cftfigpresnum}{Figure~}
\renewcommand{\cftfigaftersnum}{.}
\setlength{\cftfignumwidth}{5em}
\AtBeginDocument{
  \makeatletter
  \renewcommand\listoffigures{
    \section*{\listfigurename}
    \@starttoc{lof}
  }
  \makeatother
}

%% List of annexes
\newcommand{\listannexname}{List of annexes}
\newlistof{annexes}{loa}{\listannexname}
\newcommand{\annex}[1]{
    \refstepcounter{annexes}
    \addcontentsline{loa}{annexes}{
      \protect\numberline{Annex \theannexes.} #1
    }
    \par\noindent\section*{Annex \theannexes. #1}
}
\setlength{\cftannexesindent}{-0.3em}
\setlength{\cftannexesnumwidth}{4.5em}
\AtBeginDocument{
  \makeatletter
  \renewcommand\listofannexes{
    \section*{\listannexname}
    \@starttoc{loa}
  }
  \makeatother
}

%% survey
\newcommand{\checkbox}{
  \raisebox{-1.5pt}{
    \framebox(12pt,12pt){}
  }
}
\newcommand{\inputfield}[1]{
  \raisebox{-1.5pt}{
    \underline{
      \makebox[#1]{}
    }
  }
}

\makeatletter
\newcommand*{\Romannum}[1]{\expandafter\@slowromancap\romannumeral #1@}
\makeatother