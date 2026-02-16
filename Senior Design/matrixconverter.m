function final = matrixconverter(input)
for i=1:length(input)
    for j=1:length(input)
        if input(i,j)=="N" || input(i,j)=="S" || input(i,j)=="E" || input(i,j)=="W"
            input(i,j)=1;
        end
    end
end
final=str2double(input);
end

