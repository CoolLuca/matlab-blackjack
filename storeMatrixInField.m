%used to add a matrix to the centre of another matrix
function field = storeMatrixInField(matrix, field)
    for r = 1:size(matrix,1)
        for c = 1:size(matrix,2)
            %logic to stack the matrix in the centre of the field
            fieldCol = size(field,2)/2 ...
                    - size(matrix, 2)/2 + c;
            %rounds fieldCol incase it has a decimal
            fieldCol = round(fieldCol);
            for z = 1:3
                field(r,fieldCol,z) = matrix(r,c,z);
            end
        end
    end
end