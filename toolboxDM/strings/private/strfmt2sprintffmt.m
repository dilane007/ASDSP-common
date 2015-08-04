function [cfmt, inds] = strfmt2sprintffmt(fmt, op)
%STRFMT2SPRINTFFMT Converts format string to sprintf's style
%
% [ Syntax ]
%   - [cfmt, inds] = strfmt2sprintffmt(fmt, op)
%
% [ Arguments ]
%   - fmt:      the format spec in dmtoolbox
%   - op:       the option string
%               - 'ord':    using ordered index
%               - 'named':  using named index
%   - cfmt:     the converted sprintf-style format spec
%   - inds:     the parameter indices used in invoking sprintf.
%               if op is 'ord', inds is an index array;
%               if op is 'named', inds is cell array of field names
%
% [ History ]
%   - Created by Dahua Lin, on Jun 26, 2007
%

% parse fmt

[tks, sp, ep] = regexp(fmt, ...
    '\#\{\s*(?<index>\w+)\s*\:\s*(?<spec>\%[\+\-\s0]?[\w\.]*[a-zA-Z])\s*\}', ...
    'names', 'start', 'end');

% convert fmt

ranges = [sp; ep];
cfmt = strrangesubs(fmt, ranges, {tks.spec});

% make inds

switch op
    case 'ord'
        inds = cellfun(@str2double, {tks.index});
    case 'named'
        inds = {tks.index};
end






