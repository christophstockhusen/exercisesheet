%% exercisesheet.cls
%% Copyright 2011 Christoph Stockhusen
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Christoph Stockhusen.
%
% This work consists of the file exercisesheet.cls.

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{exercisesheet}[2011/10/19]

\RequirePackage{xkeyval}
\RequirePackage{pgfkeys}
\RequirePackage{environ}
% \RequirePackage{graphicx}

% --------------------------------------------------------------------
%
% helper
%
% --------------------------------------------------------------------

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

% --------------------------------------------------------------------
%
% Setting up the Key Tree
%
% --------------------------------------------------------------------

\newif\if@sheet@student

\pgfkeys{%
  %
  % global keys
  %
  /exercisesheet/.cd,
  %
  student/.is if=@sheet@student,
  student/.initial=true,
  student/.default=true,
  %
  narrow/.initial=.7,
  narrow/.value required,
  nonarrow/.is if=@sheet@nonarrow,
  nonarrow/.initial=false,
  nonarrow/.default=true,
  %
  solution/.is if=@sheet@solution,
  solution/.initial=false,
  solution/.default=true,
  %
  author/.value required,
  author/.initial={NO AUTHOR DEFINED!},
  %
  lecture/.value required,
  lecture/.initial={NO LECTURE DEFINED!},
  %
  lecturer/.value required,
  lecturer/.initial={NO LECTURER DEFINED!},
  %
  semester/.value required,
  semester/.initial={NO SEMESTER DEFINED!},
  %
  %
  % fonts
  %
  /exercisesheet/fonts/.cd,
  %
  basic/.value required,
  basic/.initial=\normalfont\rmfamily,
  %
  sheet title/.value required,
  sheet title/.initial=\sffamily\fontsize{36}{40}\selectfont,
  %
  sheet topic/.value required,
  sheet topic/.initial=\sffamily\Huge,
  %
  sheet deadline/.value required,
  sheet deadline/.initial=\sffamily\LARGE,
  %
  sheet author/.value required,
  sheet author/.initial=\sffamily\footnotesize,
  %
  exercise topic/.value required,
  exercise topic/.initial=\small\sffamily,
  %
  subexercise topic/.value required,
  subexercise topic/.initial=\footnotesize\sffamily,
  %
  % variables
  %
  % sheets
  /exercisesheet/variables/sheet/.cd,
  %
  topic/.value required,
  topic/.initial={},
  %
  deadline/.value required,
  deadline/.initial={},
  %
  % exercises
  /exercisesheet/variables/exercise/.cd,
  %
  topic/.value required,
  topic/.initial={},
  %
  credits/.value required,
  credits/.initial={},
  %
  % subexercises
  /exercisesheet/variables/subexercise/.cd,
  %
  topic/.value required,
  topic/.initial={},
  %
  credits/.value required,
  credits/.initial={},
  %
  % templates
  %
  /exercisesheet/templates/.cd,
  %
  % generic templates
  %
  sheet topic/.value required,
  sheet topic/.initial={%
    \sheetusefont{sheet topic}{%
      \sheet@ifempty{\sheetgetsheettopic}{}{%
        \sheetgetsheettopic
        \par
      }%
    }%
  },
  %
  sheet topic
  %
  sheet deadline/.value required,
  sheet deadline/.initial={%
    \sheetusefont{sheet deadline}{%
      \sheet@ifempty{\sheetgetsheetdeadline}{}{%
        \insertsheettopic
        \par
      }%
    }%
  }
  sheet title (student)/.value required,
  sheet title (student)/.initial={Exercise~Sheet~\thesheet{}},
  %
  sheet title (teacher without solutions)/.value required,
  sheet title (teacher without solutions)/.initial={%
    Exercise~Sheet~\thesheet{}%
  },
  %
  sheet title (teacher with solutions)/.value required,
  sheet title (teacher with solutions)/.initial={%
    Exercise~Sheet~\thesheet{} with Solutions%
  },
  %
  sheet front matter (student)/.value required,
  sheet front matter (student)/.initial={%
    \sheetusefont{sheet title}{%
      \sheetinserttemplate{sheet title (student)}%
      \vskip .5ex \par
    }%
    \sheet@ifempty{\sheetgetsheettopic}{}{%
      \sheetusefont{sheet topic}{%
        \vskip .5ex
        \sheetgetsheettopic
        \vskip .5ex \par
      }
    }%
    \sheet@ifempty{\sheetinsertsemester}{}{%
      \sheetusefont{sheet author}{%
        \vskip 1ex
        \sheetinsertsemester
        \vskip 1ex \par
      }%
    }%
    \sheetusefont{sheet author}{%
      \vskip 1ex
      \sheetinsertauthor
      \vskip 1ex \par
    }
  },
  %
  sheet front matter (teacher without solutions)/.value required,
  sheet front matter (teacher without solutions)/.initial={},
  %
  sheet front matter (teacher with solutions)/.value required,
  sheet front matter (teacher with solutions)/.initial={},
  %
  exercise title/.value required,
  exercise title/.initial={},
  %
}


% \sheetsettemplate{sheet front matter generic (topic)}{%
%   \sheetusefont{sheet topic}{%
%     \sheet@ifempty{\insertsheettopic}{}{%
%       \insertsheettopic
%       \par\vskip 1em
%     }%
%   }%
% }
% 
% \sheetsettemplate{sheet front matter generic (lecture, semester)}{%
%   \sheetusefont{sheet author}{%
%     \sheet@ifempty{\insertlecture}{}{%
%       \lecturetype~\emph{\insertlecture}%
%     }%
%     \sheet@ifempty{\insertsemester}{}{%
%       \sheet@ifempty{\insertlecture}{}{, }%
%       \insertsemester%
%     }%
%     \sheet@ifempty{\insertlecture\insertsemester}{}{%
%       \par\vskip .5em
%     }%
%   }%
% }
% 
% \sheetsettemplate{sheet front matter student (main title)}{%
%   \sheettitlefont{%
%     Solutions for Exercise~Sheet~\thesheet{}%
%   }%
%   \par\vskip .5em
% }
% 
% \setsheettemplate{sheet front matter student (student name)}{%
%   \par\vskip .5em
%   \sheetstudentfont{\insertstudent}%
%   \par\vskip .5em
% }
% 
% \setsheettemplate{sheet front matter student}{%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter student (main title)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (topic)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (lecture, semester)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter student (student name)%
%   }
% }
% 
% \setsheettemplate{sheet front matter teacher solution (main title)}{%
%   \sheettitlefont{%
%     Exercise~Sheet~\thesheet{} with Sample~Solutions%
%   }%
%   \par\vskip .5em
% }
% 
% \setsheettemplate{sheet front matter teacher (teacher name)}{%
%   \par\vskip .5em
%   \sheetstudentfont{\insertlecturer}%
%   \par\vskip .5em
% }
% 
% \setsheettemplate{sheet front matter teacher solution}{%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter teacher solution (main title)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (topic)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (lecture, semester)%
%   }
%   \sheetinserttemplate[grouping]{%
%     sheet front matter teacher (teacher name)%
%   }
% }
% 
% \setsheettemplate{sheet front matter teacher no solution (main title)}{%
%   \sheettitlefont{%
%     Exercise~Sheet~\thesheet{}%
%   }%
%   \par\vskip .5em
% }
% 
% \setsheettemplate{sheet front matter teacher no solution}{%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter teacher no solution (main title)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (topic)%
%   }%
%   \sheetinserttemplate[grouping]{%
%     sheet front matter generic (lecture, semester)%
%   }
%   \sheetinserttemplate[grouping]{%
%     sheet front matter teacher (teacher name)%
%   }
% }
% 
% \setsheettemplate{exercises}{Exercises}
% 
% \setsheettemplate{solutions}{Solutions}
% 
% \setsheettemplate{solutions for exercise}{Solutions for Exercise}



% Generic Getter and Setter Methods

\def\sheet@generickeysetter#1#2#3{%
  \sheet@ifempty{#1}{%
    \pgfkeyssetvalue{/exercisesheet/#2}{#3}%
  }{%
    \pgfkeyssetvalue{/exercisesheet/#1/#2}{#3}%
  }%
}

\def\sheet@generickeygetter#1#2{%
  \sheet@ifempty{#1}{%
    \pgfkeysvalueof{/exercisesheet/#2}%
  }{%
    \pgfkeysvalueof{/exercisesheet/#1/#2}%
  }%
}


% Getter and Setter for Fonts

\def\sheetsetfont#1#2{%
  \sheet@generickeysetter{fonts}{#1}{#2}%
}

\def\sheetusefont#1{%
  \sheet@generickeygetter{fonts}{#1}%
}


% Getter and Setter for Templates

\def\sheetsettemplate#1#2{%
  \sheet@generickeysetter{templates}{#1}{#2}%
}

\def\sheetinserttemplate#1{%
  \sheet@generickeygetter{templates}{#1}%
}


% Getter and Setter for Semester

\def\sheetinsertsemester{%
  \sheet@generickeygetter{}{semester}%
}

\def\sheetsetsemester#1{%
  \sheet@generickeysetter{}{semester}{#1}%
}


% Getter and Setter for Author

\def\sheetinsertauthor{%
  \sheet@generickeygetter{}{author}%
}

\def\sheetsetauthor#1{%
  \sheet@generickeysetter{}{author}{#1}%
}


% Getter and Setter for Sheets

\def\sheetgetsheettopic{%
  \sheet@generickeygetter{variables/sheet}{topic}%
}

\def\sheetgetsheetdeadline{%
  \sheet@generickeygetter{variables/sheet}{deadline}%
}


% Getter and Setter for Exercises and Subexercises

\def\sheetgetexercisetopic{%
  \sheet@generickeygetter{variables/exercise}{topic}%
}

\def\sheetgetexercisecredits{%
  \sheet@generickeygetter{variables/exercise}{credits}%
}

\def\sheetgetsubexercisetopic{%
  \sheet@generickeygetter{variables/subexericse}{topic}%
}

\def\sheetgetsubexercisecredits{%
  \sheet@generickeygetter{variables/subexercise}{credits}%
}

  
% --------------------------------------------------------------------
%
% Loading the underlying class.
%
% --------------------------------------------------------------------

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

\DeclareOptionX{teacher}[true]{%
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

% --------------------------------------------------------------------
%
% Setting up the default fonts.
%
% --------------------------------------------------------------------

\def\sheettitlefont{\sffamily\fontsize{36}{40}\selectfont}
\def\sheettopicfont{\sffamily\Huge}
\def\sheetdeadlinefont{\sffamily\LARGE}
\def\sheetlecturefont{\sffamily\footnotesize}
\def\sheetsemesterfont{\sffamily\footnotesize}
\def\sheetlecturerfont{\sffamily\footnotesize}
\def\sheetstudentfont{\sffamily}
\def\sheetexercisetopicfont{\small\sffamily}
\def\sheetsubexercisetopicfont{\footnotesize\sffamily}

% --------------------------------------------------------------------
% 
% Setting up the default layout.
%
% --------------------------------------------------------------------

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

% --------------------------------------------------------------------
%
% Macros for switching between the narrow and the wide layouts.
%
% --------------------------------------------------------------------

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



% --------------------------------------------------------------------
%
% Pagestyles.
%
% --------------------------------------------------------------------

\def\ps@headings{%
  \let\@oddhead\@empty
  \def\@oddfoot{{\footnotesize \hfil \thepage}}%
  \let\@mkboth\markboth}

\let\ps@plain\ps@empty

\pagestyle{headings}

%
% Defining the keys for the sheets.
%

\define@key{sheet@sheet}{topic}{\sheet@sheet@topic={#1}}
\define@key{sheet@sheet}{deadline}{\sheet@sheet@deadline={#1}}
\define@key{sheet@sheet}{label}{\def\sheet@sheet@label{#1}}
\define@key{sheet@sheet}{credits}{\sheet@sheet@credits=#1}
\define@key{sheet@sheet}{number}{%
  \setcounter{sheet}{#1}%
  \addtocounter{sheet}{-1}%
}

\newtoks\sheet@sheet@topic
\newtoks\sheet@sheet@deadline
\def\sheet@sheet@label{}
\newcount\sheet@sheet@credits

% --------------------------------------------------------------------
%
% Defining the keys for the exercises.
%
% --------------------------------------------------------------------

\define@key{sheet@exercise}{topic}{\sheet@exercise@topic={#1}}
\define@key{sheet@exercise}{label}{\def\sheet@exercise@label{#1}}
\define@key{sheet@exercise}{credits}{\sheet@exercise@credits=#1}
\define@key{sheet@exercise}{number}{%
  \setcounter{exercise}{#1}%
  \addtocounter{exercise}{-1}%
}

\newtoks\sheet@exercise@topic
\def\sheet@exercise@label{}
\newcount\sheet@exercise@credits

% --------------------------------------------------------------------
%
% Defining the keys for the subexercises.
%
% --------------------------------------------------------------------

\define@key{sheet@subexercise}{topic}{\sheet@subexercise@topic={#1}}
\define@key{sheet@subexercise}{label}{\def\sheet@subexercise@label{#1}}
\define@key{sheet@subexercise}{credits}{\sheet@subexercise@credits=#1}
\define@key{sheet@subexercise}{number}{%
  \setcounter{subexercise}{#1}%
  \addtocounter{subexercise}{-1}%
}

\newtoks\sheet@subexercise@topic
\def\sheet@subexercise@label{}
\newcount\sheet@subexercise@credits

% --------------------------------------------------------------------
%
% Defining the keys for the solutions.
%
% --------------------------------------------------------------------

\define@key{sheet@solution}{exerciselabel}{\def\sheet@solution@exerciselabel{#1}}

\def\sheet@solution@exerciselabel{}

% --------------------------------------------------------------------
%
% Defining the names that are used within the titles of the sheets,
% exercises and subexercises.
%
% --------------------------------------------------------------------

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
\newcommand\lecturetype{Lecture}
\newcommand\solutionsbyname{Solutions by}

\def\setsheetname#1{\def\sheetname{#1}}
\def\setdeadlinename#1{\def\sheetdeadline{#1}}
\def\setexercisename#1{\def\exercisename{#1}}
\def\setsubexercisename#1{\def\subexercisename{#1}}
\def\setsolutionname#1{\def\solutionname{#1}}
\def\setcreditname#1{\def\creditname{#1}}
\def\setcreditsname#1{\def\creditsname{#1}}
\def\setlecturename#1{\def\lecturetype{#1}}
\def\setsolutionsbyname#1{\def\solutionsbyname{#1}}

% --------------------------------------------------------------------
%
% Insert commands for sheets, exercises, and subexercises.
%
% --------------------------------------------------------------------

\newcommand\insertsheettopic{\the\sheet@sheet@topic}
\newcommand\insertsheetdeadline{\the\sheet@sheet@deadline}
\newcommand\insertsheetcredits{\the\sheet@sheet@credits}

\newcommand\insertexercisetopic{\the\sheet@exercise@topic}
\newcommand\insertexercisecredits{\the\sheet@exercise@credits}

\newcommand\insertsubexercisetopic{\the\sheet@subexercise@topic}
\newcommand\insertsubexercisecredits{\the\sheet@subexercise@credits}

% --------------------------------------------------------------------
%
% The \maketitle command for typesetting the title page.
%
% --------------------------------------------------------------------

\def\maketitle{%
  \begin{titlepage}
    \ifx\insertsheetlogo\relax
    \else
      \leavevmode
      \insertsheetlogo
      \par \bigskip
    \fi
    \null \vskip .15\textheight
    \begingroup 
      \normalfont
      % lecture title
      \begingroup
        \sheettitlefont{\insertlecture}\par 
      \endgroup
      % document type (exercises, exercises with solutions, solutions)
      \begingroup
        \ifstudent
          \sheettopicfont{\insertsolutionsname}\par\medskip
        \else
          \ifsolution
            \sheettopicfont{\insertexerciseswithsamplesolutionsname}\par\medskip
          \else
            \sheettopicfont{\insertexercisesname}\par\medskip
          \fi
        \fi
      \endgroup
      \vskip .1\textheight
      \begingroup
        \ifstudent
          \sheetdeadlinefont{\insertstudent}\par
        \else
          \sheetdeadlinefont{\insertlecturer}\par
        \fi
        \sheetdeadlinefont{\insertsemester}\par
      \endgroup
    \endgroup
  \end{titlepage}%
}

% --------------------------------------------------------------------
%
% The \sheet command for typesetting the titling of a new exercise
% sheet.
%
% --------------------------------------------------------------------

\let\insertsheetlogo=\relax

\newcommand\sheet{\@ifnextchar[\sheet@start@sheet{\sheet@start@sheet[]}}

\@afterindentfalse

\def\sheet@start@sheet[#1]{
  % conclude the last sheet
  \clearpage
  % parse keys
  \setkeys{sheet@sheet}{label={},credits=-1,#1}%
  \pgfqkeys{/exercisesheet/variables/sheet}{#1}%
  % begin new page
  \global\@topnum\z@
  \setcounter{page}{1}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{sheet}%
    \addcontentsline{toc}{sheet}{\protect\numberline{\sheetname~\thesheet}\insertsheettopic}%
  \else
    \addcontentsline{toc}{sheet}{\insertsheettopic}%
  \fi
  \markboth{}{}%
  %
  % insert logo
  %
  \ifx\insertsheetlogo\relax
  \else
    \leavevmode
    \insertsheetlogo
    \par \bigskip
  \fi
  {%
    \sheet@setwide
    \parindent=0pt
    \parskip=0pt
    \interlinepenalty \@M
    {% 
      %
      % insert front matter
      %
      \normalfont
      %
      \ifstudent
        % student mode
        \sheetinserttemplate{sheet front matter (student)}
      \else
        % teacher mode
        \ifsolution
          % \sheetinserttemplate{sheet front matter teacher solution}
        \else
          % \sheetinserttemplate{sheet front matter teacher no solution}
        \fi
      \fi
      \par
    }%
  }%
  \sheet@ifempty{\sheet@sheet@label}{}{%
    \expandafter\label\expandafter{\sheet@sheet@label}%
    \def\sheet@sheet@label{}%
  }
  \nobreak
  \vskip .5em
  \@afterheading
  \sheet@setnarrow
}

% --------------------------------------------------------------------
%
% Title definitions.
%
% --------------------------------------------------------------------

\def\setsheettitlestudent#1{%
  \def\insertsheettitlestudent{#1}}

\def\setsheettitleteachersolution#1{%
  \def\insertsheettitleteachersolution{#1}}

\def\setsheettitleteachernosolution#1{%
  \def\insertsheettitleteachernosolution{#1}}

\def\setexercisesname#1{%
  \def\insertexercisesname{#1}}

\def\setexerciseswithsamplesolutionsname#1{%
  \def\insertexerciseswithsamplesolutionsname{#1}}

\def\setsolutionsname#1{%
  \def\insertsolutionsname{#1}}

\def\setsolutionforname#1{%
  \def\solutionforname{#1}}


\setsheettitlestudent{Solutions for Exercise~Sheet~\thesheet}
\setsheettitleteachersolution{Exercise~Sheet~\thesheet{} with 
  Sample~Solutions}
\setsheettitleteachernosolution{Exercise~Sheet~\thesheet{}}
\setexercisesname{Exercises}
\setexerciseswithsamplesolutionsname{Exercises with Sample~Solutions}
\setsolutionsname{Solutions}
\setsolutionforname{Solution for Exercise}

% --------------------------------------------------------------------
%
% Setting up the templates.
%
% --------------------------------------------------------------------

% --------------------------------------------------------------------
%
% \exercise
%
% --------------------------------------------------------------------

\newcommand\exercise{\@ifnextchar[\sheet@start@exercise{\sheet@start@exercise[]}}

\def\sheet@start@exercise[#1]{
  % parse keys
  \setkeys{sheet@exercise}{label={},credits=-1,#1}
  \sheet@setwide
  % typeset 
  \@startsection{exercise}{2}{\z@}%
                {-3ex \@plus -.2ex \@minus -.2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\sheetexercisetopicfont}%
                [\insertexercisetopic]%
                {\sheetinserttemplate{exercise title}}%
  \sheet@ifempty{\sheet@exercise@label}{}{%
    \expandafter\label\expandafter{\sheet@exercise@label}%
    \def\sheet@exercise@label{}%
  }%
  \sheet@setnarrow
}

\sheetsettemplate{exercise title}{%
  \insertexercisetopic
  \ifnum\insertexercisecredits>-1
    \sheet@ifempty{\insertexercisetopic}{}{, }%
    \insertexercisecredits~%
    \ifnum\insertexercisecredits=1
      \creditname
    \else
      \creditsname
    \fi
  \fi
}

% --------------------------------------------------------------------
%
% \subexercise
%
% --------------------------------------------------------------------

\newcommand\subexercise{\@ifnextchar[\sheet@start@subexercise{\sheet@start@subexercise[]}}

\def\sheet@start@subexercise[#1]{
  % parse keys
  \setkeys{sheet@subexercise}{label={},credits=-1,#1}
  \sheet@setwide
  % typeset 
  \@startsection{subexercise}{3}{\z@}%
                {-1.5ex \@plus -.1ex \@minus -.1ex}%
                {.75ex \@plus .1ex \@minus .1ex}%
                {\normalfont\sheetsubexercisetopicfont}%
                [\insertsubexercisetopic]%
                {\sheetinserttemplate{subexercise title}}%
  \sheet@ifempty{\sheet@subexercise@label}{}{%
    \expandafter\label\expandafter{\sheet@subexercise@label}%
    \def\sheet@subexercise@label{}%
  }%
  \sheet@setnarrow
}

\sheetsettemplate{subexercise title}{%
  \insertsubexercisetopic
  \ifnum\insertsubexercisecredits>-1
    \sheet@ifempty{\insertsubexercisetopic}{}{, }%
    \insertsubexercisecredits~%
    \ifnum\insertsubexercisecredits=1
      \creditname
    \else
      \creditsname
    \fi
  \fi
}

% --------------------------------------------------------------------
% 
% \@seccntformat
%
% --------------------------------------------------------------------

\def\@seccntformat#1{\csname #1name\endcsname~\csname the#1\endcsname\quad}

% --------------------------------------------------------------------
%
% \solution
%
% --------------------------------------------------------------------

% \newcommand\solution{\@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}}

\def\sheet@solution@refseccntformat#1{%
  \solutionforname~\expandafter\ref\expandafter{\sheet@solution@exerciselabel}%
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
                {\normalfont\sheetexercisetopicfont}%
                []{}%{\@seccntformat{}}
  \let\@seccntformat=\sheet@orig@seccntformat
}

% --------------------------------------------------------------------
% 
% Solution environment for typesetting solutions that are only typeset
% when the "solution" option is set.
%
% --------------------------------------------------------------------

\def\sheet@startsolution{%
  \@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}%
}

\NewEnviron{solution}{%
  \ifsolution
    \expandafter\sheet@startsolution\BODY%
  \fi}{}

% --------------------------------------------------------------------
%
% Table of Contents
%
%   The following redefinitions of LaTeX-macros contain only small
%   changes. However, as their original definitions are very complex
%   (and long) we always have to redefine the whole macro. If there
%   are only minor changes, they are labeled.
%
% --------------------------------------------------------------------

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

% --------------------------------------------------------------------
%
% Counters
%
% --------------------------------------------------------------------

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

% --------------------------------------------------------------------
% 
% marks
%
% --------------------------------------------------------------------

\newcommand*\sheetmark[1]{}
\newcommand*\exercisemark[1]{}
\newcommand*\subexercisemark[1]{}
\newcommand*\solutionmark[1]{}

% --------------------------------------------------------------------
%
% hyperref support
%
% --------------------------------------------------------------------

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

