xlabel('Dimensionality','FontSize',20);
ylabel('Accuracy','FontSize',20)
title('');
legend({'LRSR','SR'},'FontSize',20,'Location','SouthEast');
set(gca,'FontSize',20);
print COIL20_acc_unsup.eps -depsc2 -r600