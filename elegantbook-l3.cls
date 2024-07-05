\ProvidesExplClass{elegantbook-l3}{2024/06/17}{v1.0}{ElegantBook document class}


\RequirePackage{l3keys2e}

% message
\prop_gput:Nnn \g_msg_module_type_prop { elegant } { Class }
\prop_gput:Nnn \g_msg_module_name_prop { elegant } { ElegantBook }

\msg_new:nnn { elegant }{ not support language }
{
  The~language~`#1'~is~not~support. ^^J
  Please~select~one~of~the~following~languages. ^^J
  \clist_use:Nn \l__elegant_language_clist {,~} 
}

\msg_new:nnn { elegant }{ not support theme }
{
  The~theme~`#1'~is~not~support. ^^J
  Please~select~one~of~the~following~themes. ^^J
  \clist_use:Nn \l__elegant_theme_clist {,~} 
}


% class options
\tl_new:N \l__elegant_base_class_options_tl
\tl_new:N \l__elegant_language_tl 

\clist_new:N \l__elegant_language_clist
\clist_new:N \l__elegant_theme_clist

\tl_new:N \l__elegant_theme_tl 

\prop_new:N \l__elegant_colors_prop


% colors 
\RequirePackage{xcolor}


\cs_set_eq:NN \__elegant_declare_color:nnn \definecolor


% #1 name, #2 model, #3 value

\cs_new_protected_nopar:Npn \elegant_declare_color:nnn #1#2#3
  {
    \tl_if_eq:nnTF { #2 } { name }
      {
        \colorlet{ elegant_#1_color }{ #3 }
      }
      {
        \tl_if_eq:nnTF { #2 } { expression }
          {
            \colorlet{ elegant_#1_color }{ #3 }
          }
          {
            \__elegant_declare_color:nnn { elegant_#1_color } { #2 } { #3 }
          }
      }
  }


\keys_define:nn { elegant / classoption }
  {
    lang.tl_set:N = \l__elegant_language_tl,
    lang.initial:n = cn,
    theme.tl_set:N = \l__elegant_theme_tl,
    theme.initial:n = {Techno~Blue},
    unknown.code:n = \__elegant_parse_unknown_option:n { #1 }
  }



\cs_new_protected_nopar:Npn \__elegant_parse_unknown_option:n #1
{
  \tl_if_empty:nTF { #1 }
  {
    \tl_gput_right:NV \l__elegant_base_class_options_tl \l_keys_key_str
  }
  {
    \exp_args:NNx \tl_gput_right:Nn \l__elegant_base_class_options_tl { \l_keys_key_str = \exp_not:n {#1} }
  }
}

\ProcessKeyOptions[ elegant / classoption ]

\LoadClass{book}

\PassOptionsToClass\l__elegant_base_class_options_tl{book}

\cs_new_protected_nopar:Npn \elegant_declare_language:nn #1#2 
  {
    \tl_set:cn { g_elegant_language_#1_tl } { #2 }
    \clist_gput_right:Nn \l__elegant_language_clist { #1 }
  }


\AtBeginDocument
  {
    \let \xeCJK@document@left@hook \relax
    \let \xeCJK@document@hook \relax
    \tl_if_exist:cTF { g_elegant_language_ \l__elegant_language_tl _tl }
    {
      \tl_use:c { g_elegant_language_ \l__elegant_language_tl _tl }
    }
    {
      % error / message
      \msg_error:nnx { elegant }{ not support language } { \l__elegant_language_tl }
    }
  }


\elegant_declare_language:nn { cn }
  {
    \RequirePackage{ctex}
    \def\ad{sd}
  }

\cs_new_protected_nopar:Npn \elegant_declare_theme:nn #1#2
  {
    \tl_set:cn { g_elegant_theme_#1_tl } 
    {
      \prop_set_from_keyval:Nn \l__elegant_colors_prop { #2 }
      \prop_map_inline:Nn \l__elegant_colors_prop 
      {
        \exp_last_unbraced:Nno \elegant_declare_color:nnn { ##1 }{ ##2 }
      }
      
    }
    \clist_gput_right:Nn \l__elegant_theme_clist { #1 }
  }

\AtBeginDocument
  {
    \tl_if_exist:cTF { g_elegant_theme_ \l__elegant_theme_tl _tl }
    {
      \tl_use:c { g_elegant_theme_ \l__elegant_theme_tl _tl }
    }
    {
      % error / message
      \msg_error:nnx { elegant }{ not support theme } { \l__elegant_theme_tl }
    }
  }

\elegant_declare_theme:nn { Techno~Blue }
  {
    chapter      =   {RGB}{ 60,  113, 183 },
    section      =   {RGB}{ 60,  113, 183 },
    subsection   =   {RGB}{ 60,  113, 183 },
    definition   =   {RGB}{ 0,   166, 82  },
    exercise     =   {RGB}{ 0,   166, 82  },
    problem      =   {RGB}{ 0,   166, 82  },
    theorem      =   {RGB}{ 255, 134, 24  },
    lemma        =   {RGB}{ 255, 134, 24  },
    corollary    =   {RGB}{ 255, 134, 24  },
    proposition  =   {RGB}{ 0,   174, 247 }
  }

\elegant_declare_theme:nn { Fresh~Green }
  {
    chapter      =   {RGB}{ 0,   120, 2   },
    section      =   {RGB}{ 0,   120, 2   },
    subsection   =   {RGB}{ 0,   120, 2   },
    definition   =   {RGB}{ 0,   120, 2   },
    exercise     =   {RGB}{ 0,   120, 2   },
    problem      =   {RGB}{ 0,   120, 2   },
    theorem      =   {RGB}{ 230, 90,  7   },
    lemma        =   {RGB}{ 230, 90,  7   },
    corollary    =   {RGB}{ 230, 90,  7   },
    proposition  =   {RGB}{ 0,   160, 152 }
  }

\elegant_declare_theme:nn { Polar~Blue }
  {
    chapter      =   {RGB}{ 31,  186, 190 },
    section      =   {RGB}{ 31,  186, 190 },
    subsection   =   {RGB}{ 31,  186, 190 },
    definition   =   {RGB}{ 59,  180, 5   },
    exercise     =   {RGB}{ 59,  180, 5   },
    problem      =   {RGB}{ 59,  180, 5   },
    theorem      =   {RGB}{ 175, 153, 8   },
    lemma        =   {RGB}{ 175, 153, 8   },
    corollary    =   {RGB}{ 175, 153, 8   },
    proposition  =   {RGB}{ 244, 105, 102 }
  }


\elegant_declare_theme:nn { Rocky~Gray }
  {
    chapter      =   {RGB}{ 150, 150, 150 },
    section      =   {RGB}{ 150, 150, 150 },
    subsection   =   {RGB}{ 150, 150, 150 },
    definition   =   {RGB}{ 150, 150, 150 },
    exercise     =   {RGB}{ 150, 150, 150 },
    problem      =   {RGB}{ 150, 150, 150 },
    theorem      =   {RGB}{ 150, 150, 150 },
    lemma        =   {RGB}{ 150, 150, 150 },
    corollary    =   {RGB}{ 150, 150, 150 },
    proposition  =   {RGB}{ 150, 150, 150 },
  }

\elegant_declare_theme:nn { Neon~Black }
  {
    chapter      =   {RGB}{ 0,   0,   0   },
    section      =   {RGB}{ 0,   0,   0   },
    subsection   =   {RGB}{ 0,   0,   0   },
    definition   =   {RGB}{ 0,   0,   0   },
    exercise     =   {RGB}{ 0,   0,   0   },
    problem      =   {RGB}{ 0,   0,   0   },
    theorem      =   {RGB}{ 0,   0,   0   },
    lemma        =   {RGB}{ 0,   0,   0   },
    corollary    =   {RGB}{ 0,   0,   0   },
    proposition  =   {RGB}{ 0,   0,   0   },
  }






\endinput