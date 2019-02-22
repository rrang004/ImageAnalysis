%Frame by Frame Analysis

%Start clock
tic

%ENTER NAME OF FILE HERE (MUST BE IN LOCAL DIRECTORY OF PROGRAM)
fname = 'Data1n.tif';
img = imread(fname);
info = imfinfo(fname);
num_images = numel(info);

%Arrays with frames corresponding to closest shape
shape1 = [];
shape2 = [];
shape3 = [];
shape4 = [];

%Arrays with frames with tethers in focus
tether1 = [];
tether2 = [];
tether3 = [];
tether4 = [];
%Read in desired precision
%prompt = 'Enter precision (0-100):';
%precision = input(prompt)

%Selecting Base Frames
 BaseFrame1 = imread(fname,89, 'Info', info)       
 BaseFrame2 = imread(fname,93, 'Info', info)
 BaseFrame3 = imread(fname,100, 'Info', info)
 BaseFrame4 = imread(fname,105, 'Info', info)
 Tether1 = imread(fname, 92, 'Info', info)
 Tether2 = imread(fname, 100, 'Info', info)
 %Loop to just analyze bead part of image
 %TestFrame = imread(fname, 90, 'Info', info)
 %disp(TestFrame(127,119))

 
 for k = 1:num_images
      frame = imread(fname,k, 'Info', info) 
       sum1 = 0
       sum2 = 0
       sum3 = 0
       sum4 = 0
 
     for x = 127:168
         for y = 119:153
            if BaseFrame1(x,y) == frame(x,y)
                sum1 = sum1 + 1
            end
            if BaseFrame2(x,y) == frame(x,y)
                sum2 = sum2 + 1
            end
            if BaseFrame3(x,y) == frame(x,y)
                sum3 = sum3 + 1
            end
            if BaseFrame4(x,y) == frame(x,y)
                sum4 = sum4 + 1
            end
            
       
    
    
           end
     end
     
     percent1 = sum1/1470 * 100
     percent2 = sum2/1470 * 100
     percent3 = sum3/1470 * 100
     percent4 = sum4/1470 * 100
     %ADJUST PERCENTAGES
    if percent1 >= 23.8
        shape1(end+1) = k
    elseif percent2 >= 23.8
        shape2(end+1) = k
    elseif percent3 >= 23.8
        shape3(end+1) = k
    elseif percent4 >= 23.8
        shape4(end+1) = k
    end
 end
 %}
 
 CombinedFrames = [shape1 shape2 shape3 shape4]
 CombinedSize = length(CombinedFrames)
 GoodFrames = []

 
 %Filtering to focus on organizing tethers
   for k = 1:CombinedSize
       i = CombinedFrames(k)
      frame = imread(fname,i, 'Info', info) 
       sum1 = 0
       sum2 = 0
 
     for x = 69:117
         for y = 131:133
           %{ 
            if Tether1(x,y) <= frame(x,y) + 1 || Tether1(x,y) >= frame(x,y) - 1
                sum1 = sum1 + 1
            else if Tether2(x,y) <= frame(x,y) + 1 || Tether2(x,y) >= frame(x,y) - 1
                sum2 = sum2 + 1
           %}
            if Tether1(x,y) == frame(x,y)
                sum1 = sum1 + 1
            else if Tether2(x,y) == frame(x,y)
                sum2 = sum2 + 1
           
                end
            
       
  
            end
         end
     end
     
     tetherpercent1 = sum1/147 * 100
     tetherpercent2 = sum2/147 * 100
     %ADJUST PERCENTAGES
        if tetherpercent1 >= 22 || tetherpercent2 >= 20
           GoodFrames(end+1) = i
           end
        
      
   end

    
  %{  
    disp('Frames close to pattern 1: ')
    disp(shape1)
    disp('Frames close to pattern 2: ')
    disp(shape2)
    disp('Frames close to pattern 3: ')
    disp(shape3)
    disp('Frames close to pattern 4: ')
    disp(shape4)
 %}
 %{
for k = 1:1%num_images
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
 %}
 %End clock
 toc

 