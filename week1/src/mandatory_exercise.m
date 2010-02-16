function mandatory_exercise()

    function image = reduceGray(n, image)
        
        [counts, bins] = imhist(image, n+1);
        
        [m,n]=size(image);       
        
        for i=1:1:length(bins)-1
            for x=1:1:m
                for y=1:1:n
                    if image(x,y) >= bins(i) && image(x,y) <= bins(i+1)                        
                            image(x,y) = mean([bins(i) bins(i+1)]);
                    end
                end
            end
        end
    end

    function image = changeResolution(factor, image)
           
        [m,n] = size(image);
        
        overHang_m = mod(m, factor);
        overHang_n = mod(n, factor);
        
        if overHang_m/factor < 0.5 && overHang_m ~= 0
            copy = mat2gray(zeros(m+(factor-overHang_m),n));
            copy = im2uint8(copy);
            copy(1:m, 1:n) = image(:,:);
            copy_col = image(m,:);
            for i = m+1:m+(factor-overHang_m)
                for j = 1:length(copy_col)
                    copy(i,j) = copy_col(j);
                end
            end
            image=copy;

            clearvars copy;
        elseif overHang_m ~= 0
            image = image(1:m-overHang_m, :);
        end
        
        [m, n] = size(image);

        if overHang_n/factor < 0.5 && overHang_n ~= 0
            copy = mat2gray(zeros(m, n+(factor-overHang_n)));
            copy = im2uint8(copy);
            copy(1:size(image,1), 1:size(image,2)) = image(:,:);
            copy_row = image(size(image,1),:);
            for i = length(copy_row)
                for j = n+1:n+(factor-overHang_n)
                    copy(i,j) = copy_row(i);
                end
            end
            image = copy;

            clearvars copy;
        elseif overHang_n ~= 0
            image = image(:,1:size(image,2)-overHang_n);
        end
        
        [m, n] = size(image);
                  
        for x=1:factor:n
            for y=1:factor:m
                new_color = mean2(image(y:y+factor-1,x:x+factor-1));
                image(y:y+factor-1,x:x+factor-1) = new_color;
            end
        end
    end

    function run( ~ )
        filepath = './images/idotyl.tiff';
        %filepath = './images/brenda_keesal.tiff';
        
        I = imread(filepath);
        
%         imwrite(I, './images/img00.png')
%         figure, imhist(I)
        
        I = imadjust(I);
        
%         figure, imshow(I)
%         figure, imhist(I)
        
%         imwrite(I, './images/img01.png', 'png')
        
%         reduceTo = 64;
        
%         I_reduced_1 = reduceGray(reduceTo, I);

%         figure, imshow(I_reduced_1)
%         figure, imhist(I_reduced_1, 70);
        
%         imwrite(I_reduced_1, './images/img03.png', 'png')
        
%         reduceTo = 16;
%         I_reduced_2 = reduceGray(reduceTo, I);
        
%         figure, imshow(I_reduced_2);
%         figure, imhist(I_reduced_2, 20);
        
%         imwrite(I_reduced_2, './images/img05.png', 'png')
        
%         reduceTo = 6;
%         I_reduced_3 = reduceGray(reduceTo, I);
%         
%         figure, imshow(I_reduced_3);
%         figure, imhist(I_reduced_3, 8)
        
%         imwrite(I_reduced_3, './images/img07.png', 'png')


        % Run reduction sequence
%         R64 = reduceGray(64, I);
%         R32 = reduceGray(32, I);
%         R16 = reduceGray(16, I);
%         R8 = reduceGray(8, I);
%         R4 = reduceGray(4, I);
%         R2 = reduceGray(2, I);
% 
%         figure, imhist(R8, 8)
%         imwrite(R8, './images/r08.png', 'png')
%         figure, imhist(R4, 8)
%         imwrite(R4, './images/r04.png', 'png')
%         figure, imhist(R2, 8)
%         imwrite(R2, './images/r02.png', 'png')
%         
%         figure
%         hold on        
%         subplot(2,3,1)
%         imshow(R64)
%         subplot(2,3,2)
%         imshow(R32)
%         subplot(2,3,3)
%         imshow(R16)
%         subplot(2,3,4)
%         imshow(R8)
%         subplot(2,3,5)
%         imshow(R4)
%         subplot(2,3,6)
%         imshow(R2)
%         hold off
        
%          resolutionFactor = 3;
         rf4 = changeResolution(4, I);
         imwrite(rf4, './images/rf04.png', 'png')
         figure, imhist(rf4);
         
         rf8 = changeResolution(8, I);
         imwrite(rf8, './images/rf08.png', 'png')
         figure, imhist(rf8);

         rf16 = changeResolution(16, I);
         imwrite(rf16, './images/rf16.png', 'png')
         figure, imhist(rf16);
        
         
         
         %         figure, imshow(I_resolutionChange_1);

        
%         imwrite(I_resolutionChange_1, './images/img09.png', 'png')
        
%         resolutionFactor = 10;
%         I_resolutionChange_2 = changeResolution(resolutionFactor, I);
        
%         figure, imshow(I_resolutionChange_2);
%         figure, imhist(I_resolutionChange_2);
        
%         imwrite(I_resolutionChange_2, './images/img11.png', 'png')
        
    end

    run()

end