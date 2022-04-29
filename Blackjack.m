clc
clear
close all

addpath("textures\")

%use createDeck function to create a cell array of 52 structures
%representing the cards
deck = createDeck;

%initialise win counter
winCount = 0;

%initialises the play again loop
while true

    %creates a randomiser
    rng('shuffle')
    randomiser = randperm(52);
    
    %shuffles the deck using the randomiser
    shuffledDeck = cell(1,52); 
    for i = 1:52
        shuffledDeck{i} = deck{randomiser(i)};
    end
    
    %initialises playerCards and dealerCards as a cell arrays
    playerCards = {};
    dealerCards = {};
    
    %gives the player and dealer two cards each, removing from the deck
    [playerCards, shuffledDeck] = getCard(2, playerCards, shuffledDeck);
    [dealerCards, shuffledDeck] = getCard(2, dealerCards, shuffledDeck);
    
    %saves the image of the first card in the dealers hand
    cardFace = dealerCards{1}.img;
    %flips over the card
    cardBack = imread("cardBack.png");
    dealerCards{1}.img = cardBack;
    
    %initialses flags
    [playerCards] = aceTransform(playerCards);
    [dealerCards] = aceTransform(dealerCards);  
    bust = false;
    playerStand = false;
    dealerStand = false;
    
    %Initialising the question
    quest = "Will you hit or stand?";
    
        
    %CREATING and DISPLAYING the PLAYFIELD
    %creates the playfield with dealerCards above playerCards
    playfield = createPlayfield(dealerCards, playerCards);

    %displays the playfield. 'border', 'tight' removes the grey border
    %around the image 'initialmagnification' zooms the playfield 'MenuBar'
    %removes the menue bar from the top
    set(gcf,'MenuBar','none');
    imshow(playfield,'Border','tight','InitialMagnification',550);
    
    
    %game loop
    while ~bust && (~playerStand || ~dealerStand)
        %player turn
        if playerStand == false     
            %gets the player action form a dialouge box
            action = questdlg(quest,"Hit or Stand?","Hit","Stand","Hit");

    %         %for testing
    %         action = input("Will you hit or stand: ",'s');
            
            if strcmp(action, 'Hit')
                [playerCards, shuffledDeck] ...
                   = getCard(1, playerCards, shuffledDeck);
    
            elseif strcmp(action, 'Stand')
                playerStand = true;
            end
            
        end
        
        %checking if the player busts, and holds an ace with value 11
        [playerCards] = aceTransform(playerCards);
    
    
        %Updating and displaying the playfield
        playfield = createPlayfield(dealerCards, playerCards);
        imshow(playfield,'Border','tight','InitialMagnification',550);
    
        %checking if player bust
        bust = checkBust(playerCards);
        if bust == true
            break
        end
    
        %DEALER TURN
        %pause for better user experience
        pause(0.5)
        if calcTotal(dealerCards) < 17
            [dealerCards, shuffledDeck] =...
                getCard(1,dealerCards,shuffledDeck); 
        else 
            dealerStand = true;
        end
    
        %checking if the dealer busts, and holds an ace with value 11
        [dealerCards] = aceTransform(dealerCards);
        
        %updating and displaying the playfield after dealer turn
        playfield = createPlayfield(dealerCards, playerCards);
        imshow(playfield,'Border','tight','InitialMagnification',550);
    
        %not checking if the dealer busts as one card is face down during 
        %the game loop. Whether the dealer is bust or not is revealed after 
        %the player either busts, or stands.

        %NOTE: the player also has to stand when they reach 21, this is not
        %done for them automaticaly by the program them and emulates real 
        %world blackjack
    end
    
    %unturns the first card of the dealer
    dealerCards{1}.img = cardFace;
    
    pause(0.25)
    %updates the playfield showing the player and dealer cards
    playfield = createPlayfield(dealerCards,playerCards);
    imshow(playfield,'Border','tight','InitialMagnification',550);
    
    %calculating the player and dealer total to determine win conditions
    playerTotal = calcTotal(playerCards);
    dealerTotal = calcTotal(dealerCards);
    
    %gets the winner and respective phrase from the dealer and player total
    [statement, winCount] = createWinnerStatement(...
        playerTotal,dealerTotal,winCount);

    %dialouge box asking to play again
    playAgain=questdlg(statement,"Win Screen","Yes","No","Yes");
    
    %determines wheather or not to play again
    if ~strcmp(playAgain, "Yes")
        break
    end
end
close

%Black Jack Specific FUNCTIONS
%calculate total
function total = calcTotal(hand)
    %initialises the total as 0
    total = 0;
    %adds all the values of the hand together
    for i = 1:length(hand)
        total = total + hand{i}.value;
    end
end


%function to check if a player busts
function bust = checkBust(hand)
    total = calcTotal(hand);
    if total > 21
        bust = true;
    else 
        bust = false;
    end
end


%function to transform an ace from value 11 to value 1 if a player busts
function [hand] = aceTransform(hand)
    %if the player busts, the function itterates through the hand, 
    %changing the first ace with value 11 to value 1, then, breaks the loop
    bust = checkBust(hand);
    if bust == true
        for i = 1:length(hand)
            if hand{i}.value == 11
                hand{i}.value = 1;
                %checking if the hand has more than one ace, and is still 
                %bust after one ace is tranformed
                bust = checkBust(hand);
                if bust == false
                    break
                end
            end
        end
    end
end
