from data_parse import prep_data


if __name__=="__main__":

    if "yeast" in sys.argv[1]:
        feat_size = 117
    elif "rcv1subset" in sys.argv[1]:
        feat_size = 47337
    else: 
        print "Invalid dataset selected"
        exit(0)
   
     
    features = prep_data(sys.argv[1],feat_size)
    del features[-1] # Last value is empty/ \n



