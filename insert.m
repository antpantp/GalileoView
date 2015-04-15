function [signal]=insert(signal,complexes,signal_length,...
    complexes_distance,biasx,sum,complexNoise)

switch(sum)
    case 1
        
for l=1:size(signal,1)
    
    x = ceil(length(complexes)*rand);
    bias = biasx;
    
    while (bias+length(complexes{x})) < signal_length
        
        signal(l,bias:(bias+length(complexes{x}))-1) = ...
            complexNoise*signal(l,bias:(bias+length(complexes{x}))-1) + ...
            complexes{x}(:)';

        bias = bias + complexes_distance;
        x = ceil(length(complexes)*rand); 
    end
end


    case 2
   
for l=1:size(signal,1)
    
    x = ceil(length(complexes)*rand);
    bias = biasx;
    
    while (bias+length(complexes{x})) < signal_length
        
        signal(l,bias:(bias+length(complexes{x}))-1) = ...
            signal(l,bias:(bias+length(complexes{x}))-1)+complexes{x}(:)';
%         bias = bias + length(complexes{x}) + complexes_distance;
        bias = bias + complexes_distance;
        x = ceil(length(complexes)*rand); 
    end
end

end