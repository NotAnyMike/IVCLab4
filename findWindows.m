function locations = findWindows(window_size,img_test,svm_model1)
    img = rgb2gray(img_test);
    locations = [];
    [imgd1, imgd2, ~] = size(img_test);
    windd1 = window_size(1);
    windd2 = window_size(2);
    i = 1; j = 1;
    while i <= (imgd1-windd2)     
        while j <= (imgd2-windd1)
            window = img(i:i+windd2,j:j+windd1,:);
            HoGFeatures = extractHOGFeatures(window,'CellSize',[32 32]);
            [label,score] = predict(svm_model1,HoGFeatures);
            if label == 1 & score(2) >= 0.1
                "adding location";
                locations = [locations; i,j];
            end
            j = j + 16;
        end
        j = 1;
        i = i + 16;
    end
end