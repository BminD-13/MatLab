clear
close all
clc
%% Data
P04

%% function call
[a,b,c] = knapsackDynamic(knapsackCapacity, item);

%% knapsack dynamic algorithm
function [valueMax, sumTable, itemsPicked] = knapsackDynamic(knapsackCapacity, item)

%% declaration
itemCount = length(item.Capacity);
itemsPicked = [];
sumTable = zeros(length(item.Capacity) + 1,knapsackCapacity);

%% filling the knapsack table with the information 

% iterate rows (items) of the table
    for iRowAbove = 1:itemCount
        iRowActual = iRowAbove +1;

    % iterate columns (knapsackCapacity) of the table
        for iColumnActual = 1:knapsackCapacity+1        

        % knapsack Capacity smaller than item capacity
            if iColumnActual <= item.Capacity(iRowAbove)            
                valueAbove = sumTable(iRowAbove, iColumnActual);    
                sumTable(iRowActual, iColumnActual) = valueAbove;

        % knapsack Capacity bigger than item capacity
            else            
                valueItem = item.Value(iRowAbove);
                columnCapShift = iColumnActual-item.Capacity(iRowAbove);
                valueDiagonal = sumTable(iRowAbove, columnCapShift);    
                sumTable(iRowActual, iColumnActual) = valueItem + valueDiagonal;    
            end
        end
    end

    valueMax = sumTable(end, end);


%% choosing most suitable items by evaluating the table
jColumnActual = knapsackCapacity + 1;
items = linspace(itemCount+1,2,itemCount);
for jRowActual = items
    jRowAbove = jRowActual-1;

    if sumTable(jRowActual, jColumnActual) > sumTable(jRowAbove, jColumnActual)
        itemsPicked(end+1) = jRowAbove;
        jColumnActual = jColumnActual - item.Capacity(jRowActual-1);
    end
end

end