xlabel('Dimensionality of subspace','FontSize',20);
ylabel('Rank','FontSize',20);
title('');
grid on;
legend({'LRSR: Reduced rank mapping','SR: Full rank mapping'},'Location','NorthWest');
set(gca,'FontSize',20);
print COIL20_rank_sup.eps -depsc2 -r600