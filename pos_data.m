function [train_data_pos,label_ops] = pos_data(pos_train_names)
    dir = pwd();
    num = size(pos_train_names,1);
    train_data_pos = []; % to hold all the HoG for training
    trn_imgs = [];
    imsize = [300, 100];       
    
    for i = 1:num
        input_dir = strcat(dir,'/Trainsvm/humanpos/',pos_train_names(i,:));
        input_raw = imresize(imread(input_dir),imsize);
        if(i<8) trn_imgs  = [trn_imgs,input_raw];end
        input = rgb2gray(input_raw);
        tmp = extractHOGFeatures(input,'CellSize',[32 32]);
        train_data_pos = [train_data_pos;tmp]; 
    end 
    
    num_pos = size(train_data_pos,1);
    label_ops = ones(num_pos,1);
    
    figure(1); clf; imagesc(trn_imgs); title('Example Train Images: Positive');