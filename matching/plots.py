#!/usr/bin/python

from utils import *
from pylab import *
from matplotlib import rc

class Plot(object): 

    def show(self):
        print "Hi Show"
        show()

class ParametricPlot(Plot):
    def __init__(self, LA, wa, LB, wb, steps):
        initFromArgs(self)
        fig = figure(1)
        ax = subplot(111)
        plot(LA, wa, LB, wb)
        title('Parametric Curves for Midfocus Matching')
        xlabel(r'$L_A (mm)$')
        ylabel(r'$w_{02}  (um)$')
        
        ax.fmt_xdata =  lambda x: '%0.4f' % x
        ax.fmt_ydata = lambda y: '%0.4f' % y
        
        ylim=(0, 1000)


        
    def on_click(self, event):
        LA, wa = event.xdata, event.ydata
        BeamProfile(LA=LA, wa=wa)
        
# class BeamProfile(Plot):
#     def __init__(self, LA=None, wa=None):
#         initFromArgs(self)
#         ax = axes()
#         plot([1000,2000,3000], [1000,2000,3000])
#         title('Gaussian Beam Profile')
#         ylabel('$w (\mu m)$')
#         xlabel('Position (mm)')
#         setp(ax, ylim=(-1000,1000))
#         show()

# class PointBrowser: 
#     """ 
#     Click on a point to select and highlight it -- the data that 
#     generated the point will be shown in the lower axes.  Use the 'n' 
#     and 'p' keys to browse through the next and pervious points 
#     """ 
#     def __init__(self, ax=None): 
#         self.lastind = 0 

#         self.text = ax.text(0.05, 0.95, 'selected: none', 
#                             transform=ax.transAxes, va='top') 
#         self.selected,  = ax.plot([xs[0]], [ys[0]], 'o', ms=12, alpha=0.4, 
#                                   color='yellow', visible=False) 

#     def onpress(self, event): 
#         if self.lastind is None: return 
#         if event.key not in ('n', 'p'): return 
#         if event.key=='n': inc = 1 
#         else:  inc = -1 


#         self.lastind += inc 
#         self.lastind = clip(self.lastind, 0, len(xs)-1) 
#         self.update() 

#     def onpick(self, event): 

#        if event.artist!=line: return True 

#        N = len(event.ind) 
#        if not N: return True 

#        # the click locations 
#        x = event.mouseevent.xdata 
#        y = event.mouseevent.ydata 


#        distances = hypot(x-xs[event.ind], y-ys[event.ind]) 
#        indmin = distances.argmin() 
#        dataind = event.ind[indmin] 

#        self.lastind = dataind 
#        self.update() 

#     def update(self): 
#         if self.lastind is None: return 

#         dataind = self.lastind 

#         ax2.cla() 
#         ax2.plot(X[dataind]) 

#         ax2.text(0.05, 0.9, 'mu=%1.3f\nsigma=%1.3f'%(xs[dataind], ys[dataind]), 
#                  transform=ax2.transAxes, va='top') 
#         ax2.set_ylim(-0.5, 1.5) 
#         self.selected.set_visible(True) 
#         self.selected.set_data(xs[dataind], ys[dataind]) 

#         self.text.set_text('selected: %d'%dataind) 
#         fig.canvas.draw() 




# if __name__ == "__main__":
#     BeamProfile()


# http://sourceforge.net/mailarchive/message.php?msg_id=m31xea3al0.fsf%40peds-pc311.bsd.uchicago.edu
