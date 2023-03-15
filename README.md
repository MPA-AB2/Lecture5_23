# Lecture5 - IMAGE REGISTRATION METHODS (ELASTIX)

[**Benchmark Results**](https://moodle.vut.cz/pluginfile.php/408977/mod_resource/content/1/L5_BenchmarkRegistration.xlsx%20-%20List1.pdf)

## Preparation

1. Run Git bash.
2. Set username by: `$ git config --global user.name "name_of_your_GitHub_profile"`
3. Set email by: `$ git config --global user.email "email@example.com"`
4. Select some MAIN folder with write permision.
5. Clone the Lecture5_23 repository from GitHub by: $ git clone https://github.com/MPA-AB2/Lecture5_23.git
6. In the MAIN folder should be new folder Lecture5_23.
7. In the **Lecture5** folder create subfolder **NAME_OF_YOUR_TEAM**.
8. Copy folder ***parameter_files_stud** into **NAME_OF_YOUR_TEAM** subfolder.
9. Run Git bash in **Lecture5** folder (should be *main* branch active).
10. Create a new branch for your team by: `$ git checkout -b NAME_OF_YOUR_TEAM`
11. Check that  *NAME_OF_YOUR_TEAM* branch is active.
12. Continue to the task...

## Tasks to do

### Task 1 - Elementary script for image registration using Elastix
1. Download the zip file with Elastix software version 5.1.0 for Windows x64 from [here](https://github.com/SuperElastix/elastix/releases).
2. Extract all files from zip file into the created subfolder **elastix** in **NAME_OF_YOUR_TEAM** folder.
3. Download the data in a zip file from [here](https://www.vut.cz/www_base/vutdisk.php?i=311029afae). Extract the content of the zip folder into **Lecture5** folder. It contains three mat files (*dataX.mat*), each containing *fixed* (reference) and *moving* image. In the first task we will be working with *data1.mat* only.
4. Elastix can work with the input in the *.nii* files.
7. Create a script for registration:
   * load example images from *data1.mat*,
   * write images from *fixed* and *moving* variables into *.nii* file by niftiwrite function,
   * run image registration using Elastix by command line execution in Matlab,
   * read registered image from *nii* file by *niftiread* function.
9. Perform geometrical transformation of the image via Transformix using command line execution in Matlab.
10. Change the transformix command to save also the deformation field.
11. Perform rigid and affine registration of images from data1.mat and set the parametric files properly to get visually optimal results.
12. Save *.tiff* image with depicted results

### Task 2 - Using binary masks in Elastix
1. Create a copy of your registration script from Task 1.
2. Try to use it to register the images from *data2.mat* file.
3. Modify your script to use a binary mask for elimination zero pixels of background.
4. Perform registration of images from *data2.mat* and set the parametric files properly to get visually optimal results.
5. Save *.tiff* image with depicted results

### Task 3 - Design of registration approaches leading to correction of breathing movement - Challenge
1. Create a copy of your registration script from Task 2.
2. Use data from directory *Data* which contains patient .nii data of 2D lung CT images - fixed and moving image with available Ground truth Deformation field.
3. Design the registration approach which will correct a breathing movement in inhale and exhale phase (The pipeline can consist several registrations with different geometrical transformations and/or parameters, including pyramidal approach.).
4. Resave a deformation field into original directory with patient data as *deformationField_Est.nii*
5. Use the provided MATLAB function for the evaluation of the results. The function *eval_lung.m* called as:
`[MSE, meanVar] = eval_lung(path_Data)`,
has the following inputs and outputs:
  * MSE - mean square error = mean square value of difference between estimated and true deformation fields
  * meanVar - mean variance of difference values between estimated and true deformation fields.
6. **Push** your program implementations into GitHub repository **Lecture5_23** using the **branch of your team** (stage changed -> fill commit message -> sign off -> commit -> push -> select *NAME_OF_YOUR_TEAM* branch -> push -> manager-core -> web browser -> fill your credentials).
8. Submit *.tiff* image of the best-obtained result of your registration approach and fill in the corresponding results into a shared [Excel table](https://docs.google.com/spreadsheets/d/1kFcj3svxZ9dXdnNcJw329W-IJwhLGNss/edit#gid=1879335341). The evaluation of results from each team will be presented at the end of the lecture.
