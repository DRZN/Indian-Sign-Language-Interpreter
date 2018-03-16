function [haus_class, cross_class]= all_template(template_haus)


srcFiles = dir('C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\images\Template_matching\haus_img2\*.png');  % the folder in which ur images exists


for l = 1: length(srcFiles)

  
filename = strcat('C:\Users\hp\Desktop\Deeksha\BE_ISL\deeeksha\images\Template_matching\haus_img2\',srcFiles(l).name);

img=imread('C:\Users\hp\Documents\MATLAB\BE_project\Akshara\images\input.png'); %test image

img1=imread(filename); %template image 
 
img_new=rgb2ycbcr(img); %input image
%img_new1=rgb2ycbcr(img1); %template image

m=size(img_new,1);
n=size(img_new,2);

for i=1:m
    for j= 1:n
        y=img_new(i,j,1);
        cb = img_new(i,j,2);
        cr = img_new(i,j,3);
        if(cr > 130 && cr < 180 && cb > 75 && cb < 135 && y > 80)
            img_new(i,j,1)=235;
            img_new(i,j,2)=128;
            img_new(i,j,3)=128;
           
        else
             img_new(i,j,1)=0;
             img_new(i,j,2)=128;
             img_new(i,j,3)=128;
             
       end
    end
end

% for i=1:m
%     for j= 1:n
%         y=img_new1(i,j,1);
%         cb = img_new1(i,j,2);
%         cr = img_new1(i,j,3);
%         if(cr > 130 && cr < 180 && cb > 75 && cb < 135 && y > 80)
%             img_new1(i,j,1)=235;
%             img_new1(i,j,2)=128;
%             img_new1(i,j,3)=128;
%            
%         else
%              img_new1(i,j,1)=0;
%              img_new1(i,j,2)=128;
%              img_new1(i,j,3)=128;
%              
%        end
%     end
% end


img2=ycbcr2rgb(img_new);
% img3=ycbcr2rgb(img_new1);
% final_img=imbinarize(rgb2gray(img2));
level = graythresh(rgb2gray(img2));
final_img = im2bw(rgb2gray(img2),level);

% level1 = graythresh(rgb2gray(img3));
% final_img1 = im2bw(rgb2gray(img3),level1);
 

%% removing noise!!!! 

for i=2:m-1

    for j=2:n-1
       
        pixel=final_img(i,j);
        pixel_1=final_img(i,j+1);
        pixel_2=final_img(i,j-1);
        pixel_3=final_img(i+1,j+1);
        pixel_4=final_img(i+1,j-1);
        pixel_5=final_img(i-1,j+1);
        pixel_6=final_img(i-1,j-1);
        pixel_7=final_img(i+1,j);
        pixel_8=final_img(i-1,j);
        
        sum=pixel_1+pixel_2+pixel_3+pixel_4+pixel_5+pixel_6+pixel_7+pixel_8;
        if(sum<4)
          final_img(i,j)=0;
        end    
        
        
    end    
end    

%% removing noise!!!! 

for i=2:m-1

    for j=2:n-1
       
        pixel=final_img(i,j);
        pixel_1=final_img(i,j+1);
        pixel_2=final_img(i,j-1);
        pixel_3=final_img(i+1,j+1);
        pixel_4=final_img(i+1,j-1);
        pixel_5=final_img(i-1,j+1);
        pixel_6=final_img(i-1,j-1);
        pixel_7=final_img(i+1,j);
        pixel_8=final_img(i-1,j);
        
        sum=pixel_1+pixel_2+pixel_3+pixel_4+pixel_5+pixel_6+pixel_7+pixel_8;
        if(sum<4)
          final_img(i,j)=0;
        end    
        
        
    end    
end  

% %% removing noise!!!! 
% 
% for i=2:m-1
% 
%     for j=2:n-1
%        
%         pixel=final_img1(i,j);
%         pixel_1=final_img1(i,j+1);
%         pixel_2=final_img1(i,j-1);
%         pixel_3=final_img1(i+1,j+1);
%         pixel_4=final_img1(i+1,j-1);
%         pixel_5=final_img1(i-1,j+1);
%         pixel_6=final_img1(i-1,j-1);
%         pixel_7=final_img1(i+1,j);
%         pixel_8=final_img1(i-1,j);
%         
%         sum=pixel_1+pixel_2+pixel_3+pixel_4+pixel_5+pixel_6+pixel_7+pixel_8;
%         if(sum<4)
%           final_img1(i,j)=0;
%         end    
%         
%         
%     end    
% end    
% 
% %% removing noise!!!! 
% 
% for i=2:m-1
% 
%     for j=2:n-1
%        
%         pixel=final_img1(i,j);
%         pixel_1=final_img1(i,j+1);
%         pixel_2=final_img1(i,j-1);
%         pixel_3=final_img1(i+1,j+1);
%         pixel_4=final_img1(i+1,j-1);
%         pixel_5=final_img1(i-1,j+1);
%         pixel_6=final_img1(i-1,j-1);
%         pixel_7=final_img1(i+1,j);
%         pixel_8=final_img1(i-1,j);
%         
%         sum=pixel_1+pixel_2+pixel_3+pixel_4+pixel_5+pixel_6+pixel_7+pixel_8;
%         if(sum<4)
%           final_img1(i,j)=0;
%         end    
%         
%         
%     end    
% end    

%% Dilation

% b1=final_img1;
b=final_img;
N(1:m,1:n)=0;
% N1(1:m,1:n)=0;
for i=1:m-2;
for j=1:n-2;

w=[1*b(i,j) 1*b(i,j+1) 1*b(i,j+2) 1*b(i+2,j) 1*b(i+2,j+1) 1*b(i+2,j+2)];
N(i,j)=max(w);  

%     w1=[1*b1(i,j) 1*b1(i,j+1) 1*b1(i,j+2) 1*b1(i+2,j) 1*b1(i+2,j+1) 1*b1(i+2,j+2)];
% N1(i,j)=max(w1);

   end; 
end;  

%% shifting center.
[p, q] = size(N);
cent =[p/2, q/2];
cc=bwconncomp(N);
c2=regionprops(cc,'Centroid');
cj=c2.Centroid;

rows= round(cent(1)-cj(2));
col = round(cent(2)-cj(1)); 

copy= circshift(N,[rows col]);

% [p,q] = size(N);
% cent =[p/2, q/2];

% count=0;
% x_sum=0;
% y_sum=0;
% 
% for i=1:p
% 
%     for j=1:q
% 
%        pixel=N(i,j);
%        if(pixel==1)
%           count=count+1; 
%           x_sum=x_sum+i;
%           y_sum=y_sum+j;
%        end    
%        
%        
%         
%     end    
% end    
% 
% cj(1)=x_sum/count;
% cj(2)=y_sum/count;
% 
% rows= round(cent(1)-cj(1));
% col = round(cent(2)-cj(2));
% 
% copy= circshift(N,[rows col]);
% 
% N=copy;


% %% shifting center.
% [p q] = size(N1);
% cent1 =[p/2, q/2];
% cc1=bwconncomp(N1);
% c3=regionprops(cc1,'Centroid');
% cj=c3.Centroid;
% 
% rows= round(cent(1)-cj(2));
% col = round(cent(2)-cj(1));
% 
% copy1= circshift(N1,[rows col]);


%% edge detection

BW = edge(copy,'sobel');
% BW1 = edge(copy1,'sobel');

%% corner harris

I = BW;
C1 = corner(I);

I1=img1 ;
C2 = corner(I1);

haus(l)=hausdorff(C1,C2);


%% cross power spectrum

template = img1;  %img: 858 img1: 78
background =BW;

% calculate padding
tx = size(template, 2); % used for box placement
ty = size(template, 1);

%// Change - Compute the cross power spectrum
Ga = fft2(background);
Gb = fft2(template);
c = real(ifft2((Ga.*conj(Gb))./abs(Ga.*conj(Gb))));

% find peak correlation
max_c   = max(abs(c(:))); % returning the max value.
crosspower(l)=max_c;



end
[a ,ind] =  min(haus(:)); %% minimum dissimilarity at what index?   
trial = template_haus(ind); %% which character does each template(78) belong to.
haus_class= trial;


[a1 ,ind] =  max(crosspower(:));
cross_class = template_haus(ind);

end







