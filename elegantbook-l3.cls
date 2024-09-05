\def\elegant@date{2024/06/17}
\def\elegant@version{1.0}

\def\ProvideElegantMoudle#1#2{%
  \ProvidesExplPackage{elegant-#1-module}{\elegant@date}{\elegant@version}{#2}%
}

\ProvidesExplClass{elegantbook-l3}{\elegant@date}{\elegant@version}{ElegantBook document class}





\cs_new_protected_nopar:Npn \elegant_load_moudle:n #1 
  {
    \RequirePackage{elegant-#1-module}
  }

\prop_gput:Nnn \g_msg_module_type_prop { elegant } { Class }
\prop_gput:Nnn \g_msg_module_name_prop { elegant } { ElegantBook }


\cs_new_protected_nopar:Npn \tl_if_exist_use:N #1
  {
    \tl_if_exist:NT #1 
    {
      \tl_use:N #1
    }
  }

\cs_generate_variant:Nn \tl_if_exist_use:N { c }




% class options
\clist_new:N \g__elegant_base_class_options_clist


% keys define 
\keys_define:nn { elegant / classoption }
  {
    lang .tl_set:N = \g__elegant_language_tl,
    lang .initial:n = cn,
    theme .tl_set:N = \g__elegant_theme_tl,
    theme .initial:n = {Techno~Blue},
    font .tl_set:N = \g__elegant_font_tl,
    font .initial:n = { founder },
    unknown.code:n = \__elegant_parse_unknown_option:n { #1 }
  }


\cs_new_protected_nopar:Npn \__elegant_parse_unknown_option:n #1
{
  \tl_if_empty:nTF { #1 }
  {
    \clist_gput_right:NV \g__elegant_base_class_options_clist \l_keys_key_str
  }
  {
    \exp_args:NNx \clist_gput_right:Nn \g__elegant_base_class_options_clist { \l_keys_key_str = \exp_not:n {#1} }
  }
}


\cs_if_exist:NTF \ProcessKeyOptions 
  {
    \ProcessKeyOptions[ elegant / classoption ]
  }
  {
    \RequirePackage{l3keys2e}
    \ProcessKeysOptions{ elegant / classoption }
  }


\exp_args:NNV \LoadClass[\g__elegant_base_class_options_clist]{book}


\elegant_load_moudle:n { language }

\elegant_load_moudle:n { theme }

\elegant_load_moudle:n { cover }

\elegant_load_moudle:n { font }



\keys_define:nn { elegant / option }
  {
    tocdepth .int_set:N = \c@tocdepth,
    tocdepth .initial:n = 1,
    secnumdepth .int_set:N = \c@secnumdepth,
    secnumdepth .initial:n = 4,
  }

\NewDocumentCommand{\ElegantSetup}{m}
  { \keys_set:nn { elegant / option } { #1 } }




\RequirePackage{geometry, tikz}

\graphicspath{{./figure/}}
\geometry{
  a4paper,
  top = 25.4mm, 
  bottom = 25.4mm,
  left = 20mm, 
  right = 20mm,
  headheight = 2.17cm,
  headsep = 4mm,
  footskip = 12mm
}



\RequirePackage[explicit]{titlesec}
\titleformat{\chapter}{}{}{0em}{
  \centering
  \color{\elegant_use_color:n{headline}} \bfseries\LARGE
  \elegant_use_name:n { chapter / before } \chinese{chapter} \elegant_use_name:n { chapter / after }\;\; #1 
}

\titleformat{name = \chapter, numberless}{}{}{0em}{
  \centering
  \color{\elegant_use_color:n{headline}} \bfseries\LARGE #1 
}

\titlespacing{\chapter}{0pt}{-20pt}{1.3\baselineskip}


\titleformat{\section}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\Large \thesection\;\; #1 
}

\titleformat{name = \section, numberless}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\Large #1 
}

\titleformat{\subsection}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\large \thesubsection\;\; #1 
}

\titleformat{name = \subsection, numberless}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\large #1 
}

\titleformat{\subsubsection}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\large \thesubsubsection\;\; #1 
}

\titleformat{name = \subsubsection, numberless}{}{}{0em}{
  \color{\elegant_use_color:n{headline}} \bfseries\large #1 
}


\RequirePackage{fancyhdr}
\fancyhf{}


\fancyfoot[c]{\color{ \elegant_use_color:n { structure } }\small\thepage}
\if@twoside
  \fancyhead[EL]{\color{ \elegant_use_color:n { structure } }\small\leftmark}
  \fancyhead[OR]{\color{ \elegant_use_color:n { structure } }\small\rightmark}
\else
  \fancyhead[R]{\color{ \elegant_use_color:n { structure } }\small\rightmark}
\fi

\RenewDocumentCommand{\headrule}{}{\color{ \elegant_use_color:n { structure } }\hrule width\textwidth}
\pagestyle{fancy}
\RenewDocumentCommand{\headrulewidth}{}{1pt}
\fancypagestyle{plain}{\RenewDocumentCommand{\headrulewidth}{}{0pt}\fancyhf{}\RenewDocumentCommand{\headrule}{}{}}
\RenewDocumentCommand{\sectionmark}{ m }{\markright{\thesection\, #1}{}}
\RenewDocumentCommand{\chaptermark}{ m }{\markboth{\thechapter\, #1}{}}



\RequirePackage{hyperref}
\hypersetup{
  breaklinks,
  unicode,
  linktoc = all,
  bookmarksnumbered = true,
  bookmarksopen = true,
  pdfkeywords = {ElegantBook, elegantlatex.top},
  colorlinks,
  linkcolor= \elegant_use_color:n { headline },
  citecolor= \elegant_use_color:n { headline },
  urlcolor= \elegant_use_color:n { headline },
  plainpages = false,
  pdfstartview = FitH,
  pdfborder = {0 0 0},
  linktocpage
}

\endinput