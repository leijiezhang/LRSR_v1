xlabel('Dimensionality','FontSize',20);
ylabel('Accuracy','FontSize',20)
title('');
% title('COIL20 @ Unsupervised Setting','FontSize',20);
legend({'LRSR','SR'},'FontSize',20,'Location','SouthEast');
set(gca,'FontSize',20);
print COIL20_acc_sup.eps -depsc2 -r600