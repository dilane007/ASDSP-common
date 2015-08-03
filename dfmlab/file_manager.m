%common\file_manager.m
%1.0 <31jan2007> creation 
%2.0 <31jan2007> addition: read
%2.1 <31jan2007> addition: witness
%2.2 <31jan2007> reserve ofp to system; use ofp1, ifp1
%2.3 <31jan2007> suppression witness; fileactor is not a string
%2.4 <08Mar2007> addition: opening, closing
%2.5 <18Apr2009> addition: read long,short,byte hex

switch (filemess)
    case('opening') %ofp
        ofp1 = fopen(filetitle,'w');
    case('closing')%ofp
        fclose(ofp1);
    case('w')
        ofp1 = fopen(filetitle,'w');
        fprintf(ofp1,'%g\n', fileactor);
        fclose(ofp1);
    case('r')
        ifp1 = fopen(filetitle,'r');
        fileactor = fscanf(ifp1,'%g\n');
        fclose(ifp1);
    case('rdlhex')
        ifp1 = fopen(filetitle,'r');
        fileactor = fscanf(ifp1,'%8X\n');
        fclose(ifp1);
    case('rdshex')
        ifp1 = fopen(filetitle,'r');
        fileactor = fscanf(ifp1,'%4X\n');
        fclose(ifp1);
    case('rdbhex')
        ifp1 = fopen(filetitle,'r');
        fileactor = fscanf(ifp1,'%2X\n');
        fclose(ifp1);
    otherwise
        disp('filemess unknown');
end