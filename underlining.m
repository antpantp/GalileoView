function [detect] = underlining(sites, coefs, waves);

for n=1:size(sites,1)           % �� �������
    
    detect(n,1:size(coefs,2))=0;
    
    i=1;
    while i <= size(coefs,2)
    
        for k=1:size(sites,2)

            if i==sites(n,k)
                
                detect(n,i:i+length(waves{1}))=1; % �������������
                i = i + length(waves{1});       % ��� ���������� ���������
                                                % ���������� �� ��� �����                
            end
        end
    i=i+1;
    end
end