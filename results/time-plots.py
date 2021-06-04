import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math

def organize_data(data, engines, mappings):

    average_data = pd.DataFrame(columns = ['engine', 'mapping', 'elapsed_time'])
    for i in range(0, len(data)-2):
        if (data.iloc[i]['engine'] == data.iloc[i+1]['engine'] and data.iloc[i]['engine'] == data.iloc[i+2]['engine']):
            if (data.iloc[i]['mapping'] == data.iloc[i+1]['mapping'] and data.iloc[i]['mapping'] == data.iloc[i+2]['mapping']):
                if data.iloc[i]['elapsed_time'] == "TimeOut" or data.iloc[i+1]['elapsed_time'] == "TimeOut" or data.iloc[i+2]['elapsed_time'] == "TimeOut":
                    time_outs = []
                    for j in range (0,3):
                        time_outs.append(float(data.iloc[i+j]['elapsed_time'].replace("TimeOut", "100000")))

                    av_elapsed_time = (time_outs[0] + time_outs[1] + time_outs[2])/3
                    average_data.loc[len(average_data)] = [data.iloc[i]['engine'], data.iloc[i]['mapping'], math.log10(av_elapsed_time)]
                else:
                    av_elapsed_time = (float(data.iloc[i]['elapsed_time']) + float(data.iloc[i+1]['elapsed_time']) + float(data.iloc[i+2]['elapsed_time']))/3
                    average_data.loc[len(average_data)] = [data.iloc[i]['engine'], data.iloc[i]['mapping'], math.log10(av_elapsed_time)]    
            else:
                next
        else:
            next
    
    ordered_data = pd.DataFrame(columns = mappings, index=engines)
    for i in range(0, len(average_data)):
        for j in range(0, len(ordered_data.index)):
            for k in range(0,len(ordered_data.columns)):
                if str(average_data.iloc[i]['engine']).lower() == ordered_data.index[j] and str(average_data.iloc[i]['mapping']).lower() == ordered_data.columns[k]:
                    ordered_data.iloc[j,k] = average_data.iloc[i]['elapsed_time']
                    break
    #return(ordered_data)
    return(ordered_data.replace(np.nan, 0))


def plot(data, scale):

    # Create dataframe     
    #engines = ['carml', 'chimera', 'db2triples', 'ontop', 'morph-rdb', 'r2rml-f', 'rmlmapper', 'rmlstreamer', 'rocketrml', 'sdm-rdfizer']
    engines = ['DB2Triples', 'Ontop', 'Morph-RDB', 'R2RML-F', 'RMLMapper', 'SDM-RDFizer', 'Chimera', 'CARML', 'RocketRML']
    mappings = ['gtfs-rdb', 'gtfs-csv', 'gtfs-xml', 'gtfs-json', 'gtfs-custom']
    ordered_data = organize_data(data, [x.lower() for x in engines], mappings)

    #print(ordered_data)

    barWidth = 0.11

    r1 = np.arange(len(ordered_data.columns))
    r2 = [x + barWidth for x in r1]
    r3 = [x + barWidth * 2 for x in r1]
    r4 = [x + barWidth * 3 for x in r1]
    r5 = [x + barWidth * 4 for x in r1]
    r6 = [x + barWidth * 5 for x in r1]
    r7 = [x + barWidth * 6 for x in r1]
    r8 = [x + barWidth * 7 for x in r1]
    r9 = [x + barWidth * 8 for x in r1]
    #r10 = [x + barWidth * 9 for x in r1]

    plt.bar(r1, ordered_data.values.tolist()[0], width=barWidth, color='#F2BABA',#F2BABA
                label='DB2Triples')
    plt.bar(r2, ordered_data.values.tolist()[1], width=barWidth, color='#A46593',#A46593
                label='Ontop')
    plt.bar(r3, ordered_data.values.tolist()[2], width=barWidth, color='#2862CC',#2862CC
                label='Morph-RDB')
    plt.bar(r4, ordered_data.values.tolist()[3], width=barWidth, color='#90AFE9',#90AFE9
                label='R2RML-F')   
    plt.bar(r5, ordered_data.values.tolist()[4], width=barWidth, color='#B1ACAA',#B1ACAA
                label='RMLMapper')
    plt.bar(r6, ordered_data.values.tolist()[5], width=barWidth, color='#FCD29F',#FCD29F
                label='SDM-RDFizer')
    plt.bar(r7, ordered_data.values.tolist()[6], width=barWidth, color='#FCAB64',#FCAB64
                label='Chimera')
    plt.bar(r8, ordered_data.values.tolist()[7], width=barWidth, color='#73D4B7',#73D4B7
                label='CARML')
    plt.bar(r9, ordered_data.values.tolist()[8], width=barWidth, color='#A1FCDF',#73D4B7
                label='RocketRML')


    plt.xticks([r + barWidth*4.5  for r in range(len(r1))], mappings, fontsize=12)

    plt.yticks(np.arange(0, 6), ('0.0', '1.0', '2.0', '3.0', '4.0', 'Timeout'), fontsize=12)
    plt.ylim(top=5)
    plt.ylabel("Time (log$_{10}$(s))", fontsize=12)
    plt.xlabel("Mapping", fontsize=12)
 
    plt.legend(engines, loc='lower center', prop={'size': 10}, ncol=4, bbox_to_anchor=(0.4, -0.34))
        
    plt.savefig("./figures/time_" + scale + ".pdf", bbox_inches='tight', dpi=700)

    plt.clf()

    print("Finished: 'figures/time_" + scale +"'")

def handler():

    scales = ['GTFS-1', 'GTFS-10', 'GTFS-100']
    for scale in scales:
        plot(pd.read_csv("./data/Results - Time - " + scale + ".csv"), scale)

    # Test
    #plot(pd.read_csv("./data/Results - Time - GTFS-1.csv"), 'gtfs-1')



if __name__ == "__main__":
    handler()
