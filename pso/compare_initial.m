% initialize


% read data
orgPath = pwd;
cd ..; 
load('data\matrixA_16.mat','A','k');
cd(orgPath);
d = length(k); % dimension of k
N = size(A,1); % dimension of A

% set particle information
S = d; % number of particles 66

%% initialize for Particle Swarm Optimization (PSO)

% cost function
% W = 2;
M0 = 2e2; % iteration number
phip = 0.1; % cognitive coefficient
phig = 0.1; % social coefficient
w = 0.8; % inertia weight
beta = 1e7;
W = 1e3;

% range of k
kPowerMin = -3*ones(d,1);
kPowerMax = 3*ones(d,1);
kMin = 1e-3;
kMax = 1e3;

% record data
gbestRecord = zeros(d,M);
% save(strcat(fileTag,'data.mat'),'S','M','W');

%% conventional initialization
% assign initial particles
kList = zeros(d,S);
fpList = zeros(1,S);
t= tic;
parfor i=1:S
    fx = inf;
    while(isinf(fx))
        x = kMin + (kMax-kMin)*rand(d,1);
        % function fx
        Ak = double(subs(A,k,x));
        lambda = eig(Ak);
        [~,index]=min(abs(lambda));
        lambda = lambda(setxor(1:length(lambda),index));
        x1 = real(lambda); x2 = abs(imag(lambda)); 
        if and(x1<0,x2<beta)
            fx = sum( W./(x1.^2) - x2./x1);
        else
            fx = inf;
        end
    end
    kList(:,i) = x;
    fpList(1,i) = fx;
end
clear lambda;
% %
% parfor i=round(S/10)+1:S
%     x = kMin + (kMax-kMin)*rand(d,1);
%     % function fx
%     Ak = double(subs(A,k,x));
%     lambda = eig(Ak);
%     [~,index]=min(abs(lambda));
%     lambda = lambda(setxor(1:length(lambda),index));
%     x1 = real(lambda); x2 = abs(imag(lambda)); 
%     if and(x1<0,x2<beta)
%         fx = sum( W./(x1.^2) - x2./x1);
%     else
%         fx = inf;
%     end
%     kList(:,i) = x;
%     fpList(1,i) = fx;
% end
% clear lambda;
pList = kList; %#ok<NASGU> % best of each particle
calTime = toc(t);
fprintf('Initialization time: %.2f sec\n',calTime);

fileTag = 'result_u_'; %#ok<NASGU> 
opt_pso_ssf

% data rename
fgRecord_u = fgRecord;
fpRecord_u = fpRecord;
lambda_u = lambda;
fg_u = fg;
nList_u = nList;
M_u = M;

%% custom initialization
% assign initial particles
clear x;
kList = zeros(d,S);
fpList = zeros(1,S);
t= tic;
parfor i=1:S
    fx = inf;
    while(isinf(fx))
        x = 10.^( kPowerMin + (kPowerMax-kPowerMin).*rand(d,1) );
        % function fx
        Ak = double(subs(A,k,x));
        lambda = eig(Ak);
        [~,index]=min(abs(lambda));
        lambda = lambda(setxor(1:length(lambda),index));
        x1 = real(lambda); x2 = abs(imag(lambda)); 
        if and(x1<0,x2<beta)
            fx = sum( W./(x1.^2) - x2./x1);
        else
            fx = inf;
        end
    end
    kList(:,i) = x;
    fpList(1,i) = fx;
end
clear lambda;

pList = kList; % best of each particle
calTime = toc(t);
fprintf('Initialization time: %.2f sec\n',calTime);
% save('initialTime','calTime');

% fileTag0 = split(orgPath,'/');
fileTag = 'result_'; %#ok<NASGU> 
opt_pso_ssf

%% comparison
figure(1); clf; hold on;
plot(log10(fgRecord_u-fg+1),'b','LineWidth',2);
plot(log10(fgRecord-fg+1),'r','LineWidth',2);
grid on;
xlabel('iteration');
ylabel('$f(k_0,k_1)$ [dB]','Interpreter','latex');
legend({'conventional','custom'},'Location','best')
set(gca,'FontSize',fontSize)
%
% fp: cost function of each particle
figure(2); clf; hold on;
plot(log10(fpRecord_u(nList,:).'-fg+1),'LineWidth',2); % dB scale
% xlim([1 M+1])
grid on;
xlabel('iteration'); ylabel('$f(\mathbf{x}_i)$ [dB]','Interpreter','latex');
legend(strcat("particle ",num2str((1:length(nList))')),'Location','best')
set(gca,'FontSize',fontSize)

% fp: cost function of each particle
figure(3); clf; hold on;
plot(log10(fpRecord(nList,:).'-fg+1),'LineWidth',2); % dB scale
% xlim([1 M+1])
grid on;
xlabel('iteration'); ylabel('$f(\mathbf{x}_i)$ [dB]','Interpreter','latex');
legend(strcat("particle ",num2str((1:length(nList))')),'Location','best')
set(gca,'FontSize',fontSize)

% eigenvalue polishing: remove zero eigenvalues
[~,index]=min(abs(lambda_u));
lambda_u2 = lambda_u(setxor(1:length(lambda_u),index));
[~,index]=min(abs(lambda));
lambda2 = lambda(setxor(1:length(lambda),index));

% eigenvalue of opt result
figure(4); clf; hold on;
scatter(real(lambda_u2),imag(lambda_u2),70,'b','LineWidth',2);
scatter(real(lambda2),imag(lambda2),50,'r','filled','LineWidth',2);
xlim([-1e1 0])
xlabel('Re$(\lambda)$','Interpreter','latex');
ylabel('Im$(\lambda)$','Interpreter','latex');
legend({'conventional','custom'},'Location','best')
grid on;
set(gca,'FontSize',fontSize)

figure(5); clf; hold on;
scatter(real(lambda_u2),imag(lambda_u2),70,'b','LineWidth',2);
scatter(real(lambda2),imag(lambda2),50,'r','filled','LineWidth',2);
% axis([-5 0 -10 10])
xlabel('Re$(\lambda)$','Interpreter','latex');
ylabel('Im$(\lambda)$','Interpreter','latex');
legend({'conventional','custom'},'Location','best')
grid on;
set(gca,'FontSize',fontSize)



% save figures
fileTag = 'comp_';
print(1,strcat(fileTag,'fg'),'-djpeg');
print(2,strcat(fileTag,'fp_u'),'-djpeg');
print(3,strcat(fileTag,'fp'),'-djpeg');
print(4,strcat(fileTag,'eig_opt_zoom'),'-djpeg');
print(5,strcat(fileTag,'eigs'),'-djpeg');
