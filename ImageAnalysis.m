%Frame by Frame Analysis

%Start clock
tic

fname = 'Data1n.tif';
img = imread(fname);
info = imfinfo(fname);
num_images = numel(info);

%Arrays with frames corresponding to closest shape
shape1 = [];
shape2 = [];
shape3 = [];
shape4 = [];

%Read in desired precision
%prompt = 'Enter precision (0-100):';
%precision = input(prompt)

%Selecting Base Frames
 BaseFrame1 = imread(fname,89, 'Info', info)       
 BaseFrame2 = imread(fname,93, 'Info', info)
 BaseFrame3 = imread(fname,100, 'Info', info)
 BaseFrame4 = imread(fname,105, 'Info', info)

for k = 1:num_images
    %Iterate through and pick out frames of interest
    frame = imread(fname, k, 'Info', info)
    
    %source: http://stackoverflow.com/questions/2202641/how-do-i-compare-all-elements-of-two-arrays
    %create matrices of similarities using current frame and base frame
    similar1 = frame == BaseFrame1
    similar2 = frame == BaseFrame2
    similar3 = frame == BaseFrame3
    similar4 = frame == BaseFrame4
    
    %number of similar pixels compared to each base frame
    sum1 = sum(similar1(:) == 1)
    sum2 = sum(similar2(:) == 1)
    sum3 = sum(similar3(:) == 1)
    sum4 = sum(similar4(:) == 1)
    
    percent1 = sum1/160000
    percent2 = sum2/160000
    percent3 = sum3/160000
    percent4 = sum4/160000
    
    if percent1 >= .22
        shape1(end+1) = k
    elseif percent2 >= .22
        shape2(end+1) = k
    elseif percent3 >= .22
        shape3(end+1) = k
    elseif percent4 >= .22
        shape4(end+1) = k
    end
    
  
    
end

    disp('Frames close to pattern 1: ')
    disp(shape1)
    disp('Frames close to pattern 2: ')
    disp(shape2)
    disp('Frames close to pattern 3: ')
    disp(shape3)
    disp('Frames close to pattern 4: ')
    disp(shape4)
 
 %End clock
 toc
