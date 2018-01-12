#  Unscented Kalman Filter based Orientation tracking for Panorama Stitching

## Problem Statement
Given data from an IMU (accelerometer and gyroscope), estimate the 3D orientation and use this information to stith a panorama.

## Usage Guide:
1.  Run `Wrapper.m` for running Complementary Filter, Kalman Filter and Unscented Kalman Filter.
2. Change the flags in `Wrapper.m` as needed.
3. By default, the code runs all the filters, shows the panorama stitching and saves the panorama in the current directory.
4. By default, image blending is off as it is very slow, use `Wt` to turn it on.
5. When you run the code, dialog boxees will open for you to load the necessary files. General order is IMUData, ViconData and then CameraData (as the flags are set).
6. `Rotplot` is disabled by default, enable it using the `RotboxFlag` in `Wrapper.m`

## Report:
You can find the report [here](Report/ESE650Project2.pdf).

## References:
### For UKF:
1. Kraft, Edgar. "A quaternion-based unscented Kalman filter for orientation tracking." Proceedings of the Sixth International Conference of Information Fusion. Vol. 1. 2003.
2. S.  J.  Julier  and  J.  K.  Uhlmann, A  new  extension  of the Kalman filter to nonlinear systems , in International Symposium  on  Aerospace/Defense  Sensing,  Simulation and Controls, Orlando, USA, 1997
### For Panorama Stitching:
3. http://www.csie.ntu.edu.tw/~cyy/courses/vfx/05spring/lectures/handouts/lec06_stitching_4up.pdf
4. http://cs.gmu.edu/~kosecka/cs482/lect-panoramas.pdf
Complementary Filter:
5. http://www.pieter-jan.com/node/11
### Kalman Filter:
6. MEAM 620 slides at https://alliance.seas.upenn.edu/~meam620/wiki/index.php?n=Main.Schedule2015?action=download&upname=2015_extendedKalmanFilter.pdf

