clear all;

% SLIC
folder = 'project4/';
image=imread([folder 'white-tower.png']);
h2=size(image,1);
w2=size(image,2);
image=double(image);

% parameter
s=50;

% slic
image1=SLIC(image,s);

image1=uint8(image1(:,:,1:3));
figure,imshow(image1);
imwrite(image1,[folder 'tower_SLIC1.jpg']);

% color the pixel that touch two different clusters black
simage=image1;
for i=2:h2-1
    for j=2:w2-1
        flag=0;
        for t=1:3
            if image1(i,j,t)~=image1(i+1,j,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i,j+1,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i-1,j,t)
            	flag=1;
            end
            if image1(i,j,t)~=image1(i,j-1,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i+1,j+1,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i-1,j-1,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i+1,j-1,t)
                flag=1;
            end
            if image1(i,j,t)~=image1(i-1,j+1,t)
                flag=1;
            end
        end
        if flag==1
            simage(i,j,:)=[0 0 0];
        end
    end
end

figure,imshow(simage);
imwrite(simage,[folder 'tower_SLIC2.jpg']);