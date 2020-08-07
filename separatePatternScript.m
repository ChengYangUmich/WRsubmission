clear;
close all; 

load xBOD;
xDiurnal = zeros(size(xBOD));
xLeachate = zeros(size(xBOD));
parfor i= 1%:size(xBOD,1)
    tic
    [xDiurnal(i,:),xLeachate(i,:),~]=separatePattern(xBOD(i,:)); 
    disp(['Progressing ID = ', num2str(i)]);
    toc
end
