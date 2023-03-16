% MPA-AB2 - Lecture 5
clear,close,clc
%% call our algorithm for depth calculation
pathData = 'C:\Users\xnantl01\MPA-AB2\Lecture5_23\Data';
register_lungs(pathData);
%% evaluate results
[MSE, meanVar] = eval_lung(pathData);