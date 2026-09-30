function f = ObjFunAnt(C)

% rewriting the permutation so its the same as in the paper
% invPerm = zeros(1,length(C));
invPerm = zeros(1, length(C));
invPerm(C) = 1:length(C);
C = invPerm;

num_facilities = 11;

% frequency matrix showing amount of trips done from facility to facilty in 
% one day 
F = [0, 5, 2, 2, 1, 1, 4, 1, 2, 9, 1;
     5, 0, 2, 5, 1, 2, 7, 8, 2, 3, 8;
     2, 2, 0, 7, 4, 4, 9, 4, 5, 6, 5;
     2, 5, 7, 0, 8, 7, 8, 1, 8, 5, 1;
     1, 1, 4, 8, 0, 3, 4, 1, 3, 3, 6;
     1, 2, 4, 7, 3, 0, 5, 8, 4, 7, 5;
     4, 7, 9, 8, 4, 5, 0, 7, 6, 3, 2;
     1, 8, 4, 1, 1, 8, 7, 0, 9, 4, 8;
     2, 2, 5, 8, 3, 4, 6, 9, 0, 5, 3;
     9, 3, 6, 5, 3, 7, 3, 4, 5, 0, 5;
     1, 8, 5, 1, 6, 5, 2, 8, 3, 5, 0];

% Distance matrix showing distance between facilities
D = [0, 15, 25, 33, 40, 42, 47, 55, 35, 30, 20;
     15, 0, 10, 18, 25, 27, 32, 42, 50, 45, 35;
     25, 10, 0, 8, 15, 17, 22, 32, 52, 55, 45;
     33, 18, 8, 0, 7, 9, 14, 24, 44, 49, 53;
     40, 25, 15, 7, 0, 2, 7, 17, 37, 42, 52;
     42, 27, 17, 9, 2, 0, 5, 15, 35, 40, 50;
     47, 32, 22, 14, 7, 5, 0, 10, 30, 35, 40;
     55, 42, 32, 24, 17, 15, 10, 0, 20, 25, 35;
     35, 50, 52, 44, 37, 35, 30, 20, 0, 5, 15;
     30, 45, 55, 49, 42, 40, 35, 25, 5, 0, 10;
     20, 35, 45, 53, 52, 50, 40, 35, 15, 10, 0];

f = 0;
for i = 1:num_facilities
    for j = i:num_facilities
        f = f + F(i, j) * D(C(i), C(j));
    end
end

% f = sum;