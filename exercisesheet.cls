% Copyright 2011 by Christoph Stockhusen
%
% This file may be distributed and/or modified
%
% 1. under the LaTeX Project Public License and/or
% 2. under the GNU Public License.

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{exercisesheet}[2011/09/05]

\RequirePackage{xkeyval}
\RequirePackage{graphicx}
\RequirePackage{environ}

%
% Loading the underlying class.
%

%
% Keys for the class.
%

% Keys for the narrow layout.

\def\sheet@defaultnarrowfactor{.7}
\let\sheet@narrowfactor=\sheet@defaultnarrowfactor

\DeclareOptionX{narrowfactor}{\def\sheet@narrowfactor{#1}}

\DeclareOptionX{nonarrow}[true]{%
  \csname if#1\endcsname
    \def\sheet@narrowfactor{1}
  \else
    \let\sheet@narrowfactor=\sheet@defaultnarrowfactor
  \fi}

\DeclareOptionX{narrow}[true]{
  \csname if#1\endcsname
    \let\sheet@narrowfactor=\sheet@defaultnarrowfactor
  \else
    \def\sheet@narrowfactor{1}
  \fi}

% Keys for the student version.

\newif\ifstudent 

\DeclareOptionX{student}[true]{%
  \csname if#1\endcsname
    \studenttrue
  \else
    \strudentfalse
  \fi}

\DeclareOptionX{instructor}[true]{5
  \csname if#1\endcsname
    \studentfalse
  \else
    \studenttrue
  \fi}

% Keys for solutions.

\newif\ifsolution

\DeclareOptionX{solution}[true]{%
  \csname if#1\endcsname
    \solutiontrue
  \else
    \solutionfalse
  \fi}

\DeclareOptionX{nosolution}[true]{
  \csname if#1\endcsname
    \solutionfalse
  \else
    \solutiontrue
  \fi}

% Pass undeclared options to the underlying class file.

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{report}}

% Set default values for the class options.

\ExecuteOptionsX{narrow,student,solution}
\ProcessOptionsX
\LoadClass{report}

% 

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
% Setting up the default fonts.
%

\def\sheettitlefont{\sffamily\fontsize{36}{40}\selectfont}
\def\sheetsubtitlefont{\sffamily\Huge}
\def\sheetdeadlinefont{\sffamily\LARGE}
\def\sheetlecturefont{\sffamily\footnotesize}
\def\sheetsemesterfont{\sffamily\footnotesize}
\def\sheetlecturerfont{\sffamily\footnotesize}
\def\sheetstudentfont{\sffamily}
\def\sheetexercisefont{\small\sffamily}
\def\sheetsubexercisefont{\footnotesize\sffamily}

%
% Setting up the default layout.
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

\parindent=0pt
\parskip=\smallskipamount

%
% Macros for switching between the narrow and the wide layouts.
%

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
% Setting up the header and footer.
%

\def\ps@headings{%
  \let\@oddhead\@empty
  \def\@oddfoot{{\footnotesize \hfil \thepage}}%
  \let\@mkboth\markboth}

\let\ps@plain\ps@empty

\pagestyle{headings}

%
% Defining the keys for the sheets.
%

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

%
% Defining the keys for the exercises.
%

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

%
% Defining the keys for the subexercises.
%

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

%
% Defining the keys for the solutions.
%

\define@key{sheet@solution}{exerciselabel}{\def\sheet@solution@exerciselabel{#1}}

\def\sheet@solution@exerciselabel{}

%
% Defining the names that are used within the titles of the sheets,
% exercises and subexercises.
%

\newcommand\sheetname{Exercise Sheet}
\newcommand\sheetdeadline{Deadline}
\newcommand\exercisename{Exercise}
\newcommand\subexercisename{Subexercise}
\newcommand\solutionname{Solution}
\newcommand\solutionsname{Solutions}
\newcommand\forname{for}
\newcommand\byname{by}
\newcommand\creditname{credit}
\newcommand\creditsname{credits}

%
% Insert commands for sheets, exercises, and subexercises.
%

\newcommand\insertsheettitle{\the\sheet@sheet@title}
\newcommand\insertsheetdeadline{\the\sheet@sheet@deadline}
\newcommand\insertsheetcredits{\the\sheet@sheet@credits}

\newcommand\insertexercisetitle{\the\sheet@exercise@title}
\newcommand\insertexercisecredits{\the\sheet@exercise@credits}

\newcommand\insertsubexercisetitle{\the\sheet@subexercise@title}
\newcommand\insertsubexercisecredits{\the\sheet@subexercise@credits}

%
% The \maketitle command for typesetting the title page.
%

\def\maketitle{%
  \begin{titlepage}
    \null \vskip .25\textheight
    \begingroup 
      \ifsolution
        \begingroup
          \sheetsubtitlefont
          \solutionsname~\forname \par \medskip
        \endgroup
      \fi
      \sheettitlefont
      \insertlecture \par 
      \ifsolution
        \ifstudent
          \begingroup
            \sheetsubtitlefont
            \medskip
            \byname~\insertstudent \par
          \endgroup
        \fi
      \fi
      \vskip .1\textheight
      \begingroup
        \sheetdeadlinefont
        \insertlecturer \par
        \insertsemester \par
      \endgroup
    \endgroup
  \end{titlepage}%
}

%
% The \sheet command for typesetting the titling of a new exercise
% sheet.
%

\let\insertsheetlogo=\relax

\newcommand\sheet{\@ifnextchar[\sheet@start@sheet{\sheet@start@sheet[]}}

\@afterindentfalse

\def\sheet@start@sheet[#1]{
  % conclude the last sheet
  \clearpage
  % parse keys
  \setkeys{sheet@sheet}{label={},credits=-1,#1}
  % begin new page
  \setcounter{page}{1}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{sheet}%
    \addcontentsline{toc}{sheet}{\protect\numberline{\sheetname~\thesheet}\insertsheettitle}%
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
      \ifsolution
        \solutionsname~\forname~\sheetname~\thesheet
      \else
        \sheetname~\thesheet
      \fi
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
        \par \bigskip
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
        \par \medskip
        \sheetlecturerfont
        \insertlecturer 
      }%
    }%
    {%
      % student
      \ifstudent
        \sheet@ifempty{\insertstudent}{}{%
          \par \bigskip
          \sheetstudentfont
          \solutionsname~\byname~\insertstudent
        }%
      \fi
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
                {-3ex \@plus -.2ex \@minus -.2ex}%
                {1.5ex \@plus .2ex}%
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
                {-1.5ex \@plus -.1ex \@minus -.1ex}%
                {.75ex \@plus .1ex \@minus .1ex}%
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

% \newcommand\solution{\@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}}

\def\sheet@solution@refseccntformat#1{%
  \solutionname~\forname~\exercisename~%
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
  \@startsection{solution}{2}{\z@}%
                {-3ex \@plus -.2ex \@minus -.2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\sheetexercisefont}%
                []{}%{\@seccntformat{}}
  \let\@seccntformat=\sheet@orig@seccntformat
}

% 
% Solution environment for typesetting solutions that are only typeset
% when the "solution" option is set.
%

\def\sheet@startsolution{%
  \@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}%
}

\NewEnviron{solution}{%
  \ifsolution
    \expandafter\sheet@startsolution\BODY%
  \fi}{}

%
% Table of Contents
%
%   The following redefinitions of LaTeX-macros contain only small
%   changes. However, as their original definitions are very complex
%   (and long) we always have to redefine the whole macro. If there
%   are only minor changes, they are labeled.
%

% \@makeschapterhead is only used for typesetting the title of the
% table of contents. Therefore it is redefined to match the style of
% the sheet titles. Maybe this could be redefined to reduce the code
% duplication.

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

% \@pnumwidth is the width of the page number.

\def\@pnumwidth{3em}

% The tocdepth counter limits the depth of sheet/exercise/subexercise
% listed in the table of contents. 

\setcounter{tocdepth}{1}

% \l@chapter typesets the chapter entry in the table of contents. Only
% the width of the left margin for multi-line entries is adapted,

\def\l@chapter#1#2{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{9em}% <=========================
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

% \l@section and \l@subsection typeset the exercise/subexercise
% entries in the table of contents. The left margins are adapted.

\def\l@section{\@dottedtocline{1}{0em}{9em}}
\def\l@subsection{\@dottedtocline{2}{0em}{9em}}

% \numberline typesets the "Exercise 1.1" in the table of contents.

\def\numberline#1{\hb@xt@\@tempdima{\hfill #1\hskip 1em}}

% \@sect typesets the exercise/subexercise titles in the main text and
% creates the entries for the table of contents. Here, the numbering
% in the table of contents entry is augmented with the type of the
% corresponding section ("Exercise", "Subexercise").

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname #1name\endcsname~\csname the#1\endcsname}% <===
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     %\leaders\hbox{$\m@th
     %   \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
     %   mu$}\hfill
     \leaders\hbox to 1em{.\hss}\hfill % <===
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}

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
\let\thesolution=\theexercise

\let\sheet@orig@thepage=\thepage
\def\thepage{\thesheet~--~\sheet@orig@thepage}

% 
% marks
%

\newcommand*\sheetmark[1]{}
\newcommand*\exercisemark[1]{}
\newcommand*\subexercisemark[1]{}
\newcommand*\solutionmark[1]{}

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
\let\l@solution=\l@section
