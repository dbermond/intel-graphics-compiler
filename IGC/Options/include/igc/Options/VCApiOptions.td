/*========================== begin_copyright_notice ============================

Copyright (C) 2021-2025 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

// This file defines API options accepted by vector compiler.

// VC API options {{
let Flags = [VCApiOption] in {

// Main dispatch option.
def vc_codegen : PlainFlag<"vc-codegen">,
  HelpText<"Enable vector codegenerator">;

def fp_contract : PlainJoined<"ffp-contract=">,
  HelpText<"Form fused FP ops: fast (everywhere) | on (nowhere except insertion fma) | off (never fuse)">,
  Values<"fast,on,off">;

def : ZeFlag<"kernel-debug-enable">,
  Alias<emit_debug>, HelpText<"Alias for -g">;

def vc_optimize : PlainSeparate<"optimize">,
  HelpText<"Set optimization level to either 'none' or 'full'">,
  MetaVarName<"<level>">;
def : PlainJoined<"optimize=">, Alias<vc_optimize>,
  HelpText<"Alias for -optimize">;

def : PlainFlag<"no-optimize">, Alias<vc_optimize>,
  AliasArgs<["none"]>, HelpText<"Alias for -optimize=none">;

def vc_codegen_optimize : PlainSeparate<"codegen-optimize">,
  HelpText<"Set codegen optimization level to either 'none' or 'full'">,
  MetaVarName<"<level>">;
def : PlainJoined<"codegen-optimize=">, Alias<vc_codegen_optimize>,
  HelpText<"Alias for -codegen-optimize">;

// This option switches off vector splitting in parts to better fit
// into GRF. It may have both positive and negative consequences for
// performance so shall be used with extreme caution.
def no_vector_decomposition : ZeFlag<"no-vector-decomposition">,
  HelpText<"Disable vector decomposition pass">;
// Compatibility alias.
def : PlainFlag<"no_vector_decomposition">, Alias<no_vector_decomposition>,
  HelpText<"Alias for -ze-no-vector-decomposition"> {
  let Flags = ApiHelper.VCBackwardCompatFlags;
}
def : PlainFlag<"no-vector-decomposition">, Alias<no_vector_decomposition>,
  HelpText<"Alias for -ze-no-vector-decomposition">;

def vc_fno_struct_splitting : PlainFlag<"fno-struct-splitting">,
  HelpText<"Disable StructSplitter pass">;

def vc_fno_jump_tables : PlainFlag<"fno-jump-tables">,
  HelpText<"Disable the use of jump tables for lowering switches">;

def vc_ftranslate_legacy_memory_intrinsics :
  PlainFlag<"ftranslate-legacy-memory-intrinsics">,
  HelpText<"Legalize old memory intrinsics">;

def vc_disable_finalizer_msg :
  PlainFlag<"disable-finalizer-msg">,
  HelpText<"Turns off critical messages from cISA Builder">;

def vc_stateless_private_size : PlainJoined<"stateless-stack-mem-size=">,
  HelpText<"Stateless memory amount per thread">;

def vc_enable_preemption : PlainFlag<"vc-enable-preemption">,
  HelpText<"Enable preemption for VC path">;

def vc_use_plain_2d_images : PlainFlag<"vc-use-plain-2d-images">,
  HelpText<"Treat image2d_t annotation as non-media image">;

def vc_use_bindless_buffers : PlainFlag<"vc-use-bindless-buffers">,
  HelpText<"Enable bindless buffer access">;

def vc_use_bindless_images : PlainFlag<"vc-use-bindless-images">,
  HelpText<"Enable bindless image access">;

def vc_disable_non_overlapping_region_opt :
  PlainFlag<"vc-disable-non-overlapping-region-opt">,
  HelpText<"Disable non-overlapping region optimization">;

def vc_disable_indvars_opt :
  PlainFlag<"vc-disable-indvars-opt">,
  HelpText<"Disable induction variable optimization">;

// Compatibility alias.
def : PlainFlag<"doubleGRF">,
  Alias<exp_register_file_size_common>, AliasArgs<["256"]>,
  HelpText<"Alias for -ze-opt-large-register-file"> {
  let Flags = ApiHelper.VCBackwardCompatFlags;
}
def : PlainFlag<"double-GRF">,
  Alias<exp_register_file_size_common>, AliasArgs<["256"]>,
  HelpText<"Alias for -ze-opt-large-register-file">;

def depressurizer_grf_threshold : PlainSeparate<"depressurizer-grf-threshold">,
  HelpText<"Threshold for GRF pressure reduction">;
def : PlainJoined<"depressurizer-grf-threshold=">, Alias<depressurizer_grf_threshold>,
  HelpText<"Alias for -depressurizer-grf-threshold <value>">;
def depressurizer_flag_grf_tolerance : PlainSeparate<"depressurizer-flag-grf-tolerance">,
  HelpText<"Threshold for disabling flag pressure reduction">;
def : PlainJoined<"depressurizer-flag-grf-tolerance=">, Alias<depressurizer_flag_grf_tolerance>,
  HelpText<"Alias for -depressurizer-flag-grf-tolerance <value>">;
}
// }} VC API options

// Igcmc compatibility {{
let Flags = [IgcmcApiOption] in {

def igcmc : PlainFlag<"cmc">,
  HelpText<"Enable igcmc compatible mode; incompatible with -vc-codegen">;

def igcmc_visaopts : PlainJoined<"visaopts=">,
  HelpText<"Options for finalizer in form \"opt1 opt2 opt3...\"">;

def igcmc_stack_size : PlainJoined<"stack-mem-size=">,
  Alias<vc_stateless_private_size>,
  HelpText<"Control stack memory size (in bytes)">;

}
// }} Igcmc compatibility
