from glob import glob
import xarray as xr

def open_control():
    path = '/scratch/ltelfer/upper_sfs/pfout.zarr/ctr/ctr'
    ds = xr.open_mfdataset(path,engine='zarr')
    return ds

def open_experiments():
    paths = glob('/scratch/ltelfer/upper_sfs/pfout.zarr/exp/*/*/')
    ds = xr.open_mfdataset(paths,engine='zarr')
    return ds