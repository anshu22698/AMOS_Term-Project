

%Term Project Group Number-1
%This program is for plotting of deflection, w due to transverse uniform...
%distributed load in case of Clamped circular plate 

clc;
clear ;

h=50;  %thickness of plate in mm
E=20E5;  %Young's modulus in MPa
nu=0.3; %Poisson's Ratio
q=200; %loading in N/mm^2
R=250;  %radiuns in mm
k=4/3; %shear correction factor
r=linspace(0,R,1000);
D=(E*h^3)/(12*(1-(nu^2))); %bending rigidity
w_bend_shear= zeros(1,length(r));
w_bend= zeros(1,length(r));
for i=1:length(r)
    %it is deflection when shear deformation is not considered i.e. Classical plate theory
    bend=(q*R^4)/(64*D)*(1-(r(i)/R)^2)^2;  
    
    %it is additional deflection due to shear deformation i.e. in Mindlin's Theory
    shear=(q*(R^2)*(h^2))/(24*D*k*(1-nu))*(1-(r(i)/R)^2);
    
    w_bend(i) = bend;
    w_bend_shear(i)=bend + shear; 
end

%theta=linspace(0,2*pi,1000);
%[t,r]=meshgrid(theta,r);
%[x,y]=pol2cart(t,r);
for i=1:length(r)
    for j=1:length(r)
        W_bs(i,j)=w_bend_shear(1,j);
        W_b(i,j) = w_bend(1,j);
    end
end
W_bs=W_bs';
W_b=W_b';

figure(1)

polarplot3d(W_bs,'RadialRange',[0 R]);
st= sprintf("max deflection = %.2f mm",max(W_bs(:)));
text(0,0,1.1*max(W_bs(:)),st);
title('Variation of deflection along z-direction with the radius and theta for clamped periphery considering Shear Deformation')
d=2*R/4;
set(gca,'XTick',(-R:d:R));   
set(gca,'XTickLabel',([R,R/2,0,R/2,R]));
set(gca,'YTick',(-R:d:R));
set(gca,'YTickLabel',([R,R/2,0,R/2,R]));
xlabel('Radius(mm)') 
ylabel('Radius(mm)')
zlabel('w, Deflection(mm)')



figure(2)
polarplot3d(W_b,'RadialRange',[0 R]);
st= sprintf("max deflection = %.2f mm",max(W_b(:)));
text(0,0,1.1*max(W_b(:))+.05,st);
title('Variation of deflection along z-direction with the radius and theta for clamped periphery without considering Shear Deformation')
set(gca,'XTick',(-R:d:R));   
set(gca,'XTickLabel',([R,R/2,0,R/2,R]));
set(gca,'YTick',(-R:d:R));
set(gca,'YTickLabel',([R,R/2,0,R/2,R]));
xlabel('Radius(mm)') 
ylabel('Radius(mm)')
zlabel('w, Deflection(mm)')

