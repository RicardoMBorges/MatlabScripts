function [H,matchInfo] = manualMatchHSQC(ppm1,ppm2,ExpSpectra,Deep,ReferenceSpectra,HCdata)

%ExpSpectra	Experimental HSQC matrix
%Deep		number of lines for the contour plot
%ReferenceSpectra	reference spectra for comparison - this is simulated by the simulateHSQC_2D function
%HCdata     table of 1H and 13C chemical shifts for a STD
%ppm1 ppm2  chemical shift axes as processed for other 2D's from the original experimental axis

%By Ricardo Moreira Borges (Rio de Janeiro, Brazil)

Cq = find(HCdata==0);
[acq,~] = size(Cq); [a,~] = size(HCdata); A = a-acq;
%%%%%% Figure
figure,
contour(ppm2,ppm1,ExpSpectra,Deep,'k'), set(gca,'XDir','reverse'); set(gca,'YDir','reverse');
hold on, contour(ppm2,ppm1,ReferenceSpectra,'b'),set(gca,'XDir','reverse');set(gca,'YDir','reverse');
%%%%%%

for i=1:a % Press "space" and Left Mouse Button to point out match 
zoom on; pause(); zoom off; %Press "space" and Right Mouse Button to Break 
[H(i,1),H(i,2),c]=ginput(1);
    if c>1
        break
    end
end
% to terminate ginput PRESS RETURN(ENTER)
[aginput,~]=size(H);

out = getVarName(ReferenceSpectra); out = inputname(5);

matchInfo = [num2str(aginput-1),' match of ', num2str(A),' from ',out];
title([num2str(aginput-1),' match of ', num2str(A),' signals from ',out],'Interpreter', 'none')

for j=1:(aginput-1)
  hold on, scatter(H(j,1),H(j,2),'r')
end
%hold off; %zoom out; %saveas(gcf,[out,'.pdf'])
end

function out = getVarName(var)
    out = inputname(1);
end
