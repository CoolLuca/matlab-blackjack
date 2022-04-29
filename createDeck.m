%Function to create the deck
function cards = createDeck()
    %arrays for possible suits, types and values of cards
    suit = ["HEARTS","CLUBS","DIAMONDS","SPADES"];
    type = ["ACE","2","3","4","5",...
        "6","7","8","9","10","JACK","QUEEN","KING"];
    value = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];

    %initialises the cards variable as a cell array
    cards = {};
    %itterates through the deck, creating each card one by one
    for i = 1:52
        %calculates an index value for the suit, type, and value.
        suitIndex = ceil(i/13);
        typeIndex = mod(i-1,13)+1;
        valueIndex = mod(i-1,13)+1;
        
        %stores the card as a structre array within the "i"th index of the 
        %cards array, where the structure has fields; suit, type, and value
        %each of the 52 cards is a unique structure.
        cards{i}.suit = suit(suitIndex);
        cards{i}.type = type(typeIndex);
        cards{i}.value = value(valueIndex);

        %creating the images for the cards from the textures folder
        %stores the card suit image in the cards{i}.img
        cardSuit(i) = string(cards{i}.suit + ".png");
        cards{i}.img = imread(cardSuit(i));

        %logic to determine whether to use the red or black card type
        if strcmp(cardSuit(i), "HEARTS.png") ||...
                strcmp(cardSuit(i), "DIAMONDS.png")
            cardType(i) = string("red" + cards{i}.type + ".png");
        
        elseif strcmp(cardSuit(i), "SPADES.png") ||...
                strcmp(cardSuit(i), "CLUBS.png")
            cardType(i) = string("black" + cards{i}.type + ".png");
        end
        
        %reads the texture for the given card type from the textures folder
        cardTypeTexture = imread(cardType(i));
        
        %loops through the rows, columns and depth of the current array
        %stored in the cards structure (currently just the suit), then if 
        %any given element of the current card type's texture is darker
        %than that of the suit's texture, that element is coppied from the
        %currentTypeTexture to the array within the cards structure.

        for r = 1:size(cards{i}.img,1) %rows of card{i}.img
            for c = 1:size(cards{i}.img,2) %cols of card{i}.img
                for z = 1:3 %z of card{i}.img
                    if cardTypeTexture(r,c,z) < cards{i}.img(r,c,z)
                        cards{i}.img(r,c,z) = cardTypeTexture(r,c,z);
                    end
                end
            end
        end
    end
end