function savedata(filename, data, headers)

separator = '    ';
fileID = fopen(filename,'w');

nVariables = size(data, 2);
nDatapoints = size(data, 1);
nHeaders = size(headers, 2);


for j = 1:nHeaders   
        fprintf(fileID,headers{j});
        
        if j < nHeaders
            fprintf(fileID,separator);
        end
end

if ~isempty(headers) && ~isempty(data)
    fprintf(fileID,'\n');
end



for i = 1:nDatapoints
    for j = 1:nVariables
        
        fprintf(fileID,num2str(data(i,j)));
        
        if j < nVariables
            fprintf(fileID,separator);
        elseif i < nDatapoints
            fprintf(fileID,'\n');
        end
    end
end

fclose(fileID);