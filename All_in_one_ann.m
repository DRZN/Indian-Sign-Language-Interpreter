%% all in one. final piece 
 
function [class]=All_in_one_ann(image,net)

%% Extracting the image that was taken
img_new = image;


%% Segmentation

img_new=rgb2ycbcr(img_new);

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


img2=ycbcr2rgb(img_new);
final_img=imbinarize(rgb2gray(img2));



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

%% removing noise again!!!! 

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

%% Dilation

b=final_img;
N(1:m,1:n)=0;

for i=1:m-2;
for j=1:n-2;

w=[1*b(i,j) 1*b(i,j+1) 1*b(i,j+2) 1*b(i+2,j) 1*b(i+2,j+1) 1*b(i+2,j+2)];
N(i,j)=max(w);  

end;
end;

% final image to work on is N, hence....

final_img=N;

% Calculating Compactness

% count1=0;
% count2=0;
% 
% for i=1:m
%     for j=1:n
%        
%         pixel1=final_img(i,j);
%         if(pixel1)
%            count1=count1+1; 
%         end    
%         
%         pixel2=final_img(i,j);
%         if(pixel2)
%             count2=count2+1;
%         end    
%     end    
% end    
% 
% compactness=(count2*count2)/(4*(pi)*count1);
% 
% % orientation
% 
% % ---------- STEP 1 -----------
% %calculate centroid of the hand
% 
% sum_x=0;
% sum_y=0;
% 
% for i=1:m
%    
%     for j=1:n
%         
%         pixel= N(i,j);
%         if(pixel==1)
%         sum_x=sum_x+i;
%         sum_y=sum_y+j;
%         end    
%         
%     end    
%     
% end  
% 
% c_x=round(sum_x/count1);
% c_y=round(sum_y/count1);
% 
% %------------ STEP 2 ----------
% %calculate base line
% flag=0;
% 
% for i=m:-1:1
%    
%     for j=n:-1:1
%         
%         pixel=N(i,j);
%         if(pixel==1&&flag==0)
%             
%             
%             base_x=i;
%             base_y=j;
%             flag=1;
%             break;
%         end
%     end    
%     
%     if(flag==1)
%         break;      
%     end    
%     
% end
% 
% % baseline row if base_x
% % now calculating baseline's centroid
% 
% 
% % ----------- STEP 3 ---------
% 
% sum_x=0;
% sum_y=0;
% c=0;
% 
% for j=base_y:-1:1
% 
%     pixel=N(base_x,j);
%     if(pixel==1)
%         c=c+1;
%         %sum_x=sum_x+base_x;
%         sum_y=sum_y+j;   
%     end    
%     
% end
% 
% %bc_x=round(sum_x/c);  % baseline's centroid's absicca
% bc_x=base_x;
% bc_y=round(sum_y/c);  % baseline's centroid's ordinate
% 
% % ------------ STEP 4 -----------
% % the orientation can be calculated by the direction of the line between
% % the hand's centroid and the baseline's centroid. 
% 
% 
% slope=(c_y-bc_y)/(c_x-bc_x);
% 
% angle= atand(slope);
% 

%% Potential energy row and column

Nb1=N;
BW=edge(N,'Sobel');

a=BW;
ar=zeros(1,180);
ac=zeros(1,220);

for i=1:m
    ar(i)=0;
    for j=1:n
        ar(i)=a(i,j)+ar(i);
    end
    ar(i)= ar(i)*i;
    
end

for i=1:n
    ac(i)=0;
    for j=1:m
        ac(i)=a(j,i)+ac(i);
    end
    ac(i)= ac(i)*i;
end

%% PE features

row=ar;
col=ac;

transform_row=abs(fft(row)); % Magnitude
transform_col=abs(fft(col)); % Magnitude

normalized_transform_row=transform_row/(transform_row(1)); %normalized
normalized_transform_col=transform_col/(transform_col(1)); %normalized

second_order_row=moment(normalized_transform_row,2);  %variance
second_order_col=moment(normalized_transform_col,2);  %variance

%Variance is a measure of the dispersion of the data in a sample.
%It is a good descriptor of the probability distribution of a random variable.

third_order_row=moment(normalized_transform_row,3);   %skewness
third_order_col=moment(normalized_transform_col,3);   %skewness

%Skewness is a measure of the asymmetry of the probability 
%distribution of a real-valued random variable.

fourth_order_row=moment(normalized_transform_row,4);  %kurtosis
fourth_order_col=moment(normalized_transform_col,4);  %kurtosis

%Kurtosis is a measure of the "peakedness" of a probability distribution.

new_features_pe{1,1}=second_order_row;
new_features_pe{1,2}=second_order_col;
new_features_pe{1,3}=third_order_row;
new_features_pe{1,4}=third_order_col;
new_features_pe{1,5}=fourth_order_row;
new_features_pe{1,6}=fourth_order_col;

%testing features in the network.

%load('C:\Users\hp\Documents\MATLAB\BE_project\Akshara\feaure data\networks\net_fitnet_1.mat') %network trained for potential energy features.
test=cell2mat(new_features_pe);
class=net(transpose(test));
[maximum, class]=max(class);
 
%disp(class);


end
