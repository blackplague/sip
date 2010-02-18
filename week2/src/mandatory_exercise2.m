function [ output_args ] = mandatory_exercise2( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    function exercise11()
        
        image1 = imread('./images/square.tiff');
        
        image2 = imread('./images/noisy2.tiff');
        
%         ft_image1 = fft2(image1);
        
%         tft_image1 = log(abs(fftshift(ft_image1)) + 1);
        
%         imwrite(tft_image1, '../report/images/ft_image1.png', 'png');
        
        figure(1), imshow(image2)

        ft_image2 = fft2(image2);

%         figure(2), imshow(ft_image2)
        
        tft_image2 = log(abs(fftshift(ft_image2)) + 1);

        figure(3), imshow(tft_image2, [])
        
%         imwrite(tft_image2, '../report/images/ft_image2.png', 'png');
        
%         figure,
%         hold on
%         subplot(221)
%         figure, imshow(image1)
%         subplot(222)
%         figure, imshow(log(abs(fftshift(ft_image1)) + 1),[])
%         subplot(223)
%         figure, imshow(image2)
%         subplot(224)
%         figure, imshow(log(abs(fftshift(ft_image2)) + 1),[])
%         hold off
        
%         saveas(fig1, './images/figure1.png')

%         size(image1)
        
%         ft_pad_image1 = fft2(image1, 1024,1024);
        
%         tft_pad_image1 = log(abs(fftshift(ft_pad_image1)) + 1);
        
%         imwrite(tft_pad_image1, '../report/images/ft_pad_image1.png', 'png');
        
%         ft_pad_image2 = fft2(image2, 1024, 1024);
        
%         tft_pad_image2 = log(abs(fftshift(ft_pad_image2)) + 1);
        
%         imwrite(tft_pad_image2, '../report/images/ft_pad_image2.png', 'png');
        
%         figure,
%         hold on
%         subplot(221)
%         figure, imshow(image1)
%         subplot(222)
%         figure, imshow(log(abs(fftshift(ft_pad_image1)) + 1),[])
%         subplot(223)
%         figure, imshow(image2)
%         subplot(224)
%         figure, imshow(log(abs(fftshift(ft_pad_image2)) + 1),[])
%         hold off

    
    
    end

    function q2_3
	  A = 1;
          B = 1;
          x = -3:1:3; % [-3 -2 -1 0 1 2 3];
          f = [0 0 A A 0 0 0];
          g = [0 0 0 B 0 0 0];
          [fx fy] = stairs(x, f);
          [gx gy] = stairs(x, g)
          figure(1);
          plot(fx, fy, 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          axis([-3, 3, 0, 1.5]);
          figure(2);
          plot(gx, gy, 'LineWidth', 2, 'Color', 'r');
          axis([-3, 3, 0, 1.5]);
          
          figure(3);
          plot([-3,-2, -1, 0, 1, 2,3,4], [0,0, 0, 1, 1, 0,0,0], ...
              'LineWidth', 2, 'Color', 'g')
          axis([-3, 3, 0, 1.5]);
          
  
    end

    function q2_4
        A = 1;
        B = 1;
        x = -3:1:3; % [-3 -2 -1 0 1 2 3];
%         f = [0 0 A A 0 0 0];
%         g = [0 0 0 B 0 0 0];
%           [fx fy] = stairs(x, f);
%           [gx gy] = stairs(x, g)
        h = [1/3, 1/3, 1/3];
        
        h_1 = Conv(h, h);
        h_2 = Conv(h, h_1);
        h_3 = Conv(h, h_2);


        
          figure(1);
          %plot(fx, fy, 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          %axis([-3, 3, 0, 1.5]);
          hold on
          plot([-1 -1], [0, 1/3], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([0 0], [0, 1/3], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([1 1], [0, 1/3], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          axis([-1.5, 1.5, 0, 0.5]);
          hold off
          figure(2);
          hold on
          plot([-2 -2], [0, 1/9], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-1 -1], [0, 2/9], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([0 0], [0, 3/9], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([1 1], [0, 2/9], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([2 2], [0, 1/9], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          axis([-2.5, 2.5, 0, 0.5]);
          hold off

          figure(3);
          hold on
          plot([-3 -3], [0, 1/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-2 -2], [0, 3/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-1 -1], [0, 6/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([0 0], [0, 7/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([1 1], [0, 6/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([2 2], [0, 3/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          plot([3 3], [0, 1/27], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          axis([-3.5, 3.5, 0, 0.5]);
          hold off

          figure(4);
          hold on
          plot([-4 -4], [0, 1/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-3 -3], [0, 4/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-2 -2], [0, 10/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([-1 -1], [0, 16/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([0 0], [0, 19/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([1 1], [0, 16/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');
          plot([2 2], [0, 10/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          plot([3 3], [0, 4/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          plot([4 4], [0, 1/81], '-o', 'LineWidth', 2, 'MarkerEdgeColor', 'b');          
          axis([-4.5, 4.5, 0, 0.5]);
          hold off

          
          
          %           plot(gx, gy, 'LineWidth', 2, 'Color', 'r');
%           axis([-3, 3, 0, 1.5]);
          
%           figure(3);
%           plot([-3,-2, -1, 0, 1, 2,3,4], [0,0, 0, 1, 1, 0,0,0], ...
%               'LineWidth', 2, 'Color', 'g')
%           axis([-3, 3, 0, 1.5]);
          
  
    end
%      endimshow (RGB);
% hold on
%   plot ([tur(2), tll(2), tll(2), tur(2), tur(2)], ...
%         [tur(1), tur(1), tll(1), tll(1), tur(1)], ...
%         'k-','linewidth', 2,'Color', 'green');
% %   text (tll(2), tur(1)-15, 'Training');
% 
% hold off

 



    function run( ~ )
       
        exercise11()
%         q2_4()
    end

    run()

end

