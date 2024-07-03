\ProvidesExplClass{elegantbook-l3}{2024/06/17}{v1.0}{ElegantBook document class}


% \RequirePackage{l3keys2e}






% message
\prop_gput:Nnn \g_msg_module_type_prop { elegant } { Class }
\prop_gput:Nnn \g_msg_module_name_prop { elegant } { ElegantBook }

\msg_new:nnn { elegant }{ not support language }
{
  The~language~`#1'~is~not~support. \MessageBreak
  Please~select~one~of~the~following~languages. \MessageBreak
  \clist_use:Nn \l__elegant_language_clist {,~} 
}

\msg_new:nnn { elegant }{ not support theme }
{
  The~theme~`#1'~is~not~support. \MessageBreak
  Please~select~one~of~the~following~themes. \MessageBreak
  \clist_use:Nn \l__elegant_theme_clist {,~} 
}




% class options
\tl_new:N \l__elegant_base_class_options_tl
\tl_new:N \l__elegant_language_tl 

\clist_new:N \l__elegant_language_clist
\clist_new:N \l__elegant_theme_clist

\tl_new:N \l__elegant_theme_tl 

\prop_new:N \l__elegant_colors_prop

% \tl_new:N \l__elegant_mode_tl 
% \tl_new:N \l__elegant_result_tl
% \tl_new:N \l__elegant_device_tl
% \tl_new:N \l__elegant_math_tl
% \tl_new:N \l__elegant_marginpar_tl
% \tl_new:N \l__elegant_toc_tl
% \tl_new:N \l__elegant_scheme_tl


% colors 
\RequirePackage{xcolor}


\cs_set_eq:NN \__elegant_declare_color:nnn \definecolor


% #1 name, #2 value
\cs_new_protected_nopar:Npn \elegant_declare_color:nn #1#2 
{
  \__elegant_declare_color:nnn { elegant_#1_color } { RGB } { #2 }
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
    \tl_set:cn { g_elegant_theme_#1_tl } { #2 }
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
    \prop_set_from_keyval:Nn \l__elegant_colors_prop
    {
      chapter      =      { 60,  113, 183 },
      section      =      { 60,  113, 183 },
      subsection   =      { 60,  113, 183 },
      definition   =      { 0,   166, 82  },
      exercise     =      { 0,   166, 82  },
      problem      =      { 0,   166, 82  },
      theorem      =      { 255, 134, 24  },
      lemma        =      { 255, 134, 24  },
      corollary    =      { 255, 134, 24  },
      proposition  =      { 0,   174, 247 }
    }
    \prop_map_function:NN \l__elegant_colors_prop \elegant_declare_color:nn
  }



\endinput