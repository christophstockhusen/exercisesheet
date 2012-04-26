%% exercisesheet.cls
%% Copyright 2012 Christoph Stockhusen
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
\ProvidesClass{exercisesheet}[2012/04/26]

\RequirePackage{pgfkeys}
\RequirePackage{environ}


% --------------------------------------------------------------------
%
% helper
%
% --------------------------------------------------------------------

\long\def\sheet@firstoftwo#1#2{#1}
\long\def\sheet@secondoftwo#1#2{#2}
\def\sheet@empty{}

\long\def\sheet@ifempty#1#2#3{%
  \def\sheet@tmp{#1}%
  \ifx\sheet@empty\sheet@tmp
    \expandafter\sheet@firstoftwo
  \else
    \expandafter\sheet@secondoftwo
  \fi
  {#2}{#3}%
}

\long\def\sheet@ifempty@#1#2#3{%
  \expandafter\sheet@ifempty\expandafter{#1}{#2}{#3}%
}

\long\def\sheet@ifempty@@#1#2#3{%
  \expandafter\sheet@ifempty@\expandafter{#1}{#2}{#3}%
}

\long\def\sheet@ifempty@@@#1#2#3{%
  \expandafter\sheet@ifempty@@\expandafter{#1}{#2}{#3}%
}

\long\def\sheet@ifempty@@@@#1#2#3{%
  \expandafter\sheet@ifempty@@@\expandafter{#1}{#2}{#3}%
}

\long\def\sheet@ifempty@@@@@#1#2#3{%
  \expandafter\sheet@ifempty@@@@\expandafter{#1}{#2}{#3}%
}

% --------------------------------------------------------------------
%
% Setting up the Key Tree
%
% --------------------------------------------------------------------

\newdimen\sheet@tempdima
\newdimen\sheet@tempdimb

% \newif\if@sheet@student
\newif\if@sheet@teacher \@sheet@teacherfalse
\newif\if@sheet@solutions \@sheet@solutionstrue
\newif\if@sheet@annotations \@sheet@annotationstrue

\pgfkeys{%
  %
  % global keys
  %
  /exercisesheet/.cd,
  %
  % student/.is if=@sheet@student,
  % student/.initial=true,
  % student/.default=true,
  teacher/.is if=@sheet@teacher,
  teacher/.initial=false,
  teacher/.default=true,
  %
  textwidthval/.value required,
  textwidthval/.initial=0pt,
  %
  textwidth/.value required,
  %
  narrowtextwidthval/.value required,
  narrowtextwidthval/.initial=0pt,
  %
  narrowtextwidth/.value required,
  %
  narrowfactor/.value required,
  %
  % nonarrow/.is if=@sheet@nonarrow,
  % nonarrow/.initial=false,
  % nonarrow/.default=true,
  %
  solutions/.is if=@sheet@solutions,
  solutions/.initial=true,
  solutions/.default=true,
  %
  annotations/.is if=@sheet@annotations,
  annotations/.initial=true,
  annotations/.default=true,
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
  % options of the underlying class
  %
  % a4paper/.code={%
  %   \setlength\paperheight{297mm}%
  %   \setlength\paperwidth{210mm}%
  % },
  % %
  % letterpaper/.code={%
  %   \setlength\paperheight{11in}%
  %   \setlength\paperwidth{8.5in}%
  % },
  % %
  % 10pt/.code={\message{====>lol}\def\@ptsize{0}},
  % 11pt/.code={\def\@ptsize{1}},
  % 12pt/.code={\def\@ptsize{2}},
  % %
  % oneside/.code={\@twosidefalse\@mparswitchfalse},
  % twoside/.code={\@twosidetrue\@mparswitchtrue},
  % %
  % draft/.code={\setlength\overfullrule{5pt}},
  % final/.code={\setlength\overfullrule{0pt}},
  % %
  % titlepage/.code={\@titlepagetrue},
  % notitlepage/.code={\@titlepagefalse},
  % %
  % openright/.code={\@openrighttrue},
  % openany/.code={\@openrightfalse},
  % %
  % leqno/.code={\input{leqno.clo}},
  % fleqn/.code={\input{fleqn.clo}},
  %
  % fonts
  %
  /exercisesheet/fonts/.cd,
  %
  basic/.value required,
  basic/.initial=\normalfont\rmfamily,
  %
  sheet title/.value required,
  sheet title/.initial=\sffamily\fontsize{32}{40}\selectfont,
  %
  sheet topic/.value required,
  sheet topic/.initial=\sffamily\Huge,
  %
  sheet deadline/.value required,
  sheet deadline/.initial=\sffamily\LARGE,
  %
  sheet author/.value required,
  sheet author/.initial=\sffamily\small,
  %
  sheet lecture/.value required,
  sheet lecture/.initial=\sffamily\small,
  %
  sheet lecturer/.value required,
  sheet lecturer/.initial=\sffamily\small,
  %
  sheet semester/.value required,
  sheet semester/.initial=\sffamily\small,
  %
  exercise topic/.value required,
  exercise topic/.initial=\small\sffamily,
  %
  exercise label/.value required,
  exercise label/.initial=\small\sffamily,
  %
  subexercise topic/.value required,
  subexercise topic/.initial=\footnotesize\sffamily,
  %
  subexercise label/.value required,
  subexercise label/.initial=\footnotesize\sffamily,
  %
  lecture on titlepage/.value required,
  lecture on titlepage/.initial=\sffamily\huge,
  %
  lecturer on titlepage/.value required,
  lecturer on titlepage/.initial=\sffamily\large,
  %
  author on titlepage/.value required,
  author on titlepage/.initial=\sffamily\large,
  %
  semester on titlepage/.value required,
  semester on titlepage/.initial=\sffamily\large,
  %
  type on titlepage/.value required,
  type on titlepage/.initial=\sffamily\Large,
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
  label/.value required,
  label/.initial={},
  %
  % exercises
  /exercisesheet/variables/exercise/.cd,
  %
  topic/.value required,
  topic/.initial={},
  %
  credits/.value required,
  credits/.initial={-1},
  %
  label/.value required,
  label/.initial={},
  %
  % subexercises
  /exercisesheet/variables/subexercise/.cd,
  %
  topic/.value required,
  topic/.initial={},
  %
  credits/.value required,
  credits/.initial={-1},
  %
  label/.value required,
  label/.initial={},
  %
  % solutions
  /exercisesheet/variables/solution/.cd,
  %
  of/.value required,
  of/.initial={},
  %
  % annotations
  /exercisesheet/variables/annotations/.cd,
  %
  body/.value required,
  body/.initial={},
  %
  %
  % templates
  %
  /exercisesheet/templates/.cd,
  %
  % generic templates
  %
  sheet title (student)/.value required,
  sheet title (student)/.initial={%
    Solutions for Exercise~Sheet~\thesheet{}%
  },
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
  sheet front matter (generic)/.value required,
  sheet front matter (generic)/.initial={%
    \sheet@ifusetemplateempty{\usesheettopic}{%
      \vskip 1ex \par
    }{%
      \begingroup
        \usesheetfont{sheet topic}{%
          \usesheettopic
          \vskip 1ex \par
        }%
      \endgroup
    }%
    \sheet@ifusetemplateempty{\usesheetdeadline}{}{%
      \begingroup
        \usesheetfont{sheet deadline}{%
          \usesheetdeadline
          \vskip 1.5ex \par
        }%
      \endgroup
    }%
    \sheet@ifusetemplateempty{\insertlecture}{}{%
      \begingroup
        \usesheetfont{sheet lecture}{%
          \vskip .5ex
          \insertlecture%
          \vskip .5ex
        }%
      \endgroup
    }%
    \sheet@ifusetemplateempty{\insertlecturer}{}{%
      \begingroup
        \usesheetfont{sheet lecturer}{%
          \vskip .5ex
          \insertlecturer%
          \vskip .5ex
        }%
      \endgroup
    }%
    \sheet@ifusetemplateempty{\insertsemester}{}{%
      \begingroup
        \usesheetfont{sheet semester}{%
          \vskip .5ex
          \insertsemester
          \vskip .5ex \par
        }%
      \endgroup
    }%
    \begingroup
      \usesheetfont{sheet author}{%
        \vskip 2.5ex
        \insertauthor
        \vskip 2.5ex \par
      }
    \endgroup
  },
  %
  sheet front matter (student)/.value required,
  sheet front matter (student)/.initial={%
    \begingroup
      \usesheetfont{sheet title}{%
        \usesheettemplate{sheet title (student)}%
        \vskip .5ex \par
      }%
    \endgroup
    \usesheettemplate{sheet front matter (generic)}%
  },
  %
  sheet front matter (teacher without solutions)/.value required,
  sheet front matter (teacher without solutions)/.initial={%
    \begingroup
      \usesheetfont{sheet title}{%
        \usesheettemplate{sheet title (teacher without solutions)}%
        \vskip .5ex \par
      }%
    \endgroup
    \usesheettemplate{sheet front matter (generic)}%
  },
  %
  sheet front matter (teacher with solutions)/.value required,
  sheet front matter (teacher with solutions)/.initial={%
    \begingroup
      \usesheetfont{sheet title}{%
        \usesheettemplate{sheet title (teacher with solutions)}%
        \vskip .5ex \par
      }%
    \endgroup
    \usesheettemplate{sheet front matter (generic)}%
  },
  %
  exercise title/.value required,
  exercise title/.initial={%
    \useexercisetopic
    \ifnum\useexercisecredits>-1
      \sheet@ifusetemplateempty{\useexercisetopic}{}{, }%
      \usesheettemplate{exercise title (credits)}
    \fi
  },
  %
  exercise title (credits)/.value required,
  exercise title (credits)/.initial={%
    \useexercisecredits~%
    \ifnum\useexercisecredits=1
      \usesheettemplate{credit name}%
    \else
      \usesheettemplate{credits name}%
    \fi
  },
  %
  subexercise title/.value required,
  subexercise title/.initial={%
    \usesubexercisetopic
    \ifnum\usesubexercisecredits>-1
      \sheet@ifusetemplateempty{\usesubexercisetopic}{}{, }%
      \usesheettemplate{subexercise title (credits)}
    \fi
  },
  %
  subexercise title (credits)/.value required,
  subexercise title (credits)/.initial={%
    \usesubexercisecredits~%
    \ifnum\usesubexercisecredits=1
      \usesheettemplate{credit name}%
    \else
      \usesheettemplate{credits name}%
    \fi
  },
  %
  title page/.value required,
  title page/.initial={%
    \begin{titlepage}
      % insert logo if defined
      \ifx\insertsheetlogo\relax
      \else
        \leavevmode
        \insertsheetlogo
        \par \bigskip
      \fi
      \null \vskip.2\textheight
      \begingroup 
        \normalfont
        % lecture title
        \begingroup
          \usesheetfont{lecture on titlepage}{\insertlecture}%
          \par\medskip%
        \endgroup
        \begingroup
          \usesheetfont{lecturer on titlepage}{\insertlecturer}%
          \par\bigskip
        \endgroup
        % document type (exercises, exercises with solutions, solutions)
        \begingroup
          \if@sheet@teacher
            \if@sheet@solutions
              \usesheetfont{type on titlepage}{%
                \usesheettemplate{sheet type (exercises with sample solutions)}%
              }%
              \par\bigskip
            \else
              \usesheetfont{type on titlepage}{%
                \usesheettemplate{sheet type (exercises)}%
              }%
              \par\bigskip
            \fi
          \else
            \usesheetfont{type on titlepage}{%
              \usesheettemplate{sheet type (solutions)}%
            }%
            \par\bigskip
          \fi
        \endgroup
        \begingroup
          \usesheetfont{author on titlepage}{\insertauthor}%
          \par
          \usesheetfont{semester on titlepage}{\insertsemester}%
          \par
        \endgroup
      \endgroup
    \end{titlepage}%
  },
  %
  sheet name/.value required,
  sheet name/.initial={Sheet},
  %
  exercise name/.value required,
  exercise name/.initial={Exercise},
  %
  subexercise name/.value required,
  subexercise name/.initial={Subexercise},
  %
  deadline name/.value required,
  deadline name/.initial={Deadline},
  %
  credit name/.value required,
  credit name/.initial={Credit},
  %
  credits name/.value required,
  credits name/.initial={Credits},
  %
  sheet type (exercises with sample solutions)/.value required,
  sheet type (exercises with sample solutions)/.initial={%
    Exercises with Sample Solutions%
  },
  %
  sheet type (exercises)/.value required,
  sheet type (exercises)/.initial={%
    Exercises%
  },
  %
  sheet type (solutions)/.value required,
  sheet type (solutions)/.initial={%
    Solutions%
  },
  %
  exercises name/.value required,
  exercises name/.initial={%
    Exercises%
  },
  %
  solutions name/.value required,
  solutions name/.initial={%
    Solutions%
  },
  %
  solution title (with reference)/.value required,
  solution title (with reference)/.initial={%
    Solution~of~\ref{\useexerciselabelofsolution}%
  },
  %
  solution title (without reference)/.value required,
  solution title (without reference)/.initial={%
    Solution%
  },
  %
  annotation/.value required,
  annotation/.initial={\insertannotationbody},
}

\pgfkeysdef{/exercisesheet/variables/sheet/number}{%
  \setcounter{sheet}{#1}%
  \addtocounter{sheet}{-1}%
}

\pgfkeysdef{/exercisesheet/variables/exercise/number}{%
  \setcounter{exercise}{#1}%
  \addtocounter{exercise}{-1}%
}

\pgfkeysdef{/exercisesheet/variables/subexercise/number}{%
  \setcounter{subexercise}{#1}%
  \addtocounter{subexercise}{-1}%
}

\pgfkeysdef{/exercisesheet/textwidth}{%
  % Ugly fully expanding.
  \sheet@tempdima=#1
  \sheet@tempdima=\the\sheet@tempdima
  \pgfqkeys{/exercisesheet}{textwidthval/.expanded=\the\sheet@tempdima}%
}

\pgfkeysdef{/exercisesheet/narrowtextwidth}{%
  % Ugly fully expanding.
  \sheet@tempdima=#1
  \sheet@tempdima=\the\sheet@tempdima
  \pgfqkeys{/exercisesheet}{narrowtextwidthval/.expanded=\the\sheet@tempdima}%
}

\pgfkeysdef{/exercisesheet/narrowfactor}{%
  % Ugly fully expanding.
  \sheet@tempdima=\sheet@textwidth
  \sheet@tempdima=#1\sheet@tempdima
  \pgfqkeys{/exercisesheet}{%
    narrowtextwidth/.expanded=\the\sheet@tempdima
  }%
}

% Set Global Options

\def\sheetconf#1{\pgfqkeys{/exercisesheet}{#1}}


% Generic Getter and Setter Methods

\def\sheet@generickeysetter#1#2{%
  \pgfkeyssetvalue{/exercisesheet/#1}{#2}%
}

\def\sheet@generickeygetter#1{%
  \pgfkeysvalueof{/exercisesheet/#1}%
}


% Test whether template is the empty string

\long\def\sheet@ifusetemplateempty#1#2#3{%
  \sheet@ifempty@@@@@{#1}{#2}{#3}%
}


% Getter and Setter for Fonts

\def\setsheetfont#1#2{%
  \sheet@generickeysetter{fonts/#1}{#2}%
}
\def\usesheetfont#1{%
  \sheet@generickeygetter{fonts/#1}%
}


% Getter and Setter for Templates

\def\setsheettemplate#1#2{%
  \sheet@generickeysetter{templates/#1}{#2}%
}
\def\usesheettemplate#1{%
  \sheet@generickeygetter{templates/#1}%
}


% Getter and Setter for Semester

\def\insertsemester{%
  \sheet@generickeygetter{semester}%
}
\def\semester#1{%
  \sheet@generickeysetter{semester}{#1}%
}


% Getter and Setter for Author

\def\insertauthor{%
  \sheet@generickeygetter{author}%
}
\def\author#1{%
  \sheet@generickeysetter{author}{#1}%
}
\newcommand*\student[1]{%
  \author{#1}%
}
\newcommand*\insertstudent{\insertauthor}


% Getter and Setter for Sheets

\def\usesheettopic{%
  \sheet@generickeygetter{variables/sheet/topic}%
}

\def\usesheetdeadline{%
  \sheet@generickeygetter{variables/sheet/deadline}%
}

\def\usesheetlabel{%
  \sheet@generickeygetter{variables/sheet/label}%
}


% Getter and Setter for Exercises and Subexercises

\def\useexercisetopic{%
  \sheet@generickeygetter{variables/exercise/topic}%
}

\def\useexercisecredits{%
  \sheet@generickeygetter{variables/exercise/credits}%
}

\def\useexerciselabel{%
  \sheet@generickeygetter{variables/exercise/label}%
}

\def\usesubexercisetopic{%
  \sheet@generickeygetter{variables/subexercise/topic}%
}

\def\usesubexercisecredits{%
  \sheet@generickeygetter{variables/subexercise/credits}%
}

\def\usesubexerciselabel{%
  \sheet@generickeygetter{variables/subexercise/label}%
}

\def\useexerciselabelofsolution{%
  \sheet@generickeygetter{variables/solution/of}%
}

% Getter and Setter for the Lecture Name

\newcommand*\lecture[1]{%
  \sheet@generickeysetter{lecture}{#1}%
}
\newcommand*\insertlecture{%
  \sheet@generickeygetter{lecture}%
}

% Getter and Setter for the Lecturer

\newcommand*\lecturer[1]{%
  \sheet@generickeysetter{lecturer}{#1}%
}
\newcommand*\insertlecturer{%
  \sheet@generickeygetter{lecturer}%
}

% Getter for Annotations

\newcommand*\getannotationbody{%
  \sheet@generickeygetter{variables/annotations/body}%
}

\newcommand*\insertannotationbody{%
  \sheet@generickeygetter{variables/annotations/body}%
}

\newcommand*\setannotationbody[1]{%
  \sheet@generickeysetter{variables/annotations/body}{#1}%
}

  
% --------------------------------------------------------------------
%
% Loading the underlying class.
%
% --------------------------------------------------------------------

% \DeclareOption*{\expandafter\sheetconf\expandafter{\CurrentOption}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

% 

\def\exercisesheet{{\upshape\texttt{exercisesheet}}}

%
% 
%

% --------------------------------------------------------------------
% 
% Setting up the default layout.
%
% --------------------------------------------------------------------

\textwidth=\paperwidth
\advance\textwidth by -4cm
\oddsidemargin=2cm
\advance\oddsidemargin by -1in
\hoffset=0pt

\textheight=\paperheight
\advance\textheight by -4cm
\topmargin=\paperheight
\advance\topmargin by -\textheight
\topmargin=.5\topmargin
\advance\topmargin by -\headheight
\advance\topmargin by -\headsep
\advance\topmargin by -1in
\voffset=0pt

\marginparsep=1.5em

\pgfqkeys{/exercisesheet}{
  textwidth=\textwidth,
  narrowtextwidth=.7\textwidth,
}

\parindent=0pt
\parskip=\smallskipamount

% --------------------------------------------------------------------
%
% Macros for switching between the narrow and the wide layouts.
%
% --------------------------------------------------------------------

\newif\if@sheet@isnarrow
\@sheet@isnarrowfalse

\def\sheet@textwidth{\sheet@generickeygetter{textwidthval}}
\def\sheet@narrowtextwidth{\sheet@generickeygetter{narrowtextwidthval}}

% \sheet@checkTWchanges checks whether the dimension stored in
% \textwidth has changed, i.e. doesn't correspond to the dimensions
% stored in \sheet@textwidth and \sheet@narrowtextwidth. If the
% dimensions don't fit, the internal dimensions named above get
% recomputed.
%
% This does not capture changes on the narrowfactor! (TODO)

\def\sheet@checkandrecomputetextwidth{%
  \if@sheet@isnarrow
    \@tempdima=\sheet@narrowfactor\sheet@textwidth
  \else
    \@tempdima=\sheet@textwidth
  \fi
  \ifdim\textwidth=\@tempdima\else
    % textwidth has changes: recompute narrow width
    \sheet@textwidth=\textwidth
    \sheet@narrowtextwidth=\sheet@narrowfactor\sheet@textwidth
  \fi
}

\def\sheet@setwide{%
  \sheet@setsheetwidth{\sheet@textwidth}%
  \@sheet@isnarrowfalse
  % Recompute marginparwidth.
  \sheet@computemarginparwidth
}

\def\sheet@setnarrow{%
  \sheet@setsheetwidth{\sheet@narrowtextwidth}%
  \@sheet@isnarrowtrue
  % Recompute marginparwidth.
  \sheet@computemarginparwidth
}

\def\sheet@setsheetwidth#1{%
  \sheet@tempdima     = #1
  \global\textwidth   = \the\sheet@tempdima
  \global\columnwidth = \the\sheet@tempdima
  \global\hsize       = \the\sheet@tempdima
  \global\linewidth   = \the\sheet@tempdima
}

\def\sheet@computemarginparwidth{%
  \ifnum\textwidth=\sheet@textwidth
    \marginparwidth=0pt
  \else
    \marginparwidth=\sheet@textwidth
    \advance\marginparwidth by -\textwidth
    \advance\marginparwidth by -\marginparsep
  \fi
}

% --------------------------------------------------------------------
%
% Pagestyles.
%
% --------------------------------------------------------------------

\def\ps@headings{%
  \let\@oddhead\@empty
  \def\@oddfoot{\hbox to \sheet@textwidth{\footnotesize\hfil\thepage}\hss}%
  \let\@mkboth\markboth}

\let\ps@plain\ps@empty

\pagestyle{headings}


% --------------------------------------------------------------------
%
% Defining the names that are used within the titles of the sheets,
% exercises and subexercises (especially by @seccntformat).
%
% --------------------------------------------------------------------

% \newcommand\sheetname{Exercise Sheet}
% \newcommand\sheetdeadline{Deadline}
% \newcommand\exercisename{Exercise}
% \newcommand\subexercisename{Subexercise}
% \newcommand\solutionname{Solution}

\newcommand\sheetname{\usesheettemplate{sheet name}}
\newcommand\sheetdeadline{\usesheettemplate{deadline name}}
\newcommand\exercisename{\usesheettemplate{exercise name}}
\newcommand\subexercisename{\usesheettemplate{subexercise name}}
\newcommand\solutionname{\usesheettemplate{solution title (without reference)}}


% --------------------------------------------------------------------
% 
% \@seccntformat
%
% --------------------------------------------------------------------

\def\@seccntformat#1{%
  \usesheetfont{#1 label}%
  \csname #1name\endcsname~\csname the#1\endcsname\quad
}%


% --------------------------------------------------------------------
%
% The \maketitle command for typesetting the title page.
%
% --------------------------------------------------------------------

\def\maketitle{\usesheettemplate{title page}}

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
  \pgfqkeys{/exercisesheet/variables/sheet}{%
    label={},
    topic={},
    deadline={},%
    #1%
  }%
  %
  % advance internal counter for sheets
  \advance\sheet@sheetcnt by 1
  % begin new page
  \global\@topnum\z@
  \setcounter{page}{1}%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{sheet}%
    \addcontentsline{toc}{sheet}{%
      \protect\numberline{\sheetname~\thesheet}\usesheettopic%
    }%
  \else
    \addcontentsline{toc}{sheet}{\usesheettopic}%
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
      \if@sheet@teacher
        % teacher mode
        % \ifsolution
        \if@sheet@solutions
          \usesheettemplate{sheet front matter (teacher with solutions)}
        \else
          \usesheettemplate{sheet front matter (teacher without solutions)}
        \fi
      \else
        % student mode
        \usesheettemplate{sheet front matter (student)}
      \fi
      \par
    }%
  }%
  \sheet@ifusetemplateempty{\usesheetlabel}{}{%
    \label{\usesheetlabel}%
  }
  \nobreak
  \vskip .5em
  \@afterheading
  \sheet@setnarrow
}

% --------------------------------------------------------------------
%
% \exercise
%
% --------------------------------------------------------------------

\newcommand\exercise{%
  \@ifnextchar[%
    \sheet@start@exercise%
    {\sheet@start@exercise[]}%
}

\def\sheet@start@exercise[#1]{
  \pgfqkeys{/exercisesheet/variables/exercise}{%
    label={},
    topic={},
    credits=-1,%
    #1%
  }%
  \par\sheet@setwide
  \@startsection{exercise}{2}{\z@}%
                {-3ex \@plus -.2ex \@minus -.2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\usesheetfont{exercise topic}}%
                [\useexercisetopic]%
                {\usesheettemplate{exercise title}}%
  \sheet@ifusetemplateempty{\useexerciselabel}{}{%
    \label{\useexerciselabel}%
  }%
  \nobreak\par\sheet@setnarrow
}

% --------------------------------------------------------------------
%
% \subexercise
%
% --------------------------------------------------------------------

\newcommand\subexercise{%
  \@ifnextchar[%
    \sheet@start@subexercise%
    {\sheet@start@subexercise[]}%
}

\def\sheet@start@subexercise[#1]{
  \pgfqkeys{/exercisesheet/variables/subexercise}{%
    label={},
    topic={},
    credits=-1,%
    #1%
  }
  \par\sheet@setwide
  \@startsection{subexercise}{3}{\z@}%
                {-1.5ex \@plus -.1ex \@minus -.1ex}%
                {.75ex \@plus .1ex \@minus .1ex}%
                {\normalfont\usesheetfont{subexercise topic}}%
                [\usesubexercisetopic]%
                {\usesheettemplate{subexercise title}}%
  \sheet@ifusetemplateempty{\usesubexerciselabel}{}{%
    \label{\usesubexerciselabel}%
  }%
  \nobreak\par\sheet@setnarrow
}


% --------------------------------------------------------------------
%
% \solution
%
% --------------------------------------------------------------------

\def\sheet@solution@refseccntformat#1{%
  \usesheettemplate{solution title (with reference)}%
}

\def\sheet@solution@plainseccntformat#1{%
  \usesheettemplate{solution title (without reference)}%
}

\def\sheet@start@solution[#1]{
  % parse keys
  \pgfqkeys{/exercisesheet/variables/solution}{%
    of={},%
    #1%
  }
  % typeset 
  \let\sheet@orig@seccntformat=\@seccntformat % hackery...
  \sheet@ifusetemplateempty{\useexerciselabelofsolution}%
    {%
      \let\@seccntformat=\sheet@solution@plainseccntformat
    }{%
      \let\@seccntformat=\sheet@solution@refseccntformat
    }%
  \@startsection{solution}{2}{\z@}%
                {-3ex \@plus -.2ex \@minus -.2ex}%
                {1.5ex \@plus .2ex}%
                {\normalfont\usesheetfont{exercise topic}}%
                []{}%
  \let\@seccntformat=\sheet@orig@seccntformat
}

% --------------------------------------------------------------------
% 
% Solution environment for typesetting solutions that are only typeset
% when the "solutions" option is set.
%
% --------------------------------------------------------------------

\def\sheet@startsolution{%
  \@ifnextchar[\sheet@start@solution{\sheet@start@solution[]}%
}

\NewEnviron{solution}{%
  \if@sheet@solutions
    \expandafter\sheet@startsolution\BODY%
  \fi\par}{}

% --------------------------------------------------------------------
% 
% Annotation environment for typesetting annotations that are only
% typeset if the "annotation" option is set.
%
% --------------------------------------------------------------------

\NewEnviron{annotation}{%
  \if@sheet@annotations
    \expandafter\sheet@startannotation\BODY\sheet@stop%
  \fi}{}

\def\sheet@startannotation{%
  \@ifnextchar[\sheet@start@annotation{\sheet@start@annotation[]}%
}

\def\sheet@start@annotation[#1]#2\sheet@stop{%
  % Set keys.
  \pgfqkeys{/exercisesheet/variables/annotations}{#1}%
  % Store annotation.
  \setannotationbody{#2}%
  % Typeset annotation
  \usesheettemplate{annotation}%
}

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
    \usesheetfont{sheet title}
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

% Interal Counter for Sheets

\newcount\sheet@sheetcnt
\sheet@sheetcnt=0

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

