function [x_scale, y_scale, x_0index, y_0index] = find_scale(indices, values, mode)

switch mode
    case 'axes' %indices = [x-axis point x-index, x-axis point y-index, y-axis point x-index, y-axis point y-index]
                %values = [x-axis point x-value, y-axis point y-value]
        
        x_index1 = indices(1);
        y_index1 = indices(2);
        
        x_index2 = indices(3);
        y_index2 = indices(4);
        
        x_value1 = values(1);
        y_value1 = 0;
        
        y_value2 = values(2);
        x_value2 = 0;

    case 'points' %indices = [point 1 x-index, point 1 y-index, point 2 x-index, point 2 y-index]
                  %values = [point 1 x-value, point 1 y-value, point 2 x-value, point 2 y-value]
        
        x_index1 = indices(1);
        y_index1 = indices(2);
        
        x_value1 = values(1);
        y_value1 = values(2);
        
        x_index2 = indices(3);
        y_index2 = indices(4);
        
        x_value2 = values(3);
        y_value2 = values(4);
        
    case 'axis points' %indices = [x-axis point 1 x-index, x-axis point 2 x-index, y-axis point 1 x-index, y-axis point 2 x-index]
                       %values = [x-axis point 1 x-value, x-axis point 2 x-value, y-axis point 1 y-value, y-axis point 2 y-value]
        
        x_index1 = indices(1);
        x_index2 = indices(2);
        
        y_index1 = indices(3);
        y_index2 = indices(4);
        
        x_value1 = values(1);
        x_value2 = values(2);
        
        y_value1 = values(3);
        y_value2 = values(4);               
                
end


%Calculating scaling factors for x and y
x_scale = (x_value1 - x_value2) / (x_index1 - x_index2);
y_scale = (y_value1 - y_value2) / (y_index2 - y_index1);
%Note the difference in sign; this is due to matrix i-indices running from
%up to down and graph y-coordinates from down to up

x_0index = x_index1 - (x_value1 / x_scale); %Index of x-value zero, doesn't need to be integer
y_0index = y_index1 + (y_value1 / y_scale); %Index of y-value zero, doesn't need to be integer
%Note again the difference in sign