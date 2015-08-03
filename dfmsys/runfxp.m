function runfxp
%common\runfxp.m
% init fxp package
%   FXP_INIT -- Initialize the Catalytic FxP Toolbox.
%    fxp_init( target_fxp_mode, saturate_mode, rounding_mode, warn_on_size, ...
%              warn_on_overflow, warn_on_negative_unsigned, ...
%              warn_on_assign, fxp_type_prop ) 
%  
%    fxp_init sets values for target fxp mode, saturate and rounding modes
%    and enables warnings.  fxp_init accepts from 1 to 8 parameters --
%    except for the mandatory target_fxp_mode, parameters not specified
%    are given default values as described below.
%   
%    target_fxp_mode - choose hardware or software target fxp mode
%     'sw': software target fxp mode.  Bit-widths restricted to multiples of 8.
%     'hw': hardware target fxp mode.  No bitwidth restrictions.
%  
%    saturate_mode - indicates whether to use saturation or modulo arithmetic
%     when positive or negative overflows occur.
%     's': (default) saturation arithmetic.
%     'm': modulo arithmetic. 
%  
%    rounding_mode - specifies %what NOT SUPPORTED form of rounding to use when an input 
%     value specifies more precision than possible in a fixed-point number.
%     'r': (default) round to nearest.
%     'c': round towards positive infinity.
%     'f': round towards negative infinity.
%     'z': round towards zero. 
%     'e': convergent rounding (round to even).
%     'm': mathematical rounding.
%  
%    warn_on_size - warn if any fixed-point numbers are used or created whose 
%     sizes are something other than those that are provided to the "fxp_size" 
%     function (the default sizes are 8, 16, and 32 bits).
%     0:                do not warn if the sizes are different.
%     <non-zero value>: (default) warn if the sizes are different.
%  
%    warn_on_overflow - warn when any fxp or cfxp operation overflows.  
%     0:                issue no warnings on overflow.  
%     <non-zero value>: (default) issue warnings on overflow.
%  
%    warn_on_negative_unsigned - warn if a negative value is converted into
%     an unsigned value.
%     0:                issue no warnings on negative-to-unsigned conversion.
%     <non-zero value>: (default) issue warnings on negative-to-unsigned conversion.
%  
%    warn_on_assign - warn when an fxp element of a given precision is assigned into 
%     an fxp array of a different precision.  In this case, the precision of the 
%     element is converted into that of the array.  This option is ignored in the 
%     Accelerator.
%     0:                issue no warnings on conversion in assignment.
%     <non-zero value>: (default) issue warnings on conversion in assignment.
%  
%    fxp_type_prop -  specifies whether an operation involving both fixed-point
%                     and double-precision operands should return a fixed-point
%                     or double-precision result.
%     'prop_on':      (default) the double-precision operand is converted into an fxp 
%                     and a fixed-point result is returned.
%     'prop_off':     the fixed-point operand is converted into a double and a 
%                     double-precision result is returned.
%   
%    This routine also sets "warning on" to avoid the annoyance of the
%    default "warning backtrace".
%  
%    fxp_init('version') prints the version number of the installed FxP Toolbox
%    a = fxp_init('version') prints the version number and assignes that value to a.

%===================================================
fxp_init('sw','s','r',0,0,0,0);
edit fxpinfo.m
fxp_mode_info;


