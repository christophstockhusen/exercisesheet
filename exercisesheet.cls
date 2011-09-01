% Copyright by Christoph Stockhusen

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{exercisesheet}[2011/08/30]

\RequirePackage{xkeyval}
\RequirePackage{graphicx}

%
% loading the underlying class
%

%
% keys for the class
%

\def\sheet@narrowfactor{.7}
\DeclareOptionX{narrowfactor}{\def\sheet@narrowfactor{#1}}
\DeclareOptionX{nonarrow}{\def\sheet@narrowfactor{1}}

% pass undeclared options to the underlying class file
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptionsX
\LoadClass{report}

\def\exercisesheet{\texttt{exercisesheet}}

%
%
%

\newtoks\sheet@lecture
\newcommand*\lecture[1]{\sheet@lecture={#1}}
\newcommand*\insertlecture{\the\sheet@lecture}

\newtoks\sheet@lecturer
\newcommand*\lecturer[1]{\sheet@lecturer={#1}}
\newcommand*\insertlecturer{\the\sheet@lecturer}

\newtoks\sheet@semester{}
\newcommand*\semester[1]{\sheet@semester={#1}}
\newcommand*\insertsemester{\the\sheet@semester}

\newtoks\sheet@student{}
\newcommand*\student[1]{\sheet@student={#1}}
\newcommand*\insertstudent{\the\sheet@student}

%
% fonts
%

\def\sheettitlefont{\sffamily\fontsize{36}{40}\selectfont}
\def\sheetsubtitlefont{\sffamily\Huge}
\def\sheetdeadlinefont{\sffamily\LARGE}
\def\sheetlecturefont{\sffamily\footnotesize}
\def\sheetsemesterfont{\sffamily\footnotesize}
\def\sheetlecturerfont{\sffamily\footnotesize}
\def\sheetexercisefont{\small\sffamily}
\def\sheetsubexercisefont{\footnotesize\sffamily}

%
% layout
%

\textwidth=\paperwidth
\advance\textwidth by -4cm
\oddsidemargin=2cm
\hoffset=-1in

\textheight=\paperheight
\topmargin=1cm
\advance\textheight by -\topmargin
\advance\textheight by -\headheight
\advance\textheight by -\headsep
\advance\textheight by -\footskip
\advance\textheight by -1cm
\voffset=-1in


\newdimen\sheet@textwidth
\sheet@textwidth=\textwidth
\newdimen\sheet@narrowtextwidth
\sheet@narrowtextwidth=\sheet@narrowfactor\sheet@textwidth

\def\sheet@setwide{\sheet@setsheetwidth{\the\sheet@textwidth}}
\def\sheet@setnarrow{\sheet@setsheetwidth{\the\sheet@narrowtextwidth}}
\def\sheet@setsheetwidth#1{
  \global\hsize=#1
  \global\linewidth=#1
}

%
% header and footer
%

\def\ps@headings{%
  \let\@oddhead\@empty
  \def\@oddfoot{{\footnotesize \hfil \thepage}}%
  \let\@mkboth\markboth}

\let\ps@plain\ps@empty

\pagestyle{headings}

% keys for sheets

\define@key{sheet@sheet}{title}{\sheet@sheet@title={#1}}
\define@key{sheet@sheet}{deadline}{\sheet@sheet@deadline={#1}}
\define@key{sheet@sheet}{label}{\def\sheet@sheet@label{#1}}
\define@key{sheet@sheet}{credits}{\sheet@sheet@credits=#1}
\define@key{sheet@sheet}{number}{%
  \setcounter{sheet}{#1}%
  \addtocounter{sheet}{-1}%
}

\newtoks\sheet@sheet@title
\newtoks\sheet@sheet@deadline
\def\sheet@sheet@label{}
\newcount\sheet@sheet@credits

% keys for exercises

\define@key{sheet@exercise}{title}{\sheet@exercise@title={#1}}
\define@key{sheet@exercise}{label}{\def\sheet@exercise@label{#1}}
\define@key{sheet@exercise}{credits}{\sheet@exercise@credits=#1}
\define@key{sheet@exercise}{number}{%
  \setcounter{exercise}{#1}%
  \addtocounter{exercise}{-1}%
}

\newtoks\sheet@exercise@title
\def\sheet@exercise@label{}
\newcount\sheet@exercise@credits

% keys for subexercises

\define@key{sheet@subexercise}{title}{\sheet@subexercise@title={#1}}
\define@key{sheet@subexercise}{label}{\def\sheet@subexercise@label{#1}}
\define@key{sheet@subexercise}{credits}{\sheet@subexercise@credits=#1}
\define@key{sheet@subexercise}{number}{%
  \setcounter{subexercise}{#1}%
  \addtocounter{subexercise}{-1}%
}

\newtoks\sheet@subexercise@title
\def\sheet@subexercise@label{}
\newcount\sheet@subexercise@credits

% keys for solutions

\define@key{sheet@solution}{exerciselabel}{\def\sheet@solution@exerciselabel{#1}}

\def\sheet@solution@exerciselabel{}

%
% names
%

\newcommand\sheetname{Exercise Sheet}
\newcommand\sheetdeadline{Deadline}
\newcommand\exercisename{Exercise}
\newcommand\subexercisename{Subexercise}
\newcommand\solutionname{Solution}
\newcommand\forname{for}
\newcommand\creditname{credit}
\newcommand\creditsname{credits}

% insert commands for sheets

\newcommand\insertsheettitle{\the\sheet@sheet@title}
\newcommand\insertsheetdeadline{\the\sheet@sheet@deadline}
\newcommand\insertsheetcredits{\the\sheet@sheet@credits}

% insert commands for exercises

\newcommand\insertexercisetitle{\the\sheet@exercise@title}
\newcommand\insertexercisecredits{\the\sheet@exercise@credits}

% insert commands for subexercises

\newcommand\insertsubexercisetitle{\the\sheet@subexercise@title}
\newcommand\insertsubexercisecredits{\the\sheet@subexercise@credits}

%
% \maketitle
%

\def\maketitle{%
  \begin{titlepage}
    \null\vskip 0pt plus 2fil
    \begingroup 
      \sheettitlefont \insertlecture \par \bigskip \bigskip \bigskip
      \normalsize \insertlecturer \par \medskip
      \insertsemester \par \bigskip \bigskip
    \endgroup
    \vskip 0pt plus 3fil
  \end{titlepage}%
}

%
% \sheet
%

\let\insertsheetlogo=\relax

\newcommand\sheet{\@ifnextchar[\sheet@start@sheet{\sheet@start@sheet[]}}

\@afterindentfalse

\def\sheet@start@sheet[#1]{
  % parse keys
  \setkeys{sheet@sheet}{label={},credits=-1,#1}
  % typeset
  % begin new page
  \clearpage
  \setcounter{page}{1}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{sheet}%
    \addcontentsline{toc}{sheet}{\thesheet\texorpdfstring{\quad}{ }\insertsheettitle}%
  \else
    \addcontentsline{toc}{sheet}{\insertsheettitle}%
  \fi
  \markboth{}{}%
  % insert logo
  \ifx\insertsheetlogo\relax\else
    \leavevmode
    \insertsheetlogo
    \par
    \bigskip
  \fi
  {%
    \sheet@setwide
    \parindent=0pt
    \parskip=0pt
    \interlinepenalty \@M
    {% 
      % sheet number
      \normalfont
      \sheettitlefont
      \sheetname~\thesheet
    }%
    {%
      % sheet title
      \sheet@ifempty{\insertsheettitle}{}{%
        \vskip 1em
        \normalfont
        \sheetsubtitlefont
        \insertsheettitle \par
      }%
    }%
    {%
      % sheet deadline
      \sheet@ifempty{\insertsheetdeadline}{}{%
        \vskip 1em
        \normalfont
        \sheetdeadlinefont
        \sheetdeadline~\insertsheetdeadline \par
      }%
    }%
    {%
      % lecture, semester
      \sheet@ifempty{\insertlecture\insertsemester}{}{%
        \vskip 1em
      }%
      \sheet@ifempty{\insertlecture}{}{%
        \sheetlecturefont
        \sheetname~\forname~\emph{\insertlecture}%
      }%
      \sheet@ifempty{\insertsemester}{}{%
        \sheet@ifempty{\insertlecture}{}{, }%
        \sheetsemesterfont
        \insertsemester%
      }%
    }%
    {%
      % lecturer
      \sheet@ifempty{\insertlecturer}{}{%
        \vskip 1ex
        \sheetlecturerfont
        \insertlecturer 
      }%
    }%
  }%
  \sheet@ifempty{\sheet@sheet@label}{}{%
    \expandafter\label\expandafter{\sheet@sheet@label}%
    \def\sheet@sheet@label{}%
  }
  \nobreak
  \vskip 1.5em
  \@afterheading
  \sheet@setnarrow
}

%
% \exercise
%

\newcommand\exercise{\@ifnextchar[\sheet@start@exercise{\sheet@start@exercise[]}}

\def\sheet@start@exercise[#1]{
  % parse keys
  \setkeys{sheet@exercise}{label={},credits=-1,#1}
  \sheet@setwide
  % typeset 
  \@startsection{exercise}{2}{\z@}%
                {-3ex \@plus -1ex \@minus -.2ex}%
                {1ex \@plus .2ex}%
                {\normalfont\sheetexercisefont}%
                [\insertexercisetitle]{\sheet@exercise@titletemplate}%
  \sheet@ifempty{\sheet@exercise@label}{}{%
    \expandafter\label\expandafter{\sheet@exercise@label}%
    \def\sheet@exercise@label{}%
  }%
  \sheet@setnarrow
}

\def\sheet@exercise@titletemplate{%
  \insertexercisetitle
  \ifnum\insertexercisecredits>-1
    \sheet@ifempty{\insertexercisetitle}{}{, }%
    \insertexercisecredits~%
    \ifnum\insertexercisecredits=1
      \creditname
    \else
      \creditsname
    \fi
  \fi
}

%
% \subexercise
%

\newcommand\subexercise{\@ifnextchar[\sheet@start@subexercise{\sheet@start@subexercise[]}}

\def\sheet@start@subexercise[#1]{
  % parse keys
  \setkeys{sheet@subexercise}{label={},credits=-1,#1}
  \sheet@setwide
  % typeset 
  \@startsection{subexercise}{3}{\z@}%
                {-2ex \@plus -1ex \@minus -.2ex}%
                {.3ex \@plus .2ex}%
                {\normalfont\sheetsubexercisefont}%
                [\insertsubexercisetitle]{\sheet@subexercise@titletemplate}%
  \sheet@ifempty{\sheet@subexercise@label}{}{%
    \expandafter\label\expandafter{\sheet@subexercise@label}%
    \def\sheet@subexercise@label{}%
  }%
  \sheet@setnarrow
}

\def\sheet@subexercise@titletemplate{%
  \insertsubexercisetitle
  \ifnum\insertsubexercisecredits>-1
    \sheet@ifempty{\insertsubexercisetitle}{}{, }%
    \insertsubexercisecredits~%
    \ifnum\insertsubexercisecredits=1
      \creditname
    \else
      \creditsname
    \fi
  \fi
}

% 
% \@seccntformat
%

\def\@seccntformat#1{\csname #1name\endcsname~\csname the#1\endcsname\quad}

%
% \solution
%

\newcommand\solution{\@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}}

\def\sheet@solution@refseccntformat#1{%
  \solutionname~\forname~%
    \expandafter\ref\expandafter{\sheet@solution@exerciselabel}%
}

\def\sheet@solution@plainseccntformat#1{%
  \solutionname
}

\def\sheet@start@solution[#1]{
  % parse keys
  \setkeys{sheet@solution}{exerciselabel={},#1}
  % typeset 
  \let\sheet@orig@seccntformat=\@seccntformat % hackery...
  \sheet@ifempty{\sheet@solution@exerciselabel}{%
    \let\@seccntformat=\sheet@solution@plainseccntformat
  }{%
    \let\@seccntformat=\sheet@solution@refseccntformat
  }%
  \@startsection{solution}{1}{\z@}%
                {-3.5ex \@plus -1ex \@minus -.2ex}%
                {2.3ex \@plus .2ex}%
                {\normalfont\small\sffamily\bfseries}%
                {}
  \let\@seccntformat=\sheet@orig@seccntformat
}

%
% table of contents
%

\def\@makeschapterhead#1{%
  {%
    \parindent\z@
    \raggedright
    \normalfont
    \sheettitlefont
    \interlinepenalty\@M
    #1 \par \nobreak
    \vskip 40\p@
  }%
}

\def\@pnumwidth{2em}

\setcounter{tocdepth}{1}

%
% counters
%

\setcounter{secnumdepth}{3}

\newcounter{sheet}
\newcounter{exercise}[sheet]
\newcounter{subexercise}[exercise]
\newcounter{solution}

\def\thesheet{\@arabic\c@sheet}
\def\theexercise{\thesheet.\@arabic\c@exercise}
\def\thesubexercise{\theexercise.\@arabic\c@subexercise}

\let\sheet@orig@thepage=\thepage
\def\thepage{\thesheet~--~\sheet@orig@thepage}

% 
% marks
%

\newcommand*\sheetmark[1]{}
\newcommand*\exercisemark[1]{}
\newcommand*\subexercisemark[1]{}

%
% helper
%

\long\def\sheet@firstoftwo#1#2{#1}
\long\def\sheet@secondoftwo#1#2{#2}
\def\sheet@empty{}

\long\def\sheet@ifempty#1#2#3{%
  \edef\sheet@tmp{#1}%
  \ifx\sheet@empty\sheet@tmp
    \expandafter\sheet@firstoftwo
  \else
    \expandafter\sheet@secondoftwo
  \fi
  {#2}{#3}%
}

%
% hyperref support
%

\newcommand\theHsheet{\@arabic\c@sheet}
\newcommand\theHexercise{\theHsheet.\@arabic\c@exercise}
\newcommand\theHsubexercise{\theHexercise.\@arabic\c@subexercise}

\def\texorpdfstring#1#2{#1}

\def\toclevel@sheet{0}
\def\toclevel@exercise{1}
\def\toclevel@subexercise{2}

\let\l@sheet=\l@chapter
\let\l@exercise=\l@section
\let\l@subexercise=\l@subsection
