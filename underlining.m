function [detect] = underlining(sites, coefs, waves);

for n=1:size(sites,1)           % По скейлам
    
    detect(n,1:size(coefs,2))=0;
    
    i=1;
    while i <= size(coefs,2)
    
        for k=1:size(sites,2)

            if i==sites(n,k)
                
                detect(n,i:i+length(waves{1}))=1; % Подчеркивание
                i = i + length(waves{1});       % При нахождении комплекса
                                                % сдвигаемся на его длину                
            end
        end
    i=i+1;
    end
end