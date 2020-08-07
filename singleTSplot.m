function ax = singleTSplot(vector)
% singleTSplot will return eac
%   X:= input data matrix, and each row will be plotted as an individual
%   time series

x = vector(:);
n = length(x);


ax= plot(1:n,x);

% X&Y ticks 
ylim([-100,500]);
xlim([-5,725]);
set(gca,'XTick',linspace(0,720,7),'XTickLabel',{'6 am','10 am','2 pm','6 pm','10 pm','2 am','6 am'},...
    'FontWeight','bold');
set(gca,'YTick',linspace(0,500,6));

% X & Y labels 
xlabel('Time','FontSize',14,'FontWeight','bold');
ylabel('BOD, mg/L','FontSize',14,'FontWeight','bold');

grid on;

end

