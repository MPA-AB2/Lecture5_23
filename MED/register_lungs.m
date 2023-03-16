function [] = register_lungs(path_Data)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
mkdir([path_Data '\Temp'])

wt = myLoop(path_Data, ...
    'elastix\',... % path to Elastix
    {which('poc14.txt')});



for i = 1 :3
    MED_t3(wt, i);
end

delete([path_Data '\Temp'])
end