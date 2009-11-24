#!/usr/bin/python


class Laws(object):
    def __init__(self):
        pass
    


class OneLens(Laws):
    def __init__(self):
        self.do, self.di = 0
    
    def magnification(self):
        """Returns the magnification factor of a lens when supplied image distance,
        and object distance:
        
        M = magnification(object_distance, image_distance)
        M = -di/do"""
        return self.focal/(self.focal-self.do)
        return -self.di/self.do

    def lens(self):
        """Lens law for object and image with a given focal length in air
        For a focal length f, image distance di, and object distance do

        1/f = 1/di + 1/do  """
        pass 

    def focal(self):
        return (self.di*self.do)/(self.di+self.do)

        
class TwoLenses(Laws):

    def __init__(self):
        pass

    def magnification(self):
        """Returns the magnification ratio provided by two lenses of focal
        lengths f1 and f2

        M = magnification(f1, f2)
        M = -f1/f2"""
        pass

    def back_focal_length(self):
        """If two thin lenses are separated by some distance d, the distance from
        the second lens to the focal point of the combined lenses is called the
        back focal length (BFL)

        BFL = (f2*(d-f1))/(d-(f1+f2))

        When the lenses are in contact, this simplifies to:

        1/f = 1/f1 + 1/f2
        The distance from lens 1 to the focal must then be d+BFL"""
        pass


        
class GaussianBeam(Laws):
    """Defines properties of the guassian beam"""

    
    def __init__(self):
        self.wavelength = 0.852*10**-3 
        pass

    def wavelength(self):
        """Returns beam wavelength in nm"""
        return self.wavelength
    
    def waist(self):
        """Returns the waist size of the beam"""
        pass

    def roc(self):
        """Returns the radius of curvature of the beam"""
        pass

    def position(self):
        """Returns the waist position of the object"""
        

