%script #27 for GalileoView
% 
% called from GalileoView,
% Opens EEG signal stored in DX-created *.txt file, 
% uses MatlabConverter by Taras (file EEGConverterGUI.m)
% 17.01.2012


disp('Conversion started!')
%%%% path to D:\WORK\work\MATLABConverter
matlabConverterPath='D:\Dropbox\MATLABConverter\MATLABConverter.exe';
sourceTxtFileName=strcat(pname,fname);
resultMFileName=strcat(pname,fname(1:end-4),'_converted.m');
sampleRate='1000';

commandToExecute = strcat('"', matlabConverterPath, '"', 32,...
    '"', sourceTxtFileName, '"', 32,...
    '"', resultMFileName, '"', 32,...
    sampleRate)



%%%%%%%%%%%%%
% part from Taras' code

 [status result] = system(commandToExecute);
 disp('Conversion completed!')
 % if error occured during execution of external program
    if (status)
        statusException = MException('ConvertingError:Error', result);
        throw(statusException);
    end
    % if requered run result m-file
    runMFile=1;
    if (runMFile)
        try
            eval(strcat('run', 32, resultMFileName));
        catch exception2
            evalException = MException('EvaluatingError:Error', 'Path to result m-file is not proper script-path (see MATLAB help)');
            throw(evalException);
        end
    end
    msgbox(result);

clear A Ab;
A=h.data;
disp('Signal Matrix is created!')
SampleRate=h.SampleRate;
ff=[];
%%%%%%%%%%%%%%%%%%%
set(fn1,'string',fname);
set(ulm,'string','');
set([a1 al_l al_r scc sct ulm fn1],'visible','on');
set([men mens ment menf mencol mensp menpsp menpi menwav menth],'enable','on')
