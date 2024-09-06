\def\elegant@date{2024/06/17}
\def\elegant@version{1.0}

\ExplSyntaxOn
\NewDocumentCommand\ProvideElegantModule{ m }
{
  \ProvidesExplFile{elegant-#1-module.code.tex}{\elegant@date}{\elegant@version}
  {ElegantLaTeX~ \text_titlecase_all:n{ #1 } ~Module}
}
\ExplSyntaxOff


\ProvidesExplClass{elegantbook-l3}{\elegant@date}{\elegant@version}{ElegantBook document class}


\msg_new:nnn { elegant } { not found module }
{
  The~Elegant~module~`#1'~not~found.
}


\cs_new_protected_nopar:Npn \elegant_load_module:n #1 
  {
    \clist_map_inline:nn { #1 }
    {
      \file_if_exist_input:nF { ./module/elegant-##1-module.code.tex }
      {
        \msg_error:nnn { elegant } { not found module } { ##1 }
      }
    }
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

\keys_define:nn { elegant / option }
  {
    tocdepth .int_set:N = \c@tocdepth,
    tocdepth .initial:n = 1,
    secnumdepth .int_set:N = \c@secnumdepth,
    secnumdepth .initial:n = 4,
  }

\NewDocumentCommand{\ElegantSetup}{m}
  { \keys_set:nn { elegant / option } { #1 } }



\elegant_load_module:n { language }

\elegant_load_module:n { theme }

\elegant_load_module:n { cover }

\elegant_load_module:n { font }

\elegant_load_module:n { core }

\elegant_load_module:n { theorem }




\endinput