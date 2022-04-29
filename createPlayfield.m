%function that creates the final playfield,
%each individual section is created seperately such that it is easier to
%concatenate together in the final step
function playfield = createPlayfield(hand1,hand2) 
%determining the width and height of a card (all cards within the textures
%are the same size)
cardCols = size(hand1{1}.img, 2);
cardRows = size(hand1{1}.img, 1);

    %initialising the size of the visual playfields for hand 1 and 2
    if length(hand1) >= length(hand2)
        playfield1 = zeros(cardRows,cardCols*length(hand1),3);
        playfield2 = zeros(cardRows,cardCols*length(hand1),3);
    
    elseif length(hand1) < length(hand2)
        playfield1 = zeros(cardRows,cardCols*length(hand2));
        playfield2 = zeros(cardRows,cardCols*length(hand2));
    end

    %CREATING PLAYFIELD 1 and 2
    %stores the cards of hand 1 next to eachother in hand1Img
    hand1Img = createHandImg(hand1);
    %stores hand1Img in the centre of playfield
    playfield1 = storeMatrixInField(hand1Img, playfield1);

    %stores the cards of hand 2 next to eachother in hand2Img
    hand2Img = createHandImg(hand2);
    %stores hand2Img in the centre of playfield
    playfield2 = storeMatrixInField(hand2Img, playfield2);


    %quadtriples the size of the playfields
    playfield1 = imresize(playfield1,...
        [4*(size(playfield1,1)), 4*(size(playfield1,2))],"nearest");
    
    playfield2 = imresize(playfield2,...
        [4*(size(playfield2,1)), 4*(size(playfield2,2))],"nearest");

    
    %CREATING THE TEXT THAT SAYS "PLAYER CARDS" and "DEALER CARDS"
    %initialises the playercard and dealercard text bars
    textBarHand1 = zeros(9,size(playfield1,2),3);
    textBarHand2 = zeros(9,size(playfield1,2),3);

    %storing the names playerCards and dealerCards in hand1txt and hand2txt
    hand1text = inputname(1);
    hand2text = inputname(2);

    %imports the text "player cards" and "dealer cards"
    txtHand1 = imread("txt" + hand1text + ".png");
    txtHand2 = imread("txt" + hand2text + ".png");

    %adds txtHand1 to the centre of textBarHand1
    textBarHand1 = storeMatrixInField(txtHand1,textBarHand1);

    %adds txtHand2 to the centre of textBarHand2
    textBarHand2 = storeMatrixInField(txtHand2,textBarHand2);

    %concatenates the text as well as the playfields into one matrix called
    %playfield
    playfield = [textBarHand1;playfield1;textBarHand2;playfield2];
    
    %adds black line to the top of the playfield for aestetics
    rowOfZeros = zeros(4,size(playfield,2),3);
    playfield = [rowOfZeros;playfield];

end