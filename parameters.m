function [sensitivity selectivity] = parameters(detect, ...
    detectExample,wavesExample,complexesOverlap);

complexesOverlap=complexesOverlap/100;


% False negative
for i=1:size(detect,1)
n=1;
l=1;

    while l <= size(detect,2)
        
        if detectExample(1,l) == 1 
            Alert=0;
           exampleCr = l;
            
            for z=l:(l+length(wavesExample))
            
                if detect(i,z) ~= detectExample(1,z)
                    
                    Alert = Alert + 1;
                    
                    if Alert == ceil(complexesOverlap*length(wavesExample))
                        
                        falseNegative{i}(n) = exampleCr;

                        n=n+1;
                        break;
                    end
                end
            end

            l = l + length(wavesExample);
        end
        
        l=l+1;
    end
end



% True Positive
for i=1:size(detect,1)
l=1;
n=1;
    while l <= size(detect,2)
        if detectExample(1,l)*detect(i,l) == 1
            exampleCr = l;
            Alert = 0;
            for z=l:(l+length(wavesExample))
                if detectExample(1,l)*detect(i,l) == 1
                    Alert = Alert + 1;
                    if Alert == ceil(complexesOverlap*length(wavesExample))
                     
                        truePositive{i}(n) = exampleCr;
                        n=n+1;
                        break;
                    end
                end
            
            end

        l = l + length(wavesExample);
        end
        
    l=l+1;
    end
end


% False positive
for i=1:size(detect,1)

n=1;
l=1;

    while l <= size(detect,2)
        
        if detect(i,l) == 1 
            Alert=0;
           exampleCr = l;
            
            for z=l:(l+length(wavesExample))
            
                if detect(i,z) ~= detectExample(1,z)
                    
                    Alert = Alert + 1;
                    
                    if Alert == ceil(complexesOverlap*length(wavesExample))
                        
                        falsePositive{i}(n) = exampleCr;
                        n=n+1;
                        break;
                    end
                end
            end

            l = l + length(wavesExample);
        end
        
        l=l+1;
    end
end

for i=1:size(detect,1)
    
    sensitivity(i) = 100*length(truePositive{i})/(length(truePositive{i})+...
        length(falseNegative{i}));
    selectivity(i) = 100*length(truePositive{i})/(length(truePositive{i})+...
        length(falsePositive{i}));
end