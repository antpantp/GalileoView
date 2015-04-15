function fff=norming1(A);
% NORMING1 Norming of matrix's rows.
% The norming on the maximum value in the rows of input matrix.
% 
[row,col]=size(A);
fff=zeros(row,col);
maxx=max(A');
if any(maxx==0)
   error('One of maximum elements in the row is zero!!!')
end
for i=1:row
   fff(i,:)=A(i,:)/maxx(i);
end
