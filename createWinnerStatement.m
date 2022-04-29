%function to determine the winner of the blackjack game
function [statement, winCount] =...
    createWinnerStatement(pTotal, dTotal, winCount)
    
    totalphrase =sprintf("Player has total: %d. Dealer has total: %d.",...
        pTotal, dTotal);
    
    %initialising flags
    pWin = false;
    dWin = false;

    %if the player and computer totals are equal
    if pTotal == dTotal
        %skips to the switch statement
        
    %if either is 21
    elseif pTotal == 21
        pWin = true;
    elseif dTotal == 21
        dWin = true;
    
    %if both players bust
    elseif pTotal > 21 && dTotal > 21
        if pTotal < dTotal
            pWin = true;

        elseif pTotal > dTotal 
            dWin = true;
        end
    
    %if one player busts
    elseif pTotal > 21
        dWin = true;
    elseif dTotal > 21
        pWin = true;
    
    %if neither busts
    elseif pTotal > dTotal
        pWin = true;
    elseif dTotal > pTotal
        dWin = true;
    end 
    
    %determining the winner phrase depending on if pWin or dWin is true
    %if the player wins, winCount increases by 1
    switch true
        case pWin
            winnerphrase = "Player Wins!";
            winCount = winCount + 1;
        case dWin
            winnerphrase = "Dealer Wins!";
        otherwise
            winnerphrase = "Player and Dealer Draw";
    end
   
    %creates the statement using the totalPhrase and the winnerPhrase
    statement = sprintf("%s \n%s\nWins: %d\n\nPlay Again?",...
        totalphrase, winnerphrase, winCount);

end