function Img_CorrelationCoefficient

labellist={'Subj01','Subj02','Subj03','Subj04','Subj05','Subj06',...
    'Subj07','Subj08','Subj09','Subj10','Subj11','Subj12','Subj13',...
    'Subj14','Subj15','Subj16','Subj17','Subj18','Subj19','Subj20',...
    'Subj21','Subj22','Subj23','Subj24','Subj25','Subj26','Subj27',...
    'Subj28'};
subjnum=size(labellist,2);
cordata=rand(subjnum,subjnum);

s=imagesc(cordata);
set(gca,'XTickLabelRotation',90);
set(gca, 'XTickLabel',labellist ,'XTick',1:subjnum);
set(gca, 'YTickLabel',labellist ,'YTick',1:subjnum);
caxis([0 1]) 
colorbar
title('Correlation Coefficient')