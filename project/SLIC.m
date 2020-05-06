function image2=SLIC(image1,s)

h=size(image1,1); % image height
w=size(image1,2); % image width

% gradient magnitude
sobel_x=[-1,0,1;-2,0,2;-1,0,1];
sobel_y=[1,2,1;0,0,0;-1,-2,-1];
gradient(:,:,1)=f(image1(:,:,1),sobel_x);
gradient(:,:,2)=f(image1(:,:,2),sobel_x);
gradient(:,:,3)=f(image1(:,:,3),sobel_x);
gradient(:,:,4)=f(image1(:,:,1),sobel_y);
gradient(:,:,5)=f(image1(:,:,2),sobel_y);
gradient(:,:,6)=f(image1(:,:,3),sobel_y);
gradient=sqrt(sum(power(gradient,2),3));

% initialize the centroids and move it to the position 
% with the smallest gradient magnitude
count=1;
centroids=zeros(h,w);
for i=round((s+1)/2):s:h
    for j=round((s+1)/2):s:w
        window=gradient(i-1:i+1,j-1:j+1);
        [~,small]=min(window(:));
        [i2,j2]=ind2sub(size(window),small);
        centroids(i+i2-2,j+j2-2)=1;
        center(count,:)=[i+i2-2,j+j2-2];
        count=count+1;
    end
end

% divide x and y by 2
[x,y]=meshgrid(1:h,1:w);
x=x';
y=y';
image3(:,:,1:3)=image1;
image3(:,:,4)= x./2;
image3(:,:,5)= y./2;

% image3(:,:,4)= x.*2;
% image3(:,:,5)= y.*2;

% k-means
image2=kmeans(image3,center,count-1);

end
