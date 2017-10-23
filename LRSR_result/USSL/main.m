figure;
dim=9;
car_idx=(1:1:dim)';
plot(car_idx,LDA(:,1),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,2),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,3),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,4),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,5),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,6),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,1+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,2+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,3+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,4+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,5+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,6+7),'LineWidth',1.5);
hold on;
plot(car_idx,LDA(:,7+7),'LineWidth',1.5);
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14');

figure;
plot(car_idx,LPP(:,1),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,2),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,3),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,4),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,5),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,6),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,1+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,2+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,3+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,4+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,5+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,6+7),'LineWidth',1.5);
hold on;
plot(car_idx,LPP(:,7+7),'LineWidth',1.5);
hold on;
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14');

%yeleb best 13 14,para 7,8
%iso 10,para 4
%PIE 13,para 7
% USPS 9,para 3
% COIL 14,para 8
