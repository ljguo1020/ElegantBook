\def\elegant@date{2024/06/17}
\def\elegant@version{1.0}

\def\ProvideElegantMoudle#1#2{%
  \ProvidesExplPackage{elegant-#1-module}{\elegant@date}{\elegant@version}{#2}%
}

\ProvidesExplClass{elegantbook-l3}{\elegant@date}{\elegant@version}{ElegantBook document class}


\LoadClass{book}


\cs_new_protected_nopar:Npn \elegant_load_moudle:n #1 
  {
    \RequirePackage{elegant-#1-module}
  }

\prop_gput:Nnn \g_msg_module_type_prop { elegant } { Class }
\prop_gput:Nnn \g_msg_module_name_prop { elegant } { ElegantBook }

\elegant_load_moudle:n { language }

\elegant_load_moudle:n { theme }

\elegant_load_moudle:n { cover }

\elegant_load_moudle:n { font }



% class options
\tl_new:N \l__elegant_base_class_options_tl


% keys define 
\keys_define:nn { elegant / classoption }
  {
    lang.tl_set:N = \l__elegant_language_tl,
    lang.initial:n = cn,
    theme.tl_set:N = \l__elegant_theme_tl,
    theme.initial:n = {Techno~Blue},
    font.tl_set:N = \l__elegant_font_tl,
    font.initial:n = { founder },
    unknown.code:n = \__elegant_parse_unknown_option:n { #1 }
  }



\cs_new_protected_nopar:Npn \__elegant_parse_unknown_option:n #1
{
  \tl_if_empty:nTF { #1 }
  {
    \tl_gput_right:NV \l__elegant_base_class_options_tl \l_keys_key_str
  }
  {
    \exp_args:NNx \tl_gput_right:Nn \l__elegant_base_class_options_tl { \exp_not:N \l_keys_key_str = \exp_not:n {#1} }
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

\PassOptionsToClass \l__elegant_base_class_options_tl { book }





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



\usepackage{showframe}

\RequirePackage[explicit]{titlesec}
\titleformat{\chapter}{}{}{0em}{
  \hfill #1 \hfill
}

\endinput