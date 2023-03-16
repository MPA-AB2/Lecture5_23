function  MED_t3(wholeThing,poradi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

delete("V:\4_mag\Lecture5_23\MED\Data\Temp\*");
mkdir('V:\AB2\MAIN\Lecture5_23\MED\Data\Images')
cesta = char(wholeThing{poradi,1})
    


system(cesta)
system(char(wholeThing{1,3}))
movefile(char(wholeThing{1,4}),char(wholeThing{poradi,2}))

end

