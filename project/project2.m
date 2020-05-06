clear all;

folder = 'castle_dense/';
traini=double(imread([folder '0008.jpg']));        
maski=double(imread([folder 'mask2.jpg'])); 

trainimage = imresize(traini, 0.125);
maskimage = imresize(maski, 0.125);

car=[];
noncar=[];
carcolor = [];
carcolor(1,1,1) = 255;
carcolor(1,1,2) = 255;
carcolor(1,1,3) = 255;

paintcolor = [];
paintcolor(1,1,1) = 255;
paintcolor(1,1,2) = 255;
paintcolor(1,1,3) = 255;
skyindex=1;     
nonskyindex=1;     

for i=1:size(trainimage,1)
    for j=1:size(trainimage,2)
        if maskimage(i,j,:)== carcolor
            car(skyindex,:)=trainimage(i,j,:);
            skyindex=skyindex+1;
        else
            noncar(nonskyindex,:)=trainimage(i,j,:);
            nonskyindex=nonskyindex+1;
        end
    end
end

% k-means
k=8;
[~,sw]=kmeans(car,k,'EmptyAction','singleton');
[~,nsw]=kmeans(noncar,k,'EmptyAction','singleton');
words=[ones(k,1) sw;zeros(k,1) nsw];

% testing
for n=1:9
    test1=imread([folder '000' num2str(n) '.jpg']);
    [s1,s2,s3] = size(test1);
    test2=double(reshape(test1,s1*s2,s3,1));
    index3=knnsearch(words(:,2:end),test2,'k',1,'Distance','euclidean');
    test3=words(index3,1);
    [x,y]=ind2sub([s1 s2],1:s1*s2);
    
%     painting sky
    for i=1:s1*s2
        if test3(i)==1
            test1(x(i),y(i),:)= paintcolor;         
        end
    end
    
    figure,imshow(test1);
    imwrite(test1, [folder 'nocar' num2str(n) '.jpg']);
end

for n=10:18
    test1=imread([folder '00' num2str(n) '.jpg']);
    [s1,s2,s3] = size(test1);
    test2=double(reshape(test1,s1*s2,s3,1));
    index3=knnsearch(words(:,2:end),test2,'k',1,'Distance','euclidean');
    test3=words(index3,1);
    [x,y]=ind2sub([s1 s2],1:s1*s2);
    
%     painting sky
    for i=1:s1*s2
        if test3(i)==1
            test1(x(i),y(i),:)= paintcolor;         
        end
    end
    
    figure,imshow(test1);
    imwrite(test1, [folder 'nocar' num2str(n) '.jpg']);
end