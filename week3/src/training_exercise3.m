function [ output_args ] = training_exercise3( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    function box_filter(n, I)
        
        sI = size(I);
        
        Ip = pad_image(I, n);
        sIp = size(Ip);
        
        figure(2), imshow(Ip)
        
        filter_size = 2*n + 1;
        filter = 1/(filter_size*2) * ones(filter_size,filter_size);
        
        ftIp = mat2gray(zeros(sIp));
        ftIp = im2uint8(ftIp);
        
        ftIp = fftshift(fft2(Ip));
        
        figure(3), imshow(ftIp)
        
        f = fftshift(fft2(filter));
        
        new_image = mat2gray(zeros(sI));
        new_image = im2uint8(new_image);
        
        for x = n+1:sIp(1)-n
            for y = n+1:sIp(2)-n
                new_image(x,y) = sum(ftIp(x-n:x+n,y-n:y+n)*f);
            end
        end
        
        figure(4), imshow(new_image)
        figure(5), imshow(ifftshift(ifft2(ftIp)))
        
    end
        
    function [ new_image ] = pad_image(I, n)

        newimagesize = size(I);
        newimagesize = [newimagesize(1)+2*n newimagesize(2) + 2*n];
        
        new_image = mat2gray(zeros(newimagesize));
        new_image = im2uint8(new_image);
        
        new_image(n+1:end-n, n+1:end-n) = I(:,:);
        
    end

    function run()
        
        image = imread('./images/unix.tiff');
        figure(1), imshow(image)

        n = 3;
        
        box_filter(n, image)
        
    end

    run()


end

