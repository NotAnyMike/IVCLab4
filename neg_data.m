function [train_data_neg,label_neg] = neg_data(neg_train_names)
    dir = pwd();
    train_data_neg = [];
    num_neg = size(neg_train_names,1);
    num_neg = 600;
    train_imgs = [];
    for i = 1:num_neg
        try
        input_dir = strcat(dir,'/Trainsvm/train_neg/',neg_train_names(i,:));
        input_raw = imread(input_dir);
        %input = rgb2gray(input_raw);
        
        imsize =[300, 100];
        
        [x,y]=size(input_raw);
        xlimt =100;
        ylimt = floor(100/(imsize(1)/imsize(2)));
            if x>= xlimt && y >= ylimt
                input = rgb2gray(input_raw);
                randx = randi([1 xlimt],1,3);
                randy = randi([1 ylimt],1,3);
                for j = 1:3
                %inputrs=imresize(input,imsize);
                    %fprintf('\nin the randi for loop\n')
                    inputrs = input(randx(j):(randx(j)+xlimt),randy(j):(randy(j)+ylimt));
                    inputrs = imresize(inputrs,imsize);
                    %tmp = extractHOGFeatures(inputrs);
                    tmp = extractHOGFeatures(inputrs,'CellSize',[32 32]);

                    train_data_neg = [train_data_neg;tmp];
                    if(i==num_neg), train_imgs = [train_imgs, inputrs]; end
                end
            end
        end
    end
    num_neg= size(train_data_neg,1);
    label_neg = zeros(num_neg,1);
    
    figure(2); clf; imshow(input_raw); title('Example negative image');
    figure(3); clf; imshow(train_imgs); title('Example negative boxes');