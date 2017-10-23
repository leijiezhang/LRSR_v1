out_pro(1)=[];
figure;
plot(out_pro,'b-o','LineWidth',1.5);
title('Trend of Loss Function on LPP @ COIL20');
xlabel('Iteration num','fontsize',12);
ylabel('Value of Loss Function','fontsize',12);
% h_leg =legend('LRSR Accuracy','USSR Accuracy');
% set(h_leg,'position',[0.725 0.14 0.160714285714286 0.0555555555555556]);
set (gcf,'Position',[0,0,800,500], 'color','w');
set(gca,'FontSize',12);
grid on;
print tmp.eps -depsc2 -r600
