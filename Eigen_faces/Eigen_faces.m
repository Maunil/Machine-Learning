clear;
clc;

load data.mat

Original = X;
img_height = 116;
img_width = 100;

m_n = zeros(size(X,1),1);

for i=1:1:size(X,2)
    m_n = m_n + X(:,i);
end
m_n = m_n/size(X,2);

%Normalizing

for i=1:1:size(X,2)
    X(:,i)= X(:,i) - m_n;
end

C = X'*X;
no_eigenvectors = 1;
[V D] = eigs(C,no_eigenvectors);

V_ac = X*V;

eigen_face = zeros(img_height,img_width,20);
for j=1:1:no_eigenvectors
    eigen_face(:,:,j) = reshape(V_ac(:,j),img_height,img_width);
end

%Weights 
W = zeros(no_eigenvectors,size(X,2));
for j=1:1:size(X,2)
    W(:,j) = V_ac'*X(:,j);
end

No_images_check = 23;
No_sub_images = 5;
true_case = 0;

for k=1:1:No_images_check
    for j=1:1:No_sub_images
        %New Image add 
        
        j_file = strcat('D:\sem6\ML\ML Class Database\',num2str(k),'_',num2str(j),'.jpg');
        im = imread(j_file);
        im = rgb2gray(im);
        im = imresize(im,0.0735);
        im = im2double(im);

        new_image = reshape(im,size(X,1),1);

        %Normalize
        new_image = new_image-m_n; 

        %New weights
        N_W = zeros(no_eigenvectors,1);
        N_W = V_ac'*new_image;
        
        %Recognization 
        distance = zeros(size(X,2),1);
        for i=1:1:size(X,2)
            distance(i,1) = sum(abs(N_W-W(:,i)));
        end

        [dis,I] = sort(distance,'ascend');

        %Detected 
        U = reshape(Original(:,I(1)),img_height,img_width);
        imshow(U)
        if(mod(I(1),No_sub_images)==0)
           I_m = I(1)/No_sub_images;
           I_em = No_sub_images;
        else
            I_m = floor(I(1)/No_sub_images)+1;
            I_em = mod(I(1),No_sub_images);
        end
        if(I_m==k&I_em==j)
            true_case = true_case +1;
        end
     end
end
true_case








