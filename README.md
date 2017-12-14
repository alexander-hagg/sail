# sail
Source code for the Surrogate-Assisted Illumination (SAIL) algorithm, as
described in: 

"Data-Efficient Exploration, Optimization, and Modeling of Diverse Designs
 through Surrogate-Assisted Illumination" presented at GECCO 2017. 
https://arxiv.org/abs/1702.03713

and 

"Aerodynamic Design Exploration through Surrogate-Assisted Illumination"
presented at AIAA Aviation and Aeronautics Forum 2017.
https://hal.inria.fr/hal-01518786/file/aiaa_sail.pdf


Three domains are provided with parameterized and feed forward deformation encodings: 2D airfoils, 3D velomobile shells and a 3D side view mirror based on the TUM DrivAer model. 
https://www.aer.mw.tum.de/en/research-groups/automotive/drivaer/

To apply SAIL to a new domain only new representation and evaluation functions must be created. More sample domains will be made public as their are published. If you are interested in creating a new domain and having trouble, don't hesistate to ask!


Produced using

    Matlab R2017b


Required MATLAB Toolboxes:

* Parallel Computing (for parallel speed ups)

* Statistics and Machine Learning (for Sobol sequence)


Includes:
    GMPL  Version 4.1, Rasmussen & Nickisch (help gpml)


Required Software:

	Airfoil domain:

         XFOIL low Rn airfoil design and analysis code 
        
        (raphael.mit.edu/xfoil/)
        
        
    Velo domain:
        
        OpenFOAM computation fluid dynamics simulator (version 2.4.0)
        
        (https://openfoam.org/download/2-4-0-ubuntu/)

    Mirror domain:
        
        OpenFOAM computation fluid dynamics simulator (version 2.4.0)
        
        (https://openfoam.org/download/2-4-0-ubuntu/)        

        STL files from DrivAer model 
        	make sure to copy them into the oftemplates folder inside the mirror domain!)
        	part_03_Estate.stl
        	part_07_Mirror_Cover.stl
			part_01_Body_Closed_2.stl
			part_07_Mirror.stl


        (https://www.aer.mw.tum.de/en/research-groups/automotive/drivaer/download/)