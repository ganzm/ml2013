function CompareSVMvsSVMCost()

% GENERATE TRAINING SAMPLES
noise=0.025;
[trndata]=Hyperbola(100,noise);
[valdata]=Hyperbola(100,noise);
[tstdata]=Hyperbola(1000,noise);
%--------------------------------------------------------------------- 
% OBTAIN THE STANDARD SVM MODEL 
%---------------------------------------------------------------------
% Specify the parameter values
param.cset=2.^[-4:16];
param.t='linear';

r=1; % Ratio of Cfn/Cfp while training.
R=10; % Ratio of Cfn/Cfp while testing.

Rval=zeros(length(param.cset),1);

i=0;
for c=param.cset
    i=i+1;
    % SPECIFY LIBSVM MODEL PARAMETERS
    param.libsvm=['-t ',num2str(0),' -c ',num2str(c),' -w1 ',num2str(r)];
    % TRAIN THE MODEL
    model = svmtrain(trndata.y,trndata.X,param.libsvm);
    % OBTAIN WEIGHTED VALIDATION ERROR
    [jna,jnb,projection] = svmpredict(valdata.y,valdata.X, model);
    [rFp,rFn,error]=computeMetrics(valdata.y,projection,R);
    Rval(i)=error;
end

% SELECT THE MODEL WITH SMALLEST WEIGHTED VALIDATION ERROR
OptparamSVM.t='linear';
OptparamSVM.c=param.cset(min(find(Rval==min(Rval))));


% TRAIN THE OPTIMAL MODEL
param.libsvm=['-t ',num2str(0),' -c ',num2str(OptparamSVM.c),' -w1 ',num2str(r)];
Optmodel = svmtrain(trndata.y,trndata.X,param.libsvm);

% OBTAIN THE TEST ERROR
[jna,jnb,projection] = svmpredict(tstdata.y,tstdata.X, Optmodel);
[rFp,rFn,RpredSVM]=computeMetrics(tstdata.y,projection,R);


% PLOT THE HISTOGRAM OF PROJECTIONS (FOR TRAINING SAMPLES)
[jna,jnb,projection] = svmpredict(trndata.y,trndata.X, Optmodel);
hist_of_output(projection,100,100);

% PLOT THE MODEL (NOT NEEDED FOR HW)
OptmodelSVM=Optmodel; [stprmod]=libSVM2Stpr(OptmodelSVM,OptparamSVM);
nlcs1=length(find(trndata.y==1));
nlcs2=length(find(trndata.y==-1));
figure;
hold on;
plot(trndata.X(1:nlcs1,1),trndata.X(1:nlcs1,2),'b*',trndata.X(nlcs1+1:end,1),trndata.X(nlcs1+1:end,2),'r*','LineWidth',3);
xlabel('x1','fontsize',14);ylabel('x2','fontsize',14);
psvm(stprmod);
hold off;

clc;
fprintf('TEST ERROR: Std SVM (C=%1.2f) = (%f) , Cost SVM(C= %1.2f) = (%f)\n',OptparamSVM.c,RpredSVM ,OptparamSVMcost.c,RpredCostSVM);







function [nFp,nFn,wt_error]=computeMetrics(y,projection,K)
y_est=sign(projection);
y_est(find(y_est==0))=1;
y_true=y;
nFn=length(find(y_est<y_true));
nFp=length(find(y_est>y_true));
n_plus=length(find(y_true>0));
n_minus=length(find(y_true<0));
wt_error=(nFp+K*nFn)/(n_minus+K*n_plus);


function h=hist_of_output(output,N_cls1,N_cls2)
% Arrange the PROJECTION VALUES of the samples from the FIRST CLASS followed by the
samples from the 2nd class.
cls1proj = output(1:N_cls1);
cls2proj = output(N_cls1+1:N_cls1+N_cls2);
% OBTAIN THE HISTOGRAM OF PROJECTION VALUES FOR EACH CLASS
[stat1,x1] = hist(cls1proj);
[stat2,x2] = hist(cls2proj);
h=figure;
hold on;
mid_height = (max([stat1,stat2]) + min([stat1,stat2]))/2;
cls1h = mid_height*ones(size(cls1proj,1),size(cls1proj,2));
cls2h = mid_height*ones(size(cls2proj,1),size(cls2proj,2));
% PLOT THE HISTOGRAM VALUES
plot(x1,stat1,'b');
plot(x2,stat2,'r');
plot([0,0],[0,max([stat1,stat2])],'k');
plot([-1,-1],[0,max([stat1,stat2])],'k-.');
plot([+1,+1],[0,max([stat1,stat2])],'k-.');
set(gca,'FontSize',14);
