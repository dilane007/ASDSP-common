function grep(expression,expression2)
% function grep(expression,expression2)
%
% List all of the files that contain the string: expression.
% If the second parameter, expression2, is present, then list all the files
% that contain both strings: expression and expression2
% 
% In the Matlab command window, use the cd command to navigate to a
% selected directory.  The searching will then occur in said selected
% directory and all subordinate directories in a recursive fashion.
%
% For example, the following command searches for the string: 'addpath'
%  grep('addpath')

% $URL: http://brace/svn/repos/projects/rfpal2/trunk/host/tools/grep.m $
% $Author: khawkes $
% $Date: 2008-11-21 16:44:08 -0800 (Fri, 21 Nov 2008) $
% $Revision: 7617 $
%
% You need to download grep from http://gnuwin32.sourceforge.net/packages/grep.htm

% Copyright 2008 by Scintera Networks Inc., Sunnyvale, CA, 94086
% All rights reserved.  No part of this software may be reproduced in any 
% form or by any means, or used in any computer program, without permission
% in writing from Scintera Networks Inc.

program = 'C:\Program Files\GnuWin32\bin\grep.exe';
dirResults = dir(program);
if isempty(dirResults)
  fprintf('\nYou need to download the "complete package, except sources" of grep from \nhttp://gnuwin32.sourceforge.net/packages/grep.htm\n');
  error('%s doesn''t exist',program);
end
  
command = sprintf('"C:\\Program Files\\GnuWin32\\bin\\grep.exe" -rlI "%s" "%s"', ...
  expression, pwd);
[status,result] = system(command);
if status
  error(result);
end
ii = find(result == '/'); % find all forward slashes
result(ii) = '\'; % replace with back slashes
cr = sprintf('\n');
if nargin == 2
  command = sprintf('"C:\\Program Files\\GnuWin32\\bin\\grep.exe" -rlI "%s" "%s"', ...
    expression2, pwd);
  [status,result2] = system(command);
  ii = find(result2 == '/'); % find all forward slashes
  result2(ii) = '\'; % replace with back slashes
  es2 = strfind(result2,cr);
  ss2 = [1 es2(1:end-1)+1];
end
es = strfind(result,cr);
ss = [1 es(1:end-1)+1];
for ii=1:length(es) % for each file
  if length(strfind(result(ss(ii):es(ii)),'.svn')) > 0 ...
  	|| length(strfind(result(ss(ii):es(ii)),'.asv')) > 0 ...
  	|| length(strfind(result(ss(ii):es(ii)),'.h')) > 0
  else
    if nargin == 2 % there is a second expression
      match = 0; % assume there isn't a file that contains both expressions
      for jj=1:length(es2) % for each file in second expression
        if strcmp(char(result(ss(ii):es(ii))), char(result2(ss2(jj):es2(jj))))
          match = 1;
        end
      end
    else
      match = 1;
    end
    if match == 1
      fprintf('%s',char(result(ss(ii):es(ii)))); % display results
    end
  end
end
return
