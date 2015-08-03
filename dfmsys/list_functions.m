function list_functions(name)
% LIST_FUNCTIONS - Display call graph
%
% LIST_FUNCTIONS(NAME)
%   Call DEPFUN on file NAME, looks at each function called 
%   one by one and display functions called from it.
%

% Call depfun
[list, builtins, classes, prob_files, prob_sym, eval_strings, ...
    called_from, java_classes] = depfun(name,'-quiet');

% Pre-init cell array with all functions called
called_functions = cell(1,length(list));

% Look at each function
for(callee_nb=1:length(list))
    print_me = false;
    callee = list{callee_nb};

    % Look at all functions calling that function
    for(caller_nb=called_from{callee_nb})
        caller = list{caller_nb};
        % Add it to call-graph
        called_functions{caller_nb} = [ called_functions{caller_nb}, callee_nb ];
    end
end

% Look at each function
for(caller_nb = 1:length(list))
    caller = list{caller_nb};
    
    % Only consider user's functions
    if(~is_matlab_func(caller))
       disp(['Function: ', cleanup(caller)]);
       
       % Display all functions called from that user's function
       if(isempty(called_functions{caller_nb}))
           disp(['     ', '(nothing)']);
       else
           for(callee_nb = called_functions{caller_nb})
                callee = list{callee_nb};
                disp(['     ', cleanup(callee)]); 
           end
       end
    end
end


% IS_MATLAB_FUNC - return TRUE is function is matlab toolbox function or
% Catalytic function.
function yes=is_matlab_func(name)
  yes = false;
  starting_ind_win = strfind(name,[matlabroot , '\toolbox']);
  starting_ind_lx  = strfind(name,[matlabroot , '/toolbox']);
  if(~isempty(starting_ind_win) && starting_ind_win(1)==1)
      yes = true;
      return;
  end
  
  if(~isempty(starting_ind_lx) && starting_ind_lx(1)==1)
      yes = true;
      return;
  end
  
  catalytic_root = which('fxp_init');
  if(~isempty(catalytic_root))
      catalytic_root = catalytic_root(1:(end-length('lib/fxp_init.p')));
      starting_ind = strfind(name, catalytic_root);
      if(~isempty(starting_ind) && starting_ind(1)==1)
          yes = true;
          return;
      end
  end
  
  
% CLEANUP - cleanup function path. Remove PWD and MATLABROOT
function name=cleanup(name)
  starting_ind = strfind(name, matlabroot);
  if(~isempty(starting_ind) && starting_ind(1)==1)
      name = name(length(matlabroot)+2:end);
      return;
  end
  
  starting_ind = strfind(name, pwd);
  if(~isempty(starting_ind) && starting_ind(1)==1)
      name = name(length(pwd)+2:end);
      return;
  end