% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lexmount Technical Report Class
% Adapted from FAIR / AILab pre-print style
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lexmount}[2026/05/04 v1.0 Lexmount Custom Class]
\LoadClassWithOptions{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[latin, english]{babel}
\RequirePackage{etoolbox}

\DisableLigatures[f]{family=sf*}

% Graphics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{wrapfig} % wrapfigure / wraptable for text wrapping around floats

% Tables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{booktabs}
\RequirePackage{nicematrix}
\RequirePackage{multirow}
\RequirePackage{bm}

% Brand colors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[most]{tcolorbox}
\definecolor{metafg}{HTML}{1C2B33}
\definecolor{metabg}{HTML}{1A3A8E} % Lexmount deep royal blue (title block, links)
\definecolor{wordmark}{HTML}{0C4EAE} % Logo-matching blue for the header wordmark

% First-page header with single logo
\RequirePackage{fancyhdr}
\setlength{\headheight}{1.3cm}
\fancypagestyle{firstheader}{
    \fancyhf{}
    \fancyhead[R]{%
        \begin{minipage}[c]{1.26cm}\centering
            \includegraphics[height=1.26cm]{assets/lexmount_logo.png}%
        \end{minipage}%
        \hspace{0.08cm}%
        \begin{minipage}[c]{3.2cm}
            {\sffamily\bfseries\color{wordmark}\fontsize{22pt}{26pt}\selectfont Lexmount}%
        \end{minipage}%
    }
    \renewcommand{\headrulewidth}{1pt}
}

% Running header for page 2+: same logo+wordmark+rule as firstheader, plus centered page number
\fancypagestyle{lexmountrun}{
    \fancyhf{}
    \fancyhead[R]{%
        \begin{minipage}[c]{1.26cm}\centering
            \includegraphics[height=1.26cm]{assets/lexmount_logo.png}%
        \end{minipage}%
        \hspace{0.08cm}%
        \begin{minipage}[c]{3.2cm}
            {\sffamily\bfseries\color{wordmark}\fontsize{22pt}{26pt}\selectfont Lexmount}%
        \end{minipage}%
    }
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{1pt}
    \renewcommand{\footrulewidth}{0pt}
}
\AtBeginDocument{\pagestyle{lexmountrun}}

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink,capitalize]{cleveref}
\hypersetup{
    colorlinks,
    linkcolor=metabg,
    citecolor=metabg,
    urlcolor=metabg
}

\RequirePackage[numbers,square,sort&compress]{natbib}
\def\bibfont{\small}

% Section and caption format %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{titlesec}
\titleformat*{\paragraph}{\itshape}
\titleformat*{\section}{\Large\sffamily\bfseries}
\titleformat*{\subsection}{\large\sffamily\bfseries}
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries}
\DeclareTextFontCommand{\textbf}{\bfseries\sffamily}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=false,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Fonts: embed Optimistic.ttf for sans-serif %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\DeclareFontFamily{T1}{optimistic}{}
\DeclareFontShape{T1}{optimistic}{m}{n}{<-> s * [0.88] assets/optimistic}{}
\DeclareFontShape{T1}{optimistic}{b}{n}{<-> s * [0.88] assets/optimistic}{}
\pdfmapline{+optimistic < assets/Optimistic.ttf <T1-WGL4.enc}
\renewcommand{\sfdefault}{optimistic}
\linespread{1.05}

% Authors, affiliations, infos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\addtolist[5][]{
    \begingroup
        \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
        \let\protect\@unexpandable@protect
        \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
    \endgroup
}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\sffamily \bfseries #2$^{#1}$}}
\renewcommand\author[2][]{\addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\normalsize \ifx\\#1\\\else$^{#1}$\fi#2}}
\newcommand\affiliation[2][]{\addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{ }}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\small $^{#1}$#2}}
\newcommand\contribution[2][]{\addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand\emaillist{}
\newcommand\emailformat[2][]{{\small\texttt{\href{mailto:#2}{#2}}}}
\newcommand\email[1]{\addtolist[]{#1}{\emaillist}{\emailformat}{, }}

% Header content row (link bar: GitHub / HF / arXiv / Project ...)
\newcommand\headercontentlist{}
\newcommand\headercontent[1]{\renewcommand\headercontentlist{#1}}

\newcommand\metadatalist{}
\newcommand\metadataformat[2][]{{\small {\sffamily \bfseries #1:} #2}}
\newcommand\metadata[2][]{\addtolist[#1]{#2}{\metadatalist}{\metadataformat}{\par}}

\renewcommand{\abstract}[1]{\def\abstractlist{{\color{metafg} #1}}}
\renewcommand\date[1]{\metadata[Date]{#1}}
\newcommand\correspondence[1]{\metadata[Correspondence]{#1}}
\renewcommand{\title}[1]{\newcommand{\titlelist}{{\huge\sffamily\bfseries #1}}}
\newcommand{\beginappendix}{\appendix{\huge\sffamily Appendix\par}}

% Title-box construction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\mymaketitle}{%
    \tcbset{enhanced,frame hidden}
    \tcbset{left=0.5cm, right=0.5cm, top=0.5cm, bottom=0.5cm}
    \tcbset{arc=10pt}
    \tcbset{colback=metabg!10}
    \tcbset{before skip=0pt}
    \tcbset{grow to left by=1.5pt, grow to right by=1.5pt}

    \begin{tcolorbox}
        \setlength{\parindent}{0cm}
        \setlength{\parskip}{0.5cm}
        {
            \setlength{\parskip}{0cm}
            \raggedright
            \nohyphens
            {
                \setstretch{1.618}
                \titlelist\par
            }
            \vskip 0.2cm
            {\color{metabg}\authorlist}\par
            \vskip 0.2cm
            {\centering {\color{metabg}\affiliationlist}\par}
            \vskip 0.1cm
            {\centering {\color{metabg}\contributionlist}\par}

            \ifdefempty{\emaillist}{}{
                \vskip 0.1cm
                {\centering {\color{metabg}\emaillist}\par}
            }
        }

        \abstractlist\par

        \ifdefempty{\headercontentlist}{}{
            \vskip 0cm
            {
                \centering
                \color{metabg}
                \headercontentlist \par
            }
        }

        \vskip 0.1cm
        {
            \setlength{\parskip}{0cm}
            \ifdefempty{\metadatalist}{\vspace*{0.65cm}}{\metadatalist\par}
        }
    \end{tcolorbox}
    \tcbset{reset}
    \FloatBarrier
}

\if@twocolumn%
    \renewcommand{\maketitle}{\twocolumn[\mymaketitle \vskip 0.38cm]}%
\else%
    \renewcommand{\maketitle}{\mymaketitle}%
\fi

% Lightweight authoring helpers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Single review/todo macro (toggle visibility via class option later if needed)
\newcommand{\todo}[1]{\textcolor{red}{[TODO: #1]}}

% Appendix table-of-contents %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convention: call \appendixtoc right after \appendix in your appendix file.
% Renders "Contents of the Appendix" followed by a TOC listing only the
% appendix's \section / \subsection entries.
%
% Implementation: hook \appendix so subsequent \addcontentsline{toc}{...}{...}
% calls also mirror to a private .atoc aux file, which \appendixtoc reads via
% the standard \@starttoc mechanism. Two compile passes are needed for the
% entries to populate, same as any LaTeX TOC.
\let\lex@orig@addcontentsline\addcontentsline
\let\lex@orig@appendix\appendix
\renewcommand{\appendix}{%
    \lex@orig@appendix
    \renewcommand{\addcontentsline}[3]{%
        \lex@orig@addcontentsline{##1}{##2}{##3}%
        \ifstrequal{##1}{toc}{%
            \lex@orig@addcontentsline{atoc}{##2}{##3}%
        }{}%
    }%
}

\newcommand{\appendixtoc}{%
    \par\noindent{\Large\sffamily\bfseries Contents of the Appendix}\par
    \vspace{0.5em}
    \@starttoc{atoc}%
    \vspace{0.5em}
}
