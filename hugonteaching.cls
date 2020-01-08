% 2019/04/24 Justin Hugon 

% --- Class structure: identification part
% ---
\ProvidesClass{hugonteaching}[2019/07/23 version 1.0 Hugon Teaching Class for syllabi, assignments, and exams]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[letterpaper,11pt]{exam}

\RequirePackage{expl3}
%\RequirePackage[letterpaper,hmargin=1in,vmargin=0.9in,includehead,includefoot,head=15pt]{geometry}
%\RequirePackage[letterpaper,hmargin=1in,vmargin=0.9in,includehead,includefoot,head=15pt,headsep=20pt]{geometry}
\RequirePackage[letterpaper,hmargin=0.7in,includehead,includefoot,top=0.4in,bottom=0.78in,head=0.5in,foot=0.18in]{geometry}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage[english]{babel}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{mathpazo}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{titling}
\RequirePackage{xparse}
\RequirePackage{bm}
\RequirePackage[table]{xcolor}
\RequirePackage{siunitx}
\RequirePackage{isotope}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{setspace}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{datavisualization}
\usetikzlibrary{datavisualization.formats.functions}
%\usetikzlibrary{backgrounds}
%\usetikzlibrary{fit}
\RequirePackage{pgfplots}
\RequirePackage{wrapfig}
\RequirePackage{hyperref}
\RequirePackage{cleveref}

\newcolumntype{W}{>{\raggedleft\arraybackslash}X} % ragged left fill in width in tabularx
\newcolumntype{Y}{>{\raggedright\arraybackslash}X} % ragged right fill in width in tabularx


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Custom variables for Hugon teaching docs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExplSyntaxOn
\tl_new:N \g_hugonteach_doctitle_tl
\tl_new:N \g_hugonteach_institution_tl
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
\NewDocumentCommand \institution { m } {\tl_gset:Nn \g_hugonteach_institution_tl {#1}}
\NewDocumentCommand \instructorname { m } {\tl_gset:Nn \g_hugonteach_instructorname_tl {#1}}
\NewDocumentCommand \showsectionintitle {} {\bool_gset_true:N \g_hugonteach_showsectionintitle_bool}


\NewDocumentCommand \thecoursetitle {} {\thecoursetitlefunc{,\ }}
\NewDocumentCommand \thecoursetitlebig {} {\thecoursetitlefunc{\\}}

\NewDocumentCommand \thecoursetitlefunc { m } 
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
    \tl_set:cn \l_hugonteach_coursetitle_tl {\mbox{\g_hugonteach_coursenumber_tl} : ~ \g_hugonteach_coursename_tl}
  }
  { % not (name and number)
    \tl_set:cn \l_hugonteach_coursetitle_tl {\g_hugonteach_coursenumber_tl \g_hugonteach_coursename_tl}
  }
  \bool_if:nTF \l_hugonteach_sectionnumber_bool
  { % section number
    \bool_if:nTF \g_hugonteach_showsectionintitle_bool
    {
      \tl_put_right:cn \l_hugonteach_coursetitle_tl {#1\mbox{Section:~\g_hugonteach_sectionnumber_tl}}
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
  institution:~``\g_hugonteach_institution_tl''\par
  coursename:~``\g_hugonteach_coursename_tl''\par
  coursenumber:~``\g_hugonteach_coursenumber_tl''\par
  sectionnumber:~``\g_hugonteach_sectionnumber_tl''\par
  instructorname:~``\g_hugonteach_instructorname_tl''\par
  semester:~``\g_hugonteach_semester_tl''\par
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

\sisetup{per-mode=symbol}

\definecolor{darkgreen}{HTML}{008000}
\definecolor{light-gray}{gray}{0.8}
\DeclareSIUnit\lightyear{ly}
\DeclareSIUnit\parsec{pc}

\newcommand{\jra}{\ensuremath{\rightarrow}}
\newcommand{\tred}[1]{\textcolor{red}{#1}}
\newcommand{\tblue}[1]{\textcolor{blue}{#1}}
\newcommand{\tgreen}[1]{\textcolor{darkgreen}{#1}}
\newcommand{\tredbf}[1]{\textcolor{red}{\bf #1}}
\newcommand{\tbluebf}[1]{\textcolor{blue}{\bf #1}}
\newcommand{\tgreenbf}[1]{\textcolor{darkgreen}{\bf #1}}
\newcommand{\keV}{\ensuremath{\,\mathrm{ke\kern -0.1em V}}}
\newcommand{\keVc}{\ensuremath{\,\mathrm{ke\kern -0.1em V\!/c}}}
\newcommand{\keVcc}{\ensuremath{\,\mathrm{ke\kern -0.1em V\!/c}^2}}
\newcommand{\MeV}{\ensuremath{\,\mathrm{Me\kern -0.1em V}}}
\newcommand{\MeVc}{\ensuremath{\,\mathrm{Me\kern -0.1em V\!/c}}}
\newcommand{\MeVcc}{\ensuremath{\,\mathrm{Me\kern -0.1em V\!/c}^2}}
\newcommand{\GeV}{\ensuremath{\,\mathrm{Ge\kern -0.1em V}}}
\newcommand{\GeVc}{\ensuremath{\,\mathrm{Ge\kern -0.1em V\!/c}}}
\newcommand{\GeVcc}{\ensuremath{\,\mathrm{Ge\kern -0.1em V\!/c}^2}}
\newcommand{\TeV}{\ensuremath{\,\mathrm{Te\kern -0.1em V}}}
\newcommand{\TeVc}{\ensuremath{\,\mathrm{Te\kern -0.1em V\!/c}}}
\newcommand{\TeVcc}{\ensuremath{\,\mathrm{Te\kern -0.1em V\!/c}^2}}
\newcommand{\ihat}{\ensuremath{\,\bm{\hat{\imath}}}}
\newcommand{\jhat}{\ensuremath{\,\bm{\hat{\jmath}}}}
\newcommand{\khat}{\ensuremath{\,\bm{\hat{k}}}}
% For exam class checkboxes env:
\checkboxchar{$\Box$}

\ExplSyntaxOn
% All pages but first
\pagestyle{headandfoot}
\header{\g_hugonteach_doctitle_tl}{}{\thecoursetitle{}}
\footer{\g_hugonteach_semester_tl}{\g_hugonteach_institution_tl}{Page~\thepage{}~of~\pageref{LastPage}}
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

  \bool_if:nTF {\bool_lazy_and_p:nn {\bool_not_p:n {\tl_if_blank_p:V \g_hugonteach_sectionnumber_tl}} {\bool_not_p:n {\g_hugonteach_showsectionintitle_bool}} }
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
    \Huge \thecoursetitlebig{} \par
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

\newcommand{\oglethorpehonorcode}{
Persons who come to Oglethorpe University for work and study join a community
that is committed to high standards of academic honesty. The honor code
contains the responsibilities we accept by becoming members of the community
and the procedures we will follow should our commitment to honesty be
questioned. See section 11 of the
\href{https://bulletin.oglethorpe.edu/}{2019-2020 Bulletin} for a complete
description of all policies and procedures.

The students, faculty and staff of Oglethorpe University expect each other to
act with integrity in the academic endeavor they share. Members of the faculty
expect that students complete work honestly and act toward them in ways
consistent with that expectation. Students are expected to behave honorably in
their academic work and are expected to insist on honest behavior from their
peers.

Oglethorpe welcomes all who accept our principles of honest behavior. We
believe that this code will enrich our years at the University and allow us to
practice living in earnest the honorable, self-governed lives required of
society’s respected leaders.

Our honor code is an academic one. The code proscribes cheating in general
terms and also in any of its several specialized sub-forms (including but not
limited to plagiarism, lying, stealing and interacting fraudulently or
disingenuously with the honor council). The Code defines cheating as ``the
umbrella under which all academic malfeasance falls. Cheating is any willful
activity involving the use of deceit or fraud in order to attempt to secure an
unfair academic advantage for oneself or others or to attempt to cause an
unfair academic disadvantage to others. Cheating deprives persons of the
opportunity for a fair and reasonable assessment of their own work and/or a
fair comparative assessment between and among the work produced by members of a
group. More broadly, cheating undermines our community’s confidence in the
honorable state to which we aspire."

The honor code applies to all behavior related to the academic enterprise.
Thus, it extends beyond the boundaries of particular courses and classrooms per
se, and yet it does not extend out of the academic realm into the purely social
one. Examples of cheating include but are not limited to:

\begin{enumerate}
  \item The unauthorized possession or use of notes, texts, electronic devices (including, for example, computers and mobile phones), online materials or other such unauthorized materials/devices in fulfillment of course requirements.
  \item Copying another person’s work or participation in such an effort.
  \item An attempt or participation in an attempt to fulfill the requirements of a course with work other than one’s original work for that course.
  \item Forging or deliberately misrepresenting data or results.
  \item Obtaining or offering either for profit or free of charge materials one might submit (or has submitted) for academic credit. This includes uploading course materials to online sites devoted, in whole or in part, to aiding and abetting cheating under the guise of providing “study aids.” There is no prohibition concerning uploading exemplars of one’s work to one’s personal website or to departmental, divisional, University or professional society websites for purposes of publicity, praise, examination or review by potential employers, graduate school admissions committees, etc.
  \item Violating the specific directions concerning the operation of the honor code in relation to a particular assignment. 
  \item Making unauthorized copies of graded work for future distribution.
  \item Claiming credit for a group project to which one did not contribute.
  \item Plagiarism, which includes representing someone else’s words, ideas, data or original research as one’s own and in general failing to footnote or otherwise acknowledge the source of such work. One has the responsibility of avoiding plagiarism by taking adequate notes on reference materials (including material taken off the internet or other electronic sources) used in the preparation of reports, papers and other coursework.
  \item Lying, such as: Lying about the reason for an absence to avoid a punitive attendance penalty or to receive an extension on an exam or on a paper’s due date; fraudulently obtaining Petrel Points by leaving an event soon after registering one’s attendance and without offering to surrender the associated Petrel Point, or by claiming fictitious attendance for oneself or another; forging or willfully being untruthful on documents related to the academic enterprise, such as on an application for an independent study or on a registration form.
  \item Stealing, such as: Stealing another’s work so that he/she may not submit it or so that work can be illicitly shared; stealing reserve or other materials from the library; stealing devices and materials (such as computers, calculators, textbooks, notebooks and software) used in whole or in part to support the academic enterprise.
  \item Fraudulent interaction on the part of students with the honor council, such as: Willfully refusing to testify after having been duly summoned; failing to appear to testify (barring a bona fide last-minute emergency) after having been duly summoned; testifying untruthfully.
\end{enumerate}

Students pledge that they have completed assignments honestly by attaching the
following statement to each piece of work submitted in partial fulfillment of
the requirements for a course taken for academic credit:

\begin{center}
 ``I pledge that I have acted honorably.'' (Followed by the student’s signature)
\end{center}

The honor code is in force for every student who is enrolled (either full- or
part-time) in any of the academic programs of Oglethorpe University at any
given time. All cases of suspected academic dishonesty will be handled in
accordance with the provisions established in this code. The honor council has
sole jurisdiction in matters of suspected academic dishonesty. Alternative ways
of dealing with cases of suspected academic fraud are prohibited. In cases of
alleged academic dishonesty on the part of students, the honor council is the
final arbiter.
}

\newcommand{\oglethorpelettergradetable}[1]{
\begin{center}
  \begin{tabular}{ll}  \toprule
                & Grade Numerical \\
  Letter Grade  & Equivalent $#1$ [\%] \\ \midrule
  $\mathrm{A}$  & $93 \leq #1 \leq 100$ \\
  $\mathrm{A-}$ & $90 \leq #1 <    93$  \\
  $\mathrm{B+}$ & $87 \leq #1 <    90$  \\
  $\mathrm{B}$  & $83 \leq #1 <    87$  \\
  $\mathrm{B-}$ & $80 \leq #1 <    83$  \\
  $\mathrm{C+}$ & $77 \leq #1 <    80$  \\
  $\mathrm{C}$  & $73 \leq #1 <    77$  \\
  $\mathrm{C-}$ & $70 \leq #1 <    73$  \\
  $\mathrm{D+}$ & $67 \leq #1 <    70$  \\
  $\mathrm{D}$  & $60 \leq #1 <    67$  \\
  $\mathrm{F}$  & $#1 < 60$   \\
  \bottomrule
  \end{tabular}
\end{center}

An incomplete (I) will only be given under the rarest circumstances. See
section 6.20.2 of the \href{https://bulletin.oglethorpe.edu/}{2019-2020
Bulletin} for a summary of requirements.
}

\newcommand{\oglethorpeaccomodation}{
\section*{Accessibility}
If you have any accessibility needs, please contact Accessibility Services
(Accessibility@Oglethorpe.edu). It is your responsability to identify yourself
to Accessibility Services and present proper medical documentation to them.
They will then notify me of the appropriate accomodation for your needs. It is
best if Accessibility Services has this responsibility to make sure that all
students are treated fairly and appropriately. I am happy to work with you and 
Accessibility Services to make sure your needs are met.
}


\ExplSyntaxOn
\newcommand{\assignmenttitlenameline}{
  \vspace{0.5in}
  \begin{center}
    {\bf \huge 
    \g_hugonteach_doctitle_tl
    }
  \end{center}
  \vspace{0.2in}
  \makebox[\textwidth]{\hspace{3.5in}Name:\enspace\hrulefill}
  \vspace{0.2in}
}

\newcommand{\oglethorpeassignmenttitlenameline}{
  \vspace{0.5in}
  \ExplSyntaxOn
  \begin{center}
    {\bf \huge 
    \g_hugonteach_doctitle_tl
    }
  \end{center}
  \ExplSyntaxOff
  \vspace{0.2in}
  \emph{``I~pledge~that~I~have~acted~honorably''}
  \hspace{0.2\textwidth}Name:\enspace\hrulefill
  \vspace{0.2in}
}
\ExplSyntaxOff
