import numpy as np
import pandas as pd
import xarray as xr
import decimal
from decimal import Decimal
import csv

mosaics = xr.open_dataset('mosaics.nc')

def generate_vegm(group,sample_number):
    
    # import vegm template
    template = pd.read_csv('template_vegm.dat',
                           delim_whitespace=True)
    vegt = template.drop(template.columns[7:],axis=1).copy()
    
    # get mosaic array
    m = mosaics[variable].sel(n=n)
    m = m.where(m>0,0).values
    
    # mosaic to 1D list
    vlist = []
    for row in np.arange(np.shape(m)[0]):
        vlist = vlist + m[row].tolist()
    
    # add mosaic list to vegm
    vegt['veg'] = vlist
    
    # convert nodata to unburned
    ndict = {0:1,1:1,2:2,3:3,4:4}
    vegt['veg'] = vegt.veg.map(ndict)
    
    # create unburned column
    udict = {1:1,2:0,3:0,4:0}
    vegt['1'] = vegt.veg.map(udict)
    
    # create low severity column
    ldict = {1:0,2:1,3:0,4:0}
    vegt['2'] = vegt.veg.map(ldict)

    # create moderate severity column
    mdict = {1:0,2:0,3:1,4:0}
    vegt['3'] = vegt.veg.map(mdict)

    # create high severity column
    hdict = {1:0,2:0,3:0,4:1}
    vegt['4'] = vegt.veg.map(hdict)
    
    # create remaining columns
    vegt['5'] = 0
    vegt['6'] = 0
    vegt['7'] = 0
    vegt['8'] = 0
    vegt['9'] = 0
    vegt['10'] = 0
    vegt['11'] = 0
    vegt['12'] = 0
    vegt['13'] = 0
    vegt['14'] = 0
    vegt['15'] = 0
    vegt['16'] = 0
    vegt['17'] = 0
    vegt['18'] = 0
    
    # drop 'veg' column
    vegt.drop(columns='veg',inplace=True)
    
    # function for ensuring correct decimal places
    def decimalConvert(value,precision):
        decimal.getcontext().prec = precision
        n = decimal.Decimal(value)/1
        return n
    
    # apply function to columns
    vegt['lat'] = vegt.lat.apply(lambda x: decimalConvert(x,8))
    vegt['lon'] = vegt.lon.apply(lambda x: decimalConvert(x,9))
    vegt['sand'] = vegt.sand.apply(lambda x: decimalConvert(x,2))
    vegt['clay'] = vegt.clay.apply(lambda x: decimalConvert(x,2))
    
    # create path for output
    n = format(sample_number,'02')
    outpath = f'mosaics/{group}/{group}.{n}.vegm.dat'
    
    # headers to match template
    header1 = ['x','y','lat','lon','sand','clay','color',
               'fractional','coverage','of','grid,','by',
               'vegetation','class','(Must/Should','Add',
               'to','1.0)','']
    header2 = ['','','(Deg)','(Deg)','(%/100)','','index',
               '1','2','3','4','5','6',
               '7','8','9','10','11','12',
               '13','14','15','16','17','18']
    
    # write header lines
    with open(outpath,'w') as v:
        vwriter = csv.writer(v,delimiter=' ')
        vwriter.writerow(header1)
        vwriter.writerow(header2)
    
    # append data
    vegt.to_csv(outpath,mode='a',sep=' ',index=False,header=False)
    
    return outpath