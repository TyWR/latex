% -- Encoding UTF-8 without BOM

\ProvidesClass{cv-style}[2015/02/27 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{english}{\def\@cv@espanol{}}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%------------------------------------------------------------------------------
% Colors %
%------------------------------------------------------------------------------

\RequirePackage{xcolor}

\definecolor{white}{HTML}{eceff4}

\definecolor{darkgray}{HTML}{434C5e}
\definecolor{gray}{HTML}{2E3440}
\definecolor{lightgray}{HTML}{4C566a}

\definecolor{blue1}{HTML}{5e81ac}
\definecolor{blue2}{HTML}{81a1c1}
\definecolor{blue3}{HTML}{88c0d0}
\definecolor{blue4}{HTML}{8fbcbb}
\definecolor{red}{HTML}{BF616A}
\definecolor{orange}{HTML}{D08770}
\definecolor{green}{HTML}{A3BE8C}
\definecolor{purple}{HTML}{b48ead}
\definecolor{aquamarine}{HTML}{36AF90}

\definecolor{date}{HTML}{A4A4A4}

\ifdefined\@cv@print
  \colorlet{blue}{gray}
  \colorlet{red}{gray}
  \colorlet{orange}{gray}
  \colorlet{green}{gray}
  \colorlet{purple}{gray}
  \colorlet{aquamarine}{gray}
  \colorlet{fillheader}{gray}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{darkgray}

%------------------------------------------------------------------------------
% Fonts %
%------------------------------------------------------------------------------

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

\newfontfamily\bodyfont{Play-Regular.ttf}[Path=fonts/]
\newfontfamily\bodyfontit{Play-Regular.ttf}[Path=fonts/]
\newfontfamily\thinfont{Play-Regular.ttf}[Path=fonts/]
\newfontfamily\headingfont{Play-Bold.ttf}[Path=fonts/]
\newfontfamily\condensedfont{Play-Regular.ttf}[Path=fonts/]
\newfontfamily\lightfont{Play-Regular.ttf}[Path=fonts/]



\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor, Path = fonts/]{Play-Regular.ttf}

\newcommand{\italica}[1]{%
    {\color{gray}\bodyfontit #1}%
}

%------------------------------------------------------------------------------
% Header %
%------------------------------------------------------------------------------

\RequirePackage{tikz}

\newcommand{\header}[2]{%
    \begin{tikzpicture}[remember picture,overlay]
	   \draw[fill=fillheader] (-6,-0.3) rectangle (\paperwidth,10); 

	   \node [rectangle, fill=fillheader,
		     anchor=north, minimum width=\paperwidth, 
	          minimum height=2cm] (box) at (current page.north){};
	   \node [anchor=center] (name) at (box) {%
		  \fontsize{28pt}{50pt}\color{header}%
		  {\lightfont #1}{\headingfont  #2}
	   };
  \end{tikzpicture}
  \vspace{1cm}
  \vspace{-2\parskip}
}

%------------------------------------------------------------------------------
%	Last updated command %
%------------------------------------------------------------------------------

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{polyglossia}

\newcommand{\sethyphenation}[3][]{%
  \sbox0{\begin{otherlanguage}[#1]{#2}
    \hyphenation{#3}\end{otherlanguage}}}
%\sethyphenation[<options>]{<language>}{<list of words separated by spaces>}

\ifdefined\@cv@espanol
  \setdefaultlanguage{spanish}
  \def\lastupdatedtext{Última Actualización el}
\else
  \setdefaultlanguage[variant=british]{english}
  \def\lastupdatedtext{Last Updated on}
\fi

\setlength{\TPHorizModule}{0.01\paperwidth}
\setlength{\TPVertModule}{0.01\paperwidth}

\newcommand{\lastupdated}{ 
  \begin{textblock}{10}(11.3, 0.05)
    \raggedleft
    \fontsize{8pt}{10pt}\color{date}\thinfont 
    \lastupdatedtext{} \today
  \end{textblock}}

%------------------------------------------------------------------------------
% Structure %
%------------------------------------------------------------------------------
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
	   blue1\or%
	   blue2\or%
	   blue3\or%
	   blue4\or%
        purple\or%
        aquamarine\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  {\par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.25\parskip}%
}

\newcommand{\jobtitle}[1]{%
    {\color{gray}\bodyfontit #1}%
}

\pagestyle{empty}

%------------------------------------------------------------------------------
% List environment %
%------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{12.8cm}{%
    \textbf{#2}%
    \hfill%
    {\small\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}
  
%------------------------------------------------------------------------------
% Side block %
%------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1, 1.87)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%------------------------------------------------------------------------------
% Other tweaks %
%------------------------------------------------------------------------------

\RequirePackage[left=5.6cm,top=1cm,right=1cm,bottom=1cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    pdftitle=CV/Resume \textbar{} Tanguy VIVIER,
    pdfauthor=Tanguy VIVIER,
    pdfsubject=CV/Resume%
    }
