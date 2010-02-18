function [ output_args ] = mandatory_exercise3( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    function exercise31(I, n)
        
        figure(1), imshow(I)
        
        si = size(I);

        ftI = fftshift(fft2(I));
        
        alpha = 0.4;
        beta = 2;
        
        cut_off = 30;
        
        %         lowpass_filter = ideal_lowpass(si(1), si(2), cut_off);
        
%         nftI = lowpass_filter.*ftI;
  
%         figure(2), imshow(lowpass_filter)
        
%         figure(3), imshow(log(abs(ifftshift(nftI)) + 1));
        
%         figure(4), imshow(ifft2(ifftshift(nftI)),[]);

%         bw_filter = butterworth(si(1), si(2), cut_off, 2);
        
%         nftI2 = bw_filter.*ftI;
        
%         figure(5), imshow(bw_filter)
%         figure(6), imshow(ifft2(ifftshift(nftI2)), [])
        
        hfe_filter = hfe(si(1), si(2), alpha, beta, cut_off)
        
        nftI3 = hfe_filter.*ftI;

        figure(7), imshow(hfe_filter);
        
        figure(8), imshow(ifft2(ifftshift(nftI3)),[]);        
        
%         imwrite(tft_image2, '../report/images/ft_image2.png', 'png');
        
         figure(2), imshow(lowpass_filter)
         figure(4), imshow(ifft2(ifftshift(nftI)),[]);


    end

        function [filter] = ideal_lowpass(x,y, D0)
            
            filter = zeros(x,y);
            
            for i=1:x
                for j = 1:y
                    if ((i-(x/2))^2 + (j-(y/2))^2)^(1/2) < D0
                        filter(i,j) = 1;
                    else
                        filter(i,j) = 0;
                    end
                end
            end
        end
    
        function [filter] = butterworth_lowpass(x,y, D0, n)
           
            filter = zeros(x,y);
            
            for i=1:x
                for j=1:y
%                   if ((i-(x/2))^2 + (j-(y/2))^2)^(1/2) > D0
                        filter(i,j) = 1/(1 + (((i-(x/2))^2 + (j-(y/2))^2)^(1/2)/D0)^(2*n));
%                     else
%                         filter(i,j) = 0;
%                   end
                end
            end
        end

        function [filter] = butterworth_highpass(x,y, D0, n)
           
            filter = zeros(x,y);
            
            for i=1:x
                for j=1:y
%                   if ((i-(x/2))^2 + (j-(y/2))^2)^(1/2) > D0
                        filter(i,j) = 1 - (1/(1 + (((i-(x/2))^2 + (j-(y/2))^2)^(1/2)/D0)^(2*n)));
%                     else
%                         filter(i,j) = 0;
%                   end
                end
            end
        end
    
    
        function [filter] = hfe(x,y,alpha,beta, D0) 
        
            filter = zeros(x,y)
            
            for i=1:x
                for j=1:y
                    filter(i,j) = alpha + beta/(1 + (((i-(x/2))^2 + (j-(y/2))^2)^(1/2)/D0)^2);
                end
            end
        end

    function exercise33(I)
   
        si = size(I);
        
%         figure(1), imshow(I)
        
        ftI = fftshift(fft2(I));
        
%         figure(2), imshow(ftI)
        
%         figure(3), imshow(log(abs(ifftshift(ftI)) + 1));        
        
        figure(4), imshow(log(abs(ifftshift(ftI)) + 1), []);        

        design_filter = zeros(si(1), si(2));
        
        
        design_filter(180:200, 30:60) = ones(21,31);
        
        design_filter(60:80, 200:230) = ones(21,31);
        
        
        
        figure(9), imshow(design_filter)
        
        bwlf = butterworth_lowpass(si(1), si(2), 25, 2);
        
        nft3 = bwlf.*ftI;

%         figure(4), imshow(log(abs(nft3) + 1), []);
        
%         figure(7), imshow(bwlf);
        
%         figure(8), imshow(ifft2(ifftshift(nft3)),[]);        
        
        
    end

    function run( ~ )

        image_q31a = imread('./images/square.tiff');
        image_q31b = imread('./images/unix.tiff');
        
%         exercise31(image_q31a)
        
        image_q33a = imread('./images/noisy.tiff');

        exercise33(image_q33a)
            

    end

run()



end