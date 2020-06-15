clear;
close all; 

load xBOD;
xDiurnal = zeros(size(xBOD));
xLeachate = zeros(size(xBOD));
parfor i= 1:size(xBOD,1)
    tic
    [xDiurnal(i,:),xLeachate(i,:),~]=seperatePattern(xBOD(i,:)); 
    disp(['Progressing ID = ', num2str(i)]);
    toc
end
%%
save xDiurnal;
save xLeachate;

%%
    tic
    [x1,y1,~]=seperatePattern2(xBOD(1,:)); 
    toc