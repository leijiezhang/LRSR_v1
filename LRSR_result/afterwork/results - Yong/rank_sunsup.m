xlabel('Dimensionality of subspace','FontSize',20);
ylabel('Rank','FontSize',20);
title('');
legend({'LRSR: Reduced rank mapping','SR: Full rank mapping'},'Location','NorthWest');
set(gca,'FontSize',20);
print ISOLET_rank_unsup.eps -depsc2 -r600