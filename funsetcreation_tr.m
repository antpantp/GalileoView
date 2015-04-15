function F=funsetcreation_tr(setfun,part_len,sc,dl,a,b);
%FUNSETCREATION -- Function that creates the 
% overcomplete set of the initial function FUN
% using the parameters from SC, DL, A, B.

F=zeros(length(sc)*length(dl)*length(a)*length(b),part_len);
i=1;
%set functions will be formed without norming the initial function
for isc=sc
   for idl=dl
      for ia=a
         for ib=b
            F(i,:)=sc_dl_tr(setfun,isc,idl,ia,ib,part_len);
            i=i+1;
         end
      end
   end
end
clear i isc idl ish irs;