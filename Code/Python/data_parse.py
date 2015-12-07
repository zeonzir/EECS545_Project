import scipy.io.arff as sio
from scipy.io import *
import numpy as np
import sys
import csv
import arff
import scipy.io as sio


def prep_data(name,size):

    # Setup of basic folder structure
    main_folder = name.replace(".arff","")
    dataset_name = '../Dataset/'+ main_folder + "/" + name
    f = open(dataset_name,'r')

    # FLAG to establish collection of features
    feature_COLLECT= False

    # Initialization of useful lists    
    lines = list()
    X = list()
    finalX = list()

    # Extract data based on tagged name
    lines = f.readline()
    while(lines):
        lines = f.readline()

        if "@data" in lines:
            feature_COLLECT = True

        elif feature_COLLECT:
            lines = lines.replace("{","")
            lines = lines.replace("}","")
            line = lines.split(",")
            X.append(line)

    for idx in X:
        nlist = np.zeros(size)

        # Yeast dataset check
        if size==len(idx):
            nlist = idx

        for iter in idx:
            cur =  iter.split(" ")

            # Check for yeast or rcv1subset1 dataset
            if cur[0]!="" and len(cur)>1:
                nlist[int(cur[0])-1] = float(cur[1])

        finalX.append(nlist)

    return finalX

