(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload LEX = "pats_lexing.sats"
typedef tnode = $LEX.tnode

(* ****** ****** *)

staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

datatype
parerr_node =
//
  | PE_AND
  | PE_OF
  | PE_IN
  | PE_END
  | PE_REC
  | PE_WITH
//
  | PE_BAR
  | PE_COLON
  | PE_COMMA
  | PE_SEMICOLON
//
  | PE_LPAREN
  | PE_RPAREN
  | PE_LBRACKET
  | PE_RBRACKET
  | PE_LBRACE
  | PE_RBRACE
//
  | PE_BANG
  | PE_DOT
  | PE_EQ
  | PE_EQGT
  | PE_GT
  | PE_GTDOT
//
  | PE_SRPTHEN
  | PE_SRPENDIF
//
  | PE_EOF
//
  | PE_i0nt
  | PE_c0har
  | PE_f0loat
  | PE_s0tring
//
  | PE_i0de
  | PE_i0de_dlr
//
  | PE_s0rtid
  | PE_si0de // static identifier
  | PE_di0de // dynamic identifier
  | PE_pi0de // pattern identifier
  | PE_stai0de
//
(*
// HX: such errors are not reported
  | PE_s0rtq
  | PE_s0taq
  | PE_d0ynq
*)
  | PE_sqi0de
  | PE_dqi0de
//
  | PE_l0ab
  | PE_p0rec
  | PE_colonwith
//
  | PE_atme0xp
  | PE_e0xp
//
  | PE_atms0rt
  | PE_s0rt
  | PE_s0marg
  | PE_a0msrt
//
  | PE_s0exp
  | PE_atms0exp
  | PE_labs0exp
  | PE_s0rtext
  | PE_s0qua
  | PE_q0marg
//
  | PE_p0at
  | PE_atmp0at
  | PE_labp0at
//
  | PE_d0exp
  | PE_atmd0exp
  | PE_labd0exp
//
  | PE_d0ecl
  | PE_d0ecl_sta
  | PE_d0ecl_dyn
  | PE_guad0ecl
// end of [parerr_node]

typedef parerr = '{
  parerr_loc= location, parerr_node= parerr_node
} // end of [parerr]

fun parerr_make (
  loc: location, node: parerr_node
) : parerr // end of [parerr_make]

fun fprint_parerr (out: FILEref, x: parerr): void

fun the_parerrlst_add (x: parerr): void
fun the_parerrlst_add_ifnbt (
  bt: int, loc: location, node: parerr_node
) : void // end of [the_parerrlst_add_ifnbt]

fun fprint_the_parerrlst (out: FILEref): void

(* ****** ****** *)

fun tokbuf_set_ntok_null
  {a:type} (buf: &tokbuf, n: uint): a
// end of [tokbuf_set_ntok_null]

(* ****** ****** *)

typedef
parser (a: viewtype) =
  (&tokbuf, int(*bt*), &int(*err*)) -> a
// end of [parser]

typedef
parser_tok (a: viewtype) =
  (&tokbuf, int(*bt*), &int(*err*), token) -> a
// end of [parser_tok]

(* ****** ****** *)

fun p_AND : parser (token)
fun is_AND (x: tnode): bool
fun p_AND_test (buf: &tokbuf): bool

fun p_OF : parser (token)
fun is_OF (x: tnode): bool

fun p_IN : parser (token)
fun is_IN (x: tnode): bool

fun p_END : parser (token)
fun is_END (x: tnode): bool

fun p_REC : parser (token)
fun is_REC (x: tnode): bool
fun p_REC_test (buf: &tokbuf): bool

fun p_WITH : parser (token)
fun is_WITH (x: tnode): bool

(* ****** ****** *)

fun p_BAR : parser (token)
fun is_BAR (x: tnode): bool
fun p_BAR_test (buf: &tokbuf): bool

fun p_COLON : parser (token)
fun is_COLON (x: tnode): bool
fun p_COLON_test (buf: &tokbuf): bool

fun p_COMMA : parser (token)
fun is_COMMA (x: tnode): bool
fun p_COMMA_test (buf: &tokbuf): bool

fun p_SEMICOLON : parser (token)
fun is_SEMICOLON (x: tnode): bool
fun p_SEMICOLON_test (buf: &tokbuf): bool

fun is_BARSEMI (x: tnode): bool
fun p_BARSEMI_test (buf: &tokbuf): bool

(* ****** ****** *)

fun p_LPAREN : parser (token)
fun is_LPAREN (x: tnode): bool
fun p_RPAREN : parser (token)
fun is_RPAREN (x: tnode): bool

fun p_LBRACKET : parser (token)
fun is_LBRACKET (x: tnode): bool
fun p_RBRACKET : parser (token)
fun is_RBRACKET (x: tnode): bool

fun p_LBRACE : parser (token)
fun is_LBRACE (x: tnode): bool
fun p_RBRACE : parser (token)
fun is_RBRACE (x: tnode): bool

(* ****** ****** *)

fun p_BANG : parser (token)
fun is_BANG (x: tnode): bool

fun p_DOT : parser (token)
fun is_DOT (x: tnode): bool

fun p_EQ : parser (token)
fun is_EQ (x: tnode): bool

fun p_EQGT : parser (token)
fun is_EQGT (x: tnode): bool

fun p_GT : parser (token)
fun is_GT (x: tnode): bool

fun p_GTDOT : parser (token)
fun is_GTDOT (x: tnode): bool

(* ****** ****** *)

fun p_SRPTHEN : parser (token)
fun is_SRPTHEN (x: tnode): bool

fun p_SRPENDIF : parser (token)
fun is_SRPENDIF (x: tnode): bool

(* ****** ****** *)

fun p_EOF : parser (token)
fun is_EOF (x: tnode): bool

(* ****** ****** *)

fun is_ATLPAREN (x: tnode): bool
(*
fun is_QUOTELPAREN (x: tnode): bool
*)
fun is_LPAREN_deco (x: tnode): bool

fun is_ATLBRACE (x: tnode): bool
(*
fun is_QUOTELBRACE (x: tnode): bool
*)
fun is_LBRACE_deco (x: tnode): bool

(* ****** ****** *)

fun ptoken_fun (
  buf: &tokbuf, bt: int, err: &int
, f: (tnode) -> bool, enode: parerr_node
) : token // end of [ptoken_fun]

fun ptoken_test_fun (
  buf: &tokbuf, f: (tnode) -> bool
) : bool // end of [ptoken_test_fun]

fun ptokentopt_fun {a:type} (
  buf: &tokbuf, f1: (tnode) -> bool, f2: parser (a)
) : Option_vt (a)

(* ****** ****** *)

fun pstar_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun]

(* ****** ****** *)

fun pstar_sep_fun
  {a:type} (
  buf: &tokbuf, bt: int, sep: (&tokbuf) -> bool, f: parser (a)
) : List_vt (a) // end of [pstar_sep_fun]

(* ****** ****** *)
(*
// HX: fun1_sep: fun sep_fun
// HX: fun0_sep: /*empty*/ | fun1_sep
*)
fun pstar_fun0_sep
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a), sep: (&tokbuf) -> bool
) : List_vt (a) // end of [pstar_fun0_sep]

fun pstar_fun0_BAR
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_BAR]

fun pstar_fun0_COMMA
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_COMMA]

fun pstar_fun0_SEMICOLON
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_SEMICOLON]

fun pstar_fun0_BARSEMI
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : List_vt (a) // end of [pstar_fun0_BARSEMI]

(* ****** ****** *)

fun pstar_fun1_sep
  {a:type} (
  buf: &tokbuf
, bt: int, err: &int, f: parser (a), sep: (&tokbuf) -> bool
) : List_vt (a) // end of [pstar_fun1_sep]

fun pstar_fun1_AND
  {a:type} (
  buf: &tokbuf, bt: int, err: &int, f: parser (a)
) : List_vt (a) // end of [pstar_fun1_AND]

(* ****** ****** *)

fun pstar1_fun
  {a:type} (
  buf: &tokbuf, bt: int, err: &int, f: parser (a)
) : List_vt (a) // end of [pplus_fun]

(* ****** ****** *)

fun popt_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser (a)
) : Option_vt (a) // end of [popt_fun]

(* ****** ****** *)

dataviewtype
synent2 (
  a1: viewtype, a2:viewtype
) = SYNENT2 (a1, a2) of (a1, a2)

fun pseq2_fun
  {a1,a2:viewtype} (
  buf: &tokbuf
, bt: int, err: &int
, f1: parser (a1), f2: parser (a2)
) : synent2 (a1, a2)

dataviewtype
synent3 (
  a1: viewtype, a2:viewtype, a3:viewtype
) = SYNENT3 (a1, a2, a3) of (a1, a2, a3)

fun pseq3_fun
  {a1,a2,a3:viewtype} (
  buf: &tokbuf
, bt: int, err: &int
, f1: parser (a1), f2: parser (a2), f3: parser (a3)
) : synent3 (a1, a2, a3)

(* ****** ****** *)

fun ptest_fun
  {a:type} (
  buf: &tokbuf, f: parser (a), ent: &synent? >> synent
) : bool // end of [ptest_fun]

(* ****** ****** *)
//
// HX: for syntax like: ... | ...
//
dataviewtype
list12 (a:type) =
  | LIST12one (a) of List_vt (a)
  | LIST12two (a) of (List_vt (a), List_vt (a))
// end of [list12]

fun list12_free {a:type} (ent: list12 a): void

fun plist12_fun {a:type}
  (buf: &tokbuf, bt: int, f: parser (a)): list12 (a)
// end of [plist12_fun]

(* ****** ****** *)

fun pif_fun
  {a:type} (
  buf: &tokbuf
, bt: int, err: &int, f: parser (a), err0: int
) : a // end of [pif_fun]

fun ptokwrap_fun
  {a:type} (
  buf: &tokbuf
, bt: int, err: &int, f: parser_tok (a), enode: parerr_node
) : a // end of [ptokwrap_fun]

(* ****** ****** *)

fun p_i0nt : parser (i0nt) // integers: dec, oct, hex, etc.
fun p_c0har : parser (c0har) // strings
fun p_f0loat : parser (f0loat) // strings
fun p_s0tring : parser (s0tring) // strings

(* ****** ****** *)

fun p_i0de : parser (i0de) // identifier
fun p_i0deseq1 : parser (i0delst) // = {i0de}+

(* ****** ****** *)

fun p_i0de_dlr : parser (i0de) // $identifier

(* ****** ****** *)

fun p_l0ab : parser (l0ab)
fun p_p0rec : parser (p0rec)

fun p_e0fftag : parser (e0fftag)
fun p_colonwith : parser (e0fftaglstopt)

fun p_dcstkind : parser (token)
fun p_extnamopt : parser (Stropt)

(* ****** ****** *)

fun p_m0acarg : parser (m0acarg)

(* ****** ****** *)

fun p_e0xp : parser (e0xp)

(* ****** ****** *)

fun p_s0rt : parser (s0rt)
fun p_s0rtq : parser (s0rtq) // sort qualifier
fun p_s0rtid : parser (i0de) // sort identifier
//
fun p_ofs0rtopt_vt : parser (s0rtopt_vt) // OF s0rt
fun p_colons0rtopt_vt : parser (s0rtopt_vt) // COLON s0rt
//
fun p_s0arg : parser (s0arg) // static argument
fun p_s0marg : parser (s0marg) // static multi-argument
//
fun p_a0srt : parser (a0srt) // static argument sort
fun p_a0msrt : parser (a0msrt) // static argument multi-sort
//
fun p_d0atsrtconseq : parser (d0atsrtconlst)

(* ****** ****** *)

fun p_s0exp : parser (s0exp)
fun p_si0de : parser (i0de) // static identifier
fun p_s0taq : parser (s0taq) // static qualifier
fun p_sqi0de : parser (sqi0de) // static qualified identifier
fun p_labs0exp : parser (labs0exp) // labeled static exp.
//
fun p_s0rtext : parser (s0rtext)
//
fun p_s0qua : parser (s0qua)
fun p_s0quaseq_vt : parser (s0qualst_vt)
//
fun p_eqs0expopt_vt : parser (s0expopt_vt) // EQ s0exp
fun p_ofs0expopt_vt : parser (s0expopt_vt) // OF s0exp
fun p_colons0expopt_vt : parser (s0expopt_vt) // OF s0exp
//
fun p_q0marg : parser (q0marg) // quantifier-like multi-argumet
//
fun p_a0typ : parser (a0typ) // argument type
//
fun p_e0xndec : parser (e0xndec)
fun p_d0atconseq : parser (d0atconlst)
//
fun p_d0cstarg : parser (d0cstarg)
//
fun p_s0vararg : parser (s0vararg)
fun p_s0exparg : parser (s0exparg)
//
fun p_witht0ype : parser (witht0ype)
//
(* ****** ****** *)

fun p_p0at : parser (p0at)
fun p_pi0de : parser (i0de) // pattern identifier
fun p_labp0at : parser (labp0at) // labeled pattern
fun p_f0arg : parser (f0arg)

(* ****** ****** *)

fun p_d0exp : parser (d0exp)
fun p_di0de : parser (i0de) // dynamic identifier
fun p_d0ynq : parser (d0ynq) // dynamic qualifier
fun p_dqi0de : parser (dqi0de) // dynamic qualified identifier
fun p_labd0exp : parser (labd0exp) // labeled dynamic exp.
//
fun p_eqd0expopt_vt : parser (d0expopt_vt) // EQ d0exp
//
fun p_d0expsemiseq0 : parser (d0explst)

(* ****** ****** *)

fun p_d0ecl : parser (d0ecl)
fun p_d0ecl_sta : parser (d0ecl)
fun p_d0eclseq_sta : parser (d0eclist)
fun p_d0ecl_dyn : parser (d0ecl)
fun p_d0eclseq_dyn : parser (d0eclist)
//
fun p_stai0de : parser (i0de)
//
fun p_d0atsrtdecseq : parser (d0atsrtdeclst)
//
fun p_s0rtdefseq : parser (s0rtdeflst)
//
fun p_s0taconseq : parser (s0taconlst)
fun p_s0tacstseq : parser (s0tacstlst)
fun p_s0tavarseq : parser (s0tavarlst)
//
fun p_s0expdefseq : parser (s0expdeflst)
//
fun p_s0aspdec : parser (s0aspdec)
//
fun p_e0xndecseq : parser (e0xndeclst)
fun p_d0atdecseq : parser (d0atdeclst)
//
fun p_d0cstdecseq : parser (d0cstdeclst)
//
(* ****** ****** *)

(* end of [pats_parsing.sats] *)
