clear all
clc

numOfFaci = 11;
numOfAnts = 15;
numOfGens = 100;

tao = zeros(numOfFaci, numOfFaci);
ObjFun = zeros(numOfAnts, 1);
ants = zeros(numOfAnts, numOfFaci); % each row represents an ant with a permutation in it's row
ObjValRec = zeros(1,numOfGens); % record best fitness values
Q_con = 2000; % constants that affects the pheromone update
rho = 0.05; % evaporation factor

% initialize tao values, only happens once
for i = 1:numOfFaci
    for j = 1:numOfFaci
        if (i ~= 1) && (i~=10)
            tao(i,j) = 0.01;
        end        
    end
    if i ~= 1
        tao(i,8) = 0;
    end
    if i ~= 10
        tao(i,11) = 0;
    end
end

for g = 1:numOfGens
    % generational loop starts here

    % making sure ant picks facility 8 at location 1 and facility 11 at
    % location 10 and doesnt pick it before or after
    tao(1,8) = 1;
    tao(10,11) = 1;
    
    % create Probability matrix
    P = zeros(numOfFaci, numOfFaci);
    
    for i = 1:numOfFaci
        summe = sum(tao(i,:));
        for j = 1:numOfFaci
            P(i,j) = tao(i,j) / summe;
        end
    end
    
    % create ants
    for a = 1:numOfAnts
        availableLocations = 1:numOfFaci; % Initialize all locations as available
        for i = 1:numOfFaci
            fprintf("Ant is picking location number %d\n", i);
            % Compute cumulative probabilities for remaining locations
            cum_prob = cumsum(P(i, availableLocations)) / sum(P(i, availableLocations));
            
            % Pick a location based on probability
            r = rand();
            idx = find(r <= cum_prob, 1);
            
            % Assign the picked location
            ants(a, i) = availableLocations(idx);
            
            % Remove the chosen location from availableLocations
            availableLocations(idx) = [];
        end
    end
    
    %calculate Objective function values
    for i = 1:numOfAnts
        ObjFun(i,:) = ObjFunAnt(ants(i,:));
    end
    
    % sorting ants according to ObjFunctionValue
    temp = [ants, ObjFun];
    temp = sortrows(temp, numOfFaci + 1);
    ants = temp(:,1:numOfFaci);
    ObjFun = temp(:,numOfFaci + 1);
    
    % update tao values due to evaporation
    for i = 1:numOfFaci
        for j = 1:numOfFaci
            tao(i,j) = (1-rho)*tao(i,j);
        end
    end
    
    % Update winner ant
    for i = 1:numOfFaci
        tao(i,ants(1,i)) = tao(i,ants(1,i)) + (Q_con / ObjFun(1,:));
    end

    fprintf('Finished Generation number: %d\n', g);
    ObjValRec(g) = ObjFun(1);
end

plot(ObjValRec);