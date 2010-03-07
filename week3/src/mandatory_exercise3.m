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
        ftshow(F, 3);

        imwrite(mat2gray(log(abs(F) + 1)), ['../report/images/' name '_' 'ft.png'], 'png')                
        
        % Pointwise multiplication with the filter        
        G = h.*F;
        
        imwrite(mat2gray(log(abs(G) + 1)), ['../report/images/' name '_' method '_' band '_ftfilter_' num2str(d0) '.png'], 'png')        
        
        % Inspect result (Fourier)
        ftshow(G, 4);
        
        % Reverse transform to spatial
        G = abs(ifft2(fftshift(G)));
    end

    function ftshow(F, i)
       figure(i), imshow(log(abs(F) + 1), []);
    end

    function psshow(F, i)
        figure(i), imshow(log(abs(fftshift(F)) + 1));
    end

        function [ filter ] = ideal(I, D0)
            [x y] = size(I);
            filter = zeros(size(I));
            
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

    function filterDemo()
        
        Size = zeros(256,256);
        
        h = butterworth(Size, 30, 1);
        
        imwrite(h, ['../report/images/bw_n' num2str(1) '.png'], 'png');           
        
        h = butterworth(Size, 30, 2);
        
        imwrite(h, ['../report/images/bw_n' num2str(2) '.png'], 'png');           
        
        h = butterworth(Size, 30, 4);
        
        imwrite(h, ['../report/images/bw_n' num2str(4) '.png'], 'png');                    
        
        h = butterworth(Size, 30, 8);
        
        imwrite(h, ['../report/images/bw_n' num2str(8) '.png'], 'png');           
        
        h = butterworth(Size, 30, 16);
        
        imwrite(h, ['../report/images/bw_n' num2str(16) '.png'], 'png');                   
    end
    
    function exercise33(I, name)
        
        ft = fftshift(fft2(I));
        
        %         figure(2), imshow(log(abs(ifftshift(ft)) + 1), []);
        
        imwrite(mat2gray(log(abs((ft)) + 1)), ['../report/images/' name '_powerspectrum.png'], 'png');        
        
%         noisy_design_filter = ones(size(I));
%         noisy_design_filter(180:200, 70:100) = zeros(21,31);
%         noisy_design_filter(60:80, 150:180) = zeros(21,31);
        
        berlinger_design_filter = ones(size(I));
        berlinger_design_filter(370:395, 10:70) = 0;
        berlinger_design_filter(370:395, 260:290) = 0;
        berlinger_design_filter (120:135, 220:260) = 0;
        berlinger_design_filter (115:135, 470:500) = 0;      


%         figure(2), imshow(design_filter, [])
%         imwrite(noisy_design_filter, ['../report/images/' name
%         '_designfilter.png'], 'png')

        imwrite(berlinger_design_filter, ['../report/images/' name '_designfilter.png'], 'png')

        dfbw = butterworth(I, 70, 5);
        
%         figure(3), imshow(dfbw, [])
        imwrite(dfbw, ['../report/images/' name '_df_butterworth.png'], 'png')
        
%         nrdfft = noisy_design_filter.*ft;
        nrdfft = berlinger_design_filter.*ft;
        nrbwft = dfbw.*ft;
        
        smooth_bw = butterworth(I, 50, 2);
        
        nrdfft_butter = smooth_bw.*nrdfft;
        imwrite(mat2gray(real(ifft2(ifftshift(nrdfft_butter)))), ['../report/images/' name '_nrft_buttersmooth.png'], 'png')
        
%         figure(4), imshow(real(ifft2(ifftshift(nrdfft))),[]);
        imwrite(mat2gray(real(ifft2(ifftshift(nrdfft)))), ['../report/images/' name '_nrdf.png'], 'png')
%         figure(5), imshow(real(ifft2(ifftshift(nrbwft))),[]);
        imwrite(mat2gray(real(ifft2(ifftshift(nrbwft)))), ['../report/images/' name '_nrbw.png'], 'png')
        
        nrmean = (nrdfft + nrbwft)/2;
        
%         figure(6), imshow(real(ifft2(ifftshift(nrmean))), []);
        imwrite(mat2gray(real(ifft2(ifftshift(nrbwft)))), ['../report/images/' name '_nrmean.png'], 'png')
        
        B = medfilt2(real(ifft2(ifftshift(nrdfft))), [5 5]);
        imwrite(mat2gray(B), ['../report/images/' name '_medf_55_nrdf.png'], 'png')                
        C = medfilt2(real(ifft2(ifftshift(nrbwft))), [5 5]);
        imwrite(mat2gray(C), ['../report/images/' name '_medf_55_nrbw.png'], 'png')                
        D = medfilt2(real(ifft2(ifftshift(nrmean))), [5 5]);
        imwrite(mat2gray(D), ['../report/images/' name '_medf_55_nrmean.png'], 'png')
        E = medfilt2(real(ifft2(ifftshift(nrdfft_butter))), [7 7]);
        imwrite(mat2gray(E), ['../report/images/' name '_medf_77_nrdf_bwsmooth.png'], 'png')        
        
%         figure(7), imshow(B, [])
%         figure(8), imshow(C, [])
%         figure(9), imshow(D, [])
        
        num_iter = 15;
        delta_t = 1/7;
        kappa = 30;
        option = 2;
        ad = anisodiff2D(real(ifft2(ifftshift(nrdfft))),num_iter,delta_t,kappa,option);
%         figure(10), subplot 121, imshow(real(ifft2(ifftshift(nrdfft))),[]), subplot 122, imshow(ad,[])
        
        imwrite(mat2gray(ad), ['../report/images/' name '_anisotropic_diff.png'], 'png')
        
        ae = anisodiff2D(B,num_iter,delta_t,kappa,option);
%         figure(11), imshow(ae, [])
        
        imwrite(mat2gray(ae), ['../report/images/' name '_anisotropic_diff_mean.png'], 'png')

        best = anisodiff2D(E,5,delta_t,15,option);
        imwrite(mat2gray(best), ['../report/images/' name '_nrdf_bwsmooth_medfilt_77_anisotropic_diff.png'], 'png')
        
    end

    function run( ~ )
%         g1 = imread('./images/noisy.tiff');
        g1 = imread('./images/berlinger.tiff');
%         g1 = imread('./images/square.tiff');
%         g1 = imread('./images/unix.tiff');
%         imwrite(g1, '../report/images/square.png', 'png');
%         imwrite(g1, '../report/images/unix.png', 'png');
%         imwrite(g1, '../report/images/noisy.png', 'png');
        imwrite(g1, '../report/images/berlinger.png', 'png');        
%         figure(1), imshow(g1, []);

        name = 'berlinger';

        exercise33(g1, name)

        %Repair(g1);
        
        %FindCosts(1024);
        
        %MinFilterSize();
        
%         name = 'unix';
        
%         filter = 'butter';
%         frequency = 'low';
%         cut_off = 50;
        
%         filterDemo()
        
%         G1 = exercise31(g1, cut_off, frequency, filter, name);
        %G2 = FilterImage(g1, 45, 'high', 'ideal');
%         imwrite(G1, gray, ['../report/images/' name '_' filter '_' frequency '_result_' num2str(cut_off) '.png'], 'png');
        %imwrite(G1, [gray], '../report/images/unix_butter_result_45.png', 'png');
        %imwrite(G2, [gray], '../report/images/unix_high_result_45.png', 'png');
%         figure(2), imshow(G1, []);
        %figure, imshow(G2, []);

    end

run()

end