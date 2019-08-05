% 2019/04/24 Justin Hugon 

% --- Class structure: identification part
% ---
\ProvidesClass{hugonteaching}[2019/07/23 version 1.0 Hugon Teaching Class for syllabi, assignments, and exams]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[letterpaper,11pt]{exam}

\RequirePackage{expl3}
%\RequirePackage[letterpaper,hmargin=1in,vmargin=0.9in,includehead,includefoot,head=15pt]{geometry}
%\RequirePackage[letterpaper,hmargin=1in,vmargin=0.9in,includehead,includefoot,head=15pt,headsep=20pt]{geometry}
\RequirePackage[letterpaper,hmargin=1in,includehead,includefoot,top=0.5in,bottom=1in,head=0.5in,foot=0.18in]{geometry}

\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{mathpazo}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{titling}
\RequirePackage{xparse}
\RequirePackage{bm}
\RequirePackage[table]{xcolor}
\RequirePackage{siunitx}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{setspace}
%\RequirePackage{tikz}
%\usetikzlibrary{backgrounds}
%\usetikzlibrary{fit}
\RequirePackage{hyperref}

\newcolumntype{W}{>{\raggedleft\arraybackslash}X} % ragged left fill in width in tabularx
\newcolumntype{Y}{>{\raggedright\arraybackslash}X} % ragged right fill in width in tabularx


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Custom variables for Hugon teaching docs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExplSyntaxOn
\tl_new:N \g_hugonteach_doctitle_tl
\tl_new:N \g_hugonteach_coursename_tl
\tl_new:N \g_hugonteach_coursenumber_tl
\tl_new:N \g_hugonteach_sectionnumber_tl
\tl_new:N \g_hugonteach_semester_tl
\tl_new:N \g_hugonteach_instructorname_tl

% to get the coursetitle
\tl_new:N \l_hugonteach_coursetitle_tl
\bool_new:N \l_hugonteach_coursename_bool
\bool_new:N \l_hugonteach_coursenumber_bool
\bool_new:N \l_hugonteach_sectionnumber_bool
\bool_new:N \l_hugonteach_coursenameandnumber_bool
\bool_new:N \g_hugonteach_showsectionintitle_bool
\bool_gset_false:N \g_hugonteach_showsectionintitle_bool

\NewDocumentCommand \doctitle { m } {\tl_gset:Nn \g_hugonteach_doctitle_tl {#1}}
\NewDocumentCommand \coursename { m } {\tl_gset:Nn \g_hugonteach_coursename_tl {#1}}
\NewDocumentCommand \coursenumber { m } {\tl_gset:Nn \g_hugonteach_coursenumber_tl {#1}}
\NewDocumentCommand \sectionnumber { m } {\tl_gset:Nn \g_hugonteach_sectionnumber_tl {#1}}
\NewDocumentCommand \semester { m } {\tl_gset:Nn \g_hugonteach_semester_tl {#1}}
\NewDocumentCommand \instructorname { m } {\tl_gset:Nn \g_hugonteach_instructorname_tl {#1}}
\NewDocumentCommand \showsectionintitle {} {\bool_gset_true:N \g_hugonteach_showsectionintitle_bool}

\NewDocumentCommand \thecoursetitle {} 
{
  \bool_set:Nn \l_hugonteach_coursename_bool {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_coursename_tl}}
  \bool_set:Nn \l_hugonteach_coursenumber_bool {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_coursenumber_tl}}
  \bool_set:Nn \l_hugonteach_sectionnumber_bool {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_sectionnumber_tl}}
  \bool_set:Nn \l_hugonteach_coursenameandnumber_bool {\bool_lazy_and_p:nn \l_hugonteach_coursenumber_bool \l_hugonteach_coursename_bool}

  %\textbf{Debug~coursetitle:}\par
  %coursename:~\bool_if:nTF \l_hugonteach_coursename_bool {T} {F}\par
  %coursenumber:~\bool_if:nTF \l_hugonteach_coursenumber_bool {T} {F}\par
  %sectionnumber:~\bool_if:nTF \l_hugonteach_sectionnumber_bool {T} {F}\par
  %coursenameandnumber:~\bool_if:nTF \l_hugonteach_coursenameandnumber_bool {T} {F}\par

  \bool_if:nTF \l_hugonteach_coursenameandnumber_bool
  { % name and number
    \tl_set:cn \l_hugonteach_coursetitle_tl {\g_hugonteach_coursenumber_tl : ~ \g_hugonteach_coursename_tl}
  }
  { % not (name and number)
    \tl_set:cn \l_hugonteach_coursetitle_tl {\g_hugonteach_coursenumber_tl \g_hugonteach_coursename_tl}
  }
  \bool_if:nTF \l_hugonteach_sectionnumber_bool
  { % section number
    \bool_if:nTF \g_hugonteach_showsectionintitle_bool
    {
      \tl_put_right:cn \l_hugonteach_coursetitle_tl {,\ Section:~\g_hugonteach_sectionnumber_tl}
    }
    {}
  }
  { % no section number
  }
  \tl_use:c \l_hugonteach_coursetitle_tl
}

\NewDocumentCommand \hugondebug {}
{
  \vspace{1em}
  \textbf{Debug~Hugon~Variables:}\par
  doctitle:~``\g_hugonteach_doctitle_tl''\par
  coursename:~``\g_hugonteach_coursename_tl''\par
  coursenumber:~``\g_hugonteach_coursenumber_tl''\par
  sectionnumber:~``\g_hugonteach_sectionnumber_tl''\par
  semester:~``\g_hugonteach_semester_tl''\par
  instructorname:~``\g_hugonteach_instructorname_tl''\par
  coursetitle:~``\thecoursetitle{}''\par

  meetingtimes:~``\g_hugonteach_meetingtimes_tl''\par
  meetingplace:~``\g_hugonteach_meetingplace_tl''\par
  instructoroffice:~``\g_hugonteach_instructoroffice_tl''\par
  instructorphone:~``\g_hugonteach_instructorphone_tl''\par
  instructoremail:~``\g_hugonteach_instructoremail_tl''\par
  \vspace{1em}
}
\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Syllabus Vars %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExplSyntaxOn

\tl_new:N \g_hugonteach_instructoroffice_tl
\tl_new:N \g_hugonteach_instructorphone_tl
\tl_new:N \g_hugonteach_instructoremail_tl
\tl_new:N \g_hugonteach_meetingtimes_tl
\tl_new:N \g_hugonteach_meetingplace_tl
\tl_new:N \g_hugonteach_officehours_tl

\seq_new:N \g_hugonteach_sylubheadll_seq
\seq_new:N \g_hugonteach_sylubheadl_seq
\seq_new:N \g_hugonteach_sylubheadrr_seq
\seq_new:N \g_hugonteach_sylubheadr_seq

\int_new:N \g_hugonteach_sylubheadnrows_int
\int_new:N \g_hugonteach_sylubheaditer_int

\NewDocumentCommand \instructoroffice { m } {\tl_gset:Nn \g_hugonteach_instructoroffice_tl {#1}}
\NewDocumentCommand \instructorphone { m } {\tl_gset:Nn \g_hugonteach_instructorphone_tl {#1}}
\NewDocumentCommand \instructoremail { m } {\tl_gset:Nn \g_hugonteach_instructoremail_tl {#1}}
\NewDocumentCommand \meetingtimes { m } {\tl_gset:Nn \g_hugonteach_meetingtimes_tl {#1}}
\NewDocumentCommand \meetingplace { m } {\tl_gset:Nn \g_hugonteach_meetingplace_tl {#1}}
\NewDocumentCommand \officehours { m } {\tl_gset:Nn \g_hugonteach_officehours_tl {#1}}

\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Prefer PDF over png/jpeg
\DeclareGraphicsExtensions{.pdf,.png,.gif,.jpg}

\definecolor{darkgreen}{HTML}{008000}
\definecolor{light-gray}{gray}{0.8}

\newcommand{\jra}{\ensuremath{\rightarrow}}
\newcommand{\tred}[1]{\textcolor{red}{#1}}
\newcommand{\tblue}[1]{\textcolor{blue}{#1}}
\newcommand{\tgreen}[1]{\textcolor{darkgreen}{#1}}
\newcommand{\tredbf}[1]{\textcolor{red}{\bf #1}}
\newcommand{\tbluebf}[1]{\textcolor{blue}{\bf #1}}
\newcommand{\tgreenbf}[1]{\textcolor{darkgreen}{\bf #1}}

\ExplSyntaxOn
% All pages but first
\pagestyle{headandfoot}
\header{\g_hugonteach_doctitle_tl}{}{\thecoursetitle{}}
\footer{\g_hugonteach_semester_tl}{}{Page~\thepage{}~of~\pageref{LastPage}}
\headrule
\footrule

\NewDocumentCommand \makesylubhead {}
{

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_semester_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadll_seq {Semester:}
    \seq_gput_right:NV \g_hugonteach_sylubheadl_seq { \g_hugonteach_semester_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_sectionnumber_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadll_seq {Section:}
    \seq_gput_right:NV \g_hugonteach_sylubheadl_seq { \g_hugonteach_sectionnumber_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_meetingtimes_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadll_seq {Meeting~Times:}
    \seq_gput_right:NV \g_hugonteach_sylubheadl_seq { \g_hugonteach_meetingtimes_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_meetingplace_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadll_seq {Meeting~Place:}
    \seq_gput_right:NV \g_hugonteach_sylubheadl_seq {\g_hugonteach_meetingplace_tl}
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_instructorname_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadrr_seq {Instructor:}
    \seq_gput_right:NV \g_hugonteach_sylubheadr_seq { \g_hugonteach_instructorname_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_instructoroffice_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadrr_seq {Office:}
    \seq_gput_right:NV \g_hugonteach_sylubheadr_seq { \g_hugonteach_instructoroffice_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_instructoremail_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadrr_seq {E-mail:}
    \seq_gput_right:NV \g_hugonteach_sylubheadr_seq { \g_hugonteach_instructoremail_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_instructorphone_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadrr_seq {Phone:}
    \seq_gput_right:NV \g_hugonteach_sylubheadr_seq { \g_hugonteach_instructorphone_tl }
  }
  {}

  \bool_if:nTF {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_officehours_tl}}
  { % section number
    \seq_gput_right:Nn \g_hugonteach_sylubheadrr_seq {Office~Hours:}
    \seq_gput_right:NV \g_hugonteach_sylubheadr_seq { \g_hugonteach_officehours_tl }
  }
  {}

  %\seq_log:N \g_hugonteach_sylubheadll_seq
  %\seq_log:N \g_hugonteach_sylubheadl_seq
  %\seq_log:N \g_hugonteach_sylubheadrr_seq
  %\seq_log:N \g_hugonteach_sylubheadr_seq

  \int_gset:Nn \g_hugonteach_sylubheadnrows_int {
    \int_max:nn {\seq_count:N \g_hugonteach_sylubheadll_seq} {\seq_count:N \g_hugonteach_sylubheadrr_seq}
  }

  %\int_log:N \g_hugonteach_sylubheadnrows_int

  %%
  \par
  {\centering
    \Huge \thecoursetitle{} \par
  }
  \vspace{1em}
  \begin{onehalfspace}
  {
    \centering
    \begin{tabularx}{\textwidth}{@{}lYlY@{}}  
      \int_gset:Nn \g_hugonteach_sylubheaditer_int {1}
      \int_do_while:nNnn {\g_hugonteach_sylubheaditer_int} {<} {\g_hugonteach_sylubheadnrows_int + 1}
      {
        \seq_item:Nn \g_hugonteach_sylubheadll_seq {\g_hugonteach_sylubheaditer_int}
        &
        \seq_item:Nn \g_hugonteach_sylubheadl_seq {\g_hugonteach_sylubheaditer_int}
        &
        \seq_item:Nn \g_hugonteach_sylubheadrr_seq {\g_hugonteach_sylubheaditer_int}
        &
        \seq_item:Nn \g_hugonteach_sylubheadr_seq {\g_hugonteach_sylubheaditer_int}
        \\
        \int_gincr:N \g_hugonteach_sylubheaditer_int
      }
    \end{tabularx}
  }
  \end{onehalfspace}
  %\par
  %\vspace{-2em}
}

\ExplSyntaxOff
