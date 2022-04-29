%function that stores the cards of a hand next to eachother
function handImg = createHandImg(hand)
    
    %iterates through each card within the hand storing them next to
    %eachother within the matrix "handImg"
    for i = 1:length(hand)
        cardImg = hand{i}.img;
        %itterates through each row column and z coordinate
        for r = 1:size(cardImg,1)
            for c = 1:size(cardImg,2)
                %logic that stacks each card next to eachother
                fieldCol = size(cardImg,2)*(i-1)+c;
                for z = 1:3
                    handImg(r,fieldCol,z) = cardImg(r,c,z);
                end
            end
        end
    end
end

