Here is a Persistent Homology function for Computer Vision in MatLab.

The Inputs of the function are:

Image: The image that you would like to record the persistent homologies of

Steps: How many steps you would like to create, the function outputs the Betti Numbers of each step

Step Size: how big the gap between steps are

This module is intented to calculate the H_0 and H_1 Betti numbers of a 2D image,
so as to record trends in homologies between objects.

Each SIFT keypoint counts as a 0-simplex, and when two keypoints have intersecting radii, a 1 simplex is built between them.
This continues for 2-simplex's for every triangle created by three adjacent keypoints.
