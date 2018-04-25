%{

****************************************
Assignment algorithm with thresholding
****************************************
Original premise:
Initial algorithm takes the cost matrix between row and col agents and
computes the pairings between rows and cols that result in minimal total
cost. Natural extension is to unequal number of agents. In this case, the
asymmetric matrix is augmented to symmetric by adding rows or columns of
zeros. This results in extra agents, that have worst pairing weights to be
paired against fictitious agents with zero weights - that is, not being
paired to anything.

Thresholded extension:
In this extension we may reject certain pairings if they are bad, thus
leaving some of the original ones unpaired. We want to reject a certain
pairing if
    1) The individual pairing cost is above threshold
    2) The individual pairing cost is within threshold, but some other
    possible pairings for either of the agents are much better.

The algorithm thus is the same as Munkres, but with preprocessing for
likely and unlikely cases.
    1) Set all matrix values above threshold to infinity (inf)
    2) Min-preprocess: for every row, find smallest pairing, and check if
    it is at least R times smaller than all other alternatives. If yes,
    set all other elements in associated rows and cols to infinity. If no,
    continue to the next row. Stop once all rows of a matrix have been
    looped through without reassignment
    3) Run thresholded version of Munkres, where certain links are simply
    forbidden, and it could return less than fully populated matrix if it
    does not work.
%}

function [assig, notCol] = assignmentAlgWrapperThresh(M, threshAbs, threshRel)
    sizeParam = size(M);
    nrow = sizeParam(1);
    ncol = sizeParam(2);
    
    % 1) Absolute thresholding
    for i = 1:nrow
        for j = 1:ncol
            if M(i,j) > threshAbs
                M(i,j) = inf;
            end
        end
    end
    
    % 2) Relative thresholding
    updatesMade = true;
    alreadyAssigned = zeros(1, nrow);
    while updatesMade
        updatesMade = false;
        
        for i = 1:nrow
            if ~alreadyAssigned(i)
                [minRow, minRowArg] = min(M(i,:));
                rowSort = sort(M(i,:));
                colSort = sort(M(:,minRowArg));
                min2Row = rowSort(2);
                min2Col = colSort(2);
                
                if (min2Row > threshRel * minRow) && (min2Col > threshRel * minRow)
                    
                    fprintf("thresholding (%d, %d) because %f smaller than (%f; %f) \n", i, minRowArg, minRow, min2Row, min2Col);
                    
                    alreadyAssigned(i) = 1;
                    M(i,:) = inf;
                    M(:,minRowArg(1)) = inf;
                    M(i,minRowArg(1)) = minRow;
                    
                    updatesMade = true;
                    break;
                end
            end
        end
    end
    
    % 3) Running the algorithm
    [assig, cost] = assignmentoptimal(M);
    notCol = setdiff(1:ncol, assig);
end
