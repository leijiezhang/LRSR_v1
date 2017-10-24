xlabel('Index of Singlar Values','FontSize',20);
ylabel('Singular Value','FontSize',20);
title('');
xlim([1 30]);
set(gca,'FontSize',20);
print COIL20_SinglarValue_sup.eps -depsc2 -r600