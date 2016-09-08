### Collection

Raw data are obtained from UCI Machine Learning repository. In particular we used
the *Human Activity Recognition Using Smartphones Dataset Version 1.0*

Activity Recognition (AR) aims to recognize the actions and goals of one or more agents
from a series of observations on the agents' actions and the environmental conditions
[[3](#activity-recognition)]. The collectors used a sensor based approach employing
smartphones as sensing tools. Smartphones are an effective solution for AR, because
they come with embedded built-in sensors such as microphones, dual cameras, accelerometers,
gyroscopes, etc.


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at 
a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding 
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features 
was obtained by calculating variables from the time and frequency domain.  

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment

### Signals

The 3-axial time domain [[5](#time-domain)] signals from accelerometer and gyroscope
were captured at a constant rate of 50 Hz [[6](#hertz)]. Then they were filtered
to remove noise.
Similarly, the acceleration signal was then separated into body and gravity
acceleration signals using another filter.
Subsequently, the body linear acceleration and angular velocity were derived in time
to obtain Jerk signals [[7](#jerk)]. Also the magnitude [[8](#magnitude)] of these
three-dimensional signals were calculated using the Euclidean norm [[9](#euclidean-norm)]. 
Finally a Fast Fourier Transform (FFT) [[10](#fft)] was applied to some of these
time domain signals to obtain frequency domain [[11](#freq-domain)] signals.

The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window at 50 Hz).
From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded
within [-1,1].

Data transformation
-------------------

### Merge training and test sets

Test and training data (X_train.txt, X_test.txt), subjects (subject_train.txt,
subject_test.txt) and activity labels (y_train.txt, y_test.txt) are merged to obtain
a single data set "completeDT". Variables are labelled with the names assigned by original
file (features.txt).

### Extract mean and standard deviation variables

From the merged data set extractDT is made with the values of mean (variables that contain "mean") and standard
deviation (variables that contain "std").

### Use descriptive activity names

Values in Activity column of extracted data from part 2 is replaced with corresponding labels as described in "activity labels.txt".
For this the numerics in Activity column are transformed to Character vectors, then a conditional for loop is used.

### Appropriately label the data set with descriptive variable names

Labels from the original collectors were changed to obtain to obtain more descriptive labels instead of difficult abbreviations. 
For this the Readme.txt file came in handy that was given in the original data set.

### Creating a tidy data set

From the extractDT data set a final tidy data set is created with the average of each variable for each activity and each subject.

The tidy data set contains 180 rows with 88 variables

The tidy data set contains 10299 observations with 81 variables divided in:

*  an activity label: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*  an identifier of the subject taking part in experiment: 1 to 30
*  a 86-feature vector with time and frequency domain signal variables

The data set is written to the file Tidy Data Set.txt.
