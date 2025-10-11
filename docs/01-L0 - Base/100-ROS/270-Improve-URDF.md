# Improve the URDF

## Inertial parameters of triangle meshes

### Overview

An accurate simulation requires physically plausible inertial parameters: the mass, center of mass location, and the moment of inertia matrix of all links. This tutorial will guide you through the process of obtaining and setting these parameters if you have 3D models of the links.

Assuming homogeneous bodies (uniform mass density), it is shown how to obtain inertial data using the free software MeshLab. If you wish to skip the setup and only compute the volume, center of mass, or inertia properties of your model, or quickly clean the model, you can use Mesh Cleaner, a tool which runs MeshLab internally for this purpose.

### Preparation

Installing MeshLab

Download MeshLab from the official website and install it on your computer. The installation should be straightforward.

``` bash
sudo apt install meshlab
```

Once installed, you can view your meshes in MeshLab (both DAE and STL formats are supported, which are those ones supported by Gazebo/ROS).

### Computing the inertial parameters

Open the mesh file in MeshLab. For this example, a sphere.dae mesh is used. To compute the inertial parameters, you first need to display the Layers dialog *View->Show Layer Dialog*.

A panel opens in the right part of the window which is split in half - we're interested in the lower part containing text output.

Next, command MeshLab to compute the inertial parameters. Choose *Filters->Quality Measure* and *Computations->Compute Geometric Measures* from the menu. The lower part of the Layers dialog should now show some info about the inertial measures. The sphere gives the following output:

``` bash
Mesh Bounding Box Size 2.000000 2.000000 2.000000
Mesh Bounding Box Diag 3.464102
Mesh Volume is 4.094867
Mesh Surface is 12.425012
Thin shell barycenter -0.000000 -0.000000 -0.000000
Center of Mass is -0.000000 0.000000 -0.000000
Inertia Tensor is :
| 1.617916 -0.000000 0.000000 |
| -0.000000 1.604620 -0.000000 |
| 0.000000 -0.000000 1.617916 |
Principal axes are :
| 0.000000 1.000000 0.000000 |
| -0.711101 -0.000000 0.703089 |
| -0.703089 0.000000 -0.711101 |
axis momenta are :
| 1.604620 1.617916 1.617916 |
```

### Filling in the tags in URDF or SDF

The next step is to record the computed values to the URDF or SDF file containing your robot (it is assumed you already have the robot model; if not, follow the tutorial Make a Model).

In each link you should have the *inertial* tag. It should look like the following (in SDF):

``` bash
<link name='antenna'>
  <inertial>
    <pose>-0.022 0.0203 0.02917 0 0 0</pose>
    <mass>0.56</mass>
    <inertia>
      <ixx>0.004878</ixx>
      <ixy>-6.2341e-07</ixy>
      <ixz>-7.4538e-07</ixz>
      <iyy>0.00090164</iyy>
      <iyz>-0.00014394</iyz>
      <izz>0.0042946</izz>
    </inertia>
  </inertial>
  <collision name='antenna_collision'>
    ...
  </collision>
  <visual name='antenna_visual'>
    ...
  </visual>
  ...
</link>
```

or like this one (in URDF):

``` bash
<link name="antenna">
  <inertial>
    <origin rpy="0 0 0" xyz="-0.022 0.0203 0.02917"/>
    <mass value="0.56"/>
    <inertia ixx="0.004878" ixy="-6.2341e-07" ixz="-7.4538e-07" iyy="0.00090164" iyz="-0.00014394" izz="0.0042946"/>
  </inertial>
  <visual>
    ...
  </visual>
  <collision>
    ...
  </collision>
```

The *mass* should be entered in kilograms and you have to find it out experimentally (or from specifications).

The *origin* or *pose* are used to enter the Center of Mass position (relative to the link's origin; especially not relative to the link's visual or collision origin). The rotational elements can define a different coordinate from for the moment of inertia axes. If you've found out the center of mass experimentally, fill in this value, otherwise fill in the correctly scaled value computed by MeshLab.

The *inertia* tag contains the inertia tensor you have computed in the previous step. Since the matrix is symmetric, only 6 numbers are sufficient to represent it. The mapping from MeshLab's output is the following:

``` bash
| ixx ixy ixz |
| ixy iyy iyz |
| ixz iyz izz |
```

## URDF Inertia Calculator

Just run the main.py in the same folder of your robot link 3d file, type the filename and the mass and copy the XML output to your URDF.

### Install PyMeshLab

You have to install the pymeshlab package to run this script.

You can easily install PyMeshLab using pip:

``` bash
pip3 install pymeshlab
```

### Background

You want to calculate the intertial properties for your robots link. In the following this will be done for example for the Cylinder.dae file, a simple cylinder 4 metres high and 2 metres in diameter.

### Usage

Calculating the URDF inertia tag for the Cylinder.dae file can be done by typing:

``` bash
python3 main.py
```

You will be asked to type the filename and the weight of your 3D object. For example, fill Cylinder.dae and 5.

The whole process is based on this tutorial: Inertial parameters of triangle meshes

At first the script calculates the center of mass of the object. After that it scales the mesh by a factor of 100 to increase the numerical accuracy. You could manually change that, if you need to scale it more up. Now the convex hull of your object will be calculated. For the hull the geometric properties will be calculated, scaled back down and outputted as URDF XML inertial tag like that (the precision could also be changed in the script):

``` bash
<inertial>
  <origin xyz="0.00000002 -0.00000001 0.00000000"/>
  <mass value="5.00000000"/>
  <inertia ixx="7.90866056" ixy="0.00000006" ixz="0.00000000" iyy="7.90866060" iyz="0.00000000" izz="2.48398783"/>
</inertial>
```

>**Note**: The output is the URDF Syntax which can not be used in SDF Models.

## References

[URDF Inertia Calculator](https://github.com/vonunwerth/MeshLabInertiaToURDF)

[Inertial parameters of triangle meshes](https://classic.gazebosim.org/tutorials?tut=inertia&cat=build_robot)

[List of moments of inertia](https://en.wikipedia.org/wiki/List_of_moments_of_inertia)

[MeshLab](https://www.meshlab.net/#description)