% Import Image from Database

clc;
clear;

img_width = 100;
img_height = 116;

Images_No = 23;
Set_Size = 5;

X = zeros(img_width*img_height,Images_No*Set_Size);
%y = zeros(Images_No*Set_Size,3);
counter = 1;

% Image Reading

for k = 1:Images_No
    for j = 1:Set_Size
        
        % Create a mat filename, and load it into a structure called matData.
        % matFileName = sprintf('ML Class Database\%d_%d.JPG', k,j);
        % if exist(matFileName, 'file')
        %     matData = load(matFileName);
        % else
        %     fprintf('File %s does not exist.\n', matFileName);
        % end

        % Create an image filename, and read it in to a variable called imageData.
        
        jpgFileName = strcat('D:\sem6\ML\ML Class Database\',num2str(k),'_',num2str(j),'.JPG');
        
        if exist(jpgFileName, 'file')
            
            im = imread(jpgFileName);
            im = rgb2gray(im);
            im = imresize(im,0.0735);
            im = im2double(im);

            X(:,counter) = reshape(im,size(X,1),1);
            %t = reshape(X(:,counter),img_height,img_width);
            %imshow(t)
            %y(k,counter) = 1;
            
        else
            fprintf('File %s does not exist.\n', jpgFileName);
        end

        % Create a text file name, and read the file.
        % textFileName = ['file' num2str(k) '.txt'];
        % if exist(textFileName, 'file')
        %     fid = fopen(textFileName, 'rt');
        %     textData = fread(fid);
        %     fclose(fid);
        % else
        %     fprintf('File %s does not exist.\n', textFileName);
        % end
        
        counter = counter + 1;
    end
end