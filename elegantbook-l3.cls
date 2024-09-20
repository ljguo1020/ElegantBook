\def\elegant@date{2024/06/17}
\def\elegant@version{1.0}

\ExplSyntaxOn
\cs_new_protected_nopar:Npn \elegant_provide_module:n #1
  {
    \ProvidesExplFile{elegant-#1-module.code.tex}{\elegant@date}{\elegant@version}
    {ElegantLaTeX~ \text_titlecase:n { #1 } ~Module}
  }
\ExplSyntaxOff


\ProvidesExplClass{elegantbook-l3}{\elegant@date}{\elegant@version}{ElegantBook document class}

\cs_new_protected:Npn \elegant_msg_new:nn #1#2 
  { \msg_new:nnn { elegant } { #1 } { #2 } }

\cs_new_protected:Npn \elegant_msg_error:nn #1#2
  { \msg_error:nnn { elegant } { #1 } { #2 } }

\cs_generate_variant:Nn \elegant_msg_error:nn { nx }



\elegant_msg_new:nn { not found module }
  {
    The~Elegant~module~`#1'~not~found.
  }


\cs_new_protected_nopar:Npn \elegant_load_module:n #1 
  {
    \clist_map_inline:nn { #1 }
    {
      \file_if_exist_input:nF { elegant-##1-module.code.tex }
      {
        \elegant_msg_error:nn { not found module } { ##1 }
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


\prg_new_conditional:Npnn \elegant_if_package_loaded:n #1 {p, T, F, TF}
  {
    \@ifpackageloaded { #1 }
      \prg_return_true:
      \prg_return_false:
  }


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
    mode .tl_set:N = \g__elegant_theorem_mode_tl,
      mode .initial:n = { fancy },
    tocdepth .int_set:N = \g__elegant_tocdepth_int,
      tocdepth .initial:n = 1,
    secnumdepth .int_set:N = \g__elegant_secnumdepth_int,
      secnumdepth .initial:n = 5,
    usesamecnt .bool_set:N = \g__elegant_usesamecnt_bool,
      usesamecnt .initial:n = false,
      usesamecnt .default:n = true,
    thmcnt .tl_set:N = \g__elegant_thmcnt_tl,
      thmcnt .initial:n = { chapter },
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

\AddToHook{ class / after }
  {
    \int_gset_eq:NN \c@tocdepth    \g__elegant_tocdepth_int 
    \int_gset_eq:NN \c@secnumdepth \g__elegant_secnumdepth_int 
  }

\PassOptionsToClass{ oneside } { book }  

\exp_args:NNV \LoadClass[\g__elegant_base_class_options_clist]{book}





% #1: module, #2: name, #3: position, #4: code
\cs_new_protected:Npn \elegant_add_to_hook:nnnn #1#2#3#4
  {
    \hook_gput_code:nnn { elegant-module / #1 / #2 / #3 }{.}{#4}
  }

\hook_gput_code:nnn{begindocument/before}{.}
  {
    \let \xeCJK@document@left@hook \relax
    \let \xeCJK@document@hook \relax
  }

\elegant_load_module:n { font }

\elegant_load_module:n { language }

\elegant_load_module:n { theme }

\elegant_load_module:n { cover }



\elegant_load_module:n { core }

\elegant_load_module:n { theorem }




\endinput