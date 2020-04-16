% Gladys Roman
% CSE 516 LAB3 - Q-Learning
% Winter 2020

% reference: https://www.mathworks.com/matlabcentral/fileexchange/67989-q-learning-example
% I received tutor help on this make-up assignment from Taylor Pedretti
% note: if a comment is above a line of code, it's part of the grading rubric that was given on blackboard.


% Correct initialization of n*n Q-matrix
n = input('Enter size n of grid world: ');

Goal = input('Enter an end position between 1 and n: '); % let user input target

maze = -1*ones(1,(n*n)); %randomly generate path
for i = 1 :(length(maze)) %completely goes through maze and puts down a -10 at 20% of occurence
    if randi([1 10],1,1) > 8
        maze(i) = -10;
    end
end

maze(1, 1) = 1; % starting node

maze(Goal) = 10; % goal value

%display n*n matrix/maze in command window
for i=0:(n-1)
  for j=1:n
      world = maze(n * i + j);
      fprintf('%12.0f', world); % display format as whole integers
    end
    fprintf(1, '\n');
end

fprintf('Goal State is: %d', Goal);
%Create a reward matrix that is used as transtion table
reward = zeros(1, (n*n));

for i=1:(Goal-1)
  reward(end+1,:) = reshape(maze, 1, Goal);
end

for i = 1 : Goal
    for j = 1 : Goal
        if j ~= i-n  && j ~= i+n  && j ~= i-1 && j ~= i+1
            reward(i, j) = -Inf;
        end    
    end
end

for i=1 : n : Goal
    for j=1 : i + n
        if j == i+n-1 || j==i-1 || j == i-n-1 
            reward(i,j)=-Inf;
            reward(j,i)=-Inf;
        end
    end
end

q = randn(size(reward)); % Q-Learning math
gamma = 0.9;
alpha = 0.2;
maxItr = 50;

% Correct transition function to get the next state given the current state and the action
for i = 1 : maxItr
      
    cs = 1; % current state starting position 
    
    while(1) % Repeat until Goal state is reached
        
    n_actions = find(reward(cs,:) >= -2); % possible actions for the chosen state (current state)
    
    % Correct function or code block for choosing a random and valid action, or similar
    ns = n_actions(randi([1 length(n_actions)], 1, 1)); % choose an action at random and set it as the next state
            
            n_actions = find(reward(ns,:) >= -2); % find all the possible actions for the selected state
            
            % Implement episode iterations, calculate q value and update q matrix correctly
            max_q = 0; % find the maximum q-value i.e, next state with best action
            for j = 1 : length(n_actions)
                max_q = max(max_q, q(ns, n_actions(j)));
            end
            
            q(cs, ns) = reward(cs, ns) + gamma* max_q; % Update q-values as per Bellman's equation
            
            if(cs == Goal) % Check whether the episode has completed ; Goal has been reached
                break;
            end
            
            cs = ns; % Set current state as next state
    end
end

% Return the correct path of reaching the goal state given Q matrix 
start = 1;
move = 0;
path = start; 
while(move ~= Goal)
    [~,move] = max(q(start,:));   
    path = [path, move]; % Appending next action/move to the path
    start = move;
end

fprintf('\nFinal path: %s \n',num2str(path))
fprintf('Total steps: %d \n',length(path))
