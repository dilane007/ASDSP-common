function [days, secs] = datenum (year, month, day, hour, minute, second)
% all inputs must be of class double

%Days until start of month assuming year starts March 1.
  persistent monthstart; 
  persistent monthlength;
  
  if nargin <6,  second=0; end;
  if nargin <5,  minute=0; end;
  if nargin <4,  hour=[]; end;
  if nargin <3,  day=[]; end;
  if nargin <2,  month=[]; end;
  
%   if (nargin == 0 || nargin > 6 ||
%      (nargin > 2 && (ischar (year) || iscellstr (year))))
%     print_usage ();
%   end

  monthstart = [306; 337; 0; 31; 61; 92; 122; 153; 184; 214; 245; 275];
  monthlength = [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31];
  if (ischar (year) || iscellstr (year))
    [year, month, day, hour, minute, second] = datevec (year, month);
  else
    if (nargin == 1)
      nc = columns (year);
      if (nc > 6 || nc < 3)
        error ('datenum: expected date vector containing [YEAR, MONTH, DAY, HOUR, MINUTE, SECOND]');
      end
      if (nc >= 6) second = year(:,6); end
      if (nc >= 5) minute = year(:,5); end
      if (nc >= 4) hour   = year(:,4); end
      day   = year(:,3);
      month = year(:,2);
      year  = year(:,1);
    end
  end

  month(month<1) = 1;  % For compatibility.  Otherwise allow negative months.

  % Treat fractional months, by converting the fraction to days
  if (floor (month) ~= month)
    fracmonth = month - floor (month);
    month = floor (month);
    if ((mod (month-1,12) + 1) == 2 &&  (floor (year/4) - floor (year/100) + floor (year/400)) ~= 0)
      % leap year
      day = day +(fracmonth * 29);
    else
      day = day +(fracmonth * monthlength ((mod (month-1,12) + 1)));
    end
  end

  % Set start of year to March by moving Jan. and Feb. to previous year.
  % Correct for months > 12 by moving to subsequent years.
  year = year + fix ((month-14)/12);

  % Lookup number of days since start of the current year.
  if (numel (month) == 1 || numel (day) == 1)
    % Allow month or day to be scalar while other values may be vectors or
    % matrices.
    a= monthstart(mod (month-1,12) + 1) + 60;
    day= day+a;
    if (numel (month) > 1)
      day = reshape (day, size (month));
    end
  else
    day = day + reshape (monthstart (mod (month-1,12) + 1), size (day)) + 60;
  end

  % Add number of days to the start of the current year. Correct
  % for leap year every 4 years except centuries not divisible by 400.
  month(month<1) = 1;  % For compatibility.  Otherwise allow negative months.

  % Treat fractional months, by converting the fraction to days
  if (floor (month) ~= month)
    fracmonth = month - floor (month);
    month = floor (month);
    if ((mod (month-1,12) + 1) == 2 &&   (floor (year/4) - floor (year/100) + floor (year/400)) ~= 0)
      % leap year
      day = day+ (fracmonth * 29);
    else
      day = day+ (fracmonth * monthlength ((mod (month-1,12) + 1)));
    end
  end

  % Set start of year to March by moving Jan. and Feb. to previous year.
  % Correct for months > 12 by moving to subsequent years.
  year = year + fix ((month-14)/12);

  % Lookup number of days since start of the current year.
  if (numel (month) == 1 || numel (day) == 1)
    % Allow month or day to be scalar while other values may be vectors or
    % matrices.
    day = day + (monthstart (mod (month-1,12) + 1) + 60);
    if (numel (month) > 1)
      day = reshape (day, size (month));
    end
  else
    a = reshape (monthstart (mod (month-1,12) + 1), size (day)) + 60;
    day= day+ a;
  end

  % Add number of days to the start of the current year. Correct
  % for leap year every 4 years except centuries not divisible by 400.
  day= day + (365*year + floor (year/4) - floor (year/100) + floor (year/400));

  % Add fraction representing current second of the day.
  days = day + (hour + (minute + second/60)/60)/24;

  % Output seconds if asked so that etime can be more accurate
  secs = day*86400 + hour*3600 + minute*60 + second;

end

