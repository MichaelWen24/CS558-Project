function image_filter = f(image,filter)
%image info
iw = size(image,2);%image width
ih = size (image,1);%image height

%filter info
fw = size(filter,2);%filter width
fh = size(filter,1);%filter height
fhw = (fw - 1)/2;%filter half width
fhh = (fh - 1)/2;%filter half height

image1 = zeros(iw+fhw*2, ih+fhh*2);
for i = 1:iw
    for j = 1:ih
        image1(j+fhh, i+fhw) = image(j, i);
    end
end

%replicate boundary
for i = 1:iw + fhw * 2
    for j = 1:ih + fhh *2
        if i<=fhw && j>=fhh && j<=ih+fhh
            image1(j,i)=image1(j,fhw+1);
        elseif i>=iw+fhw+1 && j>=fhh+1 && j<=ih+fhh
            image1(j,i)=image1(j,fhw+iw);
        elseif j<=fhh && i>=fhw+1 && i<=iw+fhw
            image1(j,i)=image1(fhh,i);
        elseif j>=ih+fhh+1 && i>=fhw+1 && i<=iw+fhw
            image1(j,i)=image1(ih+fhh,i);
        elseif i<=fhw && j<=fhh
            image1(j,i)=image1(1+fhh,1+fhw);
        elseif i<=fhw && j>=ih+fhh+1
            image1(j,i)=image1(ih+fhh,1+fhw);
        elseif j<=fhh && i>=iw+fhw+1
            image1(j,i)=image1(1+fhh,iw+fhw);
        elseif i>=iw+fhw+1 && j>=ih+fhh+1
            image1(j,i)=image1(iw+fhh,iw+fhw);
        end
    end
end

%filter
image2 = image1;
for i = 1+fhw:iw+fhw
    for j = 1+fhh:ih+fhh
        image2(j,i)=sum(sum(filter.*image1(j-fhh:j+fhh, i-fhw:i+fhw)));
    end
end

image_filter=zeros(ih,iw);
for i=1:iw
    for j=1:ih
        image_filter(j,i)=image2(j+fhh,i+fhw);
    end
end
            

