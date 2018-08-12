function [Z] = simulateHSQC_2D(HCdata, ppm1, ppm2)

%HCdata     table of 1H and 13C chemical shifts for a STD
%ppm1 ppm2  chemical shift axes as processed for other 2D's from the original experimental axis

%By Ricardo Moreira Borges (Rio de Janeiro, Brazil)

Z = zeros(length(ppm2),length(ppm1));
for i = 1:length(HCdata);
    A = 1;
    x0 = HCdata(i,1); y0 = HCdata(i,2);
    sigma_x = 0.05; sigma_y = 0.05;
    [X, Y] = meshgrid(ppm1,ppm2);

    for theta = 0:pi/100:pi
        a = cos(theta)^2/(2*sigma_x^2) + sin(theta)^2/(2*sigma_y^2);
        b = -sin(2*theta)/(4*sigma_x^2) + sin(2*theta)/(4*sigma_y^2);
        c = sin(theta)^2/(2*sigma_x^2) + cos(theta)^2/(2*sigma_y^2);
        Z = Z+(A*exp(-(a*(X-x0).^2-2*b*(X-x0).*(Y-y0)+c*(Y-y0).^2)));
    end
end