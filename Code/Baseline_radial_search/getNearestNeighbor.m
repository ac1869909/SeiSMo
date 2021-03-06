%% This function finds nearest neighbour of a query from a time series
%% Uses MASS_V2 or UCR_DTW algorithm to find the nearest neighbor

function [nearestNeighborIndex, nearestNeighborDistance] = getNearestNeighbor(timeSeries, queryPosition, queryLength, useMASS)

    % Param r is used in UCR_DTW. Currently it's set as 10% query length
    r = round(queryLength / 10);
    
    % Extract the exact query
    query = timeSeries(queryPosition : queryPosition + queryLength - 1);
    
    % Replace the query by Gaussian random number
    timeSeries(queryPosition : queryPosition + queryLength - 1) = randn(1, queryLength);
    
    if useMASS == 1
        % Find the index of nearest neighbor using MASS
        distance = MASS_V2(timeSeries, query);
    else
        % Find the index of nearest neighbor using UCR_DTW
        distance = dtwUCR(timeSeries, query, r);
    end
    [nearestNeighborDistance, nearestNeighborIndex] = min(distance(2 : end));
end
