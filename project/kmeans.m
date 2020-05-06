function image2=kmeans(image1,center,k)

h=size(image1,1);%height
w=size(image1,2);%width
m=size(image1,3);

% get RGB
center1=zeros(k,m);
center2=zeros(k,m);
for i=1:k
    center1(i,1:m)=image1(center(i,1),center(i,2),:);
end

% initialize distance
distance=inf(h,w,k);

%calculate the distance
flag=0;
while ~flag
    for i=1:k
        for d=1:m
            temp(:,:,d)=repmat(center1(i,d),h,w);
        end
        
        distance(:,:,i)=sqrt(sum(power(image1-temp,2),3));
    end
    
    % find out which closest center
    [~,d] = min(distance,[],3);
    
    % find the centroid of these points in each cluster
    for i=1:k
        index=d==i;
        rgb=reshape(image1(repmat(index,1,1,m)),sum(index(:)),m);
        center2(i,:)=round(mean(rgb));
    end

    if abs(norm(center1-center2))<0.1
        flag=1;
    end
    
    center1=center2;
end  

image2=zeros(h,w,m);
for i=1:h
    for j=1:w
        image2(i,j,:)=center1(d(i,j),:);
    end
end


