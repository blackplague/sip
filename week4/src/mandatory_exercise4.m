function [ output_args ] = mandatory_exercise4( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    % Laplacian = coarse to finer, consider what information is available
    % when.

    % Creates a Gaussian pyramid from image I using sigma with
    % log(size(I, 1)) + 1 levels. And returns it in a cell array.
    function GP = GaussianPyramid(I, sigma, maxLevel)
        
        GP = cell(1, maxLevel);
        
        GP{1,1} = double(I);
        
        for i=2:maxLevel
            I = GP{1,i-1};
            I = Gaussian(I, sigma);
            I = Downscale(I);
            GP{1,i} = double(I);
        end
    end

    % Creates a Laplacian pyramid from image I, using the the gaussian
    % pyramid recieved in GCA. Return a cell array containing the laplacian
    % pyramid.
    function LP = LaplacianPyramid(I, sigma, maxLevel)
        
        GP = GaussianPyramid(I, sigma, maxLevel);
        
        LP = cell(1, maxLevel);
        
        for i=1:maxLevel - 1
            LP{1,i} = GP{1,i} - Upscale(GP{1,i+1});
        end
        
        LP{1,maxLevel} = GP{1,maxLevel};
    end

    % Performs reconstruction of Gaussian pyramid given a Laplacian
    % pyramid. Using GP(P) = LP(P).
    function RGP = ReconstructGaussianPyramid(LP)
       
        RGP = cell(1, length(LP));
        
        RGP{1,length(LP)} = LP{1,length(LP)};
        
        for p=length(LP):-1:2
            RGP{1,p-1} = LP{1,p-1} + Upscale(RGP{1,p});
        end
        
    end

    % Performs gaussian smoothing in the Fourier domain, recieves an
    % already Fourier transformed image and multiplies it with the built-in
    % gaussian matlab filter.
    function G = Gaussian(I, sigma)
        F = fft2(I);
        
        h = fspecial('gaussian', size(I), sigma);
        h = fft2(h);
        
        G = abs(fftshift(ifft2(h.*F)));
    end

    % Performs upscaling of image I in the Fourier domain, by creating an
    % image that is size(I)*2, then filling in the original fft2(I) in the
    % middle.
    function G = Upscale(I)
        F = fftshift(fft2(I));
        offsetM = size(I, 1)/2;
        offsetN = size(I, 2)/2;
        
        G = zeros(size(I)*2);
        G(offsetM+1:size(G,1)-offsetM,offsetN+1:size(G,2)-offsetN) = F(:,:);
        
        G = abs(ifft2(G));
    end

    % Performs downscaling in the Fourier domain by cropping out the middle
    % 1/4th of the image. This corresponds to remove half of the highest
    % frequencies sampling points.
    function G = Downscale(I)
        F = fftshift(fft2(I));
        offsetM = size(I, 1)/4;
        offsetN = size(I, 2)/4;
        
        G = F(offsetM+1:size(F,1)-offsetM,offsetN+1:size(F,2)-offsetN);
        G = abs(ifft2(G));
    end
    

    function run( ~ )

        I = imread('../../images/lenna.tiff');
        
        sigma = 4;        

        maxLevel = 8;
        
        GP = GaussianPyramid(I, sigma, maxLevel);
        
%         for i=1:length(GP)
%             figure(i), imshow(GP{1,i}, [])
%         end
    
        LP = LaplacianPyramid(I, sigma, maxLevel);
        
%         for i=1:length(LP)
%             figure(i), imshow(LP{1,i}, [])
%         end
        
        offsetFig = length(LP);
        R = ReconstructGaussianPyramid(LP);
        
%         for i = 1:length(R)
%             figure(offsetFig + i), imshow(R{1,i}, [])
%         end
%         
        for i = 1:length(R)
            figure(maxLevel*2+i), imshow(R{1,1} - GP{1,1}, [])
        end
%         figure(maxLevel+1), imshow(Gaussian(I, sigma), [])
        
    end

run()

end