function [ output_args ] = mandatory_exercise3( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    function G = exercise31(I, d0, band, method, name)
       
        % Create filter
        if strcmp(method, 'ideal')
            h = ideal(I, d0);
        elseif strcmp(method, 'butter')
            n = 2;
            h = butterworth(I, d0, n);
        elseif strcmp(method, 'emphasis')
            alpha = 1;
            beta = 15;
            h = hfe(I, d0, alpha, beta);
        else
            % Fail is fail
            error('No such method');
        end
        
        if strcmp(band, 'low')
            % Do nothing
        elseif strcmp(band, 'high')
            h = (1 - h);
        else
            % Fail
            error('Select valid band')
        end
        
        % Inspect the filter
        %figure, imshow(h, []);
        
        % Save the filter to disk
        imwrite(h, ['../report/images/' name '_' method '_' band '_filter_' num2str(d0) '.png'], 'png');
        
        % Transform image
        F = fft2(I);
        F = fftshift(F);
        ftshow(F);
        
        % Pointwise multiplication with the filter        
        G = h.*F;
        
        % Inspect result (Fourier)
        ftshow(G);
        
        % Reverse transform to spatial
        G = abs(ifft2(fftshift(G)));
    end

    function ftshow(F)
       figure, imshow(log(abs(F)), []);
    end

        function [ filter ] = ideal(I, D0)
            [x y] = size(I);
            
            filter = zeros(x,y);
            
            for u=1:x
                for v=1:y
                    D = ((u-(x/2))^2 + (v-(y/2))^2)^(1/2); 
                    if D < D0
                        filter(u,v) = 1;
                    else
                        filter(u,v) = 0;
                    end
                end
            end
        end
        
        function [ filter ] = butterworth(I, D0, n)
            [x y] = size(I);
            
            filter = zeros(x,y);
            
            for u=1:x
                for v=1:y
                        D = ((u-(x/2))^2 + (v-(y/2))^2)^(1/2);
                        filter(u,v) = 1/(1 + (D/D0)^(2*n));
                end
            end
        end
    
        function [ filter ] = hfe(I, alpha, beta, D0) 
            [x y] = size(I);
            
            filter = zeros(x,y);
            
            for u=1:x
                for v=1:y
                    D = ((u-(x/2))^2 + (v-(y/2))^2)^(1/2);
                    if D > 0
                        filter(u,v) = alpha + beta/(1 + (D/D0)^2);
                    elseif D == 0
                        filter(u,v) = 1;
                    end
                end
            end
        end

    function exercise33(I)
   
        si = size(I);
        
        figure(1), imshow(I)
        
        ftI = fftshift(fft2(I));
        
        figure(2), imshow(log(abs(ifftshift(ftI)) + 1), []);        

%         design_filter = ones(si(1), si(2));
%         design_filter(180:200, 70:100) = zeros(21,31);
%         design_filter(60:80, 150:180) = zeros(21,31);

%         figure(3), imshow(design_filter)
        
         bwlf = butterworth_lowpass(si(1), si(2), 35, 2);

        nft3 = bwlf.*ftI;
         
%         nft3 = design_filter.*ftI;
        figure(4), imshow(bwlf)
%         figure(5), imshow(nft3, []);
        figure(6), imshow(log(abs(nft3) + 1), []);
        figure(7), imshow(ifft2(ifftshift(nft3)),[]);        
        
%         design_filter2 = ones(si(1), si(2));
%         design_filter2(1:50, 1:40) = zeros(50,40);
        
%         figure(8), imshow(design_filter2)

%         nft4 = design_filter2.*ftI;

%         figure(9), imshow(log(abs(ifftshift(nft4)) + 1), []);        
        
    end

    function run( ~ )
        %g1 = imread('../../../../images/lenna.tiff');
        %g1 = imread('../../../../images/noisy.tiff');
        %g1 = imread('../../../../images/berlinger.tiff');
%         g1 = imread('./images/square.tiff');
        g1 = imread('./images/unix.tiff');
        %imwrite(g1, '../report/images/unix.png', 'png');
        imwrite(g1, '../report/images/unix.png', 'png');
        imshow(g1, []);
        
        %Repair(g1);
        
        %FindCosts(1024);
        
        %MinFilterSize();
        
        name = 'unix';
        
        filter = 'butter';
        frequency = 'low';
        cut_off = 40;
        
        G1 = exercise31(g1, cut_off, frequency, filter, name);
        %G2 = FilterImage(g1, 45, 'high', 'ideal');
        imwrite(G1, gray, ['../report/images/' name '_' filter '_' frequency '_result_' num2str(cut_off) '.png'], 'png');
        %imwrite(G1, [gray], '../report/images/unix_butter_result_45.png', 'png');
        %imwrite(G2, [gray], '../report/images/unix_high_result_45.png', 'png');
        figure, imshow(G1, []);
        %figure, imshow(G2, []);

    end

run()

end