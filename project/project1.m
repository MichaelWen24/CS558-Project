clear all;

folder = 'project1/superset1/';
bin=4;
trainl=zeros(12,1);
trainh=zeros(12,bin*3);
testl=zeros(12,1);
testh=zeros(12,bin*3);
class={'building','sculpture','door'};
count=1;

for i=1:29
    for j=1:length(class)
        % training 
        train=imread([folder num2str(i) '.jpg']);
        trainl(count) = j;
        trainh(count,:) = [Histograms(train(:,:,1),bin), Histograms(train(:,:,2),bin), Histograms(train(:,:,3),bin)];        
        % testing 
%         test=imread([folder num2str(i) '.jpg']);
%         testl(count) = j;
%         testh(count,:) = [Histograms(test(:,:,1),bin), Histograms(test(:,:,2),bin), Histograms(test(:,:,3),bin)];
%         count=count+1;
%     end
end

% index2=MeanShift(trainh,testh,'k',1,'Distance','euclidean');

count=0;
for i=1:size(testh,1)
    if testl(i)==trainl(index2(i))
        count=count+1;
    end
%     disp(['Test image ' num2str(i) ' of class ' num2str(testl(i)) ' has been assigned to class ' num2str(testl(index2(i))) '.']);    
end

