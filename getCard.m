%Function to draw cards from the deck, and store them within a hand
%n = number of cards to be drawn
%hand = the player's or computer's hand
%shuffledDeck = shuffledDeck variable
function [hand, shuffledDeck] = getCard(n, hand, shuffledDeck)   
    for i = 1:n
        hand{end+1} = shuffledDeck{1};
        shuffledDeck{1} = {}; %removes the drawn card from the deck
    
        %iterates through the structures within the shuffledDeck, shifting 
        %them left to fill the empty space removing the player card
        for j = 1:length(shuffledDeck)-1
            shuffledDeck(j) = shuffledDeck(j+1);
        end
        
        %removes the final structure of the shuffled deck as it is a 
        %duplicate of the previous one
        shuffledDeck{end} = {};
    end
end