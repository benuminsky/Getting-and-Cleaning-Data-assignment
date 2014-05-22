##CodeBook for getting and cleaning assignment

## This code book describes how I relabeled the varibales for this data set and how I relabeled the data in the "activity"column

## Relabeling the name of the variables:

## The data is structured where you have the "subject" variable first,"activity" variable second, then the rest of the measurement variables (79) next. All 79 measurement variables were relabled so that the character string contained only lowercase letters, and only alphanumeric symbols. This relabeling is a standard convention for R. I chose not to add any further descriptions to the labels as I don't full understand what the labels mean and any further modification by me may add more confusion.

## Relabeling the data contained in the "activity" variable:

## Initially all of the data in the "activity" variable is some numeric value between 1 and 6. If you check the "activity_lables.txt" file, you  will see that there are specific character strings associated with each number. They are as follows

## 1: walking
## 2: walkingupstairs
## 3: walkingdownstairs
## 4: sitting
## 5: standing
## 6: laying

## I relabled all of the data so that instead of numbers, there were the descriptive character strings.
